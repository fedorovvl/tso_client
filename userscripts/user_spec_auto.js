// Author: MadFx

(function () {

    if (specSharedHandler.__autoPickPatched) return;
    var _origHandler = specSharedHandler;

    var SCRIPT_PREFIX      = 'user_auto_pick_spec_';

    var VALUE_MAP = {
        '0,0': 'Stone',
        '0,1': 'BronzeOre',
        '0,2': 'Marble',
        '0,3': 'IronOre',
        '0,4': 'GoldOre',
        '0,5': 'Coal',
        '0,6': 'Granite',
        '0,7': 'TitaniumOre',
        '0,8': 'Salpeter'
    };

    var MOD = {
        FIND_DEPOSIT     : 'finddeposit',
        DEPOSIT_CAPACITY : 'searchdepositcapacity',
        DEPOSIT_SPEEDUP  : 'depositspeedup',
        MODIFIER_EFFECT  : 'modifiereffect',
        SEARCH_TIME      : 'searchtime',
        SEARCH_COST      : 'searchcost',
        LOOT_COUNT       : 'changelootcount',
        LOOT_CHANCE      : 'changelootchance',
        LOOT_ROLLS       : 'changeloottablerolls',
        LOOT_ADD         : 'addloot',
        LOOT_CHANGE      : 'changeloot'
    };

    var DEFAULT_ORDER = [
        'Salpeter', 'TitaniumOre',
        'Granite', 'GoldOre', 'IronOre', 'Coal',
        'BronzeOre', 'Marble', 'Stone'
    ];

    var DM_config = { order: DEFAULT_ORDER.slice() };

    function _loadSettings() {
        try {
            var saved = settings.read(null, SCRIPT_PREFIX + 'SETTINGS');
            if (saved && saved.order && Array.isArray(saved.order)) {
                $.extend(DM_config, saved);
            }
        } catch (e) {
            debug('[AutoPick] settings.read failed: ' + e);
        }
    }

    function _saveSettings() {
        try {
            settings.settings[SCRIPT_PREFIX + 'SETTINGS'] = {};
            settings.store(DM_config, SCRIPT_PREFIX + 'SETTINGS');
        } catch (e) {
            debug('[AutoPick] settings.store failed: ' + e);
        }
    }

    _loadSettings();

    function _getPriority(res) {
        var idx = DM_config.order.indexOf(res);
        return idx === -1 ? 0 : (DM_config.order.length - idx) * 10;
    }

    specSharedHandler = function (type) {
        _origHandler.apply(this, arguments);
        if (type !== 1 && type !== 2) return;

        var $footer = $('#specModal .modal-footer');

        if ($('#specAutoPickBtn').length === 0) {
            $('<button>', { id: 'specAutoPickBtn', 'class': 'btn btn-warning pull-left',
                style: 'margin-right:4px' })
                .text('⚡ Auto').appendTo($footer);

            $('<button>', { id: 'specResetBtn', 'class': 'btn btn-default pull-left',
                style: 'margin-right:4px' })
                .text('⟳').appendTo($footer);

            $('<button>', { id: 'specPriorityBtn', 'class': 'btn btn-default pull-left' })
                .text('⚙').appendTo($footer);
        }

        var t = type;
        $('#specAutoPickBtn').off('click.ap').on('click.ap', function () {
            if (t === 2) _autoPickGeologists(); else _autoPickExplorers();
        });
        $('#specResetBtn').off('click.ap').on('click.ap', _resetAll);
        $('#specPriorityBtn')
            .toggle(t === 2)
            .off('click.ap').on('click.ap', _showPriorityPanel);
    };

    function _resetAll() {
        $('#specModalData select').each(function () {
            var id = $(this).attr('id');
            if (!id || id === 'specMassChange') return;
            var v = $(this).find('option:first').val();
            $(this).val(v).trigger('change');
            updateSpecTimeRow(this, v, v);
        });
    }

    function _showPriorityPanel() {
        $('#geoPriorityPanel').remove();

        var $panel = $('<div>', {
            id: 'geoPriorityPanel',
            css: {
                position: 'fixed', top: '50%', left: '50%',
                transform: 'translate(-50%,-50%)',
                background: '#2a1f0f', border: '2px solid #8b6914',
                borderRadius: '8px', padding: '16px', zIndex: 9999,
                minWidth: '280px', boxShadow: '0 4px 24px rgba(0,0,0,0.8)',
                color: '#f0d890'
            }
        });

        $panel.append($('<div>', {
            html: '<b>'+ loca.GetText('HIL','Help_window_target_order_0') +'</b><br>',
            css: { textAlign: 'center', marginBottom: '10px',
                borderBottom: '1px solid #8b6914', paddingBottom: '8px' }
        }));

        var $list = $('<ol>', { css: { margin: '0 0 12px', padding: '0 0 0 22px', userSelect: 'none' } });

        DM_config.order.forEach(function (res, i) {
            $('<li>', {
                'data-res': res,
                css: {
                    padding: '5px 10px', margin: '3px 0',
                    background: '#3d2f10', border: '1px solid #6b4f1a',
                    borderRadius: '4px', cursor: 'grab',
                    listStyle: 'decimal inside'
                }
            }).text(loca.GetText('RES',res)).appendTo($list);
        });

        _makeDraggable($list);
        $panel.append($list);

        var $btns = $('<div>', { css: { textAlign: 'center' } });

        $('<button>', { 'class': 'btn btn-success btn-sm', css: { marginRight: '6px' } })
            .text('✓ ' + loca.GetText('LAB','Accept'))
            .on('click', function () {
                var newOrder = [];
                $list.find('li').each(function () { newOrder.push($(this).data('res')); });
                DM_config.order = newOrder;
                _saveSettings();
                debug('[AutoPick] Priority saved: ' + newOrder.join(', '));
                $panel.remove();
            }).appendTo($btns);

        $('<button>', { 'class': 'btn btn-default btn-sm', css: { marginRight: '6px' } })
            .text('↺ ' + loca.GetText('LAB','Decline'))
            .on('click', function () {
                DM_config.order = DEFAULT_ORDER.slice();
                _saveSettings();
                $panel.remove();
                _showPriorityPanel();
            }).appendTo($btns);

        $('<button>', { 'class': 'btn btn-danger btn-sm' })
            .text('✕')
            .on('click', function () { $panel.remove(); })
            .appendTo($btns);

        $panel.append($btns);
        $('body').append($panel);
    }

    function _makeDraggable($list) {
        var $drag = null;
        $list.on('mousedown', 'li', function (e) {
            $drag = $(this).css('opacity', '0.5');
            e.preventDefault();
        });
        $list.on('mouseover', 'li', function () {
            if (!$drag || $drag[0] === this) return;
            var $over = $(this);
            if ($drag.index() < $over.index()) $over.after($drag);
            else $over.before($drag);
        });
        $(document).on('mouseup.geoPrio', function () {
            if ($drag) { $drag.css('opacity', '1'); $drag = null; }
        });
    }

    var GEO_VALID_RES = [
        'Stone', 'Marble', 'GoldOre', 'BronzeOre', 'IronOre',
        'TitaniumOre', 'Coal', 'Salpeter', 'Granite'
    ];

    function _getAvailableSlots() {
        var total = {};
        try {
            game.gi.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector()
                .filter(function (b) {
                    return b != null && b.GetBuildingName_string().indexOf('MineDepleted') >= 0;
                })
                .forEach(function (b) {
                    var name = b.GetBuildingName_string().replace('MineDepletedDeposit', '');
                    if (GEO_VALID_RES.indexOf(name) >= 0) {
                        total[name] = (total[name] || 0) + 1;
                    }
                });
        } catch (e) {
            debug('[AutoPick:Geo] building scan error: ' + e);
        }
        debug('[AutoPick:Geo] total depleted on map: ' + JSON.stringify(total));

        var working = {};
        try {
            game.gi.mCurrentPlayerZone.GetSpecialists_vector().forEach(function (item) {
                if (item.GetTask() == null || item.GetBaseType() !== 2 || item.getPlayerID() === -1) return;
                var res = item.GetTask().GetDepositToSearch_string();
                if (res) working[res] = (working[res] || 0) + 1;
            });
        } catch (e) {
            debug('[AutoPick:Geo] working scan error: ' + e);
        }
        debug('[AutoPick:Geo] working geologists: ' + JSON.stringify(working));

        var available = {};
        GEO_VALID_RES.forEach(function (res) {
            var t   = total[res]   || 0;
            var w   = working[res] || 0;
            var rem = Math.max(0, t - w);
            debug('[AutoPick:Geo] ' + res + ': total=' + t +
                ' working=' + w + ' available=' + rem);
            if (rem > 0) available[res] = rem;
        });
        return available;
    }

    function _autoPickGeologists() {
        var available = _getAvailableSlots();

        var demand = [], demandRes = {};
        for (var res in available) {
            if (!available.hasOwnProperty(res)) continue;
            var pri = _getPriority(res);
            demandRes[res] = true;
            for (var i = 0; i < available[res]; i++) {
                demand.push({ res: res, priority: pri });
            }
        }
        demand.sort(function (a, b) { return b.priority - a.priority; });
        debug('[AutoPick:Geo] demand: ' +
            demand.map(function (d) { return d.res + '(p=' + d.priority + ')'; }).join(', '));

        var geoRows = [];
        $('#specModalData select').each(function () {
            var id = $(this).attr('id');
            if (!id || id === 'specMassChange') return;
            geoRows.push({ selectId: id, $sel: $(this) });
        });

        if (demand.length === 0) {
            debug('[AutoPick:Geo] no available slots → all Cancel');
            _resetAll();
            return;
        }

        var scoreMatrix = {};

        geoRows.forEach(function (geo) {
            var specName = _getSpecName(geo.selectId);
            scoreMatrix[geo.selectId] = {};
            var allResScores = {};

            geo.$sel.find('option').each(function () {
                var val = $(this).val();
                if (!val || val === geo.$sel.find('option:first').val()) return;
                try {
                    var res = VALUE_MAP[val];

                    if (!res) {
                        var parts = val.split(',');
                        var info  = getTaskInfo(parts[0], parts[1]);
                        if (!info || !info.taskName) return;
                        var tk = info.taskName + info.subTaskName;
                        if (tk.indexOf('FindDeposit') !== 0) return;
                        res = tk.slice('FindDeposit'.length);
                    }

                    var parts2 = val.split(',');
                    var info2  = getTaskInfo(parts2[0], parts2[1]);
                    if (!info2) return;

                    var s = _evalSkills(geo.selectId, specName, info2).score;
                    if (!allResScores[res] || s > allResScores[res].score) {
                        allResScores[res] = { score: s, taskVal: val };
                    }
                } catch (e) {}
            });

            for (var r in allResScores) {
                if (allResScores.hasOwnProperty(r) && demandRes[r]) {
                    scoreMatrix[geo.selectId][r] = allResScores[r];
                }
            }

            debug('[AutoPick:Geo] "' + specName + '" [' +
                Object.keys(allResScores)
                    .map(function (r) { return r + '=' + allResScores[r].score.toFixed(0); })
                    .join(', ') + ']');
        });

        var assigned = {};

        demand.forEach(function (slot) {
            var bestId = null, bestScore = -Infinity;

            geoRows.forEach(function (geo) {
                if (assigned[geo.selectId] !== undefined) return;
                var entry = scoreMatrix[geo.selectId][slot.res];
                if (!entry) return;

                debug('[AutoPick:Geo] "' + _getSpecName(geo.selectId) + '" → ' + slot.res +
                    ' score=' + entry.score.toFixed(0));

                if (entry.score > bestScore) { bestScore = entry.score; bestId = geo.selectId; }
            });

            if (bestId !== null) {
                assigned[bestId] = scoreMatrix[bestId][slot.res].taskVal;
                debug('[AutoPick:Geo] ✓ "' + _getSpecName(bestId) + '" → ' + slot.res +
                    ' score=' + bestScore.toFixed(0));
            } else {
                debug('[AutoPick:Geo] ✗ no geologist for ' + slot.res);
            }
        });

        geoRows.forEach(function (geo) {
            var val = assigned[geo.selectId] !== undefined
                ? assigned[geo.selectId]
                : geo.$sel.find('option:first').val();
            geo.$sel.val(val).trigger('change');
            updateSpecTimeRow(geo.$sel[0], val, val);
        });
    }

    function _autoPickExplorers() {
        $('#specModalData select').each(function () {
            var $sel = $(this), id = $sel.attr('id');
            if (!id || id === 'specMassChange') return;
            var cancelVal = $sel.find('option:first').val();
            var best = cancelVal, bestScore = -Infinity, bestTR = Infinity;
            var specName = _getSpecName(id);

            $sel.find('option').each(function () {
                var val = $(this).val();
                if (!val || val === cancelVal) return;
                try {
                    var parts = val.split(',');
                    var info  = getTaskInfo(parts[0], parts[1]);
                    if (!info || !info.duration) return;
                    var r = _evalSkills(id, specName, info);
                    if (r.score > bestScore || (r.score === bestScore && r.timeRatio < bestTR)) {
                        bestScore = r.score; bestTR = r.timeRatio; best = val;
                    }
                } catch (e) {}
            });
            $sel.val(best).trigger('change');
            updateSpecTimeRow($sel[0], best, best);
        });
    }

    function _getSpecName(selectId) {
        try {
            var parts    = selectId.split('_');
            var uniqueID = game.def('Communication.VO::dUniqueID').Create(parts[0], parts[1]);
            var spec     = game.zone.getSpecialist(game.gi.mCurrentViewedZoneID, uniqueID);
            return spec.getName(false).replace(/<[^>]*>/g, '').trim();
        } catch (e) { return selectId; }
    }

    function _evalSkills(selectId, specName, taskInfo) {
        var parts    = selectId.split('_');
        var uniqueID = game.def('Communication.VO::dUniqueID').Create(parts[0], parts[1]);
        var spec     = game.zone.getSpecialist(game.gi.mCurrentViewedZoneID, uniqueID);
        var taskKey  = taskInfo.taskName + taskInfo.subTaskName;
        var baseDur  = taskInfo.duration || 1;
        var score    = 0, calcDur = baseDur;

        spec.getSkillTree().getItems_vector()
            .concat(spec.skills.getItems_vector())
            .forEach(function (skill) {
                var level = skill.getLevel();
                if (level <= 0) return;
                var skillName = skill.getDefinition().name_string || '?';
                var vIdx      = level - 1;
                var lvlDefs   = skill.getDefinition().level_vector[vIdx];
                if (!lvlDefs) return;

                lvlDefs.forEach(function (sd) {
                    var mult  = (typeof sd.multiplier === 'number' && !isNaN(sd.multiplier)) ? sd.multiplier : 1;
                    var add   = (typeof sd.adder     === 'number' && !isNaN(sd.adder))     ? sd.adder     : 0;
                    var val   = (typeof sd.value     === 'number' && !isNaN(sd.value))     ? sd.value     : 0;
                    var typeS = sd.type_string    || '';
                    var modS  = (sd.modifier_string || '').toLowerCase();
                    var isGen  = typeS.length === 0;
                    var isSpec = typeS === taskKey;

                    if ((isGen || isSpec) && modS === MOD.SEARCH_TIME) {
                        calcDur = (val !== 0) ? val : ((calcDur * mult) + add);
                    }
                    if (!isSpec) return;

                    var c = 0;
                    switch (modS) {
                        case MOD.DEPOSIT_CAPACITY:
                            c = Math.max(0, mult - 1) * 1000 + Math.max(0, add) * 5;
                            break;
                        case MOD.FIND_DEPOSIT:
                            c = Math.max(0, add) * 400 + Math.max(0, mult - 1) * 400;
                            break;
                        case MOD.DEPOSIT_SPEEDUP:
                            c = Math.max(0, mult - 1) * 300 + Math.max(0, add) * 3;
                            break;
                        case MOD.SEARCH_TIME:
                            c = (val !== 0)
                                ? Math.max(0, (baseDur - val) / baseDur) * 20
                                : Math.max(0, 1 - mult) * 20 + (baseDur > 0 ? Math.max(0, -add / baseDur) * 20 : 0);
                            break;
                        case MOD.MODIFIER_EFFECT:
                            c = Math.max(0, mult - 1) * 10 + add * 2;
                            if (c === 0 && (mult !== 1 || add !== 0)) c = 1;
                            break;
                        case MOD.LOOT_COUNT:   c = Math.max(0, mult-1)*8 + Math.max(0, add)*0.1; break;
                        case MOD.LOOT_CHANCE:  c = Math.max(0, mult-1)*8 + Math.max(0, val)*0.1; break;
                        case MOD.LOOT_ROLLS:   c = Math.max(0, mult-1)*6 + Math.max(0, add)*0.6; break;
                        case MOD.LOOT_ADD:     c = 4; break;
                        case MOD.LOOT_CHANGE:  c = 3; break;
                        case MOD.SEARCH_COST:  c = Math.max(0, 1 - mult) * 2; break;
                        default:               c = 1;  break;
                    }
                    if (c !== 0) {
                        debug('[AutoPick] "' + specName + '" skill="' + skillName +
                            '" lvl=' + level + ' mod="' + sd.modifier_string +
                            '" m=' + mult + ' a=' + add + ' → +' + c.toFixed(2));
                        score += c;
                    }
                });
            });

        return {
            score: score,
            timeRatio: baseDur > 0
                ? ((calcDur / spec.GetSpecialistDescription().GetTimeBonus()) * 100) / baseDur
                : 1
        };
    }

    specSharedHandler.__autoPickPatched = true;

})();