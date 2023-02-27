
var _exudUserBuildingListLang = {
	'en-uk': {
		'UserBuildingList': 'Building List',
		'Monitor' : 'Building Monitor',
		'Monitoring' : 'Monitoring',
		'Upgrading' : 'Upgrading',
		'Notify' : 'Enable  notification',
		'Minutes' : 'Minutes',
		"Stop": "Stop",
		"Start": "Start",
		"ReadyMsg" : "Building monitor : {0} building ready!"
		},
	"pt-br" : {
		'UserBuildingList': 'Lista Predios',
		'Monitor' : 'Edificios monitorados',
		'Monitoring' : 'Observando',
		'Upgrading' : 'Melhorando',
		'Notify' : 'Habilitar notificação',
		'Minutes' : 'Minutos',
		"Stop": "Parar",
		"Start": "Ativar",
		"ReadyMsg" : "Observador : {0} edificios prontos !"
		}
	};


extendBaseLang(_exudUserBuildingListLang, 'exudUserBuildingListLang');
addToolsMenuItem(getText('UserBuildingList', 'exudUserBuildingListLang') , _exudUserBuildingListMenuHandler);
addToolsMenuItem(getText('Monitor', 'exudUserBuildingListLang') , _exudUserBuildingMonitorMenuHandler);

var _exudUserBuildingListModalInitialized = false;
var _exudUserBuildingMonitorModalInitialized = false;
var _exudUserBuildingListBuildings = new Array();

var _exudBuildingMonitorSettings = {
	'BM' : new Array(),
	'Notify' : false,
	'Minutes' : 5
};
$.extend(_exudBuildingMonitorSettings, readSettings(null, 'exusMonitorBuilding'));

var _exudBuildingMonitorTimeOut = null;

if ((_exudBuildingMonitorTimeOut == null || _exudBuildingMonitorTimeOut == undefined) && (_exudBuildingMonitorSettings.Notify))
{
	_exudBuildingMonitorTimeOut = null;
	setTimeout(_exudUserBuildingMonitorStart, 30000);
}

function _exudBuildingMonitorSaveSettings()
{

	try
	{
		storeSettings(_exudBuildingMonitorSettings, 'exusMonitorBuilding');
	} catch (e) {
		alert(e.message);
	}
}
function _exudBuildingMonitorIsMonitoring(gid)
{
	return (_exudBuildingMonitorSettings.BM.indexOf(""+gid) >= 0);
}

function _exudUserBuildingListMenuHandler(event) {
		if (!(swmmo.application.mGameInterface.mCurrentPlayer.GetHomeZoneId() == swmmo.application.mGameInterface.mCurrentViewedZoneID))
		{
			showGameAlert("Not in home zone ");	
			return;
		}

	$("div[role='dialog']:not(#UserBuildingListModal):visible").modal("hide");
	
	if(!_exudUserBuildingListModalInitialized)
		$('#UserBuildingListModal').remove();
	
	try{
		if($('#UserBuildingListModal .modal-header .container-fluid').length == 0){
			$('#udUserBuildingListStyle').remove();
		
			if($('#udUserBuildingListStyle').length == 0)
				$("head").append($("<style>", { 'id': 'udUserBuildingListStyle' }).text('div .row:hover {background-color: #A65329;}'));
			
			createModalWindow('UserBuildingListModal', getText('UserBuildingList', 'exudUserBuildingListLang'));	
			
			select = $('<select>', { id: 'exudUserBuildingListSelect' });
				select.append($('<option>', { value:"---" }).text("---")).prop("outerHTML");
			
			$('#UserBuildingListModal .modal-header').append(
				'<div class="container-fluid">' 
				+ select.prop("outerHTML") 
				+ $('<button>').attr({"id": "exudUserBuildingListRefresh","class": "btn btn-success"}).text(loca.GetText("LAB", "Update")).prop("outerHTML") 
				+ "<div id='udUserBuildingListTotal'> Tot :</div>"
				+ createTableRow([
						[1, getText('Monitoring', 'exudUserBuildingListLang')],
						[6, loca.GetText("LAB", "Name")],
						[1, getText('Upgrading', 'exudUserBuildingListLang')],
						[2, loca.GetText("LAB", 'Buff')],
						[1, loca.GetText("LAB", "Level")],
						[1, loca.GetText("LAB", "Visit")]
					], true)
				+ "</div>"
			);
			$('#exudUserBuildingListSelect').change(function() {_exudUserBuildingListUpdateView();});
			$('#exudUserBuildingListRefresh').click(function() {_exudUserBuildingListRefresh();});

			_exudUserBuildingListModalInitialized = true;
		}

		_exudUserBuildingListRefresh();
	}
	catch (e) {}
	
	$('#UserBuildingListModal:not(:visible)').modal({ backdrop: "static" });
}

function _exudUserBuildingListRefresh() {
	
	_exudUserBuildingListGetData();
	_exudUserBuildingListUpdateView();
}

function _exudUserBuildingListGetData() {

	try{
		$('#exudUserBuildingListSelect').html("");
		$('#exudUserBuildingListSelect').append($('<option>', { value:"---" }).text("---")).prop("outerHTML");
		_exudUserBuildingListBuildings = new Array();
		swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function(bld) {
			try{
				var n = _exudUserBuildingListGetName(bld.GetBuildingName_string());
				if (n != "")
				{
					var IconMapBld = getImageTag("accuracy.png", '24px', '24px').replace('<img','<img id="exudSSPOS_'+ bld.GetGrid()+'"').replace('style="', 'style="cursor: pointer;')
					var isUpgrading = "";
					try{
						if (bld.IsUpgradeInProgress()) isUpgrading = bld.mBuildingUpgradeProgress + "%";
					}
					catch (ee)
					{
					}
					_exudUserBuildingListBuildings.push(
						{
							"Building" : bld,
							"Name" : n,
							"IconMap" : IconMapBld,
							"Level" : bld.GetUIUpgradeLevel(),
							"GridPos" : bld.GetGrid(),
							"Buffed" : (bld.productionBuff == null ? 0 : 1),
							"Upg" : isUpgrading
						}
					);
				}
			}
			catch (e)
			{
			}
		});
		
		
		_exudUserBuildingListBuildings.sort(_exudUserBuildingListSort);
		var PrevBuild = "";
		_exudUserBuildingListBuildings.forEach(function(bld) {
			if (PrevBuild != bld.Name)
			{
				PrevBuild = bld.Name;
				$('#exudUserBuildingListSelect').append($('<option>', { value: PrevBuild }).text(PrevBuild)).prop("outerHTML");
			}
		});
	}
	catch (e) {}			
}

function _exudUserBuildingListUpdateView()
{
	var out = "";
	var tot = 0;
	var BuildToDisplay = $('#exudUserBuildingListSelect option:selected').val();
	_exudUserBuildingListBuildings.forEach(function(bld) {
		if (bld.Name == BuildToDisplay)
		{
			isSelected = _exudBuildingMonitorIsMonitoring(bld.GridPos);
			
			checkbox = '<input type="checkbox" id="_exudBL_{0}" {1}/>'.format(
						bld.GridPos,
						isSelected ? ' checked' : ''
					);
			out += createTableRow([
					[1, (bld.GridPos > 0 ?checkbox: "")],
					[6, bld.Name],
					[1, bld.Upg],
					[2, (bld.Buffed  == 1 ? loca.GetText("LAB", 'YES') : loca.GetText("LAB", 'NO'))],
					[1, bld.Level],
					[1, (bld.GridPos > 0 ? bld.IconMap : "")]
				], false);				
				++tot;
		}
	});
	$("#udUserBuildingListTotal").html("Tot: " + tot);
	$('#UserBuildingListModalData').html('<div class="container-fluid">{0}</div>'.format(out));
	$('#UserBuildingListModalData img[id^="exudSSPOS_"]').click(_exudUserBuildingListGoTo1);
	$('#UserBuildingListModalData input[id^="_exudBL_"]').click(_exudUserBuildingToggleMonitor);
}

function _exudUserBuildingListSort(a, b)
{
	return a.Name.toUpperCase().localeCompare(b.Name.toUpperCase());
}

function _exudUserBuildingListGetName(id)
{
	var desc = loca.GetText("BUI", id);
	if (desc.indexOf("undefined") > -1)	desc = "";
	
	return desc;
}
function _exudUserBuildingListGoTo(e)
{
	var gid = e.target.id.replace("exudSSPOS_","");
	gid = gid.replace("exudBMPOS_","");
	var bui = game.zone.mStreetDataMap.GetBuildingByGridPos(gid);
	swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(gid);
	game.gi.SelectBuilding(bui);
}
function _exudUserBuildingListGoTo1(e)
{
	_exudUserBuildingListGoTo(e);
	$('#UserBuildingListModal').modal('hide');
}
function _exudUserBuildingListGoTo2(e)
{
	_exudUserBuildingListGoTo(e);
	$('#UserBuildingMonitorModal').modal('hide');
}


function _exudUserBuildingToggleMonitor(e)
{
	try{
	var btn = e.target;
	var gid = btn.id.replace("_exudBL_","");
	gid = gid.replace("_exudBM_","");
	
	if (btn.checked)
		_exudBuildingMonitorSettings.BM.push(gid);
	else
		_exudBuildingMonitorSettings.BM.splice( $.inArray(gid, _exudBuildingMonitorSettings.BM), 1 );
	
	_exudBuildingMonitorSaveSettings();
	}
	catch (e)
	{
	}
}

function _exudUserBuildingMonitorMenuHandler(event) {
		if (!(swmmo.application.mGameInterface.mCurrentPlayer.GetHomeZoneId() == swmmo.application.mGameInterface.mCurrentViewedZoneID))
		{
			showGameAlert("Not in home zone ");	
			return;
		}

	$("div[role='dialog']:not(#UserBuildingMonitorModal):visible").modal("hide");
	
	if(!_exudUserBuildingMonitorModalInitialized)
		$('#UserBuildingMonitorModal').remove();
	
try{
		if($('#UserBuildingMonitorModal .modal-header .container-fluid').length == 0){
			$('#udUserBuildingMonitorStyle').remove();

			if($('#udUserBuildingMonitorStyle').length == 0)
				$("head").append($("<style>", { 'id': 'udUserBuildingMonitorStyle' }).text('div .row:hover {background-color: #A65329;}'));
			
			createModalWindow('UserBuildingMonitorModal', getText('Monitoring', 'exudUserBuildingListLang'));	
						
			$('#UserBuildingMonitorModal .modal-header').append(
				'<div class="container-fluid">' 
				+ '<div>'
				+ '<span style="height:30px;float:left;vertical-align: middle;"><input type="checkbox" id="_exudUserBuildingMonitorNotifyCheck" {0}/> {1}<br/>'.format((_exudBuildingMonitorSettings.Notify ? ' checked' : ''),  getText('Notify', 'exudUserBuildingListLang')) + '</span>'
				+ '<span style="height:30px;float:left;vertical-align: middle;">&nbsp;/&nbsp;' + getText('Minutes', 'exudUserBuildingListLang') + ' (2-10)  <input type="text" style="color:black;width:40px;vertical-align: bottom" id="_exudUserBuildingMonitorTime" value="'+_exudBuildingMonitorSettings.Minutes+'"/></span>'
				+ "&nbsp;&nbsp;&nbsp;" + $('<button>').attr({ "class": "btn btn-sm _exudUserBuildingMonitorAtivarPararBtn" }).text((_exudBuildingMonitorTimeOut != null ? getText('Stop', 'exudUserBuildingListLang') : getText('Start', 'exudUserBuildingListLang'))).prop("outerHTML") + ' '
				+ '</div><br/>'
				+ '<div style="clear:both">'
				+ createTableRow([
						[1, getText('Monitoring', 'exudUserBuildingListLang')],
						[6, loca.GetText("LAB", "Name")],
						[1, getText('Upgrading', 'exudUserBuildingListLang')],
						[2, loca.GetText("LAB", 'Buff')],
						[1, loca.GetText("LAB", "Level")],
						[1, loca.GetText("LAB", "Visit")]
					], true)
				+ "</div>"
				+ "</div>"
			);

			$('#UserBuildingMonitorModal ._exudUserBuildingMonitorAtivarPararBtn').click(function() {
				_exudUserBuildingMonitorStart();
				$('#UserBuildingMonitorModal').modal('hide');
			});
			$('#_exudUserBuildingMonitorNotifyCheck').change(function(){
				_exudBuildingMonitorSettings.Notify = !_exudBuildingMonitorSettings.Notify;
				_exudBuildingMonitorSaveSettings();
			});
			$('#_exudUserBuildingMonitorTime').change(function(){
				_exudBuildingMonitorSettings.Minutes = $( "#_exudUserBuildingMonitorTime" ).val();
				_exudBuildingMonitorSaveSettings();
			});
			_exudUserBuildingMonitorModalInitialized = true;
		}
		else
		{
			$('#UserBuildingMonitorModal ._exudUserBuildingMonitorAtivarPararBtn').text(_exudBuildingMonitorTimeOut != null ? getText('Stop', 'exudUserBuildingListLang') : getText('Start', 'exudUserBuildingListLang'));
		}

	}
	catch (e) {}
	
	_exudUserBuildingMonitorRefresh();
	
	$('#UserBuildingMonitorModal:not(:visible)').modal({ backdrop: "static" });
}
function _exudUserBuildingMonitorStart()
{
	if (_exudBuildingMonitorTimeOut != null)
	{
		clearTimeout(_exudBuildingMonitorTimeOut);
		_exudBuildingMonitorTimeOut = null;
		_exudUserBuildingMonitorMessage("Observer stopped");
	}
	else		
	{
		if (_exudBuildingMonitorTimeOut != null)
		{
			try {
				clearTimeout(_exudBuildingMonitorTimeOut);
				_exudBuildingMonitorTimeOut = null;
			} catch (e) {
				
			}
		}

		_exudBuildingMonitorTimeOut = setTimeout(_exudBuildingMonitorStartTimed, 10000);	
		_exudUserBuildingMonitorMessage("Observer started");
		
	}
}
function _exudBuildingMonitorStartTimed()
{	
	_exudBuildingMonitorTimeOut = null;
	if (swmmo.application.mGameInterface.mCurrentPlayer.GetHomeZoneId() == swmmo.application.mGameInterface.mCurrentViewedZoneID)
	{
		var terminated = 0;
		try{
			_exudBuildingMonitorSettings.BM.forEach(function(item) {
				var bld = game.zone.mStreetDataMap.GetBuildingByGridPos(item);
				var isUpgrading = "";
				try{
					if (!bld.IsUpgradeInProgress()) 
						++terminated;
				}
				catch (ee)
				{
				}
			});
		} catch (e)
		{
		}
		if (terminated > 0)
		{
			showGameAlert(getText('ReadyMsg', 'exudUserBuildingListLang').format(terminated));	
			var SM = swmmo.getDefinitionByName("Sound::cSoundManager").getInstance();
			SM.playEffect("MountainDestruction");
		}
	}	
	_exudBuildingMonitorTimeOut = setTimeout(_exudBuildingMonitorStartTimed, _exudBuildingMonitorSettings.Minutes*60000);
}

function _exudUserBuildingMonitorRefresh()
{
	var out = "";
	_exudBuildingMonitorSettings.BM.forEach(function(item) {
		try{
		var bld = game.zone.mStreetDataMap.GetBuildingByGridPos(item);
		isSelected = _exudBuildingMonitorIsMonitoring(item);
		
		checkbox = '<input type="checkbox" id="_exudBM_{0}" {1}/>'.format(
					item,
					isSelected ? ' checked' : ''
				);
		var isUpgrading = "";
		try{
			if (bld.IsUpgradeInProgress()) isUpgrading = bld.mBuildingUpgradeProgress + "%";
		}
		catch (ee)
		{
		}
		var IconMap = getImageTag("accuracy.png", '24px', '24px').replace('<img','<img id="exudBMPOS_'+ item+'"').replace('style="', 'style="cursor: pointer;')
		out += createTableRow([
				[1, (item > 0 ?checkbox: "")],
				[6, _exudUserBuildingListGetName(bld.GetBuildingName_string())],
				[1, isUpgrading],
				[2, (bld.productionBuff == null ? loca.GetText("LAB", 'NO') : loca.GetText("LAB", 'YES'))],
				[1, bld.GetUIUpgradeLevel()],
				[1, (item > 0 ? IconMap : "")]
			], false);
		}
		catch (e)
		{
			_exudUserBuildingToggleMonitor(item);
		}
	});
	$('#UserBuildingMonitorModalData').html('<div class="container-fluid">{0}</div>'.format(out));
	$('#UserBuildingMonitorModalData input[id^="_exudBM_"]').click(_exudUserBuildingToggleMonitor);
	$('#UserBuildingMonitorModalData img[id^="exudBMPOS_"]').click(_exudUserBuildingListGoTo2);
}

function _exudUserBuildingMonitorMessage(Text)
{
	try{
		globalFlash.gui.mChatPanel.PutMessageToChannelWithoutServer("news", new window.runtime.Date(),getText('Monitor', 'exudUserBuildingListLang'),Text,false,false);

	}
	catch (e) {
		
	}
}