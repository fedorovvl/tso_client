// Author: MadFx
// Auto-pick for geologists and explorers.
//  Geologists: strict resource priority; per slot the geologist with the biggest
//              expected deposit volume wins, search time breaks ties.
//  Explorers : relative loot factor vs. a plain explorer (rolls x count x extras),
//              compared per hour or per run; specialised explorers go to their
//              specialty, the rest follow the selected priority.

(function () {

    if (specSharedHandler.__autoPickPatched) return;
    var _origHandler = specSharedHandler;

    // ------------------------------------------------------------------ config
    var DEBUG = false;                        // true -> detailed logs via debug()
    var SCRIPT_PREFIX = 'user_auto_pick_spec_';

    var SPEC_THRESHOLD   = 1.25;  // specialty must beat the priority task by this factor
    var ADV_THRESHOLD    = 1.5;   // same, but for adventures (they cost coins and sausages)
    var EXTRA_ROLL_VALUE = 0.5;   // one roll on a bonus table, in "main table rolls"
    var EFFECT_VALUE     = 0.5;   // proc reward (modifierEffect), in "main table rolls"
    var EPS              = 1e-6;

    var TEXT = {
        none       : 'Без приоритета',
        treasure   : loca.GetText('LAB', 'FindTreasure') + ' (авто)',
        adventure  : loca.GetText('LAB', 'SpecialistTaskFindAdventureZone') + ' (авто)',
        priority   : 'Приоритет',
        metric     : 'Сравнение задач',
        perHour    : 'Лут в час',
        perRun     : 'Лут за поход'
    };

    var VALUE_MAP = {
        '0,0': 'Stone', '0,1': 'BronzeOre', '0,2': 'Marble', '0,3': 'IronOre', '0,4': 'GoldOre',
        '0,5': 'Coal',  '0,6': 'Granite',   '0,7': 'TitaniumOre', '0,8': 'Salpeter'
    };
    var GEO_VALID_RES = ['Stone', 'Marble', 'GoldOre', 'BronzeOre', 'IronOre',
                         'TitaniumOre', 'Coal', 'Salpeter', 'Granite'];
    var DEFAULT_ORDER = ['Salpeter', 'TitaniumOre', 'Granite', 'GoldOre', 'IronOre',
                         'Coal', 'BronzeOre', 'Marble', 'Stone'];

    // Explorer task values (see 4-specialists.js explorerDropSpec)
    var TREASURE_VALS  = ['1,0', '1,1', '1,2', '1,3', '1,6'];   // Short..Prolonged
    var SPECIAL_VALS   = ['1,4', '1,5'];                         // Erudite, BeanACollada
    var ADVENTURE_VALS = ['2,0', '2,1', '2,2', '2,3'];

    // Base rolls (ChanceItemsAmount) of the main loot tables, gfx_settings LootTableGroup
    var BASE_ROLLS = {
        FindTreasureShort: 2, FindTreasureMedium: 1, FindTreasureLong: 1,
        FindTreasureEvenLonger: 1, FindTreasureProlonged: 2
    };
    // Expected value of one "Lovely" roll vs. one main-table roll (computed from XML)
    var LOVELY_EV = { Short: 2.01, Medium: 1.38, Long: 1.83, EvenLonger: 1.6, Prolonged: 1.29 };
    // Item shares and total Prio of main treasure tables (for item-specific modifiers)
    var ITEM_SHARE = {
        Short:      { Plank: .311, RealPlank: .155, Stone: .311, Marble: .155, Coin: .067 },
        Medium:     { RealPlank: .405, Marble: .405, Coin: .081, IronOre: .041, ExoticWood: .027, Granite: .041 },
        Long:       { Granite: .399, ExoticWood: .399, GoldOre: .08, Salpeter: .058, TitaniumOre: .065 },
        EvenLonger: { Granite: .297, ExoticWood: .254, GoldOre: .153, Salpeter: .169, TitaniumOre: .127 },
        Prolonged:  { Granite: .18, PlatinumOre: .132, ExoticWood: .18, MahoganyWood: .09, Gold: .132,
                      Coin: .024, Salpeter: .132, Grout: .042, Titanium: .09 }
    };
    var TOTAL_PRIO = { Short: 193, Medium: 148, Long: 138, EvenLonger: 118, Prolonged: 167 };
    var DEFAULT_ITEM_SHARE = 0.15;
    var DEFAULT_TOTAL_PRIO = 150;

    var EVENT_SUFFIX = /^(Easter|XMAS|SoccerResources|SoccerBalls|Halloween|RedNose|Anniversary|Valentine|SpecialistWeek)$/;
    var SUBS = ['EvenLonger', 'Prolonged', 'VeryLong', 'TravellingErudite', 'BeanACollada', 'Medium', 'Short', 'Long'];

    // ------------------------------------------------------------------ settings
    var DM_config = { order: DEFAULT_ORDER.slice(), explPriority: 'none', explMetric: 'hour' };

    function log(msg) { if (DEBUG) debug('[AutoPick] ' + msg); }

    function _loadSettings() {
        try {
            var saved = settings.read(null, SCRIPT_PREFIX + 'SETTINGS');
            if (saved) {
                if (Array.isArray(saved.order)) DM_config.order = saved.order;
                if (saved.explPriority) DM_config.explPriority = saved.explPriority;
                if (saved.explMetric)   DM_config.explMetric   = saved.explMetric;
            }
            // keep the list complete if the game adds/removes resources
            GEO_VALID_RES.forEach(function (r) { if (DM_config.order.indexOf(r) < 0) DM_config.order.push(r); });
        } catch (e) { log('settings.read failed: ' + e); }
    }

    function _saveSettings() {
        try {
            settings.settings[SCRIPT_PREFIX + 'SETTINGS'] = {};
            settings.store(DM_config, SCRIPT_PREFIX + 'SETTINGS');
        } catch (e) { log('settings.store failed: ' + e); }
    }

    _loadSettings();

    // ------------------------------------------------------------------ UI hook
    specSharedHandler = function (type) {
        _origHandler.apply(this, arguments);
        if (type !== 1 && type !== 2) return;

        var $footer = $('#specModal .modal-footer');
        if ($('#specAutoPickBtn').length === 0) {
            $('<button>', { id: 'specAutoPickBtn', 'class': 'btn btn-warning pull-left', style: 'margin-right:4px' })
                .text('⚡ Auto').appendTo($footer);
            $('<button>', { id: 'specResetBtn', 'class': 'btn btn-default pull-left', style: 'margin-right:4px' })
                .text('⟳').appendTo($footer);
            $('<button>', { id: 'specPriorityBtn', 'class': 'btn btn-default pull-left' })
                .text('⚙').appendTo($footer);
        }

        var t = type;
        $('#specAutoPickBtn').off('click.ap').on('click.ap', function () {
            try { if (t === 2) _autoPickGeologists(); else _autoPickExplorers(); }
            catch (e) { debug('[AutoPick] ' + e); }
        });
        $('#specResetBtn').off('click.ap').on('click.ap', _resetAll);
        $('#specPriorityBtn').show().off('click.ap').on('click.ap', function () {
            if (t === 2) _showGeoPriorityPanel(); else _showExplorerPanel();
        });
    };
    specSharedHandler.__autoPickPatched = true;

    function _rows() {
        var rows = [];
        $('#specModalData select').each(function () {
            var id = $(this).attr('id');
            if (!id || id === 'specMassChange') return;
            rows.push({ id: id, $sel: $(this), cancel: $(this).find('option:first').val() });
        });
        return rows;
    }

    function _apply(row, val) {
        row.$sel.val(val).trigger('change');
        updateSpecTimeRow(row.$sel[0], val, val);
    }

    function _resetAll() { _rows().forEach(function (r) { _apply(r, r.cancel); }); }

    function _panel(id, title) {
        $('#' + id).remove();
        var $p = $('<div>', { id: id, css: {
            position: 'fixed', top: '50%', left: '50%', transform: 'translate(-50%,-50%)',
            background: '#2a1f0f', border: '2px solid #8b6914', borderRadius: '8px', padding: '16px',
            zIndex: 9999, minWidth: '280px', boxShadow: '0 4px 24px rgba(0,0,0,0.8)', color: '#f0d890'
        }});
        $p.append($('<div>', { html: '<b>' + title + '</b>', css: {
            textAlign: 'center', marginBottom: '10px', borderBottom: '1px solid #8b6914', paddingBottom: '8px' } }));
        return $p;
    }

    function _panelButtons($p, onAccept, onDefault) {
        var $b = $('<div>', { css: { textAlign: 'center', marginTop: '12px' } });
        $('<button>', { 'class': 'btn btn-success btn-sm', css: { marginRight: '6px' } })
            .text('✓ ' + loca.GetText('LAB', 'Accept')).on('click', function () { onAccept(); $p.remove(); }).appendTo($b);
        $('<button>', { 'class': 'btn btn-default btn-sm', css: { marginRight: '6px' } })
            .text('↺ ' + loca.GetText('LAB', 'Decline')).on('click', onDefault).appendTo($b);
        $('<button>', { 'class': 'btn btn-danger btn-sm' }).text('✕').on('click', function () { $p.remove(); }).appendTo($b);
        $p.append($b);
        $('body').append($p);
    }

    function _showGeoPriorityPanel() {
        var $p = _panel('geoPriorityPanel', loca.GetText('HIL', 'Help_window_target_order_0'));
        var $list = $('<ol>', { css: { margin: 0, padding: '0 0 0 22px', userSelect: 'none' } });
        DM_config.order.forEach(function (res) {
            $('<li>', { 'data-res': res, css: {
                padding: '5px 10px', margin: '3px 0', background: '#3d2f10', border: '1px solid #6b4f1a',
                borderRadius: '4px', cursor: 'pointer', listStyle: 'decimal inside' } })
                .text(loca.GetText('RES', res)).appendTo($list);
        });
        _makeDraggable($list);
        $p.append($list);
        _panelButtons($p, function () {
            var order = [];
            $list.find('li').each(function () { order.push($(this).data('res')); });
            DM_config.order = order;
            _saveSettings();
        }, function () {
            DM_config.order = DEFAULT_ORDER.slice();
            _saveSettings();
            $p.remove();
            _showGeoPriorityPanel();
        });
    }

    function _explorerPriorityOptions() {
        var opts = [{ v: 'none', t: TEXT.none }, { v: 'treasure', t: TEXT.treasure }];
        explorerDropSpec[0].data.forEach(function (it) { opts.push({ v: it.val, t: it.text }); });
        opts.push({ v: 'adventure', t: TEXT.adventure });
        return opts;
    }

    function _showExplorerPanel() {
        var $p = _panel('explPriorityPanel', loca.GetText('SPE', 'Explorer'));
        var css = {
            width: '100%', marginBottom: '8px', height: '30px', padding: '4px 8px',
            background: '#3d2f10', color: '#f0d890', border: '1px solid #6b4f1a',
            borderRadius: '4px', boxShadow: 'inset 0 1px 3px rgba(0,0,0,0.6)', outline: 'none',
            cursor: 'pointer'
        };
        var optCss = { background: '#3d2f10', color: '#f0d890' };
        var lblCss = { marginBottom: '3px', fontWeight: 'bold' };

        $p.append($('<div>').text(TEXT.priority));
        var $prio = $('<select>', { 'class': 'form-control', css: css });
        _explorerPriorityOptions().forEach(function (o) { $('<option>', { value: o.v, css: optCss }).text(o.t).appendTo($prio); });
        $prio.val(DM_config.explPriority);
        $p.append($prio);

        $p.append($('<div>').text(TEXT.metric));
        var $metric = $('<select>', { 'class': 'form-control', css: css });
        $('<option>', { value: 'hour', css: optCss }).text(TEXT.perHour).appendTo($metric);
        $('<option>', { value: 'run', css: optCss }).text(TEXT.perRun).appendTo($metric);
        $metric.val(DM_config.explMetric);
        $p.append($metric);

        _panelButtons($p, function () {
            DM_config.explPriority = $prio.val();
            DM_config.explMetric = $metric.val();
            _saveSettings();
        }, function () { $prio.val('none'); $metric.val('hour'); });
    }

    function _makeDraggable($list) {
        var $drag = null;
        $list.on('mousedown', 'li', function (e) { $drag = $(this).css({ opacity: '0.5', cursor: 'move' }); e.preventDefault(); });
        $list.on('mouseenter', 'li', function () { $(this).css({ background: '#5a4418', borderColor: '#c9a227' }); });
        $list.on('mouseleave', 'li', function () { $(this).css({ background: '#3d2f10', borderColor: '#6b4f1a' }); });
        $list.on('mouseover', 'li', function () {
            if (!$drag || $drag[0] === this) return;
            var $over = $(this);
            if ($drag.index() < $over.index()) $over.after($drag); else $over.before($drag);
        });
        $(document).off('mouseup.geoPrio').on('mouseup.geoPrio', function () {
            if ($drag) { $drag.css('opacity', '1'); $drag = null; }
        });
    }

    // ------------------------------------------------------------------ helpers
    function _num(x, def) { return (typeof x === 'number' && !isNaN(x)) ? x : def; }

    function _getSpec(selectId) {
        var p = selectId.split('_');
        var uid = game.def('Communication.VO::dUniqueID').Create(p[0], p[1]);
        return game.zone.getSpecialist(game.gi.mCurrentViewedZoneID, uid);
    }

    function _specName(spec, fallback) {
        try { return spec.getName(false).replace(/<[^>]*>/g, '').trim(); } catch (e) { return fallback; }
    }

    // All active modifiers of a specialist (skill tree + traits), flattened once.
    function _getModifiers(spec) {
        var mods = [];
        spec.getSkillTree().getItems_vector().concat(spec.skills.getItems_vector()).forEach(function (skill) {
            var level = skill.getLevel();
            if (level <= 0) return;
            var defs = skill.getDefinition().level_vector[level - 1];
            if (!defs) return;
            defs.forEach(function (sd) {
                mods.push({
                    mod:    (sd.modifier_string || '').toLowerCase(),
                    type:   sd.type_string || '',
                    names:  (sd.name_string || '').split(',').map(function (s) { return s.trim(); })
                                .filter(function (s) { return s.length > 0; }),
                    item:   sd.item_string || '',
                    prop:   sd.property_string || '',
                    mult:   _num(sd.multiplier, 1),
                    add:    _num(sd.adder, 0),
                    value:  _num(sd.value, 0),
                    chance: _num(sd.chance, 1)
                });
            });
        });
        return mods;
    }

    // Same rule as cSpecialistTask.isModifierApplyable; type may also name the main task only.
    function _applies(m, task) {
        if (!m.type) return true;
        var t = m.type.toLowerCase();
        return t === task.key.toLowerCase() || t === task.taskName.toLowerCase();
    }

    function _timeBonus(spec) {
        try { return _num(spec.GetSpecialistDescription().GetTimeBonus(), 100) || 100; } catch (e) { return 100; }
    }

    // Effective duration (ms), mirrors getTaskDurationText.
    function _duration(mods, task, timeBonus) {
        var d = task.duration;
        mods.forEach(function (m) {
            if (m.mod === 'searchtime' && _applies(m, task)) d = (m.value !== 0) ? m.value : (d * m.mult + m.add);
        });
        return d / timeBonus * 100;
    }

    function _task(val) {
        var p = val.split(',');
        var info = getTaskInfo(p[0], p[1]);
        if (!info || !info.taskName || !info.duration) return null;
        return { val: val, taskName: info.taskName, sub: info.subTaskName,
                 key: info.taskName + info.subTaskName, duration: info.duration };
    }

    // ------------------------------------------------------------------ geologists
    function _getAvailableSlots() {
        var total = {}, working = {}, available = {};
        try {
            game.gi.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector().forEach(function (b) {
                if (b == null || b.GetBuildingName_string().indexOf('MineDepleted') < 0) return;
                var name = b.GetBuildingName_string().replace('MineDepletedDeposit', '');
                if (GEO_VALID_RES.indexOf(name) >= 0) total[name] = (total[name] || 0) + 1;
            });
        } catch (e) { log('building scan error: ' + e); }
        try {
            game.gi.mCurrentPlayerZone.GetSpecialists_vector().forEach(function (s) {
                if (s.GetTask() == null || s.GetBaseType() !== 2 || s.getPlayerID() === -1) return;
                var res = s.GetTask().GetDepositToSearch_string();
                if (res) working[res] = (working[res] || 0) + 1;
            });
        } catch (e) { log('working scan error: ' + e); }
        GEO_VALID_RES.forEach(function (res) {
            var rem = (total[res] || 0) - (working[res] || 0);
            if (rem > 0) available[res] = rem;
        });
        log('depleted=' + JSON.stringify(total) + ' working=' + JSON.stringify(working));
        return available;
    }

    // Expected volume factor: capacity multiplier and expected extra deposits.
    function _evalGeo(mods, task, timeBonus) {
        var cap = 1, extra = 0;
        mods.forEach(function (m) {
            if (!_applies(m, task)) return;
            if (m.mod === 'searchdepositcapacity') cap = cap * m.mult + m.add;
            else if (m.mod === 'finddeposit') extra += m.chance * m.add;
        });
        return { cap: Math.max(0, cap), extra: Math.max(0, extra), time: _duration(mods, task, timeBonus) };
    }

    function _geoVolume(e, slotsLeft) {
        // extra deposits only count if there are free depleted slots for them
        return e.cap * (1 + Math.min(e.extra, Math.max(0, slotsLeft - 1)));
    }

    function _autoPickGeologists() {
        var available = _getAvailableSlots();
        var rows = _rows();
        var order = DM_config.order;

        var demand = Object.keys(available).sort(function (a, b) {
            var ia = order.indexOf(a), ib = order.indexOf(b);
            return (ia < 0 ? 999 : ia) - (ib < 0 ? 999 : ib);
        });
        if (demand.length === 0) { _resetAll(); return; }

        // evaluation per geologist and resource
        rows.forEach(function (row) {
            var spec = _getSpec(row.id), mods = _getModifiers(spec), tb = _timeBonus(spec);
            row.name = _specName(spec, row.id);
            row.byRes = {};
            row.$sel.find('option').each(function () {
                var val = $(this).val();
                if (!val || val === row.cancel) return;
                var task = _task(val);
                if (!task || task.taskName !== 'FindDeposit') return;
                var res = VALUE_MAP[val] || task.sub;
                if (!available[res]) return;
                var e = _evalGeo(mods, task, tb);
                e.val = val;
                row.byRes[res] = e;
            });
        });

        var remaining = $.extend({}, available), assigned = {};

        // opportunity cost: how good the geologist is on other still-open resources
        function opportunity(row, exceptRes) {
            var best = 0;
            for (var r in row.byRes) {
                if (r !== exceptRes && remaining[r] > 0) best = Math.max(best, _geoVolume(row.byRes[r], remaining[r]));
            }
            return best;
        }

        demand.forEach(function (res) {
            while (remaining[res] > 0) {
                var best = null, bestVol = -1, bestTime = Infinity, bestOpp = Infinity;
                rows.forEach(function (row) {
                    if (assigned[row.id] || !row.byRes[res]) return;
                    var e = row.byRes[res], vol = _geoVolume(e, remaining[res]);
                    var better = vol > bestVol + EPS;
                    if (!better && Math.abs(vol - bestVol) <= EPS) {
                        if (e.time < bestTime - EPS) better = true;
                        else if (Math.abs(e.time - bestTime) <= EPS) {
                            var opp = opportunity(row, res);
                            if (opp < bestOpp - EPS) { better = true; }
                        }
                    }
                    if (better) {
                        best = row; bestVol = vol; bestTime = e.time; bestOpp = opportunity(row, res);
                    }
                });
                if (!best) break;
                assigned[best.id] = best.byRes[res].val;
                remaining[res]--;
                log(best.name + ' -> ' + res + ' vol=' + bestVol.toFixed(2) + ' time=' + Math.round(bestTime / 60000) + 'm');
            }
        });

        rows.forEach(function (row) { _apply(row, assigned[row.id] || row.cancel); });
    }

    // ------------------------------------------------------------------ explorers
    // Classify a loot table name relative to a task: main | lovely | extra | null (ignore).
    function _tableRole(name, task) {
        var kind = name.indexOf('FindTreasure') === 0 ? 'FindTreasure'
                 : (name.indexOf('FindAdventure') === 0 || name === 'IntrepidLoot') ? 'FindAdventureZone' : null;
        if (kind !== task.taskName) return null;
        if (name === task.key) return 'main';
        var parts = name.split('_');
        if (EVENT_SUFFIX.test(parts[parts.length - 1])) return null;
        var head = parts[0], sub = '';
        var prefix = head.match(/^(FindTreasure|FindAdventureZone|FindAdventure)/);
        if (prefix) sub = head.slice(prefix[0].length);
        if (!sub) {
            for (var i = 1; i < parts.length && !sub; i++) if (SUBS.indexOf(parts[i]) >= 0) sub = parts[i];
        }
        if (sub && sub !== task.sub) return null;
        if (parts[1] === 'Lovely' || /_Lovely$/.test(name)) return 'lovely';
        return 'extra';
    }

    // Loot factor relative to a plain explorer (1.0 = no bonuses).
    function _lootFactor(mods, task) {
        var base = BASE_ROLLS[task.key] || 1;
        var rolls = { main: base, lovely: 0 }, extra = 0, count = 1, bonus = 0;
        var lovelyEV = LOVELY_EV[task.sub] || 1.5;
        var shares = ITEM_SHARE[task.sub] || {};
        var totalPrio = TOTAL_PRIO[task.sub] || DEFAULT_TOTAL_PRIO;

        mods.forEach(function (m) {
            if (!_applies(m, task)) return;
            var roles = {};
            if (m.names.length === 0) roles.main = true;
            m.names.forEach(function (n) { var r = _tableRole(n, task); if (r) roles[r] = true; });

            switch (m.mod) {
                case 'changeloottablerolls':
                    ['main', 'lovely'].forEach(function (r) {
                        if (!roles[r]) return;
                        if (m.mult !== 1) rolls[r] *= 1 + m.chance * (m.mult - 1);
                        rolls[r] = Math.max(0, rolls[r] + m.chance * m.add);
                    });
                    if (roles.extra && m.add > 0) extra += m.chance * m.add;
                    break;
                case 'changelootcount':
                    if (!roles.main && !roles.lovely) {
                        if (roles.extra) bonus += EXTRA_ROLL_VALUE * (m.mult - 1) * DEFAULT_ITEM_SHARE;
                        break;
                    }
                    count *= m.item ? 1 + (shares[m.item] || DEFAULT_ITEM_SHARE) * (m.mult - 1) : m.mult;
                    break;
                case 'changelootchance':
                    if (roles.main || roles.lovely) count *= 1 + m.value / (totalPrio + m.value);
                    break;
                case 'modifiereffect':
                    bonus += m.chance * EFFECT_VALUE;
                    break;
                case 'searchcost':
                    bonus += Math.max(0, 1 - m.mult) * 0.1;
                    break;
            }
        });

        var total = (rolls.main + rolls.lovely * lovelyEV) * count + extra * EXTRA_ROLL_VALUE + bonus;
        return total / base;
    }

    function _autoPickExplorers() {
        var prio = DM_config.explPriority, perHour = DM_config.explMetric !== 'run';

        _rows().forEach(function (row) {
            var spec = _getSpec(row.id), mods = _getModifiers(spec), tb = _timeBonus(spec);
            var name = _specName(spec, row.id);
            var tasks = {};

            row.$sel.find('option').each(function () {
                var val = $(this).val();
                if (!val || val === row.cancel) return;
                var task = _task(val);
                if (!task) return;
                var factor = _lootFactor(mods, task), time = _duration(mods, task, tb);
                // base value of a run is assumed proportional to its base duration
                task.score = perHour ? factor * task.duration / time : factor * task.duration;
                // advantage over a plain explorer on this task (own time bonus cancels out)
                task.adv = perHour ? factor * (task.duration / (time * tb / 100)) : factor;
                task.time = time;
                tasks[val] = task;
            });

            function pick(vals, field) {
                var best = null;
                vals.forEach(function (v) {
                    var t = tasks[v];
                    if (!t) return;
                    if (!best || t[field] > best[field] + EPS ||
                        (Math.abs(t[field] - best[field]) <= EPS &&
                         (perHour ? t.duration < best.duration : t.duration > best.duration))) best = t;
                });
                return best;
            }

            var bestTreasure = pick(TREASURE_VALS, 'score');
            var choice = bestTreasure;

            if (prio === 'none') {
                var advSpec = pick(ADVENTURE_VALS, 'adv');
                if (advSpec && bestTreasure && advSpec.adv >= ADV_THRESHOLD * bestTreasure.adv) choice = pick(ADVENTURE_VALS, 'score');
            } else if (prio === 'adventure') {
                var adv = pick(ADVENTURE_VALS, 'score');
                var trSpec = pick(TREASURE_VALS, 'adv');
                choice = adv || bestTreasure;
                if (adv && trSpec && trSpec.adv >= SPEC_THRESHOLD * adv.adv) choice = pick(TREASURE_VALS, 'score');
            } else if (prio !== 'treasure') {
                var target = tasks[prio];
                if (target) {
                    choice = target;
                    var spec1 = pick(TREASURE_VALS.concat(ADVENTURE_VALS), 'adv');
                    var isAdv = spec1 && spec1.taskName === 'FindAdventureZone' && target.taskName !== 'FindAdventureZone';
                    if (spec1 && spec1.adv >= (isAdv ? ADV_THRESHOLD : SPEC_THRESHOLD) * target.adv) {
                        choice = (spec1.taskName === 'FindAdventureZone') ? pick(ADVENTURE_VALS, 'score') : spec1;
                    }
                }
            }

            if (DEBUG) {
                log(name + ': ' + Object.keys(tasks).map(function (v) {
                    return tasks[v].key + ' s=' + tasks[v].score.toExponential(2) + ' a=' + tasks[v].adv.toFixed(2);
                }).join(', ') + ' => ' + (choice ? choice.key : 'cancel'));
            }
            _apply(row, choice ? choice.val : row.cancel);
        });
    }

})();
