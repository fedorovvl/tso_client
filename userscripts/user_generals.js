
// ========== Generals COMMAND
const _exudGeneralsLang = {
	"en-uk": {
		"ByName": "Sort by Name",
        "ByType": "Sort by Type",
        "ShowGuest": "Show Guests",
        "HideGuest": "Hide Guests",
        "ShowUnselected": "Show Unselected",
        "HideUnselected": "Hide Unselected",
        "SelectAll": "Select All",
        "Load": "Load",
        "CommandSent": "Command sent",
        "ColumnOwner": "Owner",
		"IsGuest": " (* guest) ",
		"SelectedFirst": "Selected First",
		"ExcludeStarMenu": "Exclude Star Menu"
    },
    "pt-br": {
        "ByName": "Classificar por nome",
        "ByType": "Classificar por tipo",
        "ShowGuest": "Todos",
        "HideGuest": "Excluir outros jogadores",
        "ShowUnselected": "Todos",
        "HideUnselected": "Somente selecionados",
        "SelectAll": "Selecionar todos",
        "Load": "Carregar",
        "ColumnOwner": "Proprietario",
		"IsGuest": " (* = convidado) ",
		"SelectedFirst": "Selecionado primeiro",
		"ExcludeStarMenu": "Excluir Menu Estrela"
   },
    "pl-pl": {
        "ByName": "Sortuj po nazwie",
        "ByType": "Sortuj po typie",
        "ShowGuest": "Pokaż gości",
        "HideGuest": "Ukryj gości",
        "ShowUnselected": "Pokaż niezaznaczonych",
        "HideUnselected": "Ukryj niezaznaczonych",
        "SelectAll": "Zaznacz wszystkich",
        "Load": "Załaduj",
        "CommandSent": "Generał wysłany",
        "ColumnOwner": "Właściciel"
    },
    "ru-ru": {
		"ByName": "Сортировать по имени",
        "ByType": "Сортировать по типу",
        "ShowGuest": "Показать генералов гостя",
        "HideGuest": "Спрятать генералов гостя",
        "ShowUnselected": "Показать всех",
        "HideUnselected": "Показать отмеченных",
        "SelectAll": "Выбрать всех",
        "Load": "Загрузить",
        "CommandSent": "Отправить",
        "ColumnOwner": "Владелец"
    },
	"fr-fr": {
		"ByName": "Trier par Nom",
        "ByType": "Trier par Type",
        "ShowGuest": "Afficher Invité",
        "HideGuest": "Masquer Invité",
        "ShowUnselected": "Afficher Tout",
        "HideUnselected": "Afficher Sélection",
        "SelectAll": "Sélectionner Tout",
        "Load": "Charger",
        "CommandSent": "Envoyer",
        "ColumnOwner": "Propriétaire",
		"IsGuest": " (* Invité) ",
		"SelectedFirst": "Sélection en Premier",
		 "ExcludeStarMenu": "Masquer les Généraux en Etoile"
    },
    "it-it": {
        "ByName": "Ordina per nome",
        "ByType": "Ordina per tipo",
        "ShowGuest": "Di tutti",
        "HideGuest": "Escludi altri giocatori",
        "ShowUnselected": "Tutti",
        "HideUnselected": "Solo selezionati",
        "SelectAll": "Seleciona tutto",
        "Load": "Apri",
        "ColumnOwner": "Proprietario",
		"IsGuest": " (* = invitato) "
    },
    "es-es": {
        "ByName": "Orden: Nombre",
        "ByType": "Orden: Tipo",
        "ShowGuest": "Ver generales de amigos",
        "HideGuest": "Ver solo los míos",
        "ShowUnselected": "Todos",
        "HideUnselected": "Seleccionados",
        "SelectAll": "Seleccionar todos",
        "Load": "Cargar",
	"CommandSent": "Comando enviado",
        "ColumnOwner": "Propietario",
	"IsGuest": " (* = invitado) "
    },
    "es-mx": {
        "ByName": "Ordenar: Nombre",
        "ByType": "Ordenar: Tipo",
        "ShowGuest": "Ver generales de amigos",
        "HideGuest": "Ver solo los míos",
        "ShowUnselected": "Todos",
        "HideUnselected": "Seleccionados",
        "SelectAll": "Seleccionar todos",
        "Load": "Cargar",
	"CommandSent": "Comando enviado",
        "ColumnOwner": "Propietario",
	"IsGuest": " (* = invitado) "
    }
};

addToolsMenuItem(loca.GetText("ACL", "MilitarySpecialists"), _exudGeneralsMenuHandler);

var _exudGeneralsSortType = 1; // 0 = type/name  1 = name/type
var _exudGeneralsHideGuest = true;
var _exudGeneralsHideUnselected = false;
var _exudGeneralsToggleselected = false;
var idL = loca.getSelectedLanguage();
var _exudGeneralsSelectedFirst = false;
var _exudGeneralsExcludeStarMenu = false;

function _exudGeneralsGetLabel(id)
{
	if(!_exudGeneralsLang[idL] && !_exudGeneralsLang["en-uk"][id]) { return "RES not found : " + id; }
	return _exudGeneralsLang[idL] && _exudGeneralsLang[idL][id] ? _exudGeneralsLang[idL][id] : _exudGeneralsLang["en-uk"][id];
}	

function _exudGeneralsMenuHandler(event)
{

	$('#udSpecModal').remove();
	
	try{
		_exudGeneralsSortType = readSettings('_exudGeneralsSortType',  'usMKF_Generals');
		_exudGeneralsHideUnselected = readSettings('_exudGeneralsHideUnselected', 'usMKF_Generals');
		_exudGeneralsHideGuest = readSettings('_exudGeneralsHideGuest',  'usMKF_Generals');
		_exudGeneralsSelectedFirst = readSettings('_exudGeneralsSelectedFirst',  'usMKF_Generals');
		_exudGeneralsExcludeStarMenu = readSettings('_exudGeneralsExcludeStarMenu',  'usMKF_Generals');
	}
	catch (e) {}

	
	// close all modals
	$( "div[role='dialog']:not(#udSpecModal):visible").modal("hide");
	// create modal
	createModalWindow('udSpecModal', loca.GetText("ACL", "MilitarySpecialists"));
	if($('#udSpecModal .modal-footer ._exudSpecLoadTemplateBtn').length == 0)
	{
		$("#udSpecModal .modal-footer").prepend([
			$('<button>').attr({ "id": "_exudSpecLoadTemplateBtn", "class": "btn btn-primary pull-left _exudSpecLoadTemplateBtn" }).text(_exudGeneralsGetLabel("Load")),
			$('<button>').attr({ "id": "_exudSpecSaveTemplateBtn", "class": "btn btn-primary pull-left _exudSpecSaveTemplateBtn" }).text(loca.GetText("LAB", "Save")),
			$('<button>').attr({ "id": "_exudSpecSaveTemplateBtn", "class": "btn btn-success _exudSendGeneralsBtn" }).text(loca.GetText("LAB", "Send"))
		]);
		



		$('#udSpecModal ._exudSpecLoadTemplateBtn').click(_exudGeneralsLoadData);
		$('#udSpecModal ._exudSpecSaveTemplateBtn').click(_exudGeneralsSaveData);
		$('#udSpecModal ._exudSendGeneralsBtn').click(_exudGeneralsSend);
		
		_exudGetGeneralsTitle(0);
		
		
		var out = '<div class="container-fluid">';
		try
		{
			var AdvManager = swmmo.getDefinitionByName("com.bluebyte.tso.adventure.logic::AdventureManager").getInstance();
			var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
			
			select = $('<select>', { id: 'udcboSendZones' });
			select.append($('<option>', { value: '-1' }).text('-----').prop("outerHTML"));
			select.append($('<option>', { value: '98' }).text(loca.GetText("LAB", "StarMenu")).prop("outerHTML"));
			
			if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone)
				select.append($('<option>', { value: swmmo.application.mGameInterface.mCurrentPlayer.GetHomeZoneId() }).text(loca.GetText("LAB", "ReturnHome")).prop("outerHTML"));

			AdvManager.getAdventures().forEach(function(item){
				if (item.zoneID != swmmo.application.mGameInterface.mCurrentViewedZoneID) {
					select.append($('<option>', { value: item.zoneID }).text((item.ownerPlayerID != PlayerID ? '*' : '') + loca.GetText("ADN", item.adventureName)).prop("outerHTML"));
				}
			});
			
			out += select.prop("outerHTML") + _exudGeneralsGetLabel("IsGuest");
			out += $('<button>').attr({ "class": "btn btn-sm _exudSelectAllGeneralsBtn" }).text(
				_exudGeneralsGetLabel("SelectAll")
			).prop("outerHTML") + ' ';

			out += $('<button>').attr({ "class": "btn btn-sm _exudGeneralRefreshBtn" }).text(
			loca.GetText("LAB", "Update")
			).prop("outerHTML") + ' ';
		} catch (error) {
			alert("Err (retry): " + error.message);
		}
			
		out += '<br/><br/>' + createTableRow([
			[7, loca.GetText("LAB","Name")],
			[2, loca.GetText("LAB", "StarMenu")],
			[1, loca.GetText("LAB", "Army")],
			[2, _exudGeneralsGetLabel("ColumnOwner")]
		], true) ;
		
		out += '</div>';

		$('#udSpecModal .modal-header').append(out);	
			
		$('#udSpecModal ._exudSelectAllGeneralsBtn').click(function() {
			_exudGeneralsToggleselected = !_exudGeneralsToggleselected;
			$('#udSpecModalData input[type="checkbox"]').each(function(i, item) { 
				item.checked = _exudGeneralsToggleselected;	
				});
		});
				
	}

	_exudGetGeneralsData();

	$("#udSpecModal .modal-footer .btn-danger").html(loca.GetText("LAB", "Close"));
	$('#udSpecModal:not(:visible)').modal({backdrop: "static"});
}
function _exudGetGeneralsTitle(x)
{
	$('#udSpecModal .modal-title').html( getImageTag('icon_general.png') + loca.GetText("ACL", "MilitarySpecialists") + (x>0 ? " ("+x+")" : ""));
	$("#udSpecModal .modal-title").append($('<button>').attr({ "class": "btn btn-settings pull-right" }).text(loca.GetText("LAB", "ToggleOptionsPanel")));
	$('#udSpecModal .btn-settings').click(_exudGeneralsOptions);
}

function _exudGeneralsSaveSettings()
{

	try{
	var s = {
		'_exudGeneralsSortType' : _exudGeneralsSortType,
		'_exudGeneralsHideUnselected' : _exudGeneralsHideUnselected,
		'_exudGeneralsHideGuest' : _exudGeneralsHideGuest,
		'_exudGeneralsSelectedFirst' : _exudGeneralsSelectedFirst,
		'_exudGeneralsExcludeStarMenu' : _exudGeneralsExcludeStarMenu
	}
	
	storeSettings(s, 'usMKF_Generals');
	alert("Saved");
	}
	catch
	(e) {
		alert(e.message);
	}


}

function _exudGeneralsOptions()
{
	createSettingsWindow('udSpecModal', function(){_exudGeneralsSaveSettings();},  'modal-sm');
	$('#udSpecModalsettingsData').html(_exudGeneralsOptionsCreateSettings());
	$('#udSpecModalsettings:not(:visible)').modal({backdrop: "static"});

	$('#_exudChangeGeneralSortFloatBtn').change(function(){
		if (++_exudGeneralsSortType == 2)	_exudGeneralsSortType = 0;
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});
	$('#udSpecModal ._exudGeneralRefreshBtn').click(function(){
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());			
	});
	$('#_exudHideUnselectedGeneralsFloatBtn').change(function(){
		_exudGeneralsHideUnselected = !_exudGeneralsHideUnselected;
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});
	$('#_exudHideGuestGeneralsFloatBtn').change(function(){
		_exudGeneralsHideGuest = !_exudGeneralsHideGuest;
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});
	$('#_exudGeneralsSelectedFirstFloatBtn').change(function(){
		_exudGeneralsSelectedFirst = !_exudGeneralsSelectedFirst;
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});
	$('#_exudGeneralsExcludeStarMenuFloatBtn').change(function(){
		_exudGeneralsExcludeStarMenu = !_exudGeneralsExcludeStarMenu;
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});


}

function _exudGeneralsOptionsCreateSettings()
{
		var out = '';
		
		try{

		out += '<div style="float: clear"><div style="float: left;">';
		out += createSwitch("_exudChangeGeneralSortFloatBtn", (_exudGeneralsSortType==1));
		out += '</div>';
		out += '<div>&nbsp;&nbsp;'+_exudGeneralsGetLabel("ByName") +'</div>';
		out += '</div><br/>';
		
		out += '<div style="float: clear"><div style="float: left">';
		out += createSwitch("_exudHideGuestGeneralsFloatBtn", _exudGeneralsHideGuest);
		out += '</div>';
		out += '<div >&nbsp;&nbsp;'+_exudGeneralsGetLabel("HideGuest") +'</div>';
		out += '</div><br/>';

		out += '<div style="float: clear"><div style="float: left;">';
		out += createSwitch("_exudHideUnselectedGeneralsFloatBtn", (_exudGeneralsHideUnselected));
		out += '</div>';
		out += '<div >&nbsp;&nbsp;'+_exudGeneralsGetLabel("HideUnselected") +'</div>';
		out += '</div><br/>';
		
		out += '<div style="float: clear"><div style="float: left;">';
		out += createSwitch("_exudGeneralsSelectedFirstFloatBtn", (_exudGeneralsSelectedFirst));
		out += '</div>';
		out += '<div >&nbsp;&nbsp;'+_exudGeneralsGetLabel("SelectedFirst") +'</div>';
		out += '</div><br/>';

		out += '<div style="float: clear"><div style="float: left ">';
		out += createSwitch("_exudGeneralsExcludeStarMenuFloatBtn", (_exudGeneralsExcludeStarMenu));
		out += '</div>';
		out += '<div>&nbsp;&nbsp;'+_exudGeneralsGetLabel("ExcludeStarMenu") +'</div>';
		out += '</div><br/>';

		}
		catch (e) { alert(e.message); }

		return out;

}

function _exudGetGeneralsData()
{
	var out = '<div id="_exudGeneralsDivTable">{0}</div>'.format(_exudMakeGeneralsTable());
	
	$('#udSpecModalData').html('<div class="container-fluid" id="exSpecMainDiv">' + out + '</div>');

}

function _exudMakeGeneralsTable(_sel)
{
	var out = "";	
	try{
		var Selected = (_sel == null || _sel == undefined ?_exudGeneralsGetChecked() : _sel);
		var myGens = 0;
	
		_exudGetSpecialists().forEach(function(item){
			try{
				var IsSelected = (Selected.indexOf(item.UID) >= 0);
				
				if (_exudGeneralsHideGuest && !item.Owner) return;
				if (_exudGeneralsExcludeStarMenu && (item.GridPosition < 1) && !IsSelected) return;
				if (_exudGeneralsHideUnselected && !IsSelected) return;
				if (item.Owner) ++myGens;
				
				var checkbox = '<input type="checkbox" id="{0}"{1}/> {2}'.format(item.UID, (IsSelected ? ' checked' : ''),  item.Icon + item.Name);

				out += createTableRow([
					[7, !_exudGeneralsIsSelectable(item) ? '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + item.Icon + item.Name  + (item.PlayerName != null ? ' (' + item.PlayerName + ')' : '' ): checkbox],
					[2, (item.GridPosition <= 0 ? loca.GetText("LAB", "YES"): '')],
					[1, (item.TotalArmy>0?item.TotalArmy:'')],
					[2, (item.Owner ? loca.GetText("LAB", "YES"): '')]
				]);
			}
			catch (e) {
				//alert("MGT: " + e.message);
			}
	});
	
	_exudGetGeneralsTitle(myGens);
	}
	catch (e) {
			alert(e.message);
	}
	return out;
}

function _exudGeneralsIsSelectable(S)
{
	return (S.Owner && !S.InUse && !S.Travelling)
}

function _exudGeneralsSaveData()
{
	var listS = new Array();
	$('#udSpecModalData input[type="checkbox"]').each(function(i, item) { 
		if(item.checked) {
			listS.push(item.id);
		}
	});
	if (listS.length > 0) {
		var file = new air.File(readLastDir('genspec')).resolvePath("specGenerals.txt");
		file.addEventListener(air.Event.COMPLETE, function(event){
			saveLastDir('genspec', event.target.parent.nativePath);
		}); 
		file.save(JSON.stringify(listS));
	}	
}

function _exudGeneralsLoadData()
{
	var file = new air.File(readLastDir('genspec'));
	var txtFilter = new air.FileFilter("All Files" , "*.*"); 
	file.browseForOpen("Open", [txtFilter]); 
	file.addEventListener(air.Event.SELECT, function(event){
		event.target.addEventListener(air.Event.COMPLETE, _exudGenLoadTemplateLoaded); 
		event.target.load();
	}); 
}

function _exudGenLoadTemplateLoaded(event)
{
	var listS = new Array();
	try{
	  listS = JSON.parse(event.target.data);
	} catch(e) {
	  alert("Bad template file");
	  return;
	}
	$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable(listS));	
}

function _exudGeneralsGetChecked()
{
	var GensUID = new Array();
	try{
	$('#udSpecModalData input[type="checkbox"]').each(function(i, item) { 
		if(item.checked) {
			GensUID.push(item.id); 
		}
	});
	}
	catch (e) {
		//alert("GGC:" + e.message);
		}
	return GensUID;
}

function _exudGeneralsIsCheked(uid)
{
	try{
return 	$('input:checkbox[id^="'+uid+'"]:checked').length>0;
	} catch (e) {}
	return false;
}

function _exudGeneralsSend()
{
	try
	{
		var OptionSelected = $('#udcboSendZones option:selected').val();
		if (OptionSelected == -1) return;
		var Specialists = swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector(); // Vector.<cSpecialist>	
		var Services = swmmo.getDefinitionByName("com.bluebyte.tso.service::ServiceManager").getInstance();
		_exudGeneralsGetChecked().forEach(function(item){
			var S = _exudGetSpecialistbyUID(Specialists,item);
			if (S == null) { return; }
			if (OptionSelected == '98' && S.GetGarrisonGridIdx() > 0) {
				_exudSendGeneralToStar(S);
			}
			if (OptionSelected != '98') {
				Services.specialist.sendToZone(S, OptionSelected);
			}
		});
		$('#udSpecModal').modal('hide');	
		showAlert(_exudGeneralsGetLabel("CommandSent"), false, 'success');			
	 }
	 catch (error) {
		 alert("send error : " + error.message);
	 }
}

function _exudSendGeneralToStar(S)
{
	try
	{			
		swmmo.application.mGameInterface.mCurrentCursor.mCurrentSpecialist = S;
		specTaskDef = swmmo.getDefinitionByName("Communication.VO::dStartSpecialistTaskVO");
		stask = new specTaskDef();
		stask.uniqueID = S.GetUniqueID();
		stask.subTaskID = 0;

		swmmo.application.mGameInterface.SendServerAction(95,12,swmmo.application.mGameInterface.mCurrentCursor.GetGridPosition(),0,stask);
		wfcDef = swmmo.getDefinitionByName("Specialists::cSpecialistTask_TravelToStarMenu");
		wfc = new wfcDef(swmmo.application.mGameInterface,S,0,12);
		S.SetTask(wfc);
	}
	catch (error) {
		alert("Send to star error : " + error.message);
		}
}

function _exudGetSpecialistbyUID(specs, uid)
{
	for(y = 0 ; y < specs.length ; y++) {
		if (specs[y].GetUniqueID().toKeyString() == uid)
			return specs[y];
	}
	return null;
}

function _exudGetSpecialists()
{
	var SPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
	var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
	var listS = new Array();
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
		if (!SPECIALIST_TYPE.IsGeneral(item.GetType()))
			return;
		i_pid = -1;
		try{
			i_pid = item.getPlayerID();
		}
		catch (e){}
		try{
		listS.push({
			"UID" : item.GetUniqueID().toKeyString(),
			"BaseType" : item.GetBaseType(),
			"HasElites" : item.GetArmy().HasEliteUnits(),
			"HasUnits" : item.HasUnits(),
			"Name" : item.getName(false).replace('<b>', '').replace('</b>',''),
			"PlayerID" : i_pid,
			"Type" : item.GetType(),
			"XP" : item.GetXP(),
			"Travelling" : item.isTravellingAway(),
			"InUse": item.IsInUse(),
			"Owner" : (PlayerID == i_pid),
			"IsGeneral" : true,
			"TotalArmy" : item.GetArmy().GetUnitsCount(),
			"Icon" : getImageTag(item.getIconID(), '24px', '24px')	,
			"PlayerName" : (i_pid > 0 && i_pid != PlayerID ? swmmo.application.mGameInterface.GetPlayerName_string(i_pid) : null),
			"GridPosition" : item.GetGarrisonGridIdx() 
		});
		}
		catch (e) {
				//alert("Push error : " + e.message); when general is moving to adventure, some data like playerID etc are null or undefined. so air throw a 1009 error. I ignore this item at the moment, it appear after some seconds
		}
	});
	if (listS.length > 1)
		listS.sort(_exudCompareGenerals);
		
	return listS;	
}

function _exudCompareGenerals( a, b ) {
	try{
		if (_exudGeneralsSelectedFirst)
		{
			var a_chkd = _exudGeneralsIsCheked(a.UID);
			var b_chkd = _exudGeneralsIsCheked(b.UID);
			if (a_chkd != b_chkd) 
				return (a_chkd ? -1 : 1);
		}
		if (!b.Owner && a.Owner) return -1;
		if (!a.Owner && b.Owner) return 1;
		switch(_exudGeneralsSortType)
		{
			case 1:
				var tp = a.Name.toLowerCase().localeCompare(b.Name.toLowerCase());
				if (tp != 0) return tp;
				if (a.Type < b.Type) return -1;
				if (a.Type > b.Type) return 1;
			break;
			default:
				if (a.Type < b.Type) return -1;
				if (a.Type > b.Type) return 1;
				return a.Name.toLowerCase().localeCompare(b.Name.toLowerCase());
			break;
		}
	}
	catch (error) {
				//alert("compare error : " + error.message);
	}
	return 0;
}
