////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////Created by A-Calc Development (PiTi) | In co-operation with Test_Siedler#3694//////////////////////
///////////////////////////////////////////////////////Projects:////////////////////////////////////////////////////////////////
//////////////////https://a-calc.de | Taming calculator and companion app for Ark: Survivial Evolved/Ascended///////////////////
//////////////////https://crypto-webminer.com | Crypto Webminer - Mining in your Browser with Webmining technology//////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////Ihr mögt meine Arbeit und wollt mich Supporten? https://www.paypal.com/paypalme/ACalcDevelopment///////////////////
/////////////Do you like my work and want to support me? https://www.paypal.com/paypalme/ACalcDevelopment///////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

addToolsMenuItem(loca.GetText("ALT","UpgradeBuilding"), SearchArchitecturesHandler);
var _searchArchitecturesViewerModalInitialized = false;


const UNDEFINED_TEXT = '[undefined text]',
    MAXLEVEL = 7,
	MAXLEVEL2 = 7,
    ALLLEVELS = 1,
    DEBUG = false;
var searchString = '',
    searchLevel = 1,
    destroyableOnlyShow = false,
    improvableOnlyShow = true;
var buildingTypeInfoPanelMap = {
    'decoration': 'cDecorationInfoPanel',
    'minimal': 'cMinimalInfoPanel',
    'enemy': 'cEnemyBuildingInfoPanel',
};

var buildingArray = [];
var buildingArraySave = [];
var buildingArrayLoad = [];
var maxUpgradeLevel = 4; // Max Ausbauhöhe
var exportFunction = true; // Export Funktion

var user_building_extension_settings = {
	maxUpgradeLevelSetting: 4
};

$.extend(user_building_extension_settings, settings.read(null, 'UpgradeBuilding'));
maxUpgradeLevel = user_building_extension_settings.maxUpgradeLevelSetting;

function SearchArchitecturesHandler(event) {
    $('div[role="dialog"]:not(#searchArchitecturesModal):visible').modal('hide');
    if (!_searchArchitecturesViewerModalInitialized)
        $('#searchArchitecturesModal').remove();
    createModalWindow('searchArchitecturesModal', loca.GetText("ALT","UpgradeBuilding"));
	
	building_newTemplates = new SaveLoadTemplate('upg', function(data, name) {
			$("#searchArchitecturesModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
			buildingArrayLoad = data;
			var buildingList = _getArchitecturesList();
			var keys = Object.keys(buildingList);
			keys.sort().forEach(function (key) {	
			buildingList[key].forEach(function (item) {
			var isGridInArray = false;
			for (var i = 0; i < buildingArrayLoad.length; i++) {
				if (buildingArrayLoad[i] === item.grid) {
					isGridInArray = true;
					break;
				}
			} 
			if (isGridInArray) {
				$('#_upgrade_' + item.building.GetGrid()).prop('checked', true);
				if (isGridInArray) {
					$('#_upgrade_' + item.building.GetGrid()).prop('checked', true);
					if (buildingArray.indexOf(item.building) === -1) {
						buildingArray.push(item.building);
					}
				}	
			}			
        });
    });
		});
	
    $('#searchArchitecturesModal .modal-header').append(
        '<br><div class="container-fluid" id="searchArchitecturesSelectLevel"><b>'+loca.GetText("LAB","Filter")+':</b>&emsp; </div>');
    for (i = 1; i <= MAXLEVEL; i++) {
        $('<label><input type="radio" name="searchArchitecturesRadio" value={0}> &thinsp;{1}&emsp; </label>'.format(
            i, (i < MAXLEVEL ? i : i + '+')
        )).appendTo('#searchArchitecturesSelectLevel');
    }
    $('<label><input type="radio" name="searchArchitecturesRadio"  value={0}> &thinsp;{1}&emsp; </label>'.format(
        ALLLEVELS, loca.GetText("LAB","All")
    )).appendTo('#searchArchitecturesSelectLevel');
	$('#searchArchitecturesModal .modal-header').append(
        '<br><div class="container-fluid" id="searchArchitecturesSelectLevel2"><b>Max '+ loca.GetText("ALT","UpgradeBuilding") + ' ' + loca.GetText("LAB","GuildLevel") + ' (' +loca.GetText("QUL","GuiDaiAllTheShinyRoadsSub4") + ')' +':</b>&emsp; </div>');
    for (i = 1; i <= MAXLEVEL2; i++) {
        $('<label><input type="radio" name="searchArchitecturesRadio2" value={0}> &thinsp;{1}&emsp; </label>'.format(
            i, (i < MAXLEVEL2 ? i : i)
        )).appendTo('#searchArchitecturesSelectLevel2');
    }
	$('input[name="searchArchitecturesRadio2"][value=' + maxUpgradeLevel + ']').prop('checked', true);
    $('input[name="searchArchitecturesRadio2"]').click(function () {
        maxUpgradeLevel = $(this).val();
		user_building_extension_settings.maxUpgradeLevelSetting = maxUpgradeLevel;
		settings.settings['UpgradeBuilding'] = {};
		settings.store(user_building_extension_settings, 'UpgradeBuilding');
		//game.showAlert(maxUpgradeLevel);
    });
	
    $('#searchArchitecturesModal .modal-header').append(
        '<br><div class="container-fluid" id="searchArchitecturesSelectFound"><b>'+ loca.GetText("LAB","Search") + ':</b>&emsp;</div>'
    );
	
    $('<input>', {
        'type': 'text', 'id': 'searchArchitecturesFind', 'class': 'form-control',
        'style': 'display: inline;width: 300px;', 'value': searchString
    }).appendTo('#searchArchitecturesSelectFound');
    $('<label>&emsp</label>').appendTo('#searchArchitecturesSelectFound');
    $('<label><input type="checkbox" id="searchImprovableArchitecturesOnly"> &thinsp;'+ loca.GetText("LAB","Search") + ': '+ loca.GetText("ALT","UpgradeBuilding") + '&emsp; </label>'
    ).appendTo('#searchArchitecturesSelectFound');
    $('<label><input type="checkbox" id="searchDestroyableArchitecturesOnly"> &thinsp;'+ loca.GetText("LAB","Search") + ': '+ loca.GetText("HIL","Help_window_destroyable_mountains_0") + '&emsp; </label>'
    ).appendTo('#searchArchitecturesSelectFound');
    $('#searchArchitecturesModal .modal-header').append('<br><div class="container-fluid">' + createTableRow([
        [5, loca.GetText("LAB", "Name")],
        [3, loca.GetText("LAB", "Buffs")],
        [1, ''],
        [2, loca.GetText("LAB", "Status")],
        [1, ''],
    ], true) + '</div>');
    $('#searchArchitecturesModal #searchArchitecturesFind').keyup(function (e) {
        searchString = $(e.target).val();
        if (!searchString || searchString == "") {
            $('#searchArchitecturesModalData .container-fluid div:hidden').show();
            return;
        }
        $('#searchArchitecturesModalData .container-fluid .row').each(function (i, item) {
            if ($(item.firstChild).text().toUpperCase().indexOf(searchString.toUpperCase()) == -1) {
                $(item).hide();
            } else {
                $(item).show();
            }
        });
    });
    $('input[name="searchArchitecturesRadio"][value=' + searchLevel + ']').prop('checked', true);
    $('input[name="searchArchitecturesRadio"]').click(function () {
        searchLevel = $(this).val();
        _updateArchitecturesModalData();
    });
    $('#searchImprovableArchitecturesOnly').prop('checked', improvableOnlyShow);
    $('#searchImprovableArchitecturesOnly').click(function () {
        improvableOnlyShow = $('#searchImprovableArchitecturesOnly').is(':checked');
        _updateArchitecturesModalData();
    });
    $('#searchDestroyableArchitecturesOnly').prop('checked', destroyableOnlyShow);
    $('#searchDestroyableArchitecturesOnly').click(function () {
        destroyableOnlyShow = $('#searchDestroyableArchitecturesOnly').is(':checked');
        _updateArchitecturesModalData();
    });
    _updateArchitecturesModalData();
    $('#searchArchitecturesModal:not(:visible)').modal({ backdrop: 'static' });

			$("#searchArchitecturesModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-warning upgradeReset" }).text(getText('btn_reset')),
			$('<button>').attr({ "class": "btn btn-success upgradeSubmit" }).text(getText('btn_submit')),	
			]);
			
	if (exportFunction){
			$("#searchArchitecturesModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-primary pull-left building_newSaveTemplate" }).text(getText('save_template')),
			$('<button>').attr({ "class": "btn btn-primary pull-left building_newLoadTemplate" }).text(getText('load_template'))
			]);		
	};
			
		$('#searchArchitecturesModal .upgradeReset').click(function() {
			buildingArray = [];
			buildingArraySave = [];
			buildingArrayLoad = [];
			_updateArchitecturesModalData();
		});
		$('#searchArchitecturesModal .upgradeSubmit').click(function() {
			$('#searchArchitecturesModal').modal('hide');

			if(buildingArray.length === 0)
			{
				//game.showAlert('buildingArray leer');
			}
			else if(buildingArray.length !== 0)
			{
				//game.showAlert('buildingArray nicht leer');
				setTimeout(function() {upgradeBuildingForClientArray(buildingArray);},1000);		
			}			
		});
		$('#searchArchitecturesModal .building_newSaveTemplate').click(function(){ 
			buildingArraySave = [];
			$.each(buildingArray, function(i, building) {
				
				if (buildingArraySave.indexOf(building.GetGrid()) === -1) {
					buildingArraySave.push(building.GetGrid());
				}
				
			});
			building_newTemplates.save(buildingArraySave);
		});
		$('#searchArchitecturesModal .building_newLoadTemplate').click(function() { 
			building_newTemplates.load();
			
	
		});
		$("#searchArchitecturesModal .btnClose").click(function(e) { 
			buildingArray = [];
			buildingArraySave = [];
			buildingArrayLoad = [];
			$('#searchArchitecturesModal').modal('hide');
		});
}

function _updateArchitecturesModalData() {
    var buildingList = _getArchitecturesList();
    $('#searchArchitecturesModalData').html(_searchArchitecturesModal(buildingList));
    var keys = Object.keys(buildingList);
    keys.sort().forEach(function (key) {
        buildingList[key].forEach(function (item) {
            if (item.goto != '')
                document.getElementById('buildPOS_' + item.grid).addEventListener(
                    'click', function () { _buildingViewerGoTo(item.grid, item.building); }
                );
        });
    });
    $('#searchArchitecturesModalData .container-fluid .row').each(function (i, item) {
        if ($(item.firstChild).text().toUpperCase().indexOf(searchString.toUpperCase()) == -1) {
            $(item).hide();
        } else {
            $(item).show();
        }
    });
}

function _getArchitecturesList() {
    var buildingList = {};
    swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function (item) {
        if (item.isGarrison()) { return; }
        var isDestroyableMountain = item.IsDestroyableMountain();
        if (isDestroyableMountain != destroyableOnlyShow) { return; }
        var level = item.GetUIUpgradeLevel();
        if (!(searchLevel == MAXLEVEL && level >= MAXLEVEL || searchLevel == level || searchLevel == ALLLEVELS)) { return; }
        var grid = item.GetGrid();
        var buildingGoto = '';
        if (grid > 0)
            buildingGoto = getImageTag('accuracy.png', '24px', '24px').replace(
                '<img', '<img id="buildPOS_' + grid + '"'
            ).replace('style="', 'style="cursor: pointer;');
        var name = item.GetBuildingName_string();
        if (
            name.toUpperCase().indexOf('EW_') != -1 ||
            name.toUpperCase().indexOf('DECORATION_MOUNTAIN_PEAK') != -1 ||
            name.toUpperCase().indexOf('BANDITS') != -1
        ) { return; }
        var isUpgradeAllowed = item.IsUpgradeAllowed(true) && !isDestroyableMountain && !_findBuildingType(item, ['decoration', 'minimal', 'enemy']);
        if (improvableOnlyShow && !isUpgradeAllowed) { return; }
        var locName = loca.GetText('BUI', name);
        if (locName.indexOf(UNDEFINED_TEXT) >= 0) {
            locName = name;
        }
        if (buildingList[locName] === undefined) {
            buildingList[locName] = new Array();
        }
        buff = '';
        if (item.productionBuff != null) {
            buff = loca.GetText("RES", item.productionBuff.GetBuffDefinition().GetName_string());
        }
        buildingList[locName].push({
            'grid': grid,
            'name': name,
            'goto': buildingGoto,
            'locName': locName,
            'level': level,
            'building': item,
            'isWorking': item.IsProductionActive(),
            'isUpgradeInProgress': item.IsUpgradeInProgress(),
            'isUpgradeAllowed': isUpgradeAllowed,
            'buff': buff,
        });
    });
    return buildingList
}

function _buildingViewerGoTo(g, b) {
    try {
        $('#searchArchitecturesModal').modal('hide');
        swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(g);
        swmmo.application.mGameInterface.SelectBuilding(b)
    }
    catch (e) { }
}

function _findBuildingType(b, bTypes) {
    var panelClass = globalFlash.gui.GetInfoPanel(b.GetBuildingName_string());
    var className = window.runtime.flash.utils.getQualifiedClassName(panelClass);
    var found = false;
    for (t in buildingTypeInfoPanelMap) {
        if (bTypes.indexOf(t) >= 0){
            found = found || (className == 'GUI.GAME::{0}'.format(buildingTypeInfoPanelMap[t]));
        }
    }
    return found;
}

function _searchArchitecturesModal(buildingList) {
    var out = '<div class="container-fluid">';
    try {
        var keys = Object.keys(buildingList);
        keys.sort().forEach(function (key) {
            var buildingCount = buildingList[key].length,
                firstItem = buildingList[key][0],
                prefix = '&#9500',
                counter = 1;
            out += createTableRow([
                [12, '<b>' + firstItem.locName + '</b>' + (DEBUG ? ' <sup>' + firstItem.name + '</sup>' : '')],
            ]);
            buildingList[key].sort(_compareArchitecturesByLevel).forEach(function (item) {
                checkboxU = '<input type="checkbox" id="_upgrade_' +  item.building.GetGrid()  + '" />'.format(item.building);
                if (counter == buildingCount) {
                    prefix = '&#9492;';
                }
                itemStatus = '';
                if (!item.isWorking) {
                    itemStatus = 'Gestoppt';
                }
                if (item.isUpgradeInProgress) {
                    itemStatus = 'wird ausgebaut'
                }
                out += createTableRow([
                    [5, prefix + (itemStatus == '' ? '' : ' <span style="color:LightGray;font-style:italic;">') +
                        ' <sup>' + item.level + '</sup>&thinsp;' + item.locName + " (Grid: " +item.grid+")" + (itemStatus == '' ? '' : '</span>')
                    ],
                    [3, (itemStatus == '' ? ' ' : ' <span style="color:LightGray;font-style:italic;">') +
                        '<small>' + item.buff + '</small>' + (itemStatus == '' ? '' : '</span>')],
                    [1, item.isUpgradeAllowed ?  checkboxU : ''],
                    [2, '<span style="color:LightGray;font-style:italic;"><small>' + itemStatus + '</small></span>'],
                    [1, item.goto]
                ]);
                

				
				$(document).on('click', '#_upgrade_'+ item.building.GetGrid(), function () {
					var isChecked = $('#_upgrade_' + item.building.GetGrid()).prop('checked');

					if (buildingArray.indexOf(item.building) === -1 && isChecked) {
						buildingArray.push(item.building);
						
					}
					else if(buildingArray.indexOf(item.building) !== -1 && !isChecked)
					{
						var index = buildingArray.indexOf(item.building);
						buildingArray.splice(index, 1);
					}
				});

				counter++;
            });
        });
    } catch (e) {
        out += '<p>Error: ' + e + '/<p>';
    }
    out += '</div>';

    return out;
}


function _compareArchitecturesByLevel(a, b) {
    if (a.level < b.level) return -1;
    if (a.level > b.level) return 1;
    return 0;
}

function upgradeBuildingForClientArray(buildingArray_input) { 
	var x = new TimedQueue(1000);
	$.each(buildingArray_input, function(i, building) {
		var isUpgradeAllowed_tmp = building.IsUpgradeAllowed(true);
		if (building.GetUIUpgradeLevel() < maxUpgradeLevel && building.IsBuildingInProduction() ) {
			if (isUpgradeAllowed_tmp) {
				x.add(function() { 
					if (isUpgradeAllowed_tmp) {
						game.gi.SendServerAction(60,  0, building.GetGrid(), 0, null);
					};
				}); 
			};
		}
		
	});
	x.run();
	buildingArray_input = [];
	buildingArray = [];
	game.showAlert(getText('command_sent'));
}



