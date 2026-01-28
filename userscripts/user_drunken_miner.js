// language=JavaScript; ECMAScript 5.1
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////Created by MadFX | Thanks for PiTi for source code. ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
(function (global) {
    const SCRIPT_PREFIX    = 'DM_';
    const DM_MaxUpgradeLvl = 12;
    const RESOURCES = {
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
            "SalpeterMine", "EpicSalpeterMine"
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
            IronMine: "IronOre", EpicIronMine: "IronOre", ArcticIronMine: "IronOre",
            CoalMine: "Coal", EpicCoalMine: "Coal",
            GoldMine: "GoldOre", EpicGoldMine: "GoldOre",
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

    global.DM_MenuHandler = DM_MenuHandler;
    addToolsMenuItem(loca.GetText("RES", 'BuffAd_Drunken_Miner'), global.DM_MenuHandler);

    var _DM_ModalInitialized = false;
    var DM_build_newTemplates;

    var DM_AutoModeSwitchStatus = false;
    var DM_UpgradeSwitchStatus  = false;

    const DM_lements        = {
        ON_OFF_RADIO: SCRIPT_PREFIX + 'StateSwitch',
        ON_OFF_RADIO_TEXT: SCRIPT_PREFIX + 'StateSwitch_TEXT',
        ON_OFF_AUTOMODE_RADIO: SCRIPT_PREFIX + 'AutoModeStateSwitch',
        ON_OFF_AUTOMODE_RADIO_TEXT: SCRIPT_PREFIX + 'AutoModeStateSwitch_TEXT',
        BUILD_CHECKBX: SCRIPT_PREFIX + 'buildCheckBox',
        UPGR_CHECKBX: SCRIPT_PREFIX + 'upgrCheckBox',
        SAFE_BUFF_BTN: SCRIPT_PREFIX + 'toggleSafeBuffing',
        SELECT_ALL_BTN: SCRIPT_PREFIX + 'selectAll_ALL',
    };
    const DM_SwitchStatuses = {
        UPGRADE: loca.GetText('ACL', 'Upgrades'),
        BUILD: loca.GetText('BUI', 'TwinTown_building_spot'),
        AUTOMODE_ON: loca.GetText('ACL', 'BuildQueueSlotTemp') + ' ' + loca.GetText('LAB', 'Yes'),
        AUTOMODE_OFF: loca.GetText('ACL', 'BuildQueueSlotTemp') + ' ' + loca.GetText('LAB', 'No'),
    };

    var DM_config = {
        build: [],
        upgrade: [],
        switchStatus: DM_UpgradeSwitchStatus,
        AutoModeStatus: DM_AutoModeSwitchStatus,
        maxLvl: RESOURCES.maxLevelDefaults,
        safeBuffing: false
    };
    $.extend(DM_config, settings.read(null, SCRIPT_PREFIX + 'SETTINGS'));

    function DM_MenuHandler() {
        try {
            //check home zone
            if (game.gi.isOnHomzone() === false) {
                game.showAlert(getText('not_home'));
                return;
            }

            //init script
            _DM_init();

            //Display interface
            _DM_renderHeader();
            _DM_renderBody();

            // render footer
            _DM_renderFooter();

            //Initializing Events and Configurations
            _DM_InitEvens();
            _DM_SetConfigValues();

            $('#DrunkenMinerModal:not(:visible)').modal({
                backdrop: "static"
            });
        } catch (e) {
            debug(e)
        }
    }

    function _DM_init() {
        $("div[role='dialog']:not(#DrunkenMinerModal):visible").modal("hide");
        if (!_DM_ModalInitialized) $('#DrunkenMinerModal').remove();
        createModalWindow('DrunkenMinerModal', 'Drunken Miner');

        DM_UpgradeSwitchStatus = DM_config.switchStatus;
        DM_AutoModeSwitchStatus = DM_config.AutoModeStatus;

        //load
        DM_build_newTemplates = new SaveLoadTemplate('ml', function (data, name) {
            $("#DrunkenMinerModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
            var loadData = data;
            if (loadData.length === 0) {
                return;
            }
            DM_config = loadData;
            _DM_SetConfigValues();
        });
    }

    function _DM_renderHeader() {

        function icon(id, iconName, extraStyle) {
            return getImageTag(iconName, '24px')
                .replace(
                    '<img',
                    '<img' +
                    (id ? ' id="' + id + '"' : '') +
                    ' style="vertical-align:top;cursor:pointer;' + (extraStyle || '') + '"'
                );
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
            if (ore === 'Coal' || ore === 'Salpeter'){
                ore += 'Ore';
            }
            html += '<select name="DM_maxUpgLvlFilter_' + ore + '">';
            for (var i = 1; i <= DM_MaxUpgradeLvl; i++) {
                html += '<option value="' + i + '">' + i + '</option>';
            }
            return html + '</select>';
        }

        var switchRow = createTableRow([
            [3, labeledSwitch(
                DM_lements.ON_OFF_RADIO,
                DM_UpgradeSwitchStatus,
                DM_UpgradeSwitchStatus ? DM_SwitchStatuses.UPGRADE : DM_SwitchStatuses.BUILD
            )],
            [9, labeledSwitch(
                DM_lements.ON_OFF_AUTOMODE_RADIO,
                DM_AutoModeSwitchStatus,
                DM_AutoModeSwitchStatus ? DM_SwitchStatuses.AUTOMODE_ON : DM_SwitchStatuses.AUTOMODE_OFF
            )]
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

        $('#DrunkenMinerModal .modal-header')
            .append(
                '<div class="container-fluid">' +
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
        $("#DrunkenMinerModal .modal-footer").prepend([
            $('<button>').attr({
                "class": "btn btn-warning upgradeReset"
            }).text(getText('btn_reset')), $('<button>').attr({
                "class": "btn btn-success upgradeSubmit"
            }).text(getText('btn_submit')), $('<button>').attr({
                "class": "btn btn-primary pull-left build_newSaveTemplate"
            }).text(getText('save_template')), $('<button>').attr({
                "class": "btn btn-primary pull-left build_newLoadTemplate"
            }).text(getText('load_template'))
        ]);
    }

    function _DM_checkAllTasksCompleted(gridArr, upgSwitchStatus) {
        if (upgSwitchStatus) {
            var allUpgraded = true;
            for (var i = 0; i < gridArr.length; i++) {
                var grid     = gridArr[i];
                var building = game.zone.GetBuildingFromGridPosition(grid);

                if (building) {
                    var buildingData = _DM_getBuildingDataFromDeposit({
                        GetGrid: function () {
                            return grid;
                        }, GetAmount: function () {
                            return grid;
                        }
                    });

                    if (buildingData) {
                        var resourceName = buildingData.name.replace('Mine', 'Ore');

                        var maxLevel = DM_config.maxLvl[resourceName] || DM_MaxUpgradeLvl;

                        if (buildingData.level < maxLevel || buildingData.isUpgradeInProgress) {
                            allUpgraded = false;
                            break;
                        }
                    }
                }
            }

            return allUpgraded;
        } else {
            if (gridArr.length === 0) {
                return true;
            }
        }

        return false;
    }

    function getNearestConstructionOrUpgradeTime(gridArr, upgSwitchStatus) {
        if (!Array.isArray(gridArr) || gridArr.length === 0) {
            return null;
        }

        var currentTimeMs      = game.gi.GetClientTime();
        var nearestEventTimeMs = null;
        var hasActiveProcess   = false;

        if (upgSwitchStatus) {
            for (var i = 0; i < gridArr.length; i++) {
                var grid     = gridArr[i];
                var building = game.zone.GetBuildingFromGridPosition(grid);

                if (building) {
                    if (building.IsUpgradeInProgress && building.IsUpgradeInProgress()) {
                        hasActiveProcess = true;

                        var upgradeStartTimeSec = building.GetUpgradeStartTime ? building.GetUpgradeStartTime() : 0;
                        var upgradeDurationSec  = building.GetUpgradeDuration ? building.GetUpgradeDuration() : 0;

                        var upgradeEndTimeMs = upgradeDurationSec - (currentTimeMs - upgradeStartTimeSec);

                        if (nearestEventTimeMs === null || upgradeEndTimeMs < nearestEventTimeMs) {
                            nearestEventTimeMs = upgradeEndTimeMs;
                        }
                    }
                }
            }
        } else {
            var queueVector         = game.gi.mHomePlayer.mBuildQueue.GetQueue_vector ?
                game.gi.mHomePlayer.mBuildQueue.GetQueue_vector() : [];
            var totalAvailableSlots = game.gi.mHomePlayer.mBuildQueue.GetTotalAvailableSlots ?
                game.gi.mHomePlayer.mBuildQueue.GetTotalAvailableSlots() : 0;
            var currentQueueLength  = queueVector.length;
            var freeSlots           = totalAvailableSlots - currentQueueLength;

            if (freeSlots > 0) {
                hasActiveProcess       = true;
                nearestEventTimeMs     = 3000
            } else {
                var firstQueuedBuilding = queueVector[0];
                if (firstQueuedBuilding) {
                    hasActiveProcess   = true;
                    nearestEventTimeMs = firstQueuedBuilding.GetRemainingConstructionDuration()
                }
            }
        }

        if (!hasActiveProcess) {
            nearestEventTimeMs = 28000;
        }
        if (nearestEventTimeMs < 3000) {
            nearestEventTimeMs = 5000;
        }
        nearestEventTimeMs += 2000;
        return nearestEventTimeMs;
    }

    function _DM_startAutoMode() {
        if (!DM_AutoModeSwitchStatus) {
            return;
        }

        if (game.gi.isOnHomzone()) {
            game.showAlert(loca.GetText('ALT', 'ErrorRetrievingMail') + ' ' + loca.GetText('LAB', 'QuestNew'));

            if (DM_UpgradeSwitchStatus) {
                _DM_autoLoop(DM_config.upgrade.slice(), true);
            } else {
                _DM_autoLoop(DM_config.build.slice(), false);
            }
        }
    }

    function _DM_autoLoop(gridArr, isUpgradeMode) {
        if (!game.gi.isOnHomzone()) {
            _DM_scheduleNextLoop(gridArr, isUpgradeMode, 30000);
            return;
        }

        if (!DM_AutoModeSwitchStatus || _DM_checkAllTasksCompleted(gridArr, isUpgradeMode)) {
            game.showAlert(loca.GetText('ALT', 'ErrorRetrievingMail') + ' ' + loca.GetText('LAB', 'QuestCompleted'));
            return;
        }

        if (isUpgradeMode) {
            _DM_upgradeMines(gridArr.slice());
        } else {
            _DM_buildMines(gridArr);
        }

        var time = getNearestConstructionOrUpgradeTime(gridArr, isUpgradeMode);
        _DM_scheduleNextLoop(gridArr, isUpgradeMode, time);
    }

    function _DM_scheduleNextLoop(gridArr, isUpgradeMode, delayMs) {
        setTimeout(function () {
            _DM_autoLoop(gridArr, isUpgradeMode);
        }, delayMs);
    }

    function _DM_getUpgradeData() {
        var resArr = { deposit: [], depleted: [] };
        var zone = swmmo.application.mGameInterface.mCurrentPlayerZone;
        var streetMap = zone.mStreetDataMap;

        var ores = RESOURCES.ores;
        var oreOrder = RESOURCES.oreOrder || {};
        var mineToOre = RESOURCES.mineToOre || {};
        var icons = RESOURCES.icons;

        var deposits = [];
        var container = streetMap.mDepositContainer.mContainer;

        for (var i = 0, len = container.length; i < len; i++) {
            var item = container[i];
            if (!item) continue;

            var oreName;
            try {
                oreName = item.GetName_string();
            } catch (e) {
                continue;
            }

            if (ores.indexOf(oreName) === -1) continue;

            var grid = item.GetGrid();
            var building = zone.GetBuildingFromGridPosition(grid);
            if (!building) continue;

            var buildingName;
            try {
                buildingName = building.GetBuildingName_string();
            } catch (e) {
                buildingName = null;
            }

            var ore = mineToOre[buildingName] || oreName;

            deposits.push({
                deposit: item,
                ore: ore,
                order: oreOrder[ore] || 999
            });
        }

        deposits.sort(function (a, b) {
            return a.order - b.order;
        });

        for (i = 0, len = deposits.length; i < len; i++) {
            var entry = deposits[i];
            var deposit = entry.deposit;

            var bldData = _DM_getBuildingDataFromDeposit(deposit);
            if (!bldData) continue;

            var infoText = bldData.isUpgradeInProgress
                ? loca.GetText('LAB', 'Upgrade')
                : loca.GetText('QUL', 'TutBronzeMine');

            resArr.deposit.push({
                grid: deposit.GetGrid(),
                buildingInfo: infoText,
                depositName: entry.ore,
                resourcesLeft: deposit.GetAmount(),
                icon: icons[entry.ore] || 'ButtonIconUnknown',
                buffIcon: bldData.buffIcon || '',
                building: bldData
            });
        }

        return resArr;
    }


    function _DM_GetBuildData() {
        var resArr = {
            deposit: [],
            depleted: []
        };

        var zone = swmmo.application.mGameInterface.mCurrentPlayerZone;
        var streetMap = zone.mStreetDataMap;
        var ores = RESOURCES.ores;
        var oreOrder = RESOURCES.oreOrder || {};
        var icons = RESOURCES.icons;
        var depositLabel = '(' + loca.GetText('LAB', 'DetailsDeposit') + ')';

        var freeDeposits = [];
        var deposits = streetMap.mDepositContainer.mContainer;

        for (var i = 0, len = deposits.length; i < len; i++) {
            var item = deposits[i];
            if (!item) continue;

            var name;
            try {
                name = item.GetName_string();
            } catch (e) {
                continue;
            }

            if (ores.indexOf(name) === -1) continue;

            var grid = item.GetGrid();
            var bld = zone.GetBuildingFromGridPosition(grid);

            if (!bld || bld.GetBuildingMode() === 1 || bld.GetBuildingMode() === 4) {
                freeDeposits.push({
                    deposit: item,
                    ore: name,
                    order: oreOrder[name] || 999
                });
            }
        }

        freeDeposits.sort(function (a, b) {
            return a.order - b.order;
        });

        for (i = 0, len = freeDeposits.length; i < len; i++) {
            var entry = freeDeposits[i];
            var deposit = entry.deposit;

            var grid = deposit.GetGrid();
            var bld = zone.GetBuildingFromGridPosition(grid);

            resArr.deposit.push({
                grid: grid,
                buildingInfo: depositLabel,
                depositName: entry.ore,
                resourcesLeft: deposit.GetAmount(),
                icon: icons[entry.ore] || 'ButtonIconMagnifier',
                buildMode: bld ? bld.GetBuildingMode() : null
            });
        }

        var buildings = streetMap.mBuildingContainer.mContainer;
        var assertNames = RESOURCES.assertNames;
        var depleted = [];

        for (i = 0, len = buildings.length; i < len; i++) {
            var b = buildings[i];
            if (!b) continue;

            if (!streetMap.IsADepletedDeposit(b)) continue;

            var bName;
            try {
                bName = b.GetBuildingName_string();
            } catch (e) {
                continue;
            }

            if (assertNames.indexOf(bName) === -1) continue;

            var ore = _DM_findOreInDepletedName(bName);
            if (!ore) continue;

            depleted.push({
                grid: b.GetGrid(),
                icon: icons[ore] || 'ButtonIconUnknown',
                name: bName,
                Resource: ore
            });
        }

        depleted.sort(function (a, b) {
            return a.Resource.localeCompare(b.Resource);
        });

        resArr.depleted = depleted;
        return resArr;
    }

    function _DM_renderData(deposits) {
        var $rowHtml = '';
        deposits.deposit.forEach(function (deposit) {
            var bld         = deposit.building;
            var checkbox      = '';
            var bldLvl        = '';
            var depositName   = deposit.depositName !== undefined ? loca.GetText('RES', deposit.depositName) : '';
            var resourcesLeft = deposit.resourcesLeft !== undefined ? deposit.resourcesLeft : '';
            var buffName      = '';
            var buffIcon      = '';
            var buffEndTime   = '';
            var timeHtml      = '';

            var buildingGoto = getImageTag('accuracy.png', '24px', '24px').replace('<img', '<img id="DM_MinePOS_' + deposit.grid + '"').replace('style="', 'style="cursor: pointer;');

            if (bld) {
                if (bld.isUpgradeAllowed && !bld.isUpgradeInProgress) {
                    checkbox = '<input type="checkbox" id="DM_UpgradeMines_' + bld.grid + '" name="' + deposit.depositName + '" class="' + DM_lements.UPGR_CHECKBX + '" />';
                }
                bldLvl        = bld.level;
                buffName      = bld.buff;
                buffEndTime   = bld.BufEndTime;
                resourcesLeft = bld.resourcesLeft;
                depositName   = bld.locName;
                buffIcon      = bld.buffIcon;

                if (bld.isUpgradeAllowed){
                    timeHtml = _DM_ViewerSetTimeStr(bld.SecondsToDeplete, 2);
                    if (buffEndTime.length > 0) {
                        timeHtml = '<span style="color: ' + _DM_formatBuffTimeColor(timeHtml, buffEndTime) + '">' + timeHtml + ' / ' + buffEndTime + '</span>';
                    }
                }else if(bld.isUpgradeInProgress){
                    timeHtml = loca.GetText('QUL', 'TutUpgrade')
                }
            } else if(deposit.buildMode < 1 || deposit.buildMode > 4) {
                checkbox = '<input type="checkbox" id="DM_RebuildMines_' + deposit.grid + '" name="' + deposit.depositName + '" class="' + DM_lements.BUILD_CHECKBX + '" />';
            }

            else if(deposit.buildMode >= 1 && deposit.buildMode <= 4){
                timeHtml = loca.GetText('QUL', 'Birthday2018plus_Infrastructure_62-80_Main1_Sub5')
            }

            //for upgrade skip without mines
            if (DM_UpgradeSwitchStatus && !bld) {
                return;
            }
            var $row = createTableRow([
                [3, getImageTag(deposit.icon, '24px') + '<sup>' + bldLvl + '</sup>' + ' ' + depositName],
                [1, checkbox],
                [1, resourcesLeft],
                [3, timeHtml],
                [3, (buffIcon ? getImageTag(buffIcon, '24px') : '') + ' <small>' + buffName + '</small>'],
                [1, '<div style="text-align: right;">' + buildingGoto + '</div>']
            ], false);

            if ((bld && !bld.isUpgradeAllowed) || (deposit.buildMode == 4 || deposit.buildMode == 1)){
                $row = $($row).css({opacity:'0.5'}).prop('outerHTML');
            }
            $rowHtml += $row;
        });
        deposits.depleted.forEach(function (deposit) {
            try {
                var buildingGoto = getImageTag('accuracy.png', '24px', '24px').replace('<img', '<img id="DM_MinePOS_' + deposit.grid + '"').replace('style="', 'style="cursor: pointer;');
                $rowHtml += createTableRow([
                    [
                        11,
                        getImageTag(deposit.icon, '24px') + ' ' + loca.GetText("BUI", deposit.name) + (deposit.Resource === "" ? "" : " (" + loca.GetText("RES", deposit.Resource) + ")")
                    ], [1, '<div style="text-align: right;">' + buildingGoto + '</div>']
                ], false)
            } catch (e) {
                debug(e);
            }
        });
        $('#DrunkenMinerModalData').html("").append('<div class="container-fluid">' + $rowHtml + '</div>');
    }

    function _DM_InitEvens() {
        $('[id^="DM_MinePOS_"]').off('click').on('click', function () {
            var grid = this.id.replace("DM_MinePOS_", "");
            _DM_GoTo(grid);
        });

        $('select[name^="DM_maxUpgLvlFilter_"]').off('change').change(function () {
            var ore               = this.name.replace("DM_maxUpgLvlFilter_", "");
            DM_config.maxLvl[ore] = $(this).val();
            _DM_saveTmpSetting();
        });

        //set switch animation
        var mainSwitch = $("#" + DM_lements.ON_OFF_RADIO);
        mainSwitch.off('change').change(function () {
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
            _DM_InitEvens();
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

        //set automode switch animation
        var autoModeSwitch = $("#" + DM_lements.ON_OFF_AUTOMODE_RADIO);
        autoModeSwitch.off('change').change(function () {
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

        $('[id^="DM_UpgradeMines_"]').off('click').on('click', function () {
            var grid      = this.id.replace("DM_UpgradeMines_", "");
            var isChecked = $('#DM_UpgradeMines_' + grid).prop('checked');

            _DM_pushUpgradeGridToConfig(grid, isChecked);

            _DM_saveTmpSetting();
            _DM_updateSelectAllOpacity();
        });
        $('[id^="DM_RebuildMines_"]').off('click').on('click', function () {
            var grid      = this.id.replace("DM_RebuildMines_", "");
            var isChecked = $('#DM_RebuildMines_' + grid).prop('checked');

            _DM_pushBuildGridToConfig(grid, isChecked);

            _DM_saveTmpSetting();
            _DM_updateSelectAllOpacity();
        });

        $('[id^="DM_selectAll_"]').off('click').click(function () {
            var ore = this.id.replace("DM_selectAll_", "");
            var isChecked;
            if (ore === 'ALL') {
                const anyChecked = $('#DrunkenMinerModalData input[type="checkbox"]').prop('checked');
                isChecked        = !anyChecked;
                $(this).css('opacity', isChecked ? '1' : '0.5');
            } else {
                const selector   = '[name^="' + ore + '"]';
                const anyChecked = $(selector).is(':checked');
                isChecked        = !anyChecked;
                $(this).css('opacity', isChecked ? '1' : '0.5');
            }

            const $targets = (ore === 'ALL') ? $('#DrunkenMinerModalData input[type="checkbox"]') : $('[name^="' + ore + '"]');

            $targets.each(function () {
                $(this).prop('checked', isChecked);

                if (this.id.indexOf('DM_UpgradeMines_') !== -1) {
                    const grid = this.id.replace("DM_UpgradeMines_", "");
                    _DM_pushUpgradeGridToConfig(grid, isChecked);
                    return;
                }
                if (this.id.indexOf('DM_RebuildMines_') !== -1) {
                    const grid = this.id.replace("DM_RebuildMines_", "");
                    _DM_pushBuildGridToConfig(grid, isChecked);
                }
            });

            _DM_saveTmpSetting();
            _DM_updateSelectAllOpacity();
        });

        $('#'+DM_lements.SAFE_BUFF_BTN).off('click').on('click', function () {
            DM_config.safeBuffing = !DM_config.safeBuffing;

            $(this).css('opacity', DM_config.safeBuffing ? '1' : '0.5');

            if (!DM_UpgradeSwitchStatus) {
                _DM_saveTmpSetting();
                return;
            }

            if (DM_UpgradeSwitchStatus) {
                $('#DrunkenMinerModalData input.' + DM_lements.UPGR_CHECKBX).each(function () {
                    var $cb = $(this);
                    var grid = $cb.attr('id').replace('DM_UpgradeMines_', '');

                    var $timeCell = $cb.parent().parent().find('div:eq(3)');
                    var timeText = $timeCell.text().trim();

                    if (timeText.indexOf('/') === -1) return;
                    var parts = timeText.split('/');
                    var depleteStr = parts[0].trim();
                    var buffStr    = parts[1].trim();

                    var color = _DM_formatBuffTimeColor(depleteStr, buffStr);
                    if (color !== 'orange') return;
                    if (DM_config.safeBuffing) {
                        $cb.prop('checked', true);
                        _DM_pushUpgradeGridToConfig(grid, true);
                    }else{
                        $cb.prop('checked', false);
                        _DM_pushUpgradeGridToConfig(grid, false);
                    }
                })
            }

            _DM_updateSelectAllOpacity();
            _DM_saveTmpSetting();
        });

        $('#DrunkenMinerModal .upgradeReset').off('click').click(function () {
            DM_config = {
                build: [], upgrade: [], switchStatus: DM_UpgradeSwitchStatus, maxLvl: {
                    "IronOre": 1, "CoalOre": 1, "BronzeOre": 1, "GoldOre": 1, "TitaniumOre": 1, "SalpeterOre": 1
                }
            };

            _DM_SetConfigValues();
            _DM_saveTmpSetting();
        });
        $('#DrunkenMinerModal .upgradeSubmit').off('click').click(function () {
            $('#DrunkenMinerModal').modal('hide');

            if (DM_config.upgrade.length === 0 && DM_config.build.length === 0) {
                game.showAlert(loca.GetText('LAB', 'BuffGroup14'));
                return;
            }

            if (DM_UpgradeSwitchStatus) {
                if (DM_config.upgrade.length > 0) {
                    if (DM_AutoModeSwitchStatus) {
                        _DM_startAutoMode();
                    } else {
                        _DM_upgradeMines(DM_config.upgrade);
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
        $('#DrunkenMinerModal .build_newSaveTemplate').off('click').click(function () {
            DM_build_newTemplates.save(DM_config);
        });
        $('#DrunkenMinerModal .build_newLoadTemplate').off('click').click(function () {
            DM_build_newTemplates.load();
        });
        $("#DrunkenMinerModal .btnClose").off('click').click(function () {
            $('#DrunkenMinerModal').modal('hide');
        });

        $('[data-toggle="tooltip"]').tooltip();
    }

    function _DM_SetConfigValues() {
        //set filter value
        for (var ore in DM_config.maxLvl) {
            if (DM_config.maxLvl.hasOwnProperty(ore)) {
                var value = DM_config.maxLvl[ore];
                $('select[name="DM_maxUpgLvlFilter_' + ore + '"]').val(value);
            }
        }
        $('[id^="DM_UpgradeMines_"]').prop('checked', false);
        $('[id^="DM_RebuildMines_"]').prop('checked', false);


        //todo it's remove mains swith config

        if (DM_UpgradeSwitchStatus){
            DM_config.upgrade = DM_config.upgrade.filter(function(grid) {
                return $('#DM_UpgradeMines_' + grid).length > 0;
            });
        }else{
            DM_config.build = DM_config.build.filter(function(grid) {
                return $('#DM_RebuildMines_' + grid).length > 0;
            });
        }

        DM_config.upgrade.forEach(function(grid) {
            $('#DM_UpgradeMines_' + grid).prop('checked', true);
        });
        DM_config.build.forEach(function(grid) {
            $('#DM_RebuildMines_' + grid).prop('checked', true);
        });

        _DM_updateSelectAllOpacity();
    }

    function _DM_GoTo(g) {
        try {
            $('#DrunkenMinerModal').modal('hide');
            swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(g);
        } catch (e) {
            debug(e);
        }
    }

    function _DM_saveTmpSetting() {
        settings.settings[SCRIPT_PREFIX + 'SETTINGS'] = {};
        settings.store(DM_config, SCRIPT_PREFIX + 'SETTINGS');
    }

    function _DM_buildMines(gridArr) {
        if (typeof window._DM_pendingBuilds === 'undefined') {
            window._DM_pendingBuilds = 0;
        }

        var x = new TimedQueue(1000);
        var CurrentQueue = swmmo.application.mGameInterface.mHomePlayer.mBuildQueue.GetQueue_vector().length;
        var QueueTotal = swmmo.application.mGameInterface.mHomePlayer.mBuildQueue.GetTotalAvailableSlots();

        var CurrentQueueFree = QueueTotal - CurrentQueue - window._DM_pendingBuilds;

        for (var i = gridArr.length - 1; i >= 0; i--) {
            var grid = gridArr[i];

            if (CurrentQueueFree < 1) {
                break;
            }

            var deposit = game.zone.mStreetDataMap.mDepositContainer.get(grid);
            if (!deposit) {
                DM_config.build = DM_config.build.filter(function (g) {
                    return g !== grid;
                });
                gridArr.splice(i, 1);
                continue;
            }

            var oreName = deposit.GetName_string();
            var mapping = RESOURCES.buildMapping[oreName];

            if (!mapping) {
                DM_config.build = DM_config.build.filter(function (g) {
                    return g !== grid;
                });
                gridArr.splice(i, 1);
                continue;
            }

            var bld = game.zone.GetBuildingFromGridPosition(grid);
            if (bld !== null) {
                DM_config.build = DM_config.build.filter(function (g) {
                    return g !== grid;
                });
                gridArr.splice(i, 1);
                continue;
            }

            window._DM_pendingBuilds++;
            CurrentQueueFree--;

            x.add((function (currentGrid, currentMapping) {
                return function () {
                    DM_config.build = DM_config.build.filter(function (g) {
                        return g !== currentGrid;
                    });

                    game.gi.SendServerAction(50, currentMapping.number, currentGrid, 0, null);
                    game.showAlert(loca.GetText("BUI", "DefenseModeGhostGarrison") + ' ' + loca.GetText("RES", currentMapping.text));

                    // Уменьшаем счетчик после отправки
                    window._DM_pendingBuilds--;
                };
            })(grid, mapping));

            gridArr.splice(i, 1);
        }

        x.run();

    }

    function _DM_upgradeMines(gridArr) {
        var x = new TimedQueue(1000);
        for (var i = gridArr.length - 1; i >= 0; i--) {
            var grid = gridArr[i];
            var building = game.zone.GetBuildingFromGridPosition(grid);
            if (!building) {
                //need buildin to upgrade
                gridArr.splice(i,1);
                continue;
            }
            var name = building.GetBuildingName_string().replace('Mine', 'Ore');
            var maxUpgradeLevel = DM_config.maxLvl[name];
            if (building.GetUIUpgradeLevel() < maxUpgradeLevel && building.IsBuildingInProduction() && building.IsUpgradeAllowed(true)) {
                x.add((function (grid, name) {
                    return function () {
                        game.gi.SendServerAction(60, 0, grid, 0, null);
                        var locName = loca.GetText('BUI', name);
                        game.showAlert(loca.GetText("ALT", "UpgradeBuilding") + ' ' + locName);
                    };
                })(building.GetGrid(), building.GetBuildingName_string()));
            }
            gridArr.splice(i, 1);
        }
        x.run();
    }

    function _DM_getBuildingDataFromDeposit(deposit) {
        var bld = game.zone.GetBuildingFromGridPosition(deposit.GetGrid());
        if (!bld || typeof bld.GetBuildingName_string !== 'function') {
            return null;
        }
        var name = bld.GetBuildingName_string();
        if (
            RESOURCES.mines.indexOf(name) === -1 ||
            bld.isGarrison() ||
            name.toUpperCase().indexOf('EW_') !== -1 ||
            name.toUpperCase().indexOf('DECORATION_MOUNTAIN_PEAK') !== -1 ||
            name.toUpperCase().indexOf('BANDITS') !== -1
        ) {
            return null;
        }

        var locName = loca.GetText('BUI', name);

        if (locName.indexOf('[undefined text]') >= 0) {
            locName = name;
        }

        var level                       = bld.GetUIUpgradeLevel();
        var grid                        = bld.GetGrid();
        var resLeft                     = deposit.GetAmount();
        var secsToBuffEnd               = 0;
        var cycleSeconds                = bld.CalculateWays() / 1000;
        var resourcesRemovedEverySecond = 0;
        var timeStr                     = "";
        var buffName                    = "";
        var buff                        = bld.productionBuff;
        var isWorking                   = bld.IsProductionActive();
        var buffIcon                    = '';

        //has buff
        if (buff != null) {
            var app = buff.GetApplicanceMode();
            if (buff.IsActive(swmmo.application.mGameInterface.GetClientTime())) {
                secsToBuffEnd = new window.runtime.Date(Date.now() + (buff.GetStartTime() + buff.GetBuffDefinition().getDuration(app)) - swmmo.application.mGameInterface.GetClientTime());
                buffName      = loca.GetText("RES", buff.GetBuffDefinition().GetName_string());
                buffIcon      = buff.GetBuffDefinition().GetName_string();
            }
            if (secsToBuffEnd > 0) {
                var dtfex = new window.runtime.flash.globalization.DateTimeFormatter("en-US");
                if (gameLang.indexOf("en-") > 0) dtfex.setDateTimePattern("MM-dd-yyyy HH:mm"); else dtfex.setDateTimePattern("dd-MM HH:mm");

                timeStr = dtfex.format(new window.runtime.Date(secsToBuffEnd));
            }
        }

        var rcd = swmmo.getDefinitionByName("ServerState::gEconomics").GetResourcesCreationDefinitionForBuilding(name);

        var rcd_pck = 0; // infinite mines remove 0
        if (rcd != null) rcd_pck = rcd.amountRemoved; // resources removed base value
        var totalRemoved = bld.GetResourceInputFactor() * rcd_pck; // resources removed base * level * buffs

        if (isWorking) resourcesRemovedEverySecond += (totalRemoved == 0 ? 0 : totalRemoved / cycleSeconds);

        return {
            'grid': grid,
            'name': name,
            'locName': locName,
            'level': level,
            "resourcesLeft": resLeft,
            'isWorking': bld.IsProductionActive(),
            'isUpgradeInProgress': bld.IsUpgradeInProgress(),
            'isUpgradeAllowed': bld.IsUpgradeAllowed(true),
            'buff': buffName,
            'buffIcon': buffIcon,
            'BufEndTime': timeStr,
            "AmountRemoved": totalRemoved,
            "SecondsToDeplete": (resourcesRemovedEverySecond > 0 && resLeft > 0 ? (resLeft / resourcesRemovedEverySecond) : 0),
        }
    }

    function _DM_pushUpgradeGridToConfig(grid, isChecked) {
        if (DM_config.upgrade.indexOf(grid) === -1 && isChecked) {
            DM_config.upgrade.push(grid);
        } else if (DM_config.upgrade.indexOf(grid) !== -1 && !isChecked) {
            var index = DM_config.upgrade.indexOf(grid);
            DM_config.upgrade.splice(index, 1);
        }
    }

    function _DM_pushBuildGridToConfig(grid, isChecked) {
        if (DM_config.build.indexOf(grid) === -1 && isChecked) {
            DM_config.build.push(grid);
        } else if (DM_config.build.indexOf(grid) !== -1 && !isChecked) {
            var index = DM_config.build.indexOf(grid);
            DM_config.build.splice(index, 1);
        }
    }

    function _DM_updateSelectAllOpacity() {
        var hasAnyOrangeChecked = false;
        RESOURCES.ores.forEach(function (oreName) {
            var hasChecked        = false;
            var relatedCheckboxes = $('input[type="checkbox"][name="' + oreName + '"]').filter(function () {
                var id = this.id;
                return id && (id.indexOf('DM_RebuildMines_') === 0 || id.indexOf('DM_UpgradeMines_') === 0);
            });
            relatedCheckboxes.each(function () {
                var $cb = $(this);
                if ($cb.is(':checked')) {
                    hasChecked = true;
                    if (!hasAnyOrangeChecked) {
                        var $timeCell = $cb.parent().parent().find('div:eq(3)');
                        var timeText = $timeCell.text().trim();

                        if (timeText.indexOf('/') !== -1) {
                            var parts = timeText.split('/');
                            var color = _DM_formatBuffTimeColor(parts[0].trim(), parts[1].trim());
                            if (color === 'orange') {
                                hasAnyOrangeChecked = true;
                            }
                        }
                    }
                    if (hasChecked && hasAnyOrangeChecked){
                        return false;
                    }
                }
            });
            var selectAllElement = $('#DM_selectAll_' + oreName);
            if (selectAllElement.length > 0) {
                if (hasChecked) {
                    selectAllElement.css('opacity', '1');
                } else {
                    selectAllElement.css('opacity', '.5');
                }
            }
        });

        var allCheckboxes = $('#DrunkenMinerModalData input[type="checkbox"]');
        var isAnyChecked  = allCheckboxes.is(':checked');
        $('#' + DM_lements.SELECT_ALL_BTN).css('opacity', isAnyChecked ? '1' : '.5');
        $('#' + DM_lements.SAFE_BUFF_BTN).css('opacity', hasAnyOrangeChecked ? '1' : '.5');
    }

    function _DM_findOreInDepletedName(depletedName) {
        var result = "";

        RESOURCES.ores.forEach(function (ore) {
            if (depletedName.indexOf(ore) !== -1) {
                result = ore;
            }
        });

        return result;
    }

    //helpers
    function _DM_ViewerSetTimeStr(seconds, type) {
        try {
            if (seconds < 1) return "";
            switch (type) {
                case 1:
                    return new Date(seconds * 1000).toISOString().slice(11, 19);
                case 2:
                    var d  = new Date(new Date(Date.now()).getTime() + seconds * 1000);
                    var _m = ("00" + (d.getMonth() + 1).toString()).slice(-2);
                    var _d = ("00" + d.getDate().toString()).slice(-2);
                    if (gameLang.indexOf("en-") > 0) return _m + "-" + _d + " " + d.toLocaleTimeString(); else return _d + "-" + _m + " " + d.toLocaleTimeString();
            }
        } catch (e) {
            debug(e);
        }
        return "";
    }

    function _DM_parseBuffDate(dateStr) {
        try {
            var parts = dateStr.split(" ");
            var day   = parts[0];
            var time  = parts[1];

            var dayParts = day.split("-");
            var dd       = parseInt(dayParts[0], 10);
            var MM       = parseInt(dayParts[1], 10);

            var timeParts = time.split(":");
            var hh        = parseInt(timeParts[0], 10);
            var mm        = parseInt(timeParts[1], 10);
            var ss        = timeParts.length > 2 ? parseInt(timeParts[2], 10) : 0;

            var now = new Date();
            return new Date(now.getFullYear(), MM - 1, dd, hh, mm, ss);
        } catch (e) {
            debug(e);
            return '';
        }
    }

    function _DM_formatBuffTimeColor(dateStr1, dateStr2) {
        const date1 = _DM_parseBuffDate(dateStr1);
        const date2 = _DM_parseBuffDate(dateStr2);

        return date1 > date2 ? "yellow" : "orange";
    }
})(window);