
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
var _exudGeneralsOpening = false;
function _exudGeneralsMenuHandler(event)
{

	var myStyle = document.getElementById('_exudGeneralsSyle');
	if (myStyle != null && myStyle != undefined)
		myStyle.parentNode.removeChild(myStyle);
	
	myStyle = ".CellWithComment{  position:relative; } ";
	myStyle += ".CellComment{  display:none;  position:absolute;   z-index:100;  border:1px;  background-color:#B2A589;  border-style:solid;  border-width:1px;  border-color:black;  padding:3px;  color:black;   top:320px;   left:0px; width: 250px} ";
	myStyle += ".CellWithComment:hover span.CellComment{  display:block;}";
	
	var sheet = document.createElement('style')
	sheet.innerHTML = myStyle;
	document.body.appendChild(sheet);
	
	_exudGeneralsOpening = true;
	$('#udGeneralsModal').remove();
	
	try{
		_exudGeneralsSortType = readSettings('_exudGeneralsSortType',  'usMKF_Generals');
		_exudGeneralsHideUnselected = readSettings('_exudGeneralsHideUnselected', 'usMKF_Generals');
		_exudGeneralsHideGuest = readSettings('_exudGeneralsHideGuest',  'usMKF_Generals');
		_exudGeneralsSelectedFirst = readSettings('_exudGeneralsSelectedFirst',  'usMKF_Generals');
		_exudGeneralsExcludeStarMenu = readSettings('_exudGeneralsExcludeStarMenu',  'usMKF_Generals');
	}
	catch (e) {}

	
	// close all modals
	$( "div[role='dialog']:not(#udGeneralsModal):visible").modal("hide");
	// create modal
	createModalWindow('udGeneralsModal', loca.GetText("ACL", "MilitarySpecialists"));
	if($('#udGeneralsModal .modal-footer ._exudSpecLoadTemplateBtn').length == 0)
	{
		$("#udGeneralsModal .modal-footer").prepend([
			$('<button>').attr({ "id": "_exudSpecLoadTemplateBtn", "class": "btn btn-primary pull-left _exudSpecLoadTemplateBtn" }).text(_exudGeneralsGetLabel("Load")),
			$('<button>').attr({ "id": "_exudSpecSaveTemplateBtn", "class": "btn btn-primary pull-left _exudSpecSaveTemplateBtn" }).text(loca.GetText("LAB", "Save")),
			$('<button>').attr({ "id": "_exudSpecSaveTemplateBtn", "class": "btn btn-success _exudSendGeneralsBtn" }).text(loca.GetText("LAB", "Send"))
		]);		

		$('#udGeneralsModal ._exudSpecLoadTemplateBtn').click(_exudGeneralsLoadData);
		$('#udGeneralsModal ._exudSpecSaveTemplateBtn').click(_exudGeneralsSaveData);
		$('#udGeneralsModal ._exudSendGeneralsBtn').click(_exudGeneralsSend);
		
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

			out += $('<button>').attr({ "class": "btn btn-sm _exudGeneralsSelectedFirstBtn" }).text(
				_exudGeneralsGetLabel("SelectedFirst") 
			).prop("outerHTML") + ' ';


			out += $('<button>').attr({ "class": "btn btn-sm _exudGeneralRefreshBtn" }).text(
				loca.GetText("LAB", "Update")
			).prop("outerHTML") + ' ';
			
		} catch (error) {
			alert("Err (retry): " + error.message);
		}
			if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone)
			{
				out += '<br/><br/>' + createTableRow([
					[7, loca.GetText("LAB","Name")],
					[2, loca.GetText("LAB", "StarMenu")],
					[1, loca.GetText("LAB", "Army")],
					[2, _exudGeneralsGetLabel("ColumnOwner")]
				], true) ;
			}
			else{
				out += '<br/><br/>' + createTableRow([
					[9, loca.GetText("LAB","Name")],
					[2, loca.GetText("LAB", "StarMenu")],
					[1, loca.GetText("LAB", "Army")]
				], true) ;
			}
		out += '</div>';

		$('#udGeneralsModal .modal-header').append(out);	
			
		$('#udGeneralsModal ._exudSelectAllGeneralsBtn').click(function() {
			_exudGeneralsToggleselected = !_exudGeneralsToggleselected;
			$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) { 
				item.checked = _exudGeneralsToggleselected;	
				});
		});
		$('#udGeneralsModal ._exudGeneralRefreshBtn').click(function(){
			_exudMakeGeneralsTable();			
		});
	
		$('#udGeneralsModal ._exudGeneralsSelectedFirstBtn').click(function() {
			_exudGeneralsSelectedFirst = !_exudGeneralsSelectedFirst;
			_exudMakeGeneralsTable();
		});
	}

	_exudGetGeneralsData();

	$("#udGeneralsModal .modal-footer .btn-danger").html(loca.GetText("LAB", "Close"));
	$('#udGeneralsModal:not(:visible)').modal({backdrop: "static"});
	_exudGeneralsOpening = false;
}

function _exudGetGeneralsTitle(x)
{
	var pname = "";
	if (!swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone &&
		!swmmo.application.mGameInterface.isOnHomzone())
	{
		try{
			pname = swmmo.application.mGameInterface.mHomePlayer.GetPlayerName_string() + " - " + swmmo.application.mGameInterface.mHomePlayer.GetPlayerLevel();
		}
		catch(e) {}
	}
	$('#udGeneralsModal .modal-title').html( getImageTag('icon_general.png') + loca.GetText("ACL", "MilitarySpecialists") + (x>0 ? " ("+x+")" : "") + (pname != "" ? " (" + pname + ")" : ""));
	$("#udGeneralsModal .modal-title").append($('<button>').attr({ "class": "btn btn-settings pull-right" }).text(loca.GetText("LAB", "ToggleOptionsPanel")));
	$('#udGeneralsModal .btn-settings').click(_exudGeneralsOptions);
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
	createSettingsWindow('udGeneralsModal', function(){_exudGeneralsSaveSettings();},  'modal-sm');
	$('#udGeneralsModalsettingsData').html(_exudGeneralsOptionsCreateSettings());
	$('#udGeneralsModalsettings:not(:visible)').modal({backdrop: "static"});

	$('#_exudChangeGeneralSortFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		if (++_exudGeneralsSortType == 2)	_exudGeneralsSortType = 0;
		_exudMakeGeneralsTable();
	});
	$('#_exudHideUnselectedGeneralsFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsHideUnselected = !_exudGeneralsHideUnselected;
		_exudMakeGeneralsTable();
	});
	$('#_exudHideGuestGeneralsFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsHideGuest = !_exudGeneralsHideGuest;
		_exudMakeGeneralsTable();
	});	
	$('#_exudGeneralsExcludeStarMenuFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsExcludeStarMenu = !_exudGeneralsExcludeStarMenu;
		_exudMakeGeneralsTable();
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
		/*
		out += '<div style="float: clear"><div style="float: left;">';
		out += createSwitch("_exudGeneralsSelectedFirstFloatBtn", (_exudGeneralsSelectedFirst));
		out += '</div>';
		out += '<div >&nbsp;&nbsp;'+_exudGeneralsGetLabel("SelectedFirst") +'</div>';
		out += '</div><br/>';
*/
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
	var out = '<div class="container-fluid" id="exGeneralsMainDiv">';
		out += '<div id="_exudGeneralsDivTable"></div>';
		out += '<divclass="modal-dialog" id="_exudGeneralsSkillTree" style="position:absolute; top: 50%; left: 50%; color: black; background: #B2A589; font-weight: bold; visibility:hidden; border : thick solid #000000 ; border-width: 2px; width:250px ; height:320px;"></div>';
		out += '</div>';

	$('#udGeneralsModalData').html(out);
	
	_exudMakeGeneralsTable();
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
				var tooltip = loca.GetText("HIL", "Help_window_skilltrees_0");
				var Icon =  item.Icon.replace('<img','<img id="exudSTIMG'+item.UID+'"').replace('style="', 'style="cursor: pointer;');
				

				var checkbox = '<input type="checkbox" id="{0}"{1}/> {2}'.format(item.UID, (IsSelected ? ' checked' : ''),  Icon + item.Name);

				if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone)
				{
					out += createTableRow([
						[7, !_exudGeneralsIsSelectable(item) ? '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + Icon + item.Name  + (item.PlayerName != null ? ' (' + item.PlayerName + ')' : '' ): checkbox],
						[2, (item.GridPosition <= 0 ? loca.GetText("LAB", "YES"): '')],
						[1, (item.TotalArmy>0?item.TotalArmy:'')],
						[2, (item.Owner ? loca.GetText("LAB", "YES"): '')]
					]);
				}
				else{
						out += createTableRow([
						[9, !_exudGeneralsIsSelectable(item) ? '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + Icon + item.Name : checkbox],
						[2, (item.GridPosition <= 0 ? loca.GetText("LAB", "YES"): '')],
						[1, (item.TotalArmy>0?item.TotalArmy:'')]
					]);
				}
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
	$('#_exudGeneralsDivTable').html(out);
	
	$('#_exudGeneralsExcludeStarMenuFloatBtn').change(function(){
		_exudGeneralsExcludeStarMenu = !_exudGeneralsExcludeStarMenu;
		_exudMakeGeneralsTable();
	});
	var imgs = document.getElementById('_exudGeneralsDivTable').getElementsByTagName('img');
	var x = 0;
	for(x = 0; x < imgs.length ; x++)
	{
		imgs[x].addEventListener("click", function(e) {
				_exudGeneralsOpenSkillTree(e);
		});
	}
	
}

function _exudGeneralsOpenSkillTree(e)
{
	try {
		var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
		var Spec = _exudGeneralsFindByID(e.target.id.replace("exudSTIMG",""));
		if (Spec != null)
		{
		var General = _exudGeneralsGetGeneralStruct(Spec, PlayerID);
		if (General == null) return;
		document.getElementById('_exudGeneralsSkillTree').style.visibility = "visible";
		$("#_exudGeneralsSkillTree").css({left : e.target.parentElement.offsetLeft + 200 ,  top : e.target.parentElement.offsetTop, position:'absolute'}); 
		
		var out = '';
		out += '<table border="1" style="margin-left: 10px;margin-top: 5px;padding:5px"';
		var y = 0;
		var x = 0;
		for(y = 0; y < 5; y++)
		{
			out += "<tr>";
			for(x = 0; x < 4; x++)
				out += _exudGeneralsSkillTreeAddCell(General, x, y);
			out += "</tr>";
		}
		out += "</table>";
		out += '<div style="position: absolute;left: 220px;top: 1px;"><button" style="cursor: pointer;" id="_exudGeneralsSkillTreeCloseBtn">'+getImageTag("attackweakesttarget_negative.png")+'</button></div>';
		out += '</div>';	
		$("#_exudGeneralsSkillTree").html(out);
		
		
		$('#_exudGeneralsSkillTreeCloseBtn').click(function(){
			document.getElementById('_exudGeneralsSkillTree').style.visibility = "hidden";
		});

		}
	} catch (e) {}
}

function _exudGeneralsSkillTreeAddCell(General, x, y)
{
	var out = '';
	if (General.Skills != null && General.Skills.length > 0)
		General.Skills.forEach(function(item) {
				if (item[0].PositionX == x && item[0].PositionY == y)
				{
					var inum =  item[0].Level + "/" + item[0].MaxLevel;
					if (item[0].Level > 0)
						inum = "<b>" + inum + "</b>";
					out = "<td class='CellWithComment' align='center' width='50px' height='60px' style='background: "+(item[0].Level > 0 ? "#B2A500" : "#B2A589")+"'>";
					out += getImageTag(item[0].IconString, '24px', '24px') + "<br/>" + inum ;	
					out += "<span class='CellComment'>"+item[0].Description+"</span>";
					out + "</td>";
				}
		});
	
	return out;
}

function _exudGeneralsIsSelectable(S)
{
	return (S.Owner && !S.InUse && !S.Travelling)
}

function _exudGeneralsSaveData()
{
	var listS = new Array();
	$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) { 
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
	_exudMakeGeneralsTable(listS);	
	}

function _exudGeneralsGetChecked()
{
	var GensUID = new Array();
	try{
	$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) { 
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
		$('#udGeneralsModal').modal('hide');	
		showAlert(_exudGeneralsGetLabel("CommandSent"), false, 'success');			
	 }
	 catch (error) {
		 alert("send error : " + error.message);
	 }
}

function _exudGeneralsFindByID(id)
{
	try{
	var Specialists = swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector(); // Vector.<cSpecialist>	
	return _exudGetSpecialistbyUID(Specialists,id);
	}
	catch (e)
	{
	}
	return null;

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
		try{
			if (!SPECIALIST_TYPE.IsGeneral(item.GetType()))
				return;
			var General = _exudGeneralsGetGeneralStruct(item, PlayerID);
			if (General != null)
				listS.push(General);
		}
		catch (e) {
		}
	});
	
	try{
	if (listS.length > 1)
		listS.sort(_exudCompareGenerals);
	}
	catch (e) {
	}
		
	return listS;	
}

function _exudGeneralsGetGeneralStruct(item, PlayerID)
{

		try{
			i_pid = -1;
			i_pid = item.getPlayerID();		

			var s = {
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
				"GridPosition" : item.GetGarrisonGridIdx() ,
				"Skills" : _exudGeneralsGetSkills(item)
				};
			return s;
		}
		catch (e){}
	return null;
}
//this.skillIcon.source = gAssetManager.GetBitmap((_arg_1 as cSkill).getDefinition().icon_string);

function _exudGeneralsGetSkills(itemS)
{
		var SKILLS = new  Array();

	try{
		var ss = itemS.getSkillTree();
		if (ss == null) return null;
		// Vector.<cSkill>
		var id = 0;
		var sss = ss.getItems_vector();

		sss.forEach(function(item){
			var SKILL_DATA = new Array();
			SKILL_DATA.push({
							"Name" : item.getName(),
							"Description" : loca.GetText("LAB", item.getName()).replace("'", " ").replace('"', ' '),
							"ID" : item.getId(),
							"UnappliedPoints" : item.getUnappliedPoints(),
							"PositionX" : item.getPosition().x,
							"PositionY" : item.getPosition().y,
							"Level" : item.getLevel(),
							"MaxLevel" : item.getMaxLevel(),
							"SkillPointType" : item.getSkillPointType_string(),
							"IconString" : item.getDefinition().icon_string
							});
							
			SKILLS.push(SKILL_DATA);								
		});
	}
	catch (e)
	{
	}
		return SKILLS;
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
