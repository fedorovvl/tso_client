////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////Created by MadFX | Thanks for PiTi for source code. ////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const SCRIPT_PREFIX    = 'DM_';
const DM_MaxUpgradeLvl = 12;

addToolsMenuItem(loca.GetText("RES", 'BuffAd_Drunken_Miner'), DM_MenuHandler);
var _DM_ModalInitialized = false;


var DM_UpgradeSwitchStatus = false;
var assetsNamesMinesOres   = ["IronOre", "Coal", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter"];
var assetsNamesMines       = [
    "BronzeMine", "EpicBronzeMine", "IronMine", "EpicIronMine", "ArcticIronMine", "CoalMine", "EpicCoalMine",
    "GoldMine", "EpicGoldMine", "TitaniumMine", "EpicTitaniumMine", "ArcticTitaniumMine", "SalpeterMine",
    "EpicSalpeterMine"
];
var assetsNames            = [
    "IronOre", "Coal", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter", "MineDepletedDepositIronOre",
    "MineDepletedDepositCoal", "MineDepletedDepositBronzeOre", "MineDepletedDepositGoldOre",
    "MineDepletedDepositTitaniumOre", "MineDepletedDepositSalpeter"
];
var assetsIconsOres        = {
    "IronOre": 'ButtonIconIron',
    "Coal": 'ButtonIconCoal',
    "BronzeOre": 'ButtonIconBronze',
    "GoldOre": 'ButtonIconGold',
    "TitaniumOre": 'ButtonIconTitanium',
    "Salpeter": 'ButtonIconSalpeter'
};
var build_newTemplates;

var DM_lements        = {
    ON_OFF_RADIO: SCRIPT_PREFIX + 'StateSwitch',
    ON_OFF_RADIO_TEXT: SCRIPT_PREFIX + 'StateSwitchStatus',
    BUILD_CHECKBX: SCRIPT_PREFIX + 'buildCheckBox',
    UPGR_CHECKBX: SCRIPT_PREFIX + 'upgrCheckBox'
};
var DM_SwitchStatuses = {
    UPGRADE: loca.GetText('ACL', 'Upgrades'), BUILD: loca.GetText('BUI', 'TwinTown_building_spot')
};

var config     = {
    build: [], upgrade: [], switchStatus: DM_UpgradeSwitchStatus, maxLvl: {
        "IronOre": 1, "Coal": 1, "BronzeOre": 1, "GoldOre": 1, "TitaniumOre": 1, "Salpeter": 1
    }
};
var gEconomics = swmmo.getDefinitionByName("ServerState::gEconomics");

$.extend(config, settings.read(null, SCRIPT_PREFIX + 'SETTINGS'));

function DM_MenuHandler() {
    //init
    if (game.gi.isOnHomzone() === false) {
        game.showAlert(getText('not_home'));
        return;
    }

    _DM_init();

    //view
    //render header
    _DM_renderHeader();
    //render body
    var deposits;
    if (DM_UpgradeSwitchStatus) {
        deposits = _DM_getUpgradeData();
    } else {
        deposits = _DM_GetBuildData();
    }
    _DM_renderData(deposits);

    // footer
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

    _DM_InitEvens();
    _DM_SetConfigValues();

    $('#DrunkenMinerModal:not(:visible)').modal({
        backdrop: "static"
    });
}

function _DM_init() {
    $("div[role='dialog']:not(#DrunkenMinerModal):visible").modal("hide");
    if (!_DM_ModalInitialized) $('#DrunkenMinerModal').remove();
    createModalWindow('DrunkenMinerModal', 'Drunken Miner');

    DM_UpgradeSwitchStatus = config.switchStatus;

    //load
    build_newTemplates = new SaveLoadTemplate('ml', function (data, name) {
        $("#DrunkenMinerModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
        var loadData = data;
        if (loadData.length === 0) {
            return;
        }
        config = loadData;
        _DM_SetConfigValues();
    });
}

function _DM_renderHeader() {
    var switchHtml = createTableRow([
        [
            11,
            createSwitch(DM_lements.ON_OFF_RADIO, DM_UpgradeSwitchStatus) + '<div style="position: absolute;left: 55px;top: 1px;" id="' + DM_lements.ON_OFF_RADIO_TEXT + '">{0}</div>'
                .format(DM_UpgradeSwitchStatus ? DM_SwitchStatuses.UPGRADE : DM_SwitchStatuses.BUILD)
        ], [1, '']
    ], true)

    var maxUpgradeLevelHtml = '';
    var selectAllBtnsHtml   = '';
    assetsNamesMinesOres.forEach(function (ore) {
        var img  = getImageTag(assetsIconsOres[ore], '24px');
        var html = img + '<select name="DM_maxUpgLvlFilter_' + ore + '">';
        for (var i = 0; i < DM_MaxUpgradeLvl; i++) {
            html += '<option value="' + (i + 1) + '">' + (i + 1) + '</option>';
        }
        html += '</select>';
        maxUpgradeLevelHtml += html;

        selectAllBtnsHtml += img.replace('24px', '24px;vertical-align: top') + ' ' + createSwitch('DM_selectAll_' + ore, false) + ' ';
    });
    maxUpgradeLevelHtml = createTableRow([[3, ''], [9, maxUpgradeLevelHtml]], true);
    selectAllBtnsHtml   = createTableRow([[3, ''], [9, selectAllBtnsHtml]], true);

    var tableHeadHtml = createTableRow([
        [3, loca.GetText("BUI", "BuildingMountainOre")], [3, loca.GetText('LAB', 'Expires')],
        [2, loca.GetText("LAB", "RareBuffGroup0")], [1, loca.GetText("LAB", "RareBuffGroup2")],
        [1, loca.GetText("LAB", "ExpeditionDifficultyTooltip")], [1, loca.GetText("LAB", "Tasks")],
        [1, loca.GetText("LAB", "Visit")], // [12, loca.GetText("LAB", "Buff")],
    ], true);

    $('#DrunkenMinerModal .modal-header').html('<div class="container-fluid">' + switchHtml + maxUpgradeLevelHtml + selectAllBtnsHtml + '<br>' + tableHeadHtml + '</div>');
}

function _DM_getUpgradeData() {
    var resArr   = { deposit: [], depleted: [] };
    var deposits = [];

    swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mDepositContainer.forEach(function (item) {
        if (assetsNamesMinesOres.indexOf(item.GetName_string()) !== -1 && game.zone.GetBuildingFromGridPosition(item.GetGrid()) !== null) {
            deposits.push(item);
        }
    });
    deposits.sort(function (a, b) {
        return loca.GetText("RES", a.GetName_string()).localeCompare(loca.GetText("RES", b.GetName_string()));
    });

    deposits.forEach(function (deposit) {
        try {
            var bld     = _DM_getOreMineData(deposit);
            var resItem = {
                grid: deposit.GetGrid(),
                buildingInfo: loca.GetText("LAB", "DetailsDeposit"),
                depositName: deposit.GetName_string(),
                resourcesLeft: deposit.GetAmount(),
                icon: assetsIconsOres[deposit.GetName_string()],
                building: bld,
            };

            if (bld) {
                if (bld.isUpgradeInProgress) {
                    resItem.buildingInfo = loca.GetText('LAB', 'Upgrade');
                } else {
                    resItem.buildingInfo = loca.GetText('QUL', 'TutBronzeMine');
                }

                if (bld.isUpgradeAllowed) {
                    resArr.deposit.push(resItem);
                }
            }
        } catch (e) {
            alert(e.message);
        }
    });

    return resArr;
}

function _DM_GetBuildData() {
    var resArr   = { deposit: [], depleted: [] };
    var deposits = [];

    swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mDepositContainer.forEach(function (item) {
        if (assetsNamesMinesOres.indexOf(item.GetName_string()) !== -1 && game.zone.GetBuildingFromGridPosition(item.GetGrid()) == null) {
            deposits.push(item);
        }
    });
    deposits.sort(function (a, b) {
        return loca.GetText("RES", a.GetName_string()).localeCompare(loca.GetText("RES", b.GetName_string()));
    });

    deposits.forEach(function (deposit) {
        try {
            var resItem = {
                grid: deposit.GetGrid(),
                buildingInfo: '(' + loca.GetText("LAB", "DetailsDeposit") + ')',
                depositName: deposit.GetName_string(),
                resourcesLeft: deposit.GetAmount(),
                icon: assetsIconsOres[deposit.GetName_string()]
            };
            resArr.deposit.push(resItem);
        } catch (e) {
            alert(e.message);
        }
    });

    var depleted = [];
    swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function (item) {
        try {
            if (swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.IsADepletedDeposit(item)) {
                if (item == null || assetsNames.indexOf(item.GetBuildingName_string()) === -1) {
                    return;
                }
                var resource = _DM_FindOriginalResource(item.GetBuildingName_string());
                depleted.push({
                    "grid": item.GetGrid(),
                    "icon": assetsIconsOres[resource],
                    "name": item.GetBuildingName_string(),
                    "Resource": resource,
                });
            }
        } catch (e) {
            alert(e.message);
        }
    });

    depleted.sort(function (a, b) {
        return a.Resource.localeCompare(b.Resource);
    });

    resArr.depleted = depleted;
    return resArr;
}

function _DM_renderData(deposits) {
    var $rowHtml = '';

    deposits.deposit.forEach(function (deposit) {
        var bld              = deposit.building;
        var checkbox         = '';
        var bldLvl           = '';
        var secondsToDeplete = '';
        var depositName      = deposit.depositName !== undefined ? loca.GetText('RES', deposit.depositName) : '';
        var resourcesLeft    = deposit.resourcesLeft !== undefined ? deposit.resourcesLeft : '';
        var buffName         = '';
        var buffEndTime      = '';
        var timeHtml         = '';

        var buildingGoto = getImageTag('accuracy.png', '24px', '24px').replace('<img', '<img id="DM_MinePOS_' + deposit.grid + '"').replace('style="', 'style="cursor: pointer;');

        if (bld) {
            if (bld.isUpgradeAllowed && !bld.isUpgradeInProgress) {
                checkbox = '<input type="checkbox" id="DM_UpgradeMines_' + bld.grid + '" name="' + deposit.depositName + '" class="' + DM_lements.UPGR_CHECKBX + '" />';
            }
            bldLvl           = bld.level;
            secondsToDeplete = bld.SecondsToDeplete;
            buffName         = bld.buff;
            buffEndTime      = bld.BufEndTime;
            resourcesLeft    = bld.resourcesLeft;
            depositName      = bld.locName;

            timeHtml = _DMViewerSetTimeStr(bld.SecondsToDeplete, 2);
            if (buffEndTime.length > 0) {
                timeHtml = '<span style="color: ' + _DM_formatBuffTimeColor(secondsToDeplete, buffEndTime) + '">' + timeHtml + ' / ' + buffEndTime + '</span>';
            }
        } else {
            checkbox = '<input type="checkbox" id="DM_RebuildMines_' + deposit.grid + '" name="' + deposit.depositName + '" class="' + DM_lements.BUILD_CHECKBX + '" />';
        }

        //for upgrade skip without mines
        if (DM_UpgradeSwitchStatus && !bld) {
            return;
        }
        $rowHtml += createTableRow([
            [3, getImageTag(deposit.icon, '24px') + ' ' + depositName], [3, timeHtml],
            [2, '<small>' + buffName + '</small>'], [1, resourcesLeft], [1, bldLvl], [1, checkbox],
            [1, '<div style="text-align: right;">' + buildingGoto + '</div>']
        ], false);
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
            alert(e.message);
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
        var ore            = this.name.replace("DM_maxUpgLvlFilter_", "");
        config.maxLvl[ore] = $(this).val();
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
        var deposits;
        if (DM_UpgradeSwitchStatus) {
            deposits = _DM_getUpgradeData();
        } else {
            deposits = _DM_GetBuildData();
        }

        _DM_renderData(deposits);
        config.switchStatus = DM_UpgradeSwitchStatus;
        _DM_InitEvens();
        _DM_saveTmpSetting();
    });

    if (mainSwitch.is(':checked')) {
        $("." + DM_lements.BUILD_CHECKBX).hide();
        $("." + DM_lements.UPGR_CHECKBX).show();
    } else {
        $("." + DM_lements.UPGR_CHECKBX).hide();
        $("." + DM_lements.BUILD_CHECKBX).show();
    }

    $('[id^="DM_UpgradeMines_"]').off('click').on('click', function () {
        var grid      = this.id.replace("DM_UpgradeMines_", "");
        var isChecked = $('#DM_UpgradeMines_' + grid).prop('checked');

        _DM_pushUpgradeGridToConfig(grid, isChecked);

        _DM_saveTmpSetting();
    });
    $('[id^="DM_RebuildMines_"]').off('click').on('click', function () {
        var grid      = this.id.replace("DM_RebuildMines_", "");
        var isChecked = $('#DM_RebuildMines_' + grid).prop('checked');

        _DM_pushBuildGridToConfig(grid, isChecked);

        _DM_saveTmpSetting();
    });

    $('[id^="DM_selectAll_"]').off('change').change(function () {
        var ore       = this.id.replace("DM_selectAll_", "");
        var isChecked = $('#DM_selectAll_' + ore).prop('checked');

        $('[name^="' + ore + '"]').each(function () {
            $(this).prop('checked', isChecked);
            var grid = '';

            if (this.id.indexOf('DM_UpgradeMines_') !== -1) {
                grid = this.id.replace("DM_UpgradeMines_", "");

                _DM_pushUpgradeGridToConfig(grid, isChecked);
                return;
            }
            if (this.id.indexOf('DM_RebuildMines_') !== -1) {
                grid = this.id.replace("DM_RebuildMines_", "");

                _DM_pushBuildGridToConfig(grid, isChecked);
            }
        });

        _DM_saveTmpSetting();
    });

    $('#DrunkenMinerModal .upgradeReset').off('click').click(function () {
        config = {
            build: [], upgrade: [], switchStatus: DM_UpgradeSwitchStatus, maxLvl: {
                "IronOre": 1, "CoalOre": 1, "BronzeOre": 1, "GoldOre": 1, "TitaniumOre": 1, "Salpeter": 1
            }
        };

        _DM_SetConfigValues();
        _DM_saveTmpSetting();
    });
    $('#DrunkenMinerModal .upgradeSubmit').off('click').click(function () {
        $('#DrunkenMinerModal').modal('hide');

        if (config.upgrade.length === 0 && config.build.length === 0) {
            game.showAlert(loca.GetText('CHA', 'InvalidAdminSlashCommand'));
            return;
        }

        if (DM_UpgradeSwitchStatus) {
            if (config.upgrade.length > 0) {
                setTimeout(function () {
                    _DM_upgradeMines(config.upgrade);
                }, 3000);
            }
        } else {
            if (config.build.length > 0) {
                setTimeout(function () {
                    _DM_buildMines(config.build);
                }, 3000);
            }
        }
    });
    $('#DrunkenMinerModal .build_newSaveTemplate').off('click').click(function () {
        build_newTemplates.save(config);
    });
    $('#DrunkenMinerModal .build_newLoadTemplate').off('click').click(function () {
        build_newTemplates.load();
    });
    $("#DrunkenMinerModal .btnClose").off('click').click(function () {
        $('#DrunkenMinerModal').modal('hide');
    });
}

function _DM_SetConfigValues() {
    //set filter value
    for (var ore in config.maxLvl) {
        if (config.maxLvl.hasOwnProperty(ore)) {
            var value = config.maxLvl[ore];
            $('select[name="DM_maxUpgLvlFilter_' + ore + '"]').val(value);
        }
    }
    $('[id^="DM_UpgradeMines_"]').prop('checked', false);
    $('[id^="DM_RebuildMines_"]').prop('checked', false);
    config.upgrade.forEach(function (grid) {
        $('#DM_UpgradeMines_' + grid).prop('checked', true);
    });
    config.build.forEach(function (grid) {
        $('#DM_RebuildMines_' + grid).prop('checked', true);
    });
}

function _DM_FindOriginalResource(building_name) {
    var res = "";
    try {
        assetsNamesMinesOres.forEach(function (item) {
            if (building_name.indexOf(item) >= 0) res = item;
        });
    } catch (e) {
    }
    return res;
}

function _DM_GoTo(g) {
    try {
        $('#DrunkenMinerModal').modal('hide');
        swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(g);
    } catch (e) {

    }
}

function _DM_mapItemToNumber(itemName) {
    switch (itemName) {
        case "TitaniumOre":
            return { number: 69, text: "TitaniumOre" };
        case "Salpeter":
            return { number: 63, text: "Salpeter" };
        case "BronzeOre":
            return { number: 36, text: "BronzeOre" };
        case "Coal":
            return { number: 37, text: "Coal" };
        case "GoldOre":
            return { number: 46, text: "GoldOre" };
        case "IronOre":
            return { number: 50, text: "IronOre" };
        case "MineDepletedDepositTitaniumOre":
            return { number: 69, text: "TitaniumOre" };
        case "MineDepletedDepositSalpeter":
            return { number: 63, text: "Salpeter" };
        case "MineDepletedDepositBronzeOre":
            return { number: 36, text: "BronzeOre" };
        case "MineDepletedDepositCoal":
            return { number: 37, text: "Coal" };
        case "MineDepletedDepositGoldOre":
            return { number: 46, text: "GoldOre" };
        case "MineDepletedDepositIronOre":
            return { number: 50, text: "IronOre" };
    }
}

function _DM_saveTmpSetting() {
    settings.settings[SCRIPT_PREFIX + 'SETTINGS'] = {};
    settings.store(config, SCRIPT_PREFIX + 'SETTINGS');
}

function _DM_buildMines(gridArr) {
    // air.Introspector.Console.log(gridArr);
    var x                = new TimedQueue(1000);
    var CurrentQueue     = 0;
    var CurrentQueueFree = 0;
    var QueueTotal;

    $.each(swmmo.application.mGameInterface.mHomePlayer.mBuildQueue.GetQueue_vector(), function () {
        CurrentQueue++;
    });
    QueueTotal       = swmmo.application.mGameInterface.mHomePlayer.mBuildQueue.GetTotalAvailableSlots();
    CurrentQueueFree = QueueTotal - CurrentQueue;

    $.each(gridArr, function (i, grid) {
        if (CurrentQueueFree < 1) {
            return;
        }
        var deposit = swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mDepositContainer.get(grid);
        if (!deposit) {
            return;
        }
        var buildingName = (deposit.GetBuildingName_string !== undefined) ? deposit.GetBuildingName_string() : deposit.GetName_string();
        if (buildingName === undefined) {
            return;
        }
        var Mapping = _DM_mapItemToNumber(buildingName);
        var bld     = game.zone.GetBuildingFromGridPosition(deposit.GetGrid());
        if (bld == null) {
            CurrentQueueFree--;
            x.add(function () {
                game.gi.SendServerAction(50, Mapping.number, deposit.GetGrid(), 0, null);
                game.showAlert(loca.GetText("BUI", "DefenseModeGhostGarrison") + ' ' + loca.GetText("RES", Mapping.text));
            });
        }
    });
    x.run();
}

function _DM_upgradeMines(gridArr) {
    var x = new TimedQueue(1000);
    game.showAlert(getText('command_sent'));
    $.each(gridArr, function (i, item) {
        var building = game.zone.GetBuildingFromGridPosition(item);
        if (!building) {
            return;
        }
        name = building.GetBuildingName_string().replace('Mine', 'Ore');
        if (name == 'CoalOre') {
            name = 'Coal';
        }
        var maxUpgradeLevel = config.maxLvl[name];

        if (building.GetUIUpgradeLevel() < maxUpgradeLevel && building.IsBuildingInProduction() && building.IsUpgradeAllowed(true)) {
            x.add(function () {
                game.gi.SendServerAction(60, 0, building.GetGrid(), 0, null);
                var name    = building.GetBuildingName_string();
                var locName = loca.GetText('BUI', name);
                game.showAlert(loca.GetText("ALT", "UpgradeBuilding") + ' ' + locName);
            });
        }
    });
    x.run();
}

function _DM_getOreMineData(deposit) {
    var bld = game.zone.GetBuildingFromGridPosition(deposit.GetGrid());
    if (bld === null || assetsNamesMines.indexOf(bld.GetBuildingName_string()) === -1 || bld.isGarrison()) {
        return null;
    }
    var name = bld.GetBuildingName_string();
    if (name.toUpperCase().indexOf('EW_') != -1 || name.toUpperCase().indexOf('DECORATION_MOUNTAIN_PEAK') != -1 || name.toUpperCase().indexOf('BANDITS') != -1) {
        return null;
    }

    var locName = loca.GetText('BUI', name);
    if (locName.indexOf(UNDEFINED_TEXT) >= 0) {
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
    //has buff
    if (buff != null) {
        var app = buff.GetApplicanceMode();
        if (buff.IsActive(swmmo.application.mGameInterface.GetClientTime())) {
            secsToBuffEnd = new window.runtime.Date(Date.now() + (buff.GetStartTime() + buff.GetBuffDefinition().getDuration(app)) - swmmo.application.mGameInterface.GetClientTime());
            buffName      = loca.GetText("RES", buff.GetBuffDefinition().GetName_string());
        }
        if (secsToBuffEnd > 0) {
            var dtfex = new window.runtime.flash.globalization.DateTimeFormatter("en-US");
            if (gameLang.indexOf("en-") > 0) dtfex.setDateTimePattern("MM-dd-yyyy HH:mm"); else dtfex.setDateTimePattern("dd-MM HH:mm");

            timeStr = dtfex.format(new window.runtime.Date(secsToBuffEnd));
        }
    }
    var rcd = gEconomics.GetResourcesCreationDefinitionForBuilding(bld.GetBuildingName_string());

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
        'BufEndTime': timeStr,
        "AmountRemoved": totalRemoved,
        "SecondsToDeplete": (resourcesRemovedEverySecond > 0 && resLeft > 0 ? (resLeft / resourcesRemovedEverySecond) : 0),
    }
}

function _DM_pushUpgradeGridToConfig(grid, isChecked) {
    if (config.upgrade.indexOf(grid) === -1 && isChecked) {
        config.upgrade.push(grid);
    } else if (config.upgrade.indexOf(grid) !== -1 && !isChecked) {
        var index = config.upgrade.indexOf(grid);
        config.upgrade.splice(index, 1);
    }
}

function _DM_pushBuildGridToConfig(grid, isChecked) {
    if (config.build.indexOf(grid) === -1 && isChecked) {
        config.build.push(grid);
    } else if (config.build.indexOf(grid) !== -1 && !isChecked) {
        var index = config.build.indexOf(grid);
        config.build.splice(index, 1);
    }
}

//helpers
function _DMViewerSetTimeStr(seconds, type) {
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
        return '';
    }
}

function _DM_formatBuffTimeColor(dateStr1, dateStr2) {
    const date1 = _DM_parseBuffDate(dateStr1);
    const date2 = _DM_parseBuffDate(dateStr2);

    return date1 > date2 ? "yellow" : "orange";
}