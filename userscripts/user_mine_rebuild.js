////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////Created by PiTi | In co-operation with Test_Siedler////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

addToolsMenuItem(loca.GetText("QUL", "TutBronzeMine") + " " + loca.GetText("QUL", "CQ2S1_Reconstitution_Tcl5"), DepositDepletedMenuHandler);
var _DepositDepletedModalInitialized = false;

var assetsNamesMine = ["IronOre", "Coal", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter"];
var assetsNames = ["IronOre", "Coal", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter", "MineDepletedDepositIronOre", "MineDepletedDepositCoal", "MineDepletedDepositBronzeOre", "MineDepletedDepositGoldOre", "MineDepletedDepositTitaniumOre", "MineDepletedDepositSalpeter"];

var DepositDepletedTranslates = {
    'en-uk': {
        'All' : 'All',
        'AvailableOnly' : 'Available only',
        'AvailableOnlyHint' : '"Available only": no checkbox if a mine is already built or a depo has not been found yet.'
    },
    'en-us': {
        'All' : 'All',
        'AvailableOnly' : 'Available only',
        'AvailableOnlyHint' : '"Available only": no checkbox if a mine is already built or a depo has not been found yet.'
    },
    'de-de': {
        'All' : 'Alle',
        'AvailableOnly' : 'Verfügbar nur',
        'AvailableOnlyHint' : '"Verfügbar nur“: kein Kontrollkästchen, wenn bereits eine Mine gebaut ist oder noch kein Lager gefunden wurde.'    
    },
    'fr-fr': {
        'All' : 'Tous',
        'AvailableOnly' : 'Disponible uniquement',
        'AvailableOnlyHint' : '"Disponible uniquement" : aucune case à cocher si mine construite ou si gisement non trouvé.'
    }
};
extendBaseLang(DepositDepletedTranslates, 'DepositDepletedTranslates');
var DepositDepletedNamePrefix = 'DepositDepleted_';
var DepositDepletedElements = {
    ON_OFF_RADIO: DepositDepletedNamePrefix + 'AvailableOnlySwitch',
    ON_OFF_RADIO_TEXT: DepositDepletedNamePrefix + 'AvailableOnlySwitchStatus',
    NOT_AVAILABLE_CB: 'mineNotAvailable'
};
var DepositDepletedSwitchStatuses = {
    ON: getText('AvailableOnly', 'DepositDepletedTranslates'),
    OFF: getText('All', 'DepositDepletedTranslates')
};
var DepositDepleted_AvailableOnlySwitchStatus = false;

var buildArray = [];
var buildArraySave;
var buildArrayLoad = [];
var DepositAll = [];
var DepletedAll = [];

function DepositDepletedMenuHandler(event) {
    if(game.gi.isOnHomzone() == false) {
		game.showAlert(getText('not_home'));
		return;
	}
    $("div[role='dialog']:not(#DepositDepletedModal):visible").modal("hide");
    if (!_DepositDepletedModalInitialized)
        $('#DepositDepletedModal').remove();
    createModalWindow('DepositDepletedModal', 'Deposit Viewer');

    build_newTemplates = new SaveLoadTemplate('bil', function (data, name) {
        $("#DepositDepletedModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
        buildArrayLoad = data;
        DepositAll.forEach(function (item) {
        var isMineInArray = false;
        for (var i = 0; i < buildArrayLoad.length; i++) {
             if (buildArrayLoad[i].buiGrid === item.GetGrid()) {
                  isMineInArray = true;
                  break;
                 }
             }
                if (isMineInArray) {
                    $('#_RebuildMines_' + item.GetGrid()).prop('checked', true);
                    if (isMineInArray) {
                        $('#_RebuildMines_' + item.GetGrid()).prop('checked', true);
                        if (buildArray.indexOf(item.GetGrid()) === -1) {
                            buildArray.push(item);
                        }
                    }
                }
            });
		DepletedAll.forEach(function (item) {
        var isMineInArray = false;
        for (var i = 0; i < buildArrayLoad.length; i++) {
             if (buildArrayLoad[i].buiGrid === item.Item.GetGrid()) {
                  isMineInArray = true;
                  break;
                 }
             }
                if (isMineInArray) {
                    $('#_RebuildMines_' + item.Item.GetGrid()).prop('checked', true);
                    if (isMineInArray) {
                        $('#_RebuildMines_' + item.Item.GetGrid()).prop('checked', true);
                        if (buildArray.indexOf(item.Item.GetGrid()) === -1) {
                            buildArray.push(item.Item);
                        }
                    }
                }
            });
    });

	$('#DepositDepletedModal .modal-header').html(
        createTableRow([
            [3, createSwitch(
                  DepositDepletedElements.ON_OFF_RADIO,
                  DepositDepleted_AvailableOnlySwitchStatus
                ) +
                  '<div style="position: absolute;left: 55px;top: 1px;" id="' +
                  DepositDepletedElements.ON_OFF_RADIO_TEXT +
                  '">{0}</div>'.format(
                    DepositDepleted_AvailableOnlySwitchStatus ? DepositDepletedSwitchStatuses.ON : DepositDepletedSwitchStatuses.OFF
                  )],
            [9, getText('AvailableOnlyHint', 'DepositDepletedTranslates')],
          ], true) +
        createTableRow([
                [4, loca.GetText("LAB", "Name")],
                [2, loca.GetText("LAB", "amount")],
				[1, "Grid"],
                [4, loca.GetText("LAB", "RebuildLevelOneGroup")],
				[1, loca.GetText("LAB", "Visit")],
            ], true)
         + '</div>');

    $('#DepositDepletedModalData').html('<div class="container-fluid">{0}</div>'.format(DepositDepletedMakeModal()));
	DepositDepletedGetData();
    $("#DepositDepletedModal .modal-footer").prepend([
            $('<button>').attr({
                "class": "btn btn-warning upgradeReset"
            }).text(getText('btn_reset')),
            $('<button>').attr({
                "class": "btn btn-success upgradeSubmit"
            }).text(getText('btn_submit')),
        ]);

   $("#DepositDepletedModal .modal-footer").prepend([
                $('<button>').attr({
                    "class": "btn btn-primary pull-left build_newSaveTemplate"
                }).text(getText('save_template')),
                $('<button>').attr({
                    "class": "btn btn-primary pull-left build_newLoadTemplate"
                }).text(getText('load_template'))
            ]);
    $('#DepositDepletedModal .upgradeReset').click(function () {
        buildArray = [];
        buildArraySave = [];
        buildArrayLoad = [];
        DepositDepletedGetData();
    });

    $('#DepositDepletedModal .upgradeSubmit').click(function () {
        $('#DepositDepletedModal').modal('hide');

        if (buildArray.length === 0) {
            //game.showAlert('buildArray leer');
        } else if (buildArray.length !== 0) {
            //game.showAlert('buildingArray nicht leer');
            setTimeout(function () {
                buildMine(buildArray);
            }, 2000);
        }
    });
    $('#DepositDepletedModal .build_newSaveTemplate').click(function () {
        buildArraySave = [];
        $.each(buildArray, function (i, item) {

            if (item.GetGrid() !== undefined && buildArraySave.indexOf(item.GetGrid()) === -1) {
			var buildingName = (item.GetBuildingName_string !== undefined) ? item.GetBuildingName_string() : item.GetName_string();
				
				if (buildingName !== undefined) {
					buildArraySave.push({
						buiGrid: item.GetGrid(),
						buiRessName: buildingName,
						buiMineType: mapItemToNumber(buildingName)
					});
				}
			}
        });
        build_newTemplates.save(buildArraySave);
    });
    $('#DepositDepletedModal .build_newLoadTemplate').click(function () {
        build_newTemplates.load();
    });
    $("#DepositDepletedModal .btnClose").click(function (e) {
        buildArray = [];
        buildArraySave = [];
        buildArrayLoad = [];
        $('#DepositDepletedModal').modal('hide');
    });

    $("#" + DepositDepletedElements.ON_OFF_RADIO).change(function(){
        if ($(this).is(':checked')) {
            $("#" + DepositDepletedElements.ON_OFF_RADIO_TEXT).text(DepositDepletedSwitchStatuses.ON);
            $("." + DepositDepletedElements.NOT_AVAILABLE_CB).hide();
            DepositDepleted_AvailableOnlySwitchStatus = true;
        } else {
            $("#" + DepositDepletedElements.ON_OFF_RADIO_TEXT).text(DepositDepletedSwitchStatuses.OFF);
            $("." + DepositDepletedElements.NOT_AVAILABLE_CB).show();
            DepositDepleted_AvailableOnlySwitchStatus = false;
        }
    });

    $('#DepositDepletedModal:not(:visible)').modal({
        backdrop: "static"
    });
}

function DepositDepletedMakeModal() {

    var out = '';

    out += '<div id="DepositDepletedResult"></div>';

    return out;
}

function DepositDepletedGetData() {

	buildArray = [];
	DepositAll = [];
    DepletedAll = [];
	
    $('#DepositDepletedResult').html("");
    var out = '';
	var buildingGoto = '';
    var Deposits = swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mDepositContainer;
        var sDep = new Array();
        Deposits.forEach(function (item) {

            if (assetsNamesMine.indexOf(item.GetName_string()) !== -1) {
                sDep.push(item);
            }
        });
        Deposits = sDep;
        Deposits.sort(function (a, b) {
            return loca.GetText("RES", a.GetName_string()).localeCompare(loca.GetText("RES", b.GetName_string()));
        });

        Deposits.forEach(function (item) {
            try {
                var building_built = null;
				var buildingInfo = '(' + loca.GetText("LAB", "DetailsDeposit") + ')';
                var building_built = game.zone.GetBuildingFromGridPosition(item.GetGrid());
                _checkboxRebuildMines_ = '<input type="checkbox" id="_RebuildMines_' + item.GetGrid() + '" />'.format(item.GetGrid());

                if ( building_built !== null ){
					buildingInfo = "(Mine already on deposit)";
                    _checkboxRebuildMines_ = '<input type="checkbox" class="mineNotAvailable" id="_RebuildMines_' + item.GetGrid() + '" />'.format(item.GetGrid());
				}

				//document.getElementById('buildPOSMine_' + item.grid).addEventListener('click', function () { _GoTo(item.grid, item.building); });
				buildingGoto = getImageTag('accuracy.png', '24px', '24px').replace('<img', '<img id="buildPOSMine_' + item.GetGrid() + '"').replace('style="', 'style="cursor: pointer;');
                $('#DepositDepletedResult').append(
                    createTableRow([
                            [4, loca.GetText("RES", item.GetName_string()) + ' '+  buildingInfo],
                            [2, item.GetAmount()],
							[2, item.GetGrid()],
							[3, _checkboxRebuildMines_],
							[1, '<div style="text-align: right;">' +  buildingGoto + '</div>']
                        ], false));
            } catch (e) {
                alert(e.message);
            }
			if (buildingGoto != "")
			{
				document.getElementById("buildPOSMine_" + item.GetGrid()).addEventListener("click",function() {_GoTo(item.GetGrid());});
			}			
            $(document).on('click', '#_RebuildMines_' + item.GetGrid(), function () {
				
                var isChecked = $('#_RebuildMines_' + item.GetGrid()).prop('checked');
				
                if (buildArray.indexOf(item) === -1 && isChecked) {
                    buildArray.push(item);
                } else if (buildArray.indexOf(item) !== -1 && !isChecked) {
                    var index = buildArray.indexOf(item);
                    buildArray.splice(index, 1);
                }
            });
        });
		DepositAll = Deposits;

    var Depleted = new Array();
    swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function (item) {
        try {
            if (swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.IsADepletedDeposit(item)) {
				if (item == null || assetsNames.indexOf(item.GetBuildingName_string()) === -1) {
                    return;
                }
                Depleted.push({
                    "Item": item,
                    "Resource": _FindOriginalResource(item.GetBuildingName_string())
                });
            }
        } catch (edep) {}
    });

    Depleted.sort(function (a, b) {
        return a.Resource.localeCompare(b.Resource);
    });

    Depleted.forEach(function (i) {
        try {
            var IconMap = "";
            if (i.Item.GetGrid() > 0)
                _checkboxRebuildMines_ = '<input type="checkbox" id="_RebuildMines_' + i.Item.GetGrid() + '" class="mineNotAvailable" />'.format(i.Item.GetGrid());
				buildingGoto = getImageTag('accuracy.png', '24px', '24px').replace('<img', '<img id="buildPOSMine_' +  i.Item.GetGrid() + '"').replace('style="', 'style="cursor: pointer;');
                    $('#DepositDepletedResult').append(
                        createTableRow([
                                [4, loca.GetText("BUI", i.Item.GetBuildingName_string()) + (i.Resource == "" ? "" : " (" + i.Resource + ")")],
                                [2, ""],
								[2, i.Item.GetGrid()],
								[3, _checkboxRebuildMines_],
								[1, '<div style="text-align: right;">' +  buildingGoto + '</div>']
                            ], false));
        } catch (e) {}
		if (buildingGoto != "")
		{
			document.getElementById("buildPOSMine_" + i.Item.GetGrid()).addEventListener("click",function() {_GoTo(i.Item.GetGrid());});
		}
		$(document).on('click', '#_RebuildMines_' + i.Item.GetGrid(), function () {
                var isChecked = $('#_RebuildMines_' + i.Item.GetGrid()).prop('checked');

                if (buildArray.indexOf(i.Item) === -1 && isChecked) {
                    buildArray.push(i.Item);

                } else if (buildArray.indexOf(i.Item) !== -1 && !isChecked) {
                    var index = buildArray.indexOf(i.Item);
                    buildArray.splice(index, 1);
                }
            });
    });
	DepletedAll = Depleted;

    if ($("#" + DepositDepletedElements.ON_OFF_RADIO).is(':checked')) {
        $("." + DepositDepletedElements.NOT_AVAILABLE_CB).hide();
    } else {
        $("." + DepositDepletedElements.NOT_AVAILABLE_CB).show();
    }
}

function _FindOriginalResource(building_name) {
    var res = "";
    try {
        assetsNamesMine.forEach(function (item) {
            if (building_name.indexOf(item) >= 0)
                res = item;
        });
        if (res != "")
            res = loca.GetText("RES", res);
    } catch (e) {}
    return res;
}

function _GoTo(g) {
    try {
        $('#DepositDepletedModal').modal('hide');
        swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(g);
    } catch (e) {}
}

function mapItemToNumber(itemName) {
    switch (itemName) {
    case "TitaniumOre":
        return 69;
    case "Salpeter":
        return 63;
    case "BronzeOre":
        return 36;
    case "Coal":
        return 37;
    case "GoldOre":
        return 46;
    case "IronOre":
        return 50;
	case "MineDepletedDepositTitaniumOre":
        return 69;
    case "MineDepletedDepositSalpeter":
        return 63;
    case "MineDepletedDepositBronzeOre":
        return 36;
    case "MineDepletedDepositCoal":
        return 37;
    case "MineDepletedDepositGoldOre":
        return 46;
    case "MineDepletedDepositIronOre":
        return 50;
    }
}

function buildMine(buildArray_input) {
    var x = new TimedQueue(1000);
    var CurrentQueue = 0;
    var CurrentQueueFree = 0;
    var QueueTotal = 0;
    var buildArray_local = [];
	
    $.each(buildArray_input, function (i, item) {

			try
			{
				var a = item.GetGrid();
				if (item.GetGrid() !== undefined && buildArray_input.indexOf(item.GetGrid()) === -1) {
				var buildingName = (item.GetBuildingName_string !== undefined) ? item.GetBuildingName_string() : item.GetName_string();
					
					if (buildingName !== undefined) {
						buildArray_local.push({
							buiGrid: item.GetGrid(),
							buiRessName: buildingName,
							buiMineType: mapItemToNumber(buildingName)
						});
					}
				}
			}
			catch(e){}
    });

    $.each(swmmo.application.mGameInterface.mHomePlayer.mBuildQueue.GetQueue_vector(), function (i, GetQueue) {
        CurrentQueue++;
    });
    QueueTotal = swmmo.application.mGameInterface.mHomePlayer.mBuildQueue.GetTotalAvailableSlots();
    CurrentQueueFree = QueueTotal - CurrentQueue;

    $.each(buildArray_local, function (i, item) {
        if (CurrentQueueFree > 0) {
            var building_built = game.zone.GetBuildingFromGridPosition(item.buiGrid);
            if (building_built == null && game.gi.isOnHomzone()) {
		CurrentQueueFree--;
                x.add(function () {
                    game.gi.SendServerAction(50, item.buiMineType, item.buiGrid, 0, null);
                    game.showAlert("Building: " + loca.GetText("RES", item.buiRessName));

                });
            }
        }

    });
    x.run();
    buildArray_input = [];
    buildArray_local = [];
    buildArray = [];
}
