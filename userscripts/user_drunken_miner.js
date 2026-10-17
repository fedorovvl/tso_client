// language=JavaScript; ECMAScript 5.1
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////Created by MadFX | Thanks for PiTi for source code. ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
(function () {
    // The legacy version kept its runs in an inaccessible closure. Do not create
    // a parallel engine beside it: leave it running until a one-time client restart.
    var previousRuntime = window.TSO_DrunkenMiner;
    if ((!previousRuntime && typeof window.DM_MenuHandler === 'function') ||
        (previousRuntime && (previousRuntime.apiVersion !== 2 || typeof previousRuntime.prepareReload !== 'function'))) {
        var previousMenu = previousRuntime && previousRuntime.menuHandler || window.DM_MenuHandler;
        if (typeof previousMenu === 'function') {
            window.DM_MenuHandler = previousMenu;
            addToolsMenuItem(loca.GetText('RES', 'BuffAd_Drunken_Miner'), previousMenu);
        }
        try {
            _DM_debug('DM/legacy_runtime_requires_restart');
        } catch (ignored) {}
        return;
    }
    var SCRIPT_PREFIX    = 'DM_';
    var DM_MaxUpgradeLvl = 7;
    var RESOURCES = {
        ores: ["BronzeOre", "IronOre", "Coal", "GoldOre", "TitaniumOre", "Salpeter"],
        oreOrder: {
            BronzeOre: 1, IronOre: 2, Coal: 3, GoldOre: 4, TitaniumOre: 5, Salpeter: 6
        },
        mines: [
            "BronzeMine", "EpicBronzeMine", "BronzeMineEndless",
            "IronMine", "EpicIronMine", "ArcticIronMine",
            "CoalMine", "EpicCoalMine",
            "GoldMine", "EpicGoldMine",
            "TitaniumMine", "EpicTitaniumMine", "ArcticTitaniumMine",
            "SalpeterMine", "EpicSalpeterMine",
            "IronMineEndless", "CoalMineEndless", "GoldMineEndless", "ArcticGoldMine"
        ],
        // Улучшаемые шахты (gfx_settings: BuildingUpgradeBonuses уровни 0..7).
        // Epic*, Arctic*, SpookyBronzeMine имеют только уровень 1 — не улучшаются.
        upgradableMines: [
            "BronzeMine", "IronMine", "CoalMine", "GoldMine", "TitaniumMine", "SalpeterMine",
            "BronzeMineEndless", "IronMineEndless", "CoalMineEndless", "GoldMineEndless"
        ],
        assertNames: [
            "IronOre", "Coal", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter", "MineDepletedDepositIronOre",
            "MineDepletedDepositCoal", "MineDepletedDepositBronzeOre", "MineDepletedDepositGoldOre",
            "MineDepletedDepositTitaniumOre", "MineDepletedDepositSalpeter", "MineDepletedDepositGoldOreIndustrial",
            "MineDepletedDepositIronOreIndustrial"
        ],
        icons: {
            IronOre: 'ButtonIconIron',
            Coal: 'ButtonIconCoal',
            BronzeOre: 'ButtonIconBronze',
            GoldOre: 'ButtonIconGold',
            TitaniumOre: 'ButtonIconTitanium',
            Salpeter: 'ButtonIconSalpeter'
        },
        buildMapping: {
            IronOre: {number: 50, text: "IronOre"},
            Coal: {number: 37, text: "Coal"},
            BronzeOre: {number: 36, text: "BronzeOre"},
            GoldOre: {number: 46, text: "GoldOre"},
            TitaniumOre: {number: 69, text: "TitaniumOre"},
            Salpeter: {number: 63, text: "Salpeter"}
        },
        mineToOre: {
            BronzeMine: "BronzeOre", EpicBronzeMine: "BronzeOre", BronzeMineEndless: "BronzeOre",
            IronMine: "IronOre", EpicIronMine: "IronOre", ArcticIronMine: "IronOre", IronMineEndless: "IronOre",
            CoalMine: "Coal", EpicCoalMine: "Coal", CoalMineEndless: "Coal",
            GoldMine: "GoldOre", EpicGoldMine: "GoldOre", GoldMineEndless: "GoldOre", ArcticGoldMine: "GoldOre",
            TitaniumMine: "TitaniumOre", EpicTitaniumMine: "TitaniumOre", ArcticTitaniumMine: "TitaniumOre",
            SalpeterMine: "Salpeter", EpicSalpeterMine: "Salpeter"
        },
        maxLevelDefaults: {
            IronOre: 1,
            CoalOre: 1,
            BronzeOre: 1,
            GoldOre: 1,
            TitaniumOre: 1,
            SalpeterOre: 1
        }
    };

    var CMD_BUILD = 50; // Existing build action; native upgrade/production methods below.

    var DM_build_newTemplates;

    var DM_AutoModeSwitchStatus    = false;
    var DM_UpgradeSwitchStatus     = false;

    var DM_lements = {
        ON_OFF_RADIO:             SCRIPT_PREFIX + 'StateSwitch',
        ON_OFF_RADIO_TEXT:        SCRIPT_PREFIX + 'StateSwitch_TEXT',
        ON_OFF_AUTOMODE_RADIO:    SCRIPT_PREFIX + 'AutoModeStateSwitch',
        ON_OFF_AUTOMODE_RADIO_TEXT: SCRIPT_PREFIX + 'AutoModeStateSwitch_TEXT',
        BUILD_CHECKBX:            SCRIPT_PREFIX + 'buildCheckBox',
        UPGR_CHECKBX:             SCRIPT_PREFIX + 'upgrCheckBox',
        SAFE_BUFF_BTN:            SCRIPT_PREFIX + 'toggleSafeBuffing',
        SELECT_ALL_BTN:           SCRIPT_PREFIX + 'selectAll_ALL',
        STOP_AFTER_BUILD_BTN:     SCRIPT_PREFIX + 'stopAfterBuild',
        STOP_AFTER_BUILD_LABEL:   SCRIPT_PREFIX + 'stopAfterBuildLabel',
    };

    var DM_SwitchStatuses = {
        UPGRADE:      loca.GetText('ACL', 'Upgrades'),
        BUILD:        loca.GetText('BUI', 'TwinTown_building_spot'),
        AUTOMODE_ON:  loca.GetText('ACL', 'BuildQueueSlotTemp') + ' ' + loca.GetText('LAB', 'Yes'),
        AUTOMODE_OFF: loca.GetText('ACL', 'BuildQueueSlotTemp') + ' ' + loca.GetText('LAB', 'No'),
        AUTOSTOP_ON:  loca.GetText('LAB', 'StopProduction') + ' ' + loca.GetText('LAB', 'Yes'),
        AUTOSTOP_OFF: loca.GetText('LAB', 'StopProduction') + ' ' + loca.GetText('LAB', 'No'),
    };

    var DM_config = {
        build: [],
        upgrade: [],
        switchStatus:     DM_UpgradeSwitchStatus,
        AutoModeStatus:   DM_AutoModeSwitchStatus,
        maxLvl:           $.extend({}, RESOURCES.maxLevelDefaults),
        safeBuffing:      false,
        stopAfterBuild:   false
    };
    $.extend(DM_config, settings.read(null, SCRIPT_PREFIX + 'SETTINGS'));
    DM_config.maxLvl  = $.extend({}, RESOURCES.maxLevelDefaults, DM_config.maxLvl || {});
    DM_config.build   = Array.isArray(DM_config.build)   ? DM_config.build   : [];
    DM_config.upgrade = Array.isArray(DM_config.upgrade) ? DM_config.upgrade : [];

    // Runtime survives reloadScripts. Only a new submission replaces its own run type.
    // Sent commands cannot be cancelled: receipts survive replacements and reloads.
    var DM_SEND_INTERVAL       = 1000;
    var DM_BUILD_VERIFY_MS     = 15000;
    var DM_UPGRADE_PENDING_MS  = 20000;
    var DM_RECONCILE_MS        = 120000;
    var DM_MIN_DELAY           = 3000;
    var DM_MAX_DELAY           = 60000;
    var DM_OFFZONE_DELAY       = 15000;
    var DM_STOPWATCH_DELAY     = 15000;
    var DM_BUILD_DURATION = { BronzeOre: 300, IronOre: 300, Coal: 600, GoldOre: 600, Salpeter: 1200, TitaniumOre: 1500 };
    var DM_BUILD_NAME = {
        BronzeOre: 'BronzeMine', IronOre: 'IronMine', Coal: 'CoalMine',
        GoldOre: 'GoldMine', TitaniumOre: 'TitaniumMine', Salpeter: 'SalpeterMine'
    };
    var DM_alive = true;
    var DM_previous = window.TSO_DrunkenMiner;
    if (DM_previous && DM_previous.apiVersion === 2 && typeof DM_previous.prepareReload === 'function') {
        DM_previous.prepareReload();
    }
    var DM_runtime = DM_previous && DM_previous.apiVersion === 2 ? DM_previous : {
        apiVersion: 2, runs: { build: _DM_newRun(false), upgrade: _DM_newRun(true) },
        receipts: { build: {}, upgrade: {} }, stopWatch: {}, serviceTimer: null,
        sender: { items: [], timer: null, lastSentAt: 0 }, saveTimer: null,
        lastSaved: null, config: null, ui: { closing: false, opening: false, reopen: false },
        uiWaitTimer: null, uiWaitNodes: [], uiReopenTimer: null
    };
    var DM_runs = DM_runtime.runs;
    var DM_stopWatch = DM_runtime.stopWatch;
    var DM_sender = DM_runtime.sender;
    var DM_rowData = {};
    var DM_iconCache = {};
    var DM_iconCacheSize = 0;
    var DM_economics = null;
    DM_config = _DM_normalizeConfig(DM_runtime.config || DM_config);
    DM_runtime.config = DM_config;

    function _DM_debug(error) {
        try { if (typeof debug === 'function') debug(error); } catch (ignored) {}
    }

    function _DM_notify(text) {
        try { game.showAlert(text); } catch (e) { _DM_debug(e); }
    }

    function _DM_grid(value) {
        if (typeof value !== 'string' && typeof value !== 'number') return null;
        var text = String(value);
        if (!/^\d+$/.test(text)) return null;
        var n = Number(text);
        return isFinite(n) && n > 0 && Math.floor(n) === n && n <= 2147483647 ? String(n) : null;
    }

    function _DM_grids(values) {
        var seen = {}, result = [];
        if (!Array.isArray(values)) return result;
        values.forEach(function (value) {
            var grid = _DM_grid(value);
            if (grid && !seen[grid]) { seen[grid] = true; result.push(grid); }
        });
        return result;
    }

    function _DM_normalizeConfig(data) {
        data = data && typeof data === 'object' && !Array.isArray(data) ? data : {};
        var result = {
            schemaVersion: 2, build: _DM_grids(data.build), upgrade: _DM_grids(data.upgrade),
            switchStatus: data.switchStatus === true, AutoModeStatus: data.AutoModeStatus === true,
            maxLvl: {}, safeBuffing: data.safeBuffing === true, stopAfterBuild: data.stopAfterBuild === true
        };
        Object.keys(RESOURCES.maxLevelDefaults).forEach(function (key) {
            var raw = data.maxLvl && data.maxLvl[key];
            var level = (typeof raw === 'number' || typeof raw === 'string') ? Number(raw) : NaN;
            result.maxLvl[key] = isFinite(level) && level >= 1 ? Math.min(DM_MaxUpgradeLvl, Math.floor(level)) : 1;
        });
        return result;
    }

    function _DM_isHomeZone(gi) {
        if (!gi) return false;
        if (typeof gi.isOnHomzone === 'function' && !gi.isOnHomzone()) return false;
        var cur = gi.mCurrentPlayer;
        var home = gi.mHomePlayer;
        if (!cur || !home) return false;
        if (typeof cur.GetPlayerId === 'function' && typeof home.GetPlayerId === 'function') {
            if (cur.GetPlayerId() !== home.GetPlayerId()) return false;
        }
        var curHomeZone = typeof cur.GetHomeZoneId === 'function' ? cur.GetHomeZoneId() : (typeof home.GetHomeZoneId === 'function' ? home.GetHomeZoneId() : null);
        if (curHomeZone == null || Number(curHomeZone) <= 0) return false;
        if (String(gi.mCurrentViewedZoneID) !== String(curHomeZone)) return false;
        return true;
    }

    function _DM_context(homeZoneId) {
        try {
            var gi = typeof swmmo !== 'undefined' && swmmo.application ? swmmo.application.mGameInterface : null;
            if (!gi && typeof game !== 'undefined') gi = game.gi;
            if (!gi || !gi.mCurrentPlayerZone || !gi.mCurrentPlayerZone.mStreetDataMap) return null;
            if (!_DM_isHomeZone(gi)) return null;
            var cur = gi.mCurrentPlayer;
            var homePlayer = (gi.mHomePlayer && gi.mHomePlayer.mBuildQueue) ? gi.mHomePlayer : cur;
            var curHomeZone = typeof cur.GetHomeZoneId === 'function' ? cur.GetHomeZoneId() : homePlayer.GetHomeZoneId();
            var id = String(curHomeZone);
            if (homeZoneId != null && String(homeZoneId) !== id) return null;
            return { gi: gi, zone: gi.mCurrentPlayerZone, home: homePlayer, homeZoneId: id };
        } catch (e) { return null; }
    }

    function _DM_bld(grid, context) {
        var ctx = context || _DM_context();
        if (!ctx) return null;
        // Let bridge errors propagate to the task boundary: an error is not an empty tile.
        return ctx.zone.GetBuildingFromGridPosition(Number(grid));
    }

    function _DM_deposit(grid, context) {
        var ctx = context || _DM_context();
        if (!ctx) return null;
        var map = ctx.zone.mStreetDataMap;
        return map.mDepositContainer ? map.mDepositContainer.get(Number(grid)) : null;
    }

    function _DM_depositOre(grid, context) {
        var deposit = _DM_deposit(grid, context);
        return deposit ? deposit.GetName_string() : null;
    }

    function _DM_call(obj, fn, def) {
        try { return obj && typeof obj[fn] === 'function' ? obj[fn]() : def; } catch (e) { return def; }
    }

    function _DM_maxLvlFor(buildingName, limits) {
        var ore = RESOURCES.mineToOre[buildingName];
        if (!ore) return 0;
        var key = ore === 'Coal' || ore === 'Salpeter' ? ore + 'Ore' : ore;
        var v = Number((limits || DM_config.maxLvl)[key]);
        return isFinite(v) ? Math.min(DM_MaxUpgradeLvl, Math.max(1, Math.floor(v))) : 1;
    }

    function _DM_isUpgradableMine(name) { return RESOURCES.upgradableMines.indexOf(name) !== -1; }
    function _DM_isUpgradeBusy(bld) {
        return _DM_call(bld, 'IsUpgradeInProgress', false) || _DM_call(bld, 'IsUpgradeInitiated', false);
    }
    function _DM_removeFrom(list, grid) {
        var i = list.indexOf(String(grid));
        if (i !== -1) list.splice(i, 1);
    }
    function _DM_runType(run) { return run.isUpgrade ? 'upgrade' : 'build'; }
    function _DM_runName(run) {
        return loca.GetText('RES', 'BuffAd_Drunken_Miner') + ' (' + (run.isUpgrade ? DM_SwitchStatuses.UPGRADE : DM_SwitchStatuses.BUILD) + ')';
    }
    function _DM_newRun(isUpgrade) {
        return {
            id: 0, active: false, isUpgrade: isUpgrade, oneShot: false, sentOnce: false,
            grids: [], pending: {}, timer: null, targets: {}, expected: {}, limits: {},
            homeZoneId: null, stopAfterBuild: false, errorCount: 0
        };
    }

    // Internal replacement, not a UI Stop. Never cancel independent completion watches.
    function _DM_replaceRun(run) {
        var type = _DM_runType(run);
        run.id++;
        run.active = false;
        if (run.timer !== null) { clearTimeout(run.timer); run.timer = null; }
        DM_sender.items = DM_sender.items.filter(function (item) { return item.kind !== type; });
        run.pending = {};
        run.grids = [];
    }

    function _DM_finishGrid(run, grid, removeSelection) {
        _DM_removeFrom(run.grids, grid);
        delete run.pending[grid];
        if (removeSelection) {
            _DM_removeFrom(run.isUpgrade ? DM_config.upgrade : DM_config.build, grid);
            _DM_saveTmpSetting();
        }
    }

    function _DM_canChooseUpgrade(grid) {
        try {
            var b = _DM_bld(grid);
            var name = _DM_call(b, 'GetBuildingName_string', '');
            return !!b && _DM_isUpgradableMine(name) && !_DM_isUpgradeBusy(b) &&
                !_DM_call(b, 'IsWaitForCommand', true) &&
                !DM_runtime.receipts.upgrade[String(grid)] &&
                !DM_runs.upgrade.pending[String(grid)];
        } catch (e) { return false; }
    }

    function _DM_selectionCheckboxes() {
        var cls = DM_UpgradeSwitchStatus ? DM_lements.UPGR_CHECKBX : DM_lements.BUILD_CHECKBX;
        return $('#DrunkenMinerModalData input[type="checkbox"].' + cls + ':enabled');
    }

    function _DM_startRun(isUpgrade, values, oneShot) {
        var ctx = _DM_context();
        if (!ctx) { _DM_notify(getText('not_home')); return; }
        var grids = _DM_grids(values);
        var run = isUpgrade ? DM_runs.upgrade : DM_runs.build;
        if (!grids.length) { _DM_debug('DM/no_targets'); return; }
        _DM_flushSettings();
        _DM_replaceRun(run);
        run.active = true;
        run.oneShot = !!oneShot;
        run.sentOnce = false;
        run.grids = grids;
        run.targets = {};
        run.expected = {};
        run.limits = $.extend({}, DM_config.maxLvl);
        run.stopAfterBuild = !!DM_config.stopAfterBuild;
        run.homeZoneId = ctx.homeZoneId;
        run.errorCount = 0;
        // An already sent command is adopted, not submitted a second time.
        grids.forEach(function (grid) {
            var receipt = DM_runtime.receipts[_DM_runType(run)][grid];
            if (receipt && receipt.homeZoneId === ctx.homeZoneId) {
                run.pending[grid] = receipt;
                if (isUpgrade && run.oneShot) run.targets[grid] = Math.min(_DM_maxLvlFor(receipt.name, run.limits), receipt.targetLevel);
            }
        });
        _DM_tick(run, run.id);
    }

    function _DM_schedule(run, runId, delay) {
        if (!DM_alive || runId !== run.id || !run.active) return;
        if (run.timer !== null) clearTimeout(run.timer);
        run.timer = setTimeout(function () {
            if (!DM_alive || runId !== run.id || !run.active) return;
            run.timer = null;
            _DM_tick(run, runId);
        }, Math.max(DM_MIN_DELAY, Math.min(delay, DM_MAX_DELAY)));
    }

    function _DM_tick(run, runId) {
        if (!DM_alive || runId !== run.id || !run.active) return;
        try {
            var ctx = _DM_context(run.homeZoneId);
            if (!ctx) { _DM_schedule(run, runId, DM_OFFZONE_DELAY); return; }
            _DM_reconcileReceipts(ctx);
            var delay = run.isUpgrade ? _DM_upgradeStep(run, ctx) : _DM_buildStep(run, ctx);
            run.errorCount = 0;
            if (delay === null) {
                run.active = false;
                run.timer = null;
                // All queued items have been reconciled before finishing.
                return;
            }
            _DM_schedule(run, runId, delay);
        } catch (e) {
            _DM_debug(e);
            run.errorCount++;
            if (run.errorCount === 1) _DM_debug('DM/read_error_paused');
            _DM_schedule(run, runId, Math.min(DM_MAX_DELAY, DM_MIN_DELAY * Math.pow(2, Math.min(run.errorCount, 5))));
        }
    }

    function _DM_freeQueueSlots(context) {
        var ctx = context || _DM_context();
        if (!ctx) return 0;
        var queue = ctx.home.mBuildQueue;
        var free = queue.GetTotalAvailableSlots() - queue.GetQueue_vector().length;
        return isFinite(free) ? Math.max(0, Math.floor(free)) : 0;
    }

    function _DM_reservedBuildSlots(ctx) {
        var grids = {};
        Object.keys(DM_runs.build.pending).forEach(function (grid) {
            if (DM_runs.build.pending[grid].status === 'queued') grids[grid] = true;
        });
        Object.keys(DM_runtime.receipts.build).forEach(function (grid) {
            var r = DM_runtime.receipts.build[grid];
            if (r.homeZoneId === ctx.homeZoneId && r.status !== 'confirmed' && r.status !== 'mismatch' && !_DM_bld(grid, ctx)) grids[grid] = true;
        });
        return Object.keys(grids).length;
    }

    function _DM_nearestQueueFinish(ctx) {
        var min = DM_MAX_DELAY;
        var vec = ctx.home.mBuildQueue.GetQueue_vector();
        for (var i = 0; i < vec.length; i++) {
            var t = _DM_call(vec[i], 'GetRemainingConstructionDuration', 0);
            if (t > 0) min = Math.min(min, t + 1500);
        }
        return min;
    }

    function _DM_receiptDone(run, grid, receipt) {
        if (receipt.status === 'confirmed') {
            delete run.pending[grid];
            return true;
        }
        if (receipt.status === 'mismatch' || (receipt.status === 'unknown' && Date.now() - receipt.sentAt >= DM_RECONCILE_MS)) {
            _DM_debug('DM/command_unconfirmed [' + grid + ']');
            _DM_finishGrid(run, grid, false);
            return true;
        }
        return false;
    }

    function _DM_buildStep(run, ctx) {
        var candidates = [], skipped = 0;
        run.grids.slice().forEach(function (grid) {
            var pending = run.pending[grid];
            if (pending) {
                if (pending.status === 'queued') return;
                if (!_DM_receiptDone(run, grid, pending)) return;
                if (pending.status === 'confirmed') _DM_finishGrid(run, grid, true);
                return;
            }
            var bld = _DM_bld(grid, ctx);
            var ore = _DM_depositOre(grid, ctx);
            if (bld || !RESOURCES.buildMapping[ore]) { _DM_finishGrid(run, grid, true); return; }
            var deposit = _DM_deposit(grid, ctx);
            if (!deposit || deposit.GetAmount() <= 0) { _DM_finishGrid(run, grid, true); return; }
            candidates.push({ grid: grid, ore: ore });
        });
        if (!run.grids.length) return null;
        candidates.sort(function (a, b) {
            return (DM_BUILD_DURATION[a.ore] - DM_BUILD_DURATION[b.ore]) || (RESOURCES.oreOrder[a.ore] - RESOURCES.oreOrder[b.ore]) || (Number(a.grid) - Number(b.grid));
        });
        var free = Math.max(0, _DM_freeQueueSlots(ctx) - _DM_reservedBuildSlots(ctx));
        if (!(run.oneShot && run.sentOnce)) {
            candidates.forEach(function (candidate) {
                if (free <= 0) {
                    if (run.oneShot) { skipped++; _DM_finishGrid(run, candidate.grid, false); }
                    return;
                }
                free--;
                var item = { kind: 'build', grid: candidate.grid, ore: candidate.ore,
                    name: DM_BUILD_NAME[candidate.ore], runId: run.id, homeZoneId: run.homeZoneId,
                    stopAfterBuild: run.stopAfterBuild };
                run.pending[item.grid] = { status: 'queued' };
                DM_sender.items.push(item);
            });
            run.sentOnce = true;
        }
        if (skipped) {
            _DM_notify(loca.GetText('LAB', 'FullBuildQueue'));
            _DM_debug('DM/manual_build_skipped=' + skipped);
        }
        _DM_wakeSender();
        if (!run.grids.length) return null;
        return Object.keys(run.pending).length ? 5000 : _DM_nearestQueueFinish(ctx);
    }

    function _DM_upgradeRemaining(bld, ctx) {
        var start = _DM_call(bld, 'GetUpgradeStartTime', 0);
        var duration = _DM_call(bld, 'GetUpgradeDuration', -1);
        return start > 0 && duration > 0 ? Math.max(0, start + duration - ctx.gi.GetClientTime()) : null;
    }

    function _DM_upgradeStep(run, ctx) {
        var minRemaining = DM_MAX_DELAY;
        run.grids.slice().forEach(function (grid) {
            var pending = run.pending[grid];
            if (pending) {
                if (pending.status === 'queued') return;
                if (!_DM_receiptDone(run, grid, pending)) return;
                if (run.grids.indexOf(grid) === -1) return;
            }
            var bld = _DM_bld(grid, ctx);
            var name = bld ? bld.GetBuildingName_string() : '';
            if (!bld || !_DM_isUpgradableMine(name)) { _DM_finishGrid(run, grid, true); return; }
            var level = bld.GetUIUpgradeLevel();
            if (run.expected[grid] && run.expected[grid] !== name) { _DM_finishGrid(run, grid, false); return; }
            run.expected[grid] = name;
            if (run.targets[grid] === undefined) {
                var receipt = DM_runtime.receipts.upgrade[grid];
                var firstTarget = receipt ? receipt.targetLevel : level + 1;
                run.targets[grid] = run.oneShot ? Math.min(_DM_maxLvlFor(name, run.limits), firstTarget) : _DM_maxLvlFor(name, run.limits);
            }
            if (level >= run.targets[grid]) { _DM_finishGrid(run, grid, true); return; }
            if (_DM_isUpgradeBusy(bld)) {
                var remaining = _DM_upgradeRemaining(bld, ctx);
                if (remaining !== null) minRemaining = Math.min(minRemaining, remaining + 1500);
                return;
            }
            if (bld.IsWaitForCommand()) return;
            if (!bld.IsProductionActive()) {
                _DM_debug('DM/upgrade_skipped_inactive [' + grid + ']');
                _DM_finishGrid(run, grid, false); return;
            }
            if (!bld.IsUpgradeAllowed(true)) {
                if (bld.IsUpgradeAllowed(false)) {
                    _DM_notify(loca.GetText('LAB', 'MissingResourcesShort') + ' ' + loca.GetText('BUI', name));
                    _DM_finishGrid(run, grid, false);
                } else if (run.oneShot) {
                    _DM_debug('DM/upgrade_unavailable [' + grid + ']');
                    _DM_finishGrid(run, grid, false);
                }
                return;
            }
            run.pending[grid] = { status: 'queued' };
            DM_sender.items.push({ kind: 'upgrade', grid: grid, name: name, runId: run.id,
                homeZoneId: run.homeZoneId, initialLevel: level, targetLevel: level + 1,
                stopLevel: run.targets[grid], stopAfterBuild: run.stopAfterBuild });
        });
        _DM_wakeSender();
        if (!run.grids.length) return null;
        return Object.keys(run.pending).length ? Math.min(minRemaining, 5000) : minRemaining;
    }

    function _DM_itemLive(item) {
        if (item.kind === 'stop') {
            var watch = DM_stopWatch[item.key];
            return !!watch && watch.queued === true && watch.token === item.token;
        }
        var run = DM_runs[item.kind];
        return !!run && run.active && run.id === item.runId && run.grids.indexOf(item.grid) !== -1;
    }

    function _DM_wakeSender(delay) {
        if (!DM_alive || DM_sender.timer !== null || !DM_sender.items.length) return;
        var wait = Math.max(delay || 0, DM_SEND_INTERVAL - (Date.now() - DM_sender.lastSentAt), 0);
        DM_sender.timer = setTimeout(_DM_sendNext, wait);
    }

    function _DM_sendNext() {
        if (!DM_alive) return;
        DM_sender.timer = null;
        DM_sender.items = DM_sender.items.filter(_DM_itemLive);
        if (!DM_sender.items.length) return;
        var ctx = _DM_context();
        if (!ctx) { _DM_wakeSender(DM_OFFZONE_DELAY); return; }
        if (Date.now() - DM_sender.lastSentAt < DM_SEND_INTERVAL) { _DM_wakeSender(); return; }
        var item = DM_sender.items.shift();
        if (item.homeZoneId !== ctx.homeZoneId) {
            // Do not let a different signed-in player's account inherit the command.
            if (item.kind === 'stop') {
                if (DM_stopWatch[item.key]) DM_stopWatch[item.key].queued = false;
            } else {
                delete DM_runs[item.kind].pending[item.grid];
            }
            _DM_debug('DM/home_player_changed');
            _DM_wakeSender(DM_OFFZONE_DELAY);
            return;
        }
        try {
            _DM_reconcileReceipts(ctx);
            if (item.kind === 'stop') _DM_sendStop(item, ctx);
            else _DM_sendAction(item, ctx);
        } catch (e) {
            _DM_debug(e);
            if (item.kind === 'stop') {
                var watch = DM_stopWatch[item.key];
                if (watch) watch.queued = false;
            } else {
                var run = DM_runs[item.kind];
                var receipt = DM_runtime.receipts[item.kind][item.grid];
                if (receipt) {
                    receipt.status = 'unknown';
                    receipt.warned = true;
                    _DM_debug('DM/send_unknown [' + item.grid + ']');
                } else {
                    // Exception before the sending boundary: no command was attempted.
                    delete run.pending[item.grid];
                    _DM_debug('DM/validation_error_not_sent [' + item.grid + ']');
                    _DM_finishGrid(run, item.grid, false);
                }
            }
        }
        _DM_wakeSender();
        _DM_ensureService();
    }

    function _DM_sendAction(item, ctx) {
        var run = DM_runs[item.kind];
        var old = DM_runtime.receipts[item.kind][item.grid];
        if (old && old.homeZoneId === ctx.homeZoneId && old.status !== 'confirmed') {
            run.pending[item.grid] = old; return;
        }
        var bld = _DM_bld(item.grid, ctx);
        if (item.kind === 'build') {
            if (bld || _DM_depositOre(item.grid, ctx) !== item.ore) { _DM_finishGrid(run, item.grid, true); return; }
            var deposit = _DM_deposit(item.grid, ctx);
            if (!deposit || deposit.GetAmount() <= 0) { _DM_finishGrid(run, item.grid, true); return; }
            if (_DM_freeQueueSlots(ctx) <= 0) {
                delete run.pending[item.grid];
                if (run.oneShot) {
                    _DM_notify(loca.GetText('LAB', 'FullBuildQueue'));
                    _DM_finishGrid(run, item.grid, false);
                }
                return;
            }
        } else {
            if (!bld || bld.GetBuildingName_string() !== item.name || !_DM_isUpgradableMine(item.name)) { _DM_finishGrid(run, item.grid, false); return; }
            if (bld.GetUIUpgradeLevel() !== item.initialLevel || _DM_isUpgradeBusy(bld) || bld.IsWaitForCommand()) {
                delete run.pending[item.grid]; return;
            }
            if (!bld.IsProductionActive() || !bld.IsUpgradeAllowed(true)) {
                _DM_debug('DM/state_changed_not_sent [' + item.grid + ']');
                _DM_finishGrid(run, item.grid, false); return;
            }
            if (typeof ctx.zone.UpgradeBuildingOnGridPosition !== 'function') {
                _DM_debug('DM/upgrade_method_unavailable');
                _DM_finishGrid(run, item.grid, false); return;
            }
        }
        var receipt = {
            kind: item.kind, grid: item.grid, homeZoneId: item.homeZoneId, name: item.name,
            ore: item.ore, initialLevel: item.initialLevel, targetLevel: item.targetLevel,
            sentAt: Date.now(), status: 'sent', warned: false
        };
        // Register before crossing the bridge: a throwing bridge call can still have sent.
        DM_runtime.receipts[item.kind][item.grid] = receipt;
        run.pending[item.grid] = receipt;
        DM_sender.lastSentAt = receipt.sentAt;
        var watchKey = item.kind + ':' + item.grid;
        var previousWatch = DM_stopWatch[watchKey];
        var addWatch = item.stopAfterBuild && (item.kind === 'build' || item.targetLevel >= item.stopLevel);
        if (addWatch) _DM_addStopWatch(item);
        if (item.kind === 'build') {
            ctx.gi.SendServerAction(CMD_BUILD, RESOURCES.buildMapping[item.ore].number, Number(item.grid), 0, null);
        } else {
            var ok = ctx.zone.UpgradeBuildingOnGridPosition(Number(item.grid));
            if (!ok) {
                delete DM_runtime.receipts.upgrade[item.grid];
                delete run.pending[item.grid];
                // Native method returned before sending (missing building / wait-for-command).
                if (addWatch) {
                    if (previousWatch) DM_stopWatch[watchKey] = previousWatch;
                    else delete DM_stopWatch[watchKey];
                }
                return;
            }
            if (typeof bld.SetIsUpgradeInitiated === 'function') bld.SetIsUpgradeInitiated(true);
        }
        _DM_notify((item.kind === 'build' ? loca.GetText('BUI', 'DefenseModeGhostGarrison') : loca.GetText('ALT', 'UpgradeBuilding')) +
            ' ' + loca.GetText(item.kind === 'build' ? 'RES' : 'BUI', item.kind === 'build' ? item.ore : item.name));
    }

    function _DM_reconcileReceipts(ctx) {
        ['build', 'upgrade'].forEach(function (type) {
            var receipts = DM_runtime.receipts[type];
            Object.keys(receipts).forEach(function (grid) {
                var r = receipts[grid];
                if (r.homeZoneId !== ctx.homeZoneId) return;
                var bld = _DM_bld(grid, ctx);
                var name = bld ? bld.GetBuildingName_string() : '';
                var confirmed = false;
                if (bld && name !== r.name) r.status = 'mismatch';
                else if (bld && type === 'build') confirmed = true;
                else if (bld && bld.GetUIUpgradeLevel() >= r.targetLevel) confirmed = true;
                else if (bld && type === 'upgrade' && bld.IsUpgradeInProgress()) r.status = 'observed';
                if (confirmed) {
                    r.status = 'confirmed';
                    delete receipts[grid];
                    return;
                }
                var timeout = type === 'build' ? DM_BUILD_VERIFY_MS : DM_UPGRADE_PENDING_MS;
                if (r.status !== 'observed' && r.status !== 'mismatch' && Date.now() - r.sentAt > timeout) r.status = 'unknown';
                if ((r.status === 'unknown' || r.status === 'mismatch') && !r.warned) {
                    r.warned = true;
                    _DM_debug('DM/' + type + '_unconfirmed [' + grid + ']');
                }
            });
        });
    }

    function _DM_addStopWatch(item) {
        var key = item.kind + ':' + item.grid;
        var existing = DM_stopWatch[key];
        DM_stopWatch[key] = {
            grid: item.grid, type: item.kind, homeZoneId: item.homeZoneId, name: item.name,
            targetLevel: item.kind === 'upgrade' ? item.stopLevel : 1,
            since: existing ? existing.since : Date.now(), queued: false,
            token: (DM_runtime.watchSequence = (DM_runtime.watchSequence || 0) + 1),
            sentAt: null, attempts: 0, warned: false
        };
        _DM_ensureService();
    }

    function _DM_checkStopWatch(ctx) {
        Object.keys(DM_stopWatch).forEach(function (key) {
            var w = DM_stopWatch[key];
            if (w.homeZoneId !== ctx.homeZoneId) return;
            var bld = _DM_bld(w.grid, ctx);
            if (!bld) {
                if (Date.now() - w.since > DM_RECONCILE_MS) {
                    // Keep waiting if the originating command itself is still unresolved.
                    if (!DM_runtime.receipts[w.type][w.grid]) delete DM_stopWatch[key];
                }
                return;
            }
            if (bld.GetBuildingName_string() !== w.name) { delete DM_stopWatch[key]; return; }
            if (!bld.IsBuildingInProduction() || _DM_isUpgradeBusy(bld)) return;
            if (w.type === 'upgrade' && bld.GetUIUpgradeLevel() < w.targetLevel) return;
            if (w.type === 'build' && DM_runs.upgrade.active && DM_runs.upgrade.grids.indexOf(w.grid) !== -1) return;
            // Only the observed production flag confirms that stopping succeeded.
            if (!bld.IsProductionActive()) { delete DM_stopWatch[key]; return; }
            if (w.queued || bld.IsWaitForCommand()) return;
            if (w.sentAt !== null && Date.now() - w.sentAt < DM_UPGRADE_PENDING_MS) return;
            if (w.attempts >= 3) {
                if (!w.warned) {
                    w.warned = true;
                    _DM_debug('DM/production_stop_unconfirmed [' + w.grid + ']');
                }
                return;
            }
            w.queued = true;
            DM_sender.items.push({ kind: 'stop', grid: w.grid, key: key, token: w.token, homeZoneId: w.homeZoneId });
        });
        _DM_wakeSender();
    }

    function _DM_sendStop(item, ctx) {
        var w = DM_stopWatch[item.key];
        if (!w || w.token !== item.token) return;
        w.queued = false;
        var bld = _DM_bld(w.grid, ctx);
        if (!bld || bld.GetBuildingName_string() !== w.name) return;
        if (!bld.IsBuildingInProduction() || _DM_isUpgradeBusy(bld) || bld.IsWaitForCommand()) return;
        if (w.type === 'upgrade' && bld.GetUIUpgradeLevel() < w.targetLevel) return;
        if (w.type === 'build' && DM_runs.upgrade.active && DM_runs.upgrade.grids.indexOf(w.grid) !== -1) return;
        if (!bld.IsProductionActive()) { delete DM_stopWatch[item.key]; return; }
        if (typeof bld.SetProductionActiveCommand !== 'function') {
            if (!w.warned) _DM_debug('DM/production_stop_method_unavailable');
            w.warned = true;
            w.attempts = 3;
            return;
        }
        w.attempts++;
        w.sentAt = Date.now();
        DM_sender.lastSentAt = w.sentAt;
        // Stopping (false) is idempotent. Retry only after checking the live state.
        bld.SetProductionActiveCommand(false);
    }

    function _DM_serviceTick() {
        if (!DM_alive) return;
        DM_runtime.serviceTimer = null;
        try {
            var ctx = _DM_context();
            if (ctx) { _DM_reconcileReceipts(ctx); _DM_checkStopWatch(ctx); }
        } catch (e) { _DM_debug(e); }
        _DM_ensureService();
    }

    function _DM_ensureService() {
        if (!DM_alive || DM_runtime.serviceTimer !== null) return;
        if (Object.keys(DM_stopWatch).length || Object.keys(DM_runtime.receipts.build).length || Object.keys(DM_runtime.receipts.upgrade).length) {
            DM_runtime.serviceTimer = setTimeout(_DM_serviceTick, DM_STOPWATCH_DELAY);
        }
    }

    function _DM_prepareReload() {
        _DM_flushSettings();
        DM_alive = false;
        Object.keys(DM_runs).forEach(function (type) {
            if (DM_runs[type].timer !== null) clearTimeout(DM_runs[type].timer);
            DM_runs[type].timer = null;
        });
        if (DM_sender.timer !== null) clearTimeout(DM_sender.timer);
        DM_sender.timer = null;
        ['serviceTimer', 'saveTimer', 'uiWaitTimer', 'uiReopenTimer'].forEach(function (key) {
            if (DM_runtime[key] !== null) clearTimeout(DM_runtime[key]);
            DM_runtime[key] = null;
        });
        $('#DrunkenMinerModal').off('.dmMiner');
        DM_runtime.uiWaitNodes.forEach(function (node) { $(node).off('.dmMinerWait'); });
        DM_runtime.uiWaitNodes = [];
        DM_runtime.ui.waiting = false;
    }

    function _DM_resumeRuntime() {
        window.TSO_DrunkenMiner = DM_runtime;
        DM_runtime.prepareReload = _DM_prepareReload;
        DM_runtime.menuHandler = DM_MenuHandler;
        window.DM_MenuHandler = DM_MenuHandler;
        addToolsMenuItem(loca.GetText('RES', 'BuffAd_Drunken_Miner'), window.DM_MenuHandler);
        Object.keys(DM_runs).forEach(function (type) {
            if (DM_runs[type].active) _DM_schedule(DM_runs[type], DM_runs[type].id, DM_MIN_DELAY);
        });
        _DM_wakeSender();
        _DM_ensureService();
        if ($('#DrunkenMinerModal').length) {
            _DM_init();
            _DM_InitEvens();
            if (_DM_context() && !DM_runtime.ui.closing) _DM_renderWindow();
        }
    }

    function _DM_queueReopen() {
        if (!DM_alive || DM_runtime.uiReopenTimer !== null) return;
        DM_runtime.uiReopenTimer = setTimeout(function () {
            if (!DM_alive) return;
            DM_runtime.uiReopenTimer = null;
            if (DM_runtime.ui.reopen) DM_MenuHandler();
        }, 0);
    }

    function _DM_hideModal() {
        var ui = DM_runtime.ui;
        var modal = $('#DrunkenMinerModal').data('bs.modal');
        if (ui.closing || !modal || !modal.isShown) return;
        if (ui.opening) { ui.closeRequested = true; return; }
        $('#DrunkenMinerModal').modal('hide');
    }

    function _DM_bindModalLifecycle() {
        var root = $('#DrunkenMinerModal');
        var ui = DM_runtime.ui;
        root.on('show.bs.modal.dmMiner', function (e) {
            if (e.target !== this) return;
            ui.opening = true;
            ui.closing = false;
        }).on('shown.bs.modal.dmMiner', function (e) {
            if (e.target !== this) return;
            ui.opening = false;
            if (ui.closeRequested) { ui.closeRequested = false; _DM_hideModal(); }
        }).on('hide.bs.modal.dmMiner', function (e) {
            if (e.target !== this) return;
            ui.closing = true;
            ui.reopen = false;
            _DM_flushSettings();
        }).on('hidden.bs.modal.dmMiner', function (e) {
            if (e.target !== this) return;
            ui.closing = false;
            ui.opening = false;
            ui.closeRequested = false;
            if (ui.reopen) _DM_queueReopen();
        });
    }

    function DM_MenuHandler() {
        if (!DM_alive) return;
        try {
            if (!_DM_context()) { _DM_notify(getText('not_home')); return; }
            var ui = DM_runtime.ui;
            ui.reopen = true;
            var root = $('#DrunkenMinerModal');
            var ownModal = root.data('bs.modal');
            if (ui.closing || (root.is(':visible') && ownModal && !ownModal.isShown)) return;
            if (ui.opening) { ui.reopen = false; return; }
            var others = $("div[role='dialog']:not(#DrunkenMinerModal):visible").filter(function () {
                return !!$(this).data('bs.modal');
            });
            if (others.length) {
                if (ui.waiting) return;
                ui.waiting = true;
                var left = others.length;
                DM_runtime.uiWaitNodes = others.toArray();
                others.one('hidden.bs.modal.dmMinerWait', function (e) {
                    if (!DM_alive || e.target !== this) return;
                    left--;
                    if (left === 0) {
                        if (DM_runtime.uiWaitTimer !== null) clearTimeout(DM_runtime.uiWaitTimer);
                        DM_runtime.uiWaitTimer = null;
                        DM_runtime.uiWaitNodes = [];
                        ui.waiting = false;
                        _DM_queueReopen();
                    }
                });
                DM_runtime.uiWaitTimer = setTimeout(function () {
                    if (!DM_alive) return;
                    DM_runtime.uiWaitTimer = null;
                    DM_runtime.uiWaitNodes.forEach(function (node) { $(node).off('.dmMinerWait'); });
                    DM_runtime.uiWaitNodes = [];
                    ui.waiting = false;
                    ui.reopen = false;
                    _DM_debug('DM/modal_close_timeout');
                }, 5000);
                others.each(function () {
                    var other = $(this).data('bs.modal');
                    if (other && other.isShown) $(this).modal('hide');
                });
                return;
            }
            ui.reopen = false;
            _DM_renderWindow();
            ownModal = $('#DrunkenMinerModal').data('bs.modal');
            if (!ownModal || !ownModal.isShown) $('#DrunkenMinerModal').modal({ backdrop: 'static' });
        } catch (e) { _DM_debug(e); }
    }

    function _DM_renderWindow() {
        _DM_init();
        _DM_renderHeader();
        _DM_renderBody();
        _DM_renderFooter();
        _DM_InitEvens();
        _DM_SetConfigValues();
    }

    function _DM_init() {
        if (!$('#DrunkenMinerModal').length) {
            createModalWindow('DrunkenMinerModal', loca.GetText('RES', 'BuffAd_Drunken_Miner'), false);
            DM_runtime.ui.closing = false;
            DM_runtime.ui.opening = false;
        }
        // Bootstrap also delegates [data-dismiss=modal]; keep a single guarded hide path.
        $('#DrunkenMinerModal .btnClose').removeAttr('data-dismiss');
        DM_UpgradeSwitchStatus = DM_config.switchStatus;
        DM_AutoModeSwitchStatus = DM_config.AutoModeStatus;
        if (!DM_build_newTemplates) DM_build_newTemplates = new SaveLoadTemplate('DrunkenMiner', function (data, name) {
            if (!DM_alive) return;
            if (!data || typeof data !== 'object' || Array.isArray(data)) {
                _DM_notify(getText('bad_template')); return;
            }
            DM_config = _DM_normalizeConfig(data);
            DM_config.switchStatus = DM_UpgradeSwitchStatus;
            DM_config.AutoModeStatus = DM_AutoModeSwitchStatus;
            DM_runtime.config = DM_config;
            // A template changes the next submission, never an already running job.
            _DM_renderWindow();
            $('#DrunkenMinerModal .templateFile').text('\u00a0\u00a0\u00a0\u00a0\u00a0' + loca.GetText('LAB', 'AvatarCurrentSelection') + ': ' + name);
            _DM_saveTmpSetting();
        });
    }

    function _DM_renderHeader() {

        function icon(id, iconName, extraStyle) {
            return _DM_iconButton(id, iconName, extraStyle);
        }

        function labeledSwitch(id, status, text) {
            var label = $('<div>')
                .attr({
                    id: id + '_TEXT',
                    style: 'display:inline-block;vertical-align:top;padding:2px 0 0 5px;z-index:999'
                })
                .text(text);
            return createSwitch(id, status) + label[0].outerHTML;
        }

        function buildSelect(ore) {
            var html = icon(null, RESOURCES.icons[ore], '');
            if (ore === 'Coal' || ore === 'Salpeter') {
                ore += 'Ore';
            }
            html += '<select name="DM_maxUpgLvlFilter_' + ore + '">';
            for (var i = 1; i <= DM_MaxUpgradeLvl; i++) {
                html += '<option value="' + i + '">' + i + '</option>';
            }
            return html + '</select>';
        }

        var stopAfterBuildIcon = icon(
            DM_lements.STOP_AFTER_BUILD_BTN,
            'BuildingSleepMode',
            'height:100%;margin-right:8px;' + (!DM_config.stopAfterBuild ? 'opacity:0.4;' : 'opacity:1;')
        );
        var stopAfterBuildlabel = $('<div>', {
            id: DM_lements.STOP_AFTER_BUILD_LABEL,
            css: {
                display: 'inline-block',
                verticalAlign: 'top',
                padding: '2px 0 0 5px',
                zIndex: 999
            },
            text: DM_config.stopAfterBuild
                ? DM_SwitchStatuses.AUTOSTOP_ON
                : DM_SwitchStatuses.AUTOSTOP_OFF
        });

        stopAfterBuildIcon = stopAfterBuildIcon + stopAfterBuildlabel[0].outerHTML;

        var switchRow = createTableRow([
            [3, labeledSwitch(
                DM_lements.ON_OFF_RADIO,
                DM_UpgradeSwitchStatus,
                DM_UpgradeSwitchStatus ? DM_SwitchStatuses.UPGRADE : DM_SwitchStatuses.BUILD
            )],
            [3, labeledSwitch(
                DM_lements.ON_OFF_AUTOMODE_RADIO,
                DM_AutoModeSwitchStatus,
                DM_AutoModeSwitchStatus ? DM_SwitchStatuses.AUTOMODE_ON : DM_SwitchStatuses.AUTOMODE_OFF
            )],
            [6, stopAfterBuildIcon]
        ], true);

        var maxUpgradeHtml = '';
        var selectAllHtml  = '';

        RESOURCES.ores.forEach(function (ore) {
            maxUpgradeHtml += buildSelect(ore);
            selectAllHtml  += icon('DM_selectAll_' + ore, RESOURCES.icons[ore], 'margin-right:20px;');
        });

        selectAllHtml += icon(DM_lements.SELECT_ALL_BTN, 'RefreshTradeIcon', 'margin-right:20px;');
        selectAllHtml += icon(DM_lements.SAFE_BUFF_BTN, 'ProductivityBuffLvl3', 'margin-right:20px;');

        var maxUpgradeRow = createTableRow([
            [3, '<div style="text-align:right">' +
            loca.GetText('LAB', 'Max') + ' ' +
            loca.GetText('LAB', 'ExpeditionDifficultyTooltip') + ' ' +
            loca.GetText('ACL', 'Upgrades') +
            '</div>'],
            [9, maxUpgradeHtml]
        ], true);

        maxUpgradeRow = $(maxUpgradeRow)
            .attr('id', SCRIPT_PREFIX + 'maxUpgradeRow')
            .prop('outerHTML');

        var selectAllRow = createTableRow([
            [3, '<div style="text-align:right">' +
            loca.GetText('LAB', 'Select') + ' ' +
            loca.GetText('LAB', 'All') +
            '</div>'],
            [9, selectAllHtml]
        ], true);


        var tableHeadRow = createTableRow([
            [3, loca.GetText('BUI', 'BuildingMountainOre')],
            [1, loca.GetText('LAB', 'Tasks')],
            [1, loca.GetText('LAB', 'RareBuffGroup2')],
            [3, loca.GetText('LAB', 'Expires')],
            [3, loca.GetText('LAB', 'RareBuffGroup0')],
            [1, loca.GetText('LAB', 'Visit')]
        ], true);

        $('#DrunkenMinerModal .DM_generatedHeader [data-toggle="tooltip"]').tooltip('destroy');
        $('#DrunkenMinerModal .DM_generatedHeader').remove();
        $('#DrunkenMinerModal .modal-header')
            .append(
                '<div class="container-fluid DM_generatedHeader">' +
                switchRow +
                maxUpgradeRow +
                selectAllRow +
                '<br>' +
                tableHeadRow +
                '</div>'
            );
    }

    function _DM_renderBody() {
        var deposits;
        if (DM_UpgradeSwitchStatus) {
            deposits = _DM_getUpgradeData();
        } else {
            deposits = _DM_GetBuildData();
        }
        _DM_renderData(deposits);
        _DM_updateSelectAllOpacity();
    }

    function _DM_renderFooter() {
        $('#DrunkenMinerModal .DM_action, #DrunkenMinerModal .upgradeReset').remove();
        $('#DrunkenMinerModal .modal-footer').prepend(
            $('<button>').attr({ 'class': 'btn btn-success upgradeSubmit DM_action' }).text(getText('btn_submit')),
            $('<button>').attr({ 'class': 'btn btn-primary pull-left build_newSaveTemplate DM_action' }).text(getText('save_template')),
            $('<button>').attr({ 'class': 'btn btn-primary pull-left build_newLoadTemplate DM_action' }).text(getText('load_template'))
        );
    }

    function _DM_startAutoMode() {
        if (!DM_AutoModeSwitchStatus || !_DM_context()) return;
        if (DM_UpgradeSwitchStatus) {
            _DM_startRun(true, DM_config.upgrade.slice(), false);
        } else {
            _DM_startRun(false, DM_config.build.slice(), false);
        }
    }

    function _DM_getUpgradeData() {
        var resArr = { deposit: [], depleted: [] };
        var ctx = _DM_context();
        if (!ctx) return resArr;
        var zone = ctx.zone;
        var streetMap = zone.mStreetDataMap;

        var ores     = RESOURCES.ores;
        var oreOrder = RESOURCES.oreOrder || {};
        var mineToOre = RESOURCES.mineToOre || {};
        var icons    = RESOURCES.icons;

        var deposits  = [];
        var container = streetMap.mDepositContainer && streetMap.mDepositContainer.mContainer;
        if (!container || typeof container.length !== 'number') return resArr;

        for (var i = 0, len = container.length; i < len; i++) {
            var item = container[i];
            if (!item) continue;

            var oreName;
            try { oreName = item.GetName_string(); } catch (e) { continue; }

            if (ores.indexOf(oreName) === -1) continue;

            var grid     = item.GetGrid();
            var building = zone.GetBuildingFromGridPosition(grid);
            if (!building) continue;

            var buildingName;
            try { buildingName = building.GetBuildingName_string(); } catch (e) { buildingName = null; }

            var ore = mineToOre[buildingName] || oreName;

            deposits.push({ deposit: item, ore: ore, order: oreOrder[ore] || 999 });
        }

        deposits.sort(function (a, b) { return a.order - b.order; });

        for (i = 0, len = deposits.length; i < len; i++) {
            var entry   = deposits[i];
            var deposit = entry.deposit;

            var bldData;
            try { bldData = _DM_getBuildingDataFromDeposit(deposit); } catch (e) { _DM_debug(e); continue; }
            if (!bldData) continue;

            var infoText = bldData.isUpgradeInProgress
                ? loca.GetText('LAB', 'Upgrade')
                : loca.GetText('QUL', 'TutBronzeMine');

            resArr.deposit.push({
                grid:         deposit.GetGrid(),
                buildingInfo: infoText,
                depositName:  entry.ore,
                resourcesLeft: deposit.GetAmount(),
                icon:         icons[entry.ore] || 'ButtonIconUnknown',
                buffIcon:     bldData.buffIcon || '',
                building:     bldData
            });
        }

        return resArr;
    }

    function _DM_GetBuildData() {
        var resArr = { deposit: [], depleted: [] };

        var ores      = RESOURCES.ores;
        var oreOrder  = RESOURCES.oreOrder || {};
        var icons     = RESOURCES.icons;
        var depositLabel = '(' + loca.GetText('LAB', 'DetailsDeposit') + ')';

        var ctx = _DM_context();
        if (!ctx) return resArr;
        var zone = ctx.zone;
        var streetMap = zone.mStreetDataMap;
        if (!streetMap || !streetMap.mBuildingContainer) {
            debug('streetMap.mBuildingContainer is undefined');
            return resArr;
        }

        var freeDeposits = [];
        var deposits = streetMap.mDepositContainer && streetMap.mDepositContainer.mContainer;
        if (!deposits || typeof deposits.length !== 'number') return resArr;

        for (var i = 0, len = deposits.length; i < len; i++) {
            var item = deposits[i];
            if (!item) continue;

            var name;
            try { name = item.GetName_string(); } catch (e) { continue; }

            if (ores.indexOf(name) === -1) continue;

            var grid = item.GetGrid();
            var bld  = zone.GetBuildingFromGridPosition(grid);

            if (!bld || bld.GetBuildingMode() === 1 || bld.GetBuildingMode() === 4) {
                freeDeposits.push({ deposit: item, ore: name, order: oreOrder[name] || 999 });
            }
        }

        freeDeposits.sort(function (a, b) { return a.order - b.order; });

        for (i = 0, len = freeDeposits.length; i < len; i++) {
            var entry   = freeDeposits[i];
            var deposit = entry.deposit;

            var grid = deposit.GetGrid();
            var bld  = zone.GetBuildingFromGridPosition(grid);

            resArr.deposit.push({
                grid:         grid,
                buildingInfo: depositLabel,
                depositName:  entry.ore,
                resourcesLeft: deposit.GetAmount(),
                icon:         icons[entry.ore] || 'ButtonIconMagnifier',
                buildMode:    bld ? bld.GetBuildingMode() : null
            });
        }

        var buildings   = streetMap.mBuildingContainer.mContainer || [];
        var assertNames = RESOURCES.assertNames;
        var depleted    = [];

        for (i = 0, len = buildings.length; i < len; i++) {
            var b = buildings[i];
            if (!b) continue;
            if (!streetMap.IsADepletedDeposit(b)) continue;

            var bName;
            try { bName = b.GetBuildingName_string(); } catch (e) { continue; }

            if (assertNames.indexOf(bName) === -1) continue;

            var ore = _DM_findOreInDepletedName(bName);
            if (!ore) continue;

            depleted.push({ grid: b.GetGrid(), icon: icons[ore] || 'ButtonIconUnknown', name: bName, Resource: ore });
        }

        depleted.sort(function (a, b) { return a.Resource.localeCompare(b.Resource); });
        resArr.depleted = depleted;
        return resArr;
    }

    function _DM_renderData(deposits) {
        DM_rowData = {};
        var $rowHtml = '';
        deposits.deposit.forEach(function (deposit) {
            var bld           = deposit.building;
            var checkbox      = '';
            var bldLvl        = '';
            var depositName   = deposit.depositName !== undefined ? loca.GetText('RES', deposit.depositName) : '';
            var resourcesLeft = deposit.resourcesLeft !== undefined ? deposit.resourcesLeft : '';
            var buffName      = '';
            var buffIcon      = '';
            var buffEndTime   = '';
            var timeHtml      = '';

            var buildingGoto = _DM_iconButton('DM_MinePOS_' + deposit.grid, 'accuracy.png', '');

            if (bld) {
                if (bld.isSelectable) {
                    checkbox = '<input type="checkbox" id="DM_UpgradeMines_' + bld.grid + '" name="' + deposit.depositName + '" class="' + DM_lements.UPGR_CHECKBX + '"' + (bld.isUpgradeBusy ? ' disabled="disabled" aria-disabled="true"' : '') + ' />';
                }
                bldLvl        = bld.level;
                buffName      = bld.buff;
                buffEndTime   = bld.BufEndTime;
                resourcesLeft = bld.resourcesLeft;
                depositName   = bld.locName;
                buffIcon      = bld.buffIcon;
                DM_rowData[String(bld.grid)] = bld;

                if (bld.isUpgradeAllowed) {
                    timeHtml = _DM_escape(_DM_formatTime(bld.depletesAt));
                    if (buffEndTime.length > 0 && timeHtml) {
                        timeHtml = '<span style="color: ' + _DM_buffTimeColor(bld.depletesAt, bld.buffEndsAt) + '">' + timeHtml + ' / ' + _DM_escape(buffEndTime) + '</span>';
                    }
                } else if (bld.isUpgradeInProgress) {
                    timeHtml = loca.GetText('QUL', 'TutUpgrade');
                }
            } else if (deposit.buildMode < 1 || deposit.buildMode > 4) {
                checkbox = '<input type="checkbox" id="DM_RebuildMines_' + deposit.grid + '" name="' + deposit.depositName + '" class="' + DM_lements.BUILD_CHECKBX + '" />';
            } else if (deposit.buildMode >= 1 && deposit.buildMode <= 4) {
                timeHtml = loca.GetText('QUL', 'Birthday2018plus_Infrastructure_62-80_Main1_Sub5');
            }

            if (DM_UpgradeSwitchStatus && !bld) return;

            var $row = createTableRow([
                [3, _DM_image(deposit.icon, '24px') + '<sup>' + _DM_escape(bldLvl) + '</sup>' + ' ' + _DM_escape(depositName)],
                [1, checkbox],
                [1, _DM_escape(resourcesLeft)],
                [3, timeHtml],
                [3, (buffIcon ? _DM_image(buffIcon, '24px') : '') + ' <small>' + _DM_escape(buffName) + '</small>'],
                [1, '<div style="text-align: right;">' + buildingGoto + '</div>']
            ], false);

            if ((bld && (!bld.isUpgradeAllowed || bld.isUpgradeBusy)) || (deposit.buildMode >= 1 && deposit.buildMode <= 4)) {
                $row = $($row).css({opacity: '0.5'}).prop('outerHTML');
            }
            $rowHtml += $row;
        });

        deposits.depleted.forEach(function (deposit) {
            try {
                var buildingGoto = _DM_iconButton('DM_MinePOS_' + deposit.grid, 'accuracy.png', '');
                $rowHtml += createTableRow([
                    [11, _DM_image(deposit.icon, '24px') + ' ' + _DM_escape(loca.GetText('BUI', deposit.name)) + (deposit.Resource === '' ? '' : ' (' + _DM_escape(loca.GetText('RES', deposit.Resource)) + ')')],
                    [1, '<div style="text-align: right;">' + buildingGoto + '</div>']
                ], false);
            } catch (e) {
                debug(e);
            }
        });

        $('#DrunkenMinerModalData').html("").append('<div class="container-fluid">' + $rowHtml + '</div>');
    }

    function _DM_InitEvens() {
        var root = $('#DrunkenMinerModal');
        root.off('.dmMiner');
        _DM_bindModalLifecycle();
        root.on('click.dmMiner', '[id^="DM_MinePOS_"]', function () {
            var grid = this.id.replace("DM_MinePOS_", "");
            _DM_GoTo(grid);
        });

        root.on('change.dmMiner', 'select[name^="DM_maxUpgLvlFilter_"]', function () {
            if (this.disabled || !DM_UpgradeSwitchStatus) return;
            var ore = this.name.replace("DM_maxUpgLvlFilter_", "");
            if (Object.prototype.hasOwnProperty.call(RESOURCES.maxLevelDefaults, ore)) DM_config.maxLvl[ore] = Math.max(1, Math.min(DM_MaxUpgradeLvl, Number($(this).val()) || 1));
            _DM_saveTmpSetting();
        });

        var mainSwitch = $("#" + DM_lements.ON_OFF_RADIO);
        root.on('change.dmMiner', '#' + DM_lements.ON_OFF_RADIO, function () {
            if ($(this).is(':checked')) {
                $("#" + DM_lements.ON_OFF_RADIO_TEXT).text(DM_SwitchStatuses.UPGRADE);
                $("." + DM_lements.BUILD_CHECKBX).hide();
                DM_UpgradeSwitchStatus = true;
            } else {
                $("#" + DM_lements.ON_OFF_RADIO_TEXT).text(DM_SwitchStatuses.BUILD);
                $("." + DM_lements.BUILD_CHECKBX).show();
                DM_UpgradeSwitchStatus = false;
            }
            DM_config.switchStatus = DM_UpgradeSwitchStatus;
            _DM_renderBody();
            _DM_saveTmpSetting();
            _DM_SetConfigValues();
        });

        if (mainSwitch.is(':checked')) {
            $("." + DM_lements.BUILD_CHECKBX).hide();
            $("." + DM_lements.UPGR_CHECKBX).show();
        } else {
            $("." + DM_lements.UPGR_CHECKBX).hide();
            $("." + DM_lements.BUILD_CHECKBX).show();
        }

        root.on('change.dmMiner', '#' + DM_lements.ON_OFF_AUTOMODE_RADIO, function () {
            if ($(this).is(':checked')) {
                $("#" + DM_lements.ON_OFF_AUTOMODE_RADIO_TEXT).text(DM_SwitchStatuses.AUTOMODE_ON);
                DM_AutoModeSwitchStatus = true;
            } else {
                $("#" + DM_lements.ON_OFF_AUTOMODE_RADIO_TEXT).text(DM_SwitchStatuses.AUTOMODE_OFF);
                DM_AutoModeSwitchStatus = false;
            }
            DM_config.AutoModeStatus = DM_AutoModeSwitchStatus;
            _DM_saveTmpSetting();
        });

        root.on('click.dmMiner', '[id^="DM_UpgradeMines_"]', function () {
            var grid      = this.id.replace("DM_UpgradeMines_", "");
            if (this.disabled || (this.checked && !_DM_canChooseUpgrade(grid))) {
                $(this).prop('checked', false);
                if (_DM_isUpgradeBusy(_DM_bld(grid))) $(this).prop('disabled', true);
                return;
            }
            var isChecked = $('#DM_UpgradeMines_' + grid).prop('checked');
            _DM_pushUpgradeGridToConfig(grid, isChecked);
            _DM_saveTmpSetting();
            _DM_updateSelectAllOpacity();
        });

        root.on('click.dmMiner', '[id^="DM_RebuildMines_"]', function () {
            var grid      = this.id.replace("DM_RebuildMines_", "");
            var isChecked = $('#DM_RebuildMines_' + grid).prop('checked');
            _DM_pushBuildGridToConfig(grid, isChecked);
            _DM_saveTmpSetting();
            _DM_updateSelectAllOpacity();
        });

        root.on('click.dmMiner', '[id^="DM_selectAll_"]', function () {
            var ore = this.id.replace('DM_selectAll_', '');
            var targets = _DM_selectionCheckboxes().filter(function () {
                if (ore !== 'ALL' && this.name !== ore) return false;
                if (DM_UpgradeSwitchStatus) {
                    return _DM_canChooseUpgrade(this.id.replace('DM_UpgradeMines_', ''));
                }
                return true;
            });
            var checked = !targets.is(':checked');
            targets.each(function () {
                this.checked = checked;
                if (DM_UpgradeSwitchStatus) {
                    _DM_pushUpgradeGridToConfig(this.id.replace('DM_UpgradeMines_', ''), checked);
                } else {
                    _DM_pushBuildGridToConfig(this.id.replace('DM_RebuildMines_', ''), checked);
                }
            });
            _DM_saveTmpSetting();
            _DM_updateSelectAllOpacity();
        });

        root.on('click.dmMiner', '#' + DM_lements.SAFE_BUFF_BTN, function () {
            DM_config.safeBuffing = !DM_config.safeBuffing;
            $(this).css('opacity', DM_config.safeBuffing ? '1' : '0.5');

            if (!DM_UpgradeSwitchStatus) {
                _DM_saveTmpSetting();
                return;
            }

            if (DM_UpgradeSwitchStatus) {
                $('#DrunkenMinerModalData input.' + DM_lements.UPGR_CHECKBX + ':enabled').each(function () {
                    var $cb   = $(this);
                    var grid  = $cb.attr('id').replace('DM_UpgradeMines_', '');
                    if (DM_config.safeBuffing && !_DM_canChooseUpgrade(grid)) return;
                    var data = DM_rowData[grid];
                    if (!data) return;
                    var color = _DM_buffTimeColor(data.depletesAt, data.buffEndsAt);
                    if (color !== 'orange') return;

                    if (DM_config.safeBuffing) {
                        $cb.prop('checked', true);
                        _DM_pushUpgradeGridToConfig(grid, true);
                    } else {
                        $cb.prop('checked', false);
                        _DM_pushUpgradeGridToConfig(grid, false);
                    }
                });
            }

            _DM_updateSelectAllOpacity();
            _DM_saveTmpSetting();
        });

        root.on('click.dmMiner', '#' + DM_lements.STOP_AFTER_BUILD_BTN, function () {
            DM_config.stopAfterBuild = !DM_config.stopAfterBuild;

            var isOn = DM_config.stopAfterBuild;
            $(this).css('opacity', isOn ? '1' : '0.4');
            $('#' + DM_lements.STOP_AFTER_BUILD_LABEL)
                .text(isOn ? DM_SwitchStatuses.AUTOSTOP_ON : DM_SwitchStatuses.AUTOSTOP_OFF)

            _DM_saveTmpSetting();
        });

        root.on('click.dmMiner', '.upgradeSubmit', function () {
            if (!_DM_context()) { _DM_hideModal(); _DM_notify(getText('not_home')); return; }
            _DM_flushSettings();
            _DM_hideModal();

            if (DM_config.upgrade.length === 0 && DM_config.build.length === 0) {
                game.showAlert(loca.GetText('LAB', 'BuffGroup14'));
                return;
            }

            if (DM_UpgradeSwitchStatus) {
                if (DM_config.upgrade.length > 0) {
                    if (DM_AutoModeSwitchStatus) {
                        _DM_startAutoMode();
                    } else {
                        _DM_upgradeMines(DM_config.upgrade.slice());
                    }
                }
            } else {
                if (DM_config.build.length > 0) {
                    if (DM_AutoModeSwitchStatus) {
                        _DM_startAutoMode();
                    } else {
                        _DM_buildMines(DM_config.build.slice());
                    }
                }
            }
        });

        root.on('click.dmMiner', '.build_newSaveTemplate', function () {
            _DM_flushSettings();
            DM_build_newTemplates.save(_DM_normalizeConfig(DM_config));
        });
        root.on('click.dmMiner', '.build_newLoadTemplate', function () {
            DM_build_newTemplates.load();
        });
        root.on('click.dmMiner', '.btnClose', function () {
            _DM_hideModal();
        });

        root.find('[data-toggle="tooltip"]').tooltip();
    }

    // Keep the row visible, but only allow editing in upgrade mode.
    function _DM_updateMaxUpgradeState() {
        var disabled = !DM_UpgradeSwitchStatus;
        var row = $('#DrunkenMinerModal #' + SCRIPT_PREFIX + 'maxUpgradeRow');
        row.css('opacity', '1')
            .attr('aria-disabled', disabled ? 'true' : 'false');
        // Light parchment tones derived from the client's #B2A589 header palette.
        // Empty values restore the client's normal CSS in upgrade mode.
        row.children('div').css({
            backgroundColor: disabled ? '#D8CEB8' : '',
            color: disabled ? '#6F6555' : ''
        });
        row.find('img')
            .attr('aria-disabled', disabled ? 'true' : 'false')
            .css({
                opacity: disabled ? '0.55' : '1',
                cursor: disabled ? 'default' : 'pointer'
            });
        row.find('select[name^="DM_maxUpgLvlFilter_"]')
            .prop('disabled', disabled)
            .css({
                backgroundColor: disabled ? '#EEE6D4' : '',
                color: disabled ? '#6F6555' : '',
                borderColor: disabled ? '#B2A589' : '',
                opacity: '1',
                cursor: disabled ? 'not-allowed' : ''
            });
    }

    function _DM_SetConfigValues() {
        _DM_updateMaxUpgradeState();
        for (var ore in DM_config.maxLvl) {
            if (DM_config.maxLvl.hasOwnProperty(ore)) {
                var value = DM_config.maxLvl[ore];
                $('select[name="DM_maxUpgLvlFilter_' + ore + '"]').val(value);
            }
        }

        $('[id^="DM_UpgradeMines_"]').prop('checked', false);
        $('[id^="DM_RebuildMines_"]').prop('checked', false);

        // Selection is for the next task. Current jobs keep their own snapshot.
        if (DM_UpgradeSwitchStatus) {
            DM_config.upgrade = DM_config.upgrade.filter(function (grid) {
                return $('#DM_UpgradeMines_' + grid + ':enabled').length > 0;
            });
        } else {
            DM_config.build = DM_config.build.filter(function (grid) {
                return $('#DM_RebuildMines_' + grid).length > 0;
            });
        }

        DM_config.upgrade.forEach(function (grid) { $('#DM_UpgradeMines_' + grid + ':enabled').prop('checked', true); });
        DM_config.build.forEach(function (grid)   { $('#DM_RebuildMines_'  + grid).prop('checked', true); });

        var isOn = !!DM_config.stopAfterBuild;
        $('#' + DM_lements.STOP_AFTER_BUILD_BTN).css('opacity', isOn ? '1' : '0.4');
        $('#' + DM_lements.STOP_AFTER_BUILD_LABEL)
            .text(isOn ? DM_SwitchStatuses.AUTOSTOP_ON : DM_SwitchStatuses.AUTOSTOP_OFF)

        _DM_updateSelectAllOpacity();
    }

    function _DM_GoTo(g) {
        try {
            var ctx = _DM_context();
            var grid = _DM_grid(g);
            if (!ctx || !grid) return;
            _DM_hideModal();
            ctx.zone.ScrollToGrid(Number(grid));
        } catch (e) {
            debug(e);
        }
    }

    function _DM_flushSettings() {
        if (DM_runtime.saveTimer !== null) { clearTimeout(DM_runtime.saveTimer); DM_runtime.saveTimer = null; }
        var snapshot = _DM_normalizeConfig(DM_config);
        var serialized = JSON.stringify(snapshot);
        if (serialized === DM_runtime.lastSaved) return;
        try {
            // Settings.store deep-merges arrays. Replace only our own namespace first.
            settings.settings[SCRIPT_PREFIX + 'SETTINGS'] = {};
            settings.store(snapshot, SCRIPT_PREFIX + 'SETTINGS');
            DM_runtime.lastSaved = serialized;
        } catch (e) { _DM_debug(e); }
    }

    function _DM_saveTmpSetting() {
        DM_runtime.config = DM_config;
        if (DM_runtime.saveTimer !== null) clearTimeout(DM_runtime.saveTimer);
        DM_runtime.saveTimer = setTimeout(function () {
            if (!DM_alive) return;
            DM_runtime.saveTimer = null;
            _DM_flushSettings();
        }, 400);
    }

    // Ручной режим: один проход + проверка результата (тот же движок, без повторов)
    function _DM_buildMines(gridArr) {
        _DM_startRun(false, gridArr.slice(), true);
    }

    function _DM_upgradeMines(gridArr) {
        _DM_startRun(true, gridArr.slice(), true);
    }

    function _DM_escape(value) {
        return String(value == null ? '' : value).replace(/[&<>"']/g, function (c) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
        });
    }

    function _DM_image(name, width, height) {
        var key = name + '|' + width + '|' + (height || '');
        if (Object.prototype.hasOwnProperty.call(DM_iconCache, key)) return DM_iconCache[key];
        var html;
        try { html = getImageTag(name, width, height); }
        catch (e) { html = ''; _DM_debug(e); }
        if (typeof html !== 'string' || !/<img\b/i.test(html)) html = '<span class="DM_iconFallback" aria-hidden="true">&#9633;</span>';
        if (DM_iconCacheSize < 128) { DM_iconCache[key] = html; DM_iconCacheSize++; }
        return html;
    }

    function _DM_iconButton(id, name, style) {
        // The click target exists even if the client returns a non-image placeholder.
        return '<span' + (id ? ' id="' + _DM_escape(id) + '"' : '') +
            ' style="display:inline-block;vertical-align:top;cursor:pointer;' + (style || '') + '">' +
            _DM_image(name, '24px') + '</span>';
    }

    function _DM_buffTimeColor(depletesAt, buffEndsAt) {
        if (!isFinite(depletesAt) || !isFinite(buffEndsAt) || depletesAt <= 0 || buffEndsAt <= 0) return '';
        return depletesAt > buffEndsAt ? 'yellow' : 'orange';
    }

    function _DM_formatTime(timestamp) {
        if (!isFinite(timestamp) || timestamp <= 0) return '';
        var d = new Date(timestamp);
        function two(n) { return ('0' + n).slice(-2); }
        var english = typeof gameLang === 'string' && gameLang.toLowerCase().indexOf('en') === 0;
        var day = two(d.getDate()), month = two(d.getMonth() + 1);
        return (english ? month + '-' + day : day + '-' + month) + ' ' + two(d.getHours()) + ':' + two(d.getMinutes());
    }

    function _DM_getBuildingDataFromDeposit(deposit) {
        var ctx = _DM_context();
        if (!ctx) return null;
        var bld = _DM_bld(deposit.GetGrid(), ctx);
        if (!bld) return null;
        var name = bld.GetBuildingName_string();
        if (RESOURCES.mines.indexOf(name) === -1) return null;
        var level = bld.GetUIUpgradeLevel();
        var grid = bld.GetGrid();
        var isUpgradable = _DM_isUpgradableMine(name);
        var busy = _DM_isUpgradeBusy(bld);
        var waiting = bld.IsWaitForCommand();
        var working = bld.IsProductionActive();
        var allowed = isUpgradable && bld.IsUpgradeAllowed(true);
        var resLeft = deposit.GetAmount();
        var now = Date.now();
        var buffName = '', buffIcon = '', buffEndsAt = 0;
        var secondsToDeplete = 0, totalRemoved = 0;
        // Buff/production estimates are optional presentation data, not a reason to lose the row.
        try {
            var buff = bld.productionBuff;
            var clientNow = ctx.gi.GetClientTime();
            if (buff && buff.IsActive(clientNow)) {
                var definition = buff.GetBuffDefinition();
                var remaining = buff.GetStartTime() + definition.getDuration(buff.GetApplicanceMode()) - clientNow;
                if (isFinite(remaining) && remaining > 0) {
                    buffEndsAt = now + remaining;
                    buffIcon = definition.GetName_string();
                    buffName = loca.GetText('RES', buffIcon);
                }
            }
            var cycleSeconds = bld.CalculateWays() / 1000;
            if (!DM_economics) DM_economics = swmmo.getDefinitionByName('ServerState::gEconomics');
            var definitionRC = DM_economics.GetResourcesCreationDefinitionForBuilding(name);
            totalRemoved = bld.GetResourceInputFactor() * (definitionRC ? definitionRC.amountRemoved : 0);
            if (working && isFinite(cycleSeconds) && cycleSeconds > 0 && totalRemoved > 0 && resLeft > 0) secondsToDeplete = resLeft * cycleSeconds / totalRemoved;
        } catch (e) { _DM_debug(e); }
        var depletesAt = isFinite(secondsToDeplete) && secondsToDeplete > 0 ? now + secondsToDeplete * 1000 : 0;
        var pending = !!DM_runs.upgrade.pending[String(grid)] || !!DM_runtime.receipts.upgrade[String(grid)];
        var locName = loca.GetText('BUI', name);
        if (locName.indexOf('[undefined text]') >= 0) locName = name;
        return {
            grid: grid, name: name, locName: locName, level: level, resourcesLeft: resLeft,
            isWorking: working, isUpgradeInProgress: busy, isUpgradeBusy: busy || waiting || pending,
            isUpgradeAllowed: allowed,
            isSelectable: isUpgradable && level < DM_MaxUpgradeLvl && (allowed || busy || pending),
            buff: buffName, buffIcon: buffIcon, BufEndTime: _DM_formatTime(buffEndsAt),
            AmountRemoved: totalRemoved, SecondsToDeplete: secondsToDeplete,
            depletesAt: depletesAt, buffEndsAt: buffEndsAt
        };
    }

    function _DM_pushUpgradeGridToConfig(grid, isChecked) {
        if (isChecked && !_DM_canChooseUpgrade(grid)) return;
        if (DM_config.upgrade.indexOf(grid) === -1 && isChecked) {
            DM_config.upgrade.push(grid);
        } else if (DM_config.upgrade.indexOf(grid) !== -1 && !isChecked) {
            DM_config.upgrade.splice(DM_config.upgrade.indexOf(grid), 1);
        }
    }

    function _DM_pushBuildGridToConfig(grid, isChecked) {
        if (DM_config.build.indexOf(grid) === -1 && isChecked) {
            DM_config.build.push(grid);
        } else if (DM_config.build.indexOf(grid) !== -1 && !isChecked) {
            DM_config.build.splice(DM_config.build.indexOf(grid), 1);
        }
    }

    function _DM_updateSelectAllOpacity() {
        var hasAnyOrangeChecked = false;
        RESOURCES.ores.forEach(function (oreName) {
            var hasChecked = false;
            var relatedCheckboxes = _DM_selectionCheckboxes().filter(function () {
                return this.name === oreName;
            });
            relatedCheckboxes.each(function () {
                var $cb = $(this);
                if ($cb.is(':checked')) {
                    hasChecked = true;
                    if (!hasAnyOrangeChecked) {
                        var grid = this.id.replace('DM_UpgradeMines_', '');
                        var data = DM_rowData[grid];
                        if (data && _DM_buffTimeColor(data.depletesAt, data.buffEndsAt) === 'orange') hasAnyOrangeChecked = true;
                    }
                    if (hasChecked && hasAnyOrangeChecked) return false;
                }
            });
            var selectAllElement = $('#DM_selectAll_' + oreName);
            if (selectAllElement.length > 0) {
                selectAllElement.css('opacity', hasChecked ? '1' : '.5');
            }
        });

        var allCheckboxes = _DM_selectionCheckboxes();
        var isAnyChecked  = allCheckboxes.is(':checked');
        $('#' + DM_lements.SELECT_ALL_BTN).css('opacity', isAnyChecked ? '1' : '.5');
        $('#' + DM_lements.SAFE_BUFF_BTN).css('opacity', hasAnyOrangeChecked ? '1' : '.5');
    }

    function _DM_findOreInDepletedName(depletedName) {
        var result = "";
        RESOURCES.ores.forEach(function (ore) {
            if (depletedName.indexOf(ore) !== -1) result = ore;
        });
        return result;
    }

    _DM_resumeRuntime();
})();
