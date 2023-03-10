
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
		"ReadyMsg" : "Building monitor : {0} building ready!",
		"ToolTipNotify" : "Mark to receive notification",
		"DebuffedMsg" : "Building monitor : {0} building debuffed!",
		"UpgradeSound" : "Upgrade Sound",
		"DebuffSound" : "Debuffed Sound",
		"PlayMute" : "Plays even when mute",
		"ClearMonitor" : "Clear selected",
		"AutofitUpgrading" : "Mark Upgrading"
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
		"ReadyMsg" : "Observador : {0} edificios prontos !",
		"ToolTipNotify" : "Selecionar para receber a notificação",
		"DebuffedMsg" : "Observador : {0} edificios sem catalisador !",
		"UpgradeSound" : "Som melhora",
		"DebuffSound" : "Som catalização",
		"PlayMute" : "Toca mesmo quando mudo",
		"ClearMonitor" : "Limpar selecionados",
		"AutofitUpgrading" : "Marcar em melhora"
		},
	"es-es" : {
		'UserBuildingList': 'Lista de edificios',
		'Monitor' : 'Monitor de edificios',
		'Monitoring' : 'Observador',
		'Upgrading' : 'Subiendo de nivel',
		'Notify' : 'Notificación con sonido',
		'Minutes' : 'Minutos',
		"Stop": "Parar",
		"Start": "Activar",
		"ReadyMsg" : "Observador: ¡{0} edificio(s) listos!",
		"ToolTipNotify" : "Selecciona para recibir una notificación",
		"DebuffedMsg" : "Observador: ¡{0} edificio(s) sin potenciar!",
		"UpgradeSound" : "Sonido Mejora",
		"DebuffSound" : "Sonido Sin potenciar",
		"PlayMute" : "Incluso si está silenciado el juego",
		"ClearMonitor" : "Limpiar lista",
		"AutofitUpgrading" : "Marcar subiendo de nivel"
		},
	'fr-fr': {
		'UserBuildingList': 'Liste bâtiments',
		'Monitor' : 'Surveillance des bâtiments',
		'Monitoring' : 'Suivi',
		'Upgrading' : 'Amélioration',
		'Notify' : 'Autoriser les notifications',
		'Minutes' : 'Minutes',
		"Stop": "Arrêt",
		"Start": "Départ",
		"ReadyMsg" : "Surveillance bâtiments : {0} bâtiments prêts!",
		"ToolTipNotify" : "Marquer pour recevoir une notification",
		"DebuffedMsg" : "Surveillance bâtiments : {0} Sans fortifiants!",
		"UpgradeSound" : "Son amélioration",
		"DebuffSound" : "Son arrêt fortifiant",
		"PlayMute" : "Joue même en mode muet",
		"ClearMonitor" : "Raz sélection",
		"AutofitUpgrading" : "Auto suivi amélioration"
		},
	"pl-pl": {
		"UserBuildingList": "Lista budynków",
		"Monitor": "Monitor budynków",
		"Monitoring": "Monitoring",
		"Upgrading": "Rozbudowa",
		"Notify": "Włącz powiadomienia",
		"Minutes": "Minuty",
		"Stop": "Stop",
		"Start": "Start",
		"ReadyMsg": "Monitor Budynków: {0} budynek gotowy!",
		"ToolTipNotify": "Oznacz aby otrzymać powiadomienie",
		"DebuffedMsg": "Monitor Budynków : {0} budynek bez buffa!",
		"UpgradeSound": "Dźwięk rozbudowy",
		"DebuffSound": "Dźwięk wygaśnięcia buffa",
		"PlayMute": "Graj nawet gdy wyciszone",
		"ClearMonitor": "Wyczyść zaznaczone",
		"AutofitUpgrading": "Oznacz jako rozbudowywane"
		},
	'de-de': {
		'UserBuildingList': 'Gebäude Übersichten',
		'Monitor' : 'Gebäude Beobachtung',
		'Monitoring' : 'Beobachtet',
		'Upgrading' : 'Ausbau',
		'Notify' : 'Benachrichtigungen aktivieren',
		'Minutes' : 'Minuten',
		"Stop": "Stop",
		"Start": "Start",
		"ReadyMsg" : "Gebäude Monitor : {0} Gebäude bereit!",
		"ToolTipNotify" : "Markiere für Erhalt von Benachrichtigungen",
		"DebuffedMsg" : "Gebäude Beobachtung : {0} Gebäude ungebufft!",
		"UpgradeSound" : "Ausbau Sound",
		"DebuffSound" : "Ungebufft Sound",
		"PlayMute" : "Auch im stummen Modus abspielen",
		"ClearMonitor" : "Auswahl reseten",
		"AutofitUpgrading" : "Markiere aktive Ausbauten"
		}
	};

const _exudUserBuildingListSounds = [ "BuildingPlace", "BuildingDestroy", "BuildingUpgrade", "MenuClose", "ButtonClick", "BuffPlace", "GeneralAttack",
					"ChatWhisper", "BuildingReady", "CGGemClick", "CGJackpot", "CGStartRoll" ,
					"CGShortCount", "CGCountClick", "MountainDestruction", "MenuOpen", "MenuOpenStar", "GeneralBattleStart",
					"GeneralWin","GeneralLose","GeneralMove","GeneralRetreat","BuildingSelect","GeologistStart","GeologistFail",
					"GeologistSuccess","Message","MessageMail","QuestComplete","QuestNew","QuestOpenLog","DepositDepleted","ExplorerStart",
					"ExplorerFail","ExplorerSuccess","ServerLost","PayitemPurchase","BuffProduced","UnitProduced","SelectBuilding","GeologistStart_DiligentGeologist",
					"GeologistStart_GoldheartedGeologist","GeologistFail_GoldheartedGeologist","GeologistFail_DiligentGeologist",
					"GeologistSuccess_GoldheartedGeologist","GeologistSuccess_DiligentGeologist",
					"ExplorerStart_IntrepidExplorer","ExplorerStart_CorageousExplorer","ExplorerStart_LovelyExplorer","ExplorerStart_PrincessZoeExplorer","ExplorerStart_MotherlyExplorer",
					"ExplorerStart_BenevolentExplorer","ExplorerStart_Soccer2019Explorer","ExplorerStart_EmphaticExplorer","ExplorerStart_BewitchingExplorer","ExplorerStart_KeenerExplorer",
					"ExplorerFail_IntrepidExplorer","ExplorerFail_CorageousExplorer","ExplorerFail_LovelyExplorer","ExplorerFail_PrincessZoeExplorer","ExplorerFail_MotherlyExplorer",
					"ExplorerFail_BenevolentExplorer","ExplorerFail_Soccer2019Explorer","ExplorerFail_EmphaticExplorer","ExplorerFail_BewitchingExplorer","ExplorerFail_KeenerExplorer",
					"ExplorerSuccess_IntrepidExplorer","ExplorerSuccess_CorageousExplorer","ExplorerSuccess_LovelyExplorer","ExplorerSuccess_PrincessZoeExplorer","ExplorerSuccess_MotherlyExplorer",
					"ExplorerSuccess_BenevolentExplorer","ExplorerSuccess_Soccer2019Explorer","ExplorerSuccess_EmphaticExplorer","ExplorerSuccess_BewitchingExplorer","ExplorerSuccess_KeenerExplorer",
					"SelectBuilding_statueRabbid"
					];

_exudUserBuildingListSounds.sort();		
extendBaseLang(_exudUserBuildingListLang, 'exudUserBuildingListLang');
addToolsMenuItem(getText('UserBuildingList', 'exudUserBuildingListLang') , _exudUserBuildingListMenuHandler);
addToolsMenuItem(getText('Monitor', 'exudUserBuildingListLang') , _exudUserBuildingMonitorMenuHandler);

var _exudUserBuildingListModalInitialized = false;
var _exudUserBuildingMonitorModalInitialized = false;
var _exudUserBuildingListBuildings = new Array();

var _exudBuildingMonitorSettings = {
	'BM' : new Array(),
	'Notify' : false,
	'Minutes' : 5,
	'NotifyUpgrade' : new Array(),
	'NotifyBuffed' : new Array(),
	'UpgradeSound' : 'CGJackpot',
	'BuffSound' : 'MountainDestruction',
	'PlayMute' : false
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
	return (_exudBuildingMonitorSettings.BM.indexOf(parseInt(gid)) >= 0);
}
function _exudBuildingMonitorHasNotifyUpgrade(gid)
{
	return (_exudBuildingMonitorSettings.NotifyUpgrade.indexOf(parseInt(gid)) >= 0);
}
function _exudBuildingMonitorHasNotifyBuffed(gid)
{
	return (_exudBuildingMonitorSettings.NotifyBuffed.indexOf(parseInt(gid)) >= 0);
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
				+ "&nbsp;&nbsp;" + $('<button>').attr({"id": "exudUserBuildingListRefresh","class": "btn btn-success"}).text(loca.GetText("LAB", "Update")).prop("outerHTML") 
				+ "&nbsp;&nbsp;" + $('<button>').attr({"id": "exudUserBuildingListClear","class": "btn btn-success"}).text(getText('ClearMonitor', 'exudUserBuildingListLang')).prop("outerHTML") 
				+ "&nbsp;&nbsp;" + $('<button>').attr({"id": "exudUserBuildingListAutofit","class": "btn btn-success"}).text(getText('AutofitUpgrading', 'exudUserBuildingListLang')).prop("outerHTML") 
				+ "<div id='udUserBuildingListTotal'> Tot :</div>"
				+ createTableRow([
						[1, getText('Monitoring', 'exudUserBuildingListLang')],
						[4, loca.GetText("LAB", "Name")],
						[2, getText('Upgrading', 'exudUserBuildingListLang')],
						[3, loca.GetText("LAB", 'Buff')],
						[1, loca.GetText("LAB", "Level")],
						[1, loca.GetText("LAB", "Visit")]
					], true)
				+ "</div>"
			);
			$('#exudUserBuildingListSelect').change(function() {_exudUserBuildingListUpdateView();});
			$('#exudUserBuildingListRefresh').click(function() {_exudUserBuildingListRefresh();});
			
			$('#exudUserBuildingListClear').click(function() {
				_exudUserBuildingListClear();
				showGameAlert("List cleared !");
				_exudUserBuildingListRefresh();
			});
			
			$('#exudUserBuildingListAutofit').click(function() {
				_exudUserBuildingListAutofit();
				showGameAlert("List created !");
				});

			_exudUserBuildingListModalInitialized = true;
		}

		_exudUserBuildingListRefresh();
	}
	catch (e) {}
	
	$('#UserBuildingListModal:not(:visible)').modal({ backdrop: "static" });
}

function _exudUserBuildingListClear()
{
	try {
		_exudBuildingMonitorSettings.BM = new Array();
		_exudBuildingMonitorSettings.NotifyUpgrade = new Array();
		// Not remove buffing notification. only upgrading
		if (_exudBuildingMonitorSettings.NotifyBuffed.length > 0)
			_exudBuildingMonitorSettings.NotifyBuffed.forEach(function(i) {_exudBuildingMonitorSettings.BM.push(i);});
	}
	catch (e)
	{
		alert(e.message);
	}
	_exudBuildingMonitorSaveSettings();
}
function _exudUserBuildingListAutofit()
{
	
	// Remove bulding notification
	_exudUserBuildingListClear();
	// check all building , if upgrading , add it to monitor
	swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function(bld) {
		try{
			if (bld.IsUpgradeInProgress())
			{
				var g = parseInt(bld.GetGrid());
				if (!_exudBuildingMonitorIsMonitoring(g))
					_exudBuildingMonitorSettings.BM.push(g);
				_exudBuildingMonitorSettings.NotifyUpgrade.push(g);
			}
		}
		catch (e)
		{
		}
	});
	_exudBuildingMonitorSaveSettings();
	_exudUserBuildingListRefresh();	
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
					var buffInfo = _exudBuildingListGetEndBuffTime(bld);
					_exudUserBuildingListBuildings.push(
						{
							"Building" : bld,
							"Name" : n,
							"IconMap" : IconMapBld,
							"Level" : bld.GetUIUpgradeLevel(),
							"GridPos" : bld.GetGrid(),
							"Buffed" : (buffInfo == '' ? 0 : 1),
							"BuffEnd" : buffInfo,
							"Upg" : isUpgrading
						}
					);
				}
			}
			catch (e)
			{
				alert(e);
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

function _exudBuildingListGetEndBuffTime(bld)
{
	var BuffData = '';
	 try{
		buff = bld.productionBuff;
		if (buff != null)
		{
			if (buff.IsActive(swmmo.application.mGameInterface.GetClientTime()))
			{		
				app = buff.GetApplicanceMode();			
				timeEnd =  new window.runtime.Date(Date.now() + (buff.GetStartTime() + buff.GetBuffDefinition().getDuration(app)) - swmmo.application.mGameInterface.GetClientTime());

				if (timeEnd > 0)	
				{
					var dtfex = new window.runtime.flash.globalization.DateTimeFormatter("en-US"); 
					if (gameLang.indexOf("en-") > 0)
						dtfex.setDateTimePattern("MM-dd-yyyy HH:mm"); 
					else
						dtfex.setDateTimePattern("dd-MM HH:mm"); 
					
					BuffData = dtfex.format(new window.runtime.Date(timeEnd));
					
				}	
			}							
		}
	 }
	 catch (e) {
	 }
	
	return BuffData;
}

function _exudUserBuildingListUpdateView()
{
	var out = "";
	var tot = 0;
	var BuildToDisplay = $('#exudUserBuildingListSelect option:selected').val();
	_exudUserBuildingListBuildings.forEach(function(bld) {
		try{
		if (bld.Name == BuildToDisplay)
		{
			isSelected = _exudBuildingMonitorIsMonitoring(bld.GridPos);
			
			checkbox = '<input type="checkbox" id="_exudBL_{0}" {1}/>'.format(
						bld.GridPos,
						isSelected ? ' checked' : ''
					);
			out += createTableRow([
					[1, (bld.GridPos > 0 ?checkbox: "")],
					[4, bld.Name],
					[2, bld.Upg],
					[3, (bld.Buffed  == 1 ? bld.BuffEnd : loca.GetText("LAB", 'NO'))],
					[1, bld.Level],
					[1, (bld.GridPos > 0 ? bld.IconMap : "")]
				], false);				
				++tot;
		}
		}
		catch (e)
		{
			alert(e);
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
	gid = parseInt(gid.replace("_exudBM_",""));
	
	_exudUserBuildingToggleMonitorGid(gid, btn.checked);
	}
	catch (e)
	{
	}
}
function _exudUserBuildingToggleMonitor2(e)
{
	try{
	var btn = e.target;
	var gid = btn.id.replace("_exudBL_","");
	gid = parseInt(gid.replace("_exudBM_",""));
	
	_exudUserBuildingToggleMonitorGid(gid, btn.checked);
	_exudUserBuildingMonitorRefresh();
	}
	catch (e)
	{
	}
}
function _exudUserBuildingToggleMonitorGid(gid, st)
{	
	try{
		if (st)
			_exudBuildingMonitorSettings.BM.push(gid);
		else
		{
			_exudUserBuildingRemoveArrayItem(_exudBuildingMonitorSettings.BM, gid);
			_exudUserBuildingRemoveArrayItem(_exudBuildingMonitorSettings.NotifyUpgrade, gid);
			_exudUserBuildingRemoveArrayItem(_exudBuildingMonitorSettings.NotifyBuffed, gid);
		}
		
		_exudBuildingMonitorSaveSettings();
	}
	catch (e)
	{
	}
}
function _exudUserBuildingRemoveArrayItem(ar, it)
{
	if (ar != null && ar.indexOf(it) >= 0)
		ar.splice($.inArray(it,ar),1);
}
function _exudUserBuildingToggleMonitorNotifyUpgrade(e)
{
	try{
	var btn = e.target;
	var gid = parseInt(btn.id.replace("_exudBMU_",""));
		if (_exudBuildingMonitorIsMonitoring(gid))
		{
			if (btn.checked)
				_exudBuildingMonitorSettings.NotifyUpgrade.push(gid);
			else
				_exudUserBuildingRemoveArrayItem(_exudBuildingMonitorSettings.NotifyUpgrade, gid);
			
			_exudBuildingMonitorSaveSettings();
		}
		else
			btn.checked = false;
	}
	catch (e)
	{
	}
}
function _exudUserBuildingToggleMonitorNotifyBuffed(e)
{
	try{
	var btn = e.target;
	var gid = parseInt(btn.id.replace("_exudBMB_",""));
		if (_exudBuildingMonitorIsMonitoring(gid))
		{
			if (btn.checked)
				_exudBuildingMonitorSettings.NotifyBuffed.push(gid);
			else		
				_exudUserBuildingRemoveArrayItem(_exudBuildingMonitorSettings.NotifyBuffed,gid);
			
			_exudBuildingMonitorSaveSettings();
		}
		else
			btn.checked = false;
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
			
			selectUS = $('<select>', { id: '_exudUserBuildingMonitorSelectUS' });	
			selectBS = $('<select>', { id: '_exudUserBuildingMonitorSelectBS' });	

			_exudUserBuildingListSounds.forEach(function(item) {
				selectUS.append($('<option>', { value: item }).text(item)).prop("outerHTML");
				selectBS.append($('<option>', { value: item }).text(item)).prop("outerHTML");
			});
						
			$('#UserBuildingMonitorModal .modal-header').append(
				'<div class="container-fluid">' 
				+ '<div>'
				+ '<span style="height:30px;float:left;vertical-align: middle;"><input type="checkbox" id="_exudUserBuildingMonitorNotifyCheck" {0}/> {1}<br/>'.format((_exudBuildingMonitorSettings.Notify ? ' checked' : ''),  getText('Notify', 'exudUserBuildingListLang')) + '</span>'
				+ '<span style="height:30px;float:left;vertical-align: middle;">&nbsp;/&nbsp;<input type="checkbox" id="_exudUserBuildingMonitorPlayCheck" {0}/> {1}<br/>'.format((_exudBuildingMonitorSettings.PlayMute ? ' checked' : ''),  getText('PlayMute', 'exudUserBuildingListLang')) + '</span>'
				+ '<span style="height:30px;float:left;vertical-align: middle;">&nbsp;/&nbsp;' + getText('Minutes', 'exudUserBuildingListLang') + ' (2-10)  <input type="text" style="color:black;width:40px;vertical-align: bottom" id="_exudUserBuildingMonitorTime" value="'+_exudBuildingMonitorSettings.Minutes+'"/></span>'
				+ "&nbsp;&nbsp;&nbsp;" + $('<button>').attr({ "class": "btn btn-sm _exudUserBuildingMonitorAtivarPararBtn" }).text((_exudBuildingMonitorTimeOut != null ? getText('Stop', 'exudUserBuildingListLang') : getText('Start', 'exudUserBuildingListLang'))).prop("outerHTML") + ' '
				+ "<br/>" + getText('UpgradeSound', 'exudUserBuildingListLang') + "&nbsp;&nbsp;" + selectUS.prop("outerHTML") + "&nbsp;&nbsp;"
				+ getText('DebuffSound', 'exudUserBuildingListLang') + "&nbsp;&nbsp;"+ selectBS.prop("outerHTML") 
				+ '</div><br/>'
				+ '<div style="clear:both">'
				+ createTableRow([
						[1, getText('Monitoring', 'exudUserBuildingListLang')],
						[4, loca.GetText("LAB", "Name")],
						[2, getText('Upgrading', 'exudUserBuildingListLang')],
						[3, loca.GetText("LAB", 'Buff')],
						[1, loca.GetText("LAB", "Level")],
						[1, loca.GetText("LAB", "Visit")]
					], true)
				+ "</div>"
				+ "</div>"
			);
			
			$('#_exudUserBuildingMonitorSelectUS').val(_exudBuildingMonitorSettings.UpgradeSound);
			$('#_exudUserBuildingMonitorSelectBS').val(_exudBuildingMonitorSettings.BuffSound);

			$('#_exudUserBuildingMonitorPlayCheck').change(function(){
				_exudBuildingMonitorSettings.PlayMute = !_exudBuildingMonitorSettings.PlayMute;
				_exudBuildingMonitorSaveSettings();
			});
			$('#_exudUserBuildingMonitorSelectUS').change(function(){
				_exudBuildingMonitorSettings.UpgradeSound = $( "#_exudUserBuildingMonitorSelectUS" ).val();
				_exudUserBuildingMonitorPlaySound(_exudBuildingMonitorSettings.UpgradeSound);
				_exudBuildingMonitorSaveSettings();
			});
			$('#_exudUserBuildingMonitorSelectBS').change(function(){
				_exudBuildingMonitorSettings.BuffSound = $( "#_exudUserBuildingMonitorSelectBS" ).val();
				_exudUserBuildingMonitorPlaySound(_exudBuildingMonitorSettings.BuffSound);
				_exudBuildingMonitorSaveSettings();
			});

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
				if (_exudBuildingMonitorSettings.Minutes<2)
					_exudBuildingMonitorSettings.Minutes=2;
				if(_exudBuildingMonitorSettings.Minutes>10)
					_exudBuildingMonitorSettings.Minutes=10;
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
		var unbuffed = 0;
		try{
			_exudBuildingMonitorSettings.NotifyUpgrade.forEach(function(item) {
				var bld = game.zone.mStreetDataMap.GetBuildingByGridPos(item);
				try{
					if (!bld.IsUpgradeInProgress()) 
						++terminated;
				}
				catch (ee)
				{
				}
			});
			_exudBuildingMonitorSettings.NotifyBuffed.forEach(function(item) {
				var bld = game.zone.mStreetDataMap.GetBuildingByGridPos(item);
				try{
					if (bld.productionBuff==null) 
						++unbuffed;
				}
				catch (ee)
				{
				}
			});
		} catch (e)
		{
		}
		if (terminated> 0)
		{
			showGameAlert(getText('ReadyMsg', 'exudUserBuildingListLang').format(terminated));	
			_exudUserBuildingMonitorMessage(getText('ReadyMsg', 'exudUserBuildingListLang').format(terminated));	
			_exudUserBuildingMonitorPlaySound(_exudBuildingMonitorSettings.UpgradeSound);
		}
		if (unbuffed> 0)
		{
			showGameAlert(getText('DebuffedMsg', 'exudUserBuildingListLang').format(unbuffed));	
			_exudUserBuildingMonitorMessage(getText('DebuffedMsg', 'exudUserBuildingListLang').format(unbuffed));
			_exudUserBuildingMonitorPlaySound(_exudBuildingMonitorSettings.BuffSound);
		}
	}	
	if (_exudBuildingMonitorSettings.Notify)
		_exudBuildingMonitorTimeOut = setTimeout(_exudBuildingMonitorStartTimed, _exudBuildingMonitorSettings.Minutes*60000);
}


function _exudUserBuildingMonitorRefresh()
{
	var out = "";
	_exudBuildingMonitorSettings.BM.forEach(function(item) {
		try{
		var bld = game.zone.mStreetDataMap.GetBuildingByGridPos(item);
		isSelected = true;
		hasNotifyUpgrade = _exudBuildingMonitorHasNotifyUpgrade(item);
		hasNotifyBuffed = _exudBuildingMonitorHasNotifyBuffed(item);
		
		checkbox = '<input type="checkbox" id="_exudBM_{0}" {1}/>'.format(
					item,
					isSelected ? ' checked' : ''
				);
		checkboxU = '<input type="checkbox" id="_exudBMU_{0}" data-placement="top" data-toggle="tooltip" {1} title="{2}"/>'.format(
					item,
					hasNotifyUpgrade ? ' checked' : '',
					getText('ToolTipNotify', 'exudUserBuildingListLang')
				);

		checkboxB = '<input type="checkbox" id="_exudBMB_{0}" data-placement="top" data-toggle="tooltip" {1} title="{2}"/>'.format(
					item,
					hasNotifyBuffed ? ' checked' : '',
					getText('ToolTipNotify', 'exudUserBuildingListLang')
				);
				
		var isUpgrading = "";
		try{
			if (bld.IsUpgradeInProgress()) isUpgrading = bld.mBuildingUpgradeProgress + "%";
		}
		catch (ee)
		{
		}
		var IconMap = getImageTag("accuracy.png", '24px', '24px').replace('<img','<img id="exudBMPOS_'+ item+'"').replace('style="', 'style="cursor: pointer;')
		var buffInfo = _exudBuildingListGetEndBuffTime(bld)
		out += createTableRow([
				[1, (item > 0 ?checkbox: "")],
				[4, _exudUserBuildingListGetName(bld.GetBuildingName_string())],
				[2, checkboxU + "&nbsp;" + isUpgrading],
				[3, checkboxB + "&nbsp;" + (buffInfo == '' ? loca.GetText("LAB", 'NO') : buffInfo )],
				[1, bld.GetUIUpgradeLevel()],
				[1, (item > 0 ? IconMap : "")]
			], false);
		}
		catch (e)
		{
			_exudUserBuildingToggleMonitor(item, false);
		}
	});
	$('#UserBuildingMonitorModalData').html('<div class="container-fluid">{0}</div>'.format(out));
	$('[data-toggle="tooltip"]').tooltip({container: 'body'});
	$('#UserBuildingMonitorModalData input[id^="_exudBM_"]').click(_exudUserBuildingToggleMonitor2);
	$('#UserBuildingMonitorModalData img[id^="exudBMPOS_"]').click(_exudUserBuildingListGoTo2);
	$('#UserBuildingMonitorModalData input[id^="_exudBMU_"]').click(_exudUserBuildingToggleMonitorNotifyUpgrade);
	$('#UserBuildingMonitorModalData input[id^="_exudBMB_"]').click(_exudUserBuildingToggleMonitorNotifyBuffed);
}

function _exudUserBuildingMonitorMessage(Text)
{
	try{
		globalFlash.gui.mChatPanel.PutMessageToChannelWithoutServer("news", new window.runtime.Date(),getText('Monitor', 'exudUserBuildingListLang'),Text,false,false);

	}
	catch (e) {
		
	}
}
function _exudUserBuildingMonitorPlaySound(sound)
{
	try{
		var SM = swmmo.getDefinitionByName("Sound::cSoundManager").getInstance();
		var item = sound.split("_");
		var muted = (SM.isEffectsMuted() && _exudBuildingMonitorSettings.PlayMute);

		if(muted)  
		{
			SM.toggleEffects();
			SM.setEffectsVolume(1);
		}
		if (item.length == 1)
			SM.playEffect(item[0]);
		else
			SM.playEffect(item[0], item[1]);
		
		if(muted)  SM.toggleEffects();
	}
	catch (e)
	{
	}
}
