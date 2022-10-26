
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
        "ColumnOwner": "Owner"
    },
    "pt-br": {
        "ByName": "Classificar por nome",
        "ByType": "Classificar por tipo",
        "ShowGuest": "Todos",
        "HideGuest": "Somente os meus",
        "ShowUnselected": "Todos",
        "HideUnselected": "Somente selecionados",
        "SelectAll": "Selecionar todos",
        "Load": "Carregar",
        "ColumnOwner": "Proprietario"
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
    }
};

addToolsMenuItem(loca.GetText("ACL", "MilitarySpecialists"), _exudGeneralsMenuHandler);

var _exudGeneralsSortType = 0; // 0 = type/name  1 = name/type
var _exudGeneralsHideGuest = false;
var _exudGeneralsHideUnselected = false;
var _exudGeneralsToggleselected = false;
var idL = loca.getSelectedLanguage();

function _exudGeneralsGetLabel(id)
{
	if(!_exudGeneralsLang[idL] && !_exudGeneralsLang["en-uk"][id]) { return "RES not found : " + id; }
	return _exudGeneralsLang[idL] && _exudGeneralsLang[idL][id] ? _exudGeneralsLang[idL][id] : _exudGeneralsLang["en-uk"][id];
}	

function _exudGeneralsMenuHandler(event)
{
	$('#udSpecModal').remove();
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
	}
	_exudGetGeneralsData();

	$('#udSpecModal:not(:visible)').modal({backdrop: "static"});
}

function _exudGetGeneralsData()
{
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
		
		out = select.prop("outerHTML") + ' (* = guest) ';
		out += $('<button>').attr({ "class": "btn btn-sm _exudSelectAllGeneralsBtn" }).text(
			_exudGeneralsGetLabel("SelectAll")
		).prop("outerHTML") + ' ';
		out += $('<button>').attr({ "class": "btn btn-sm _exudChangeGeneralSortBtn" }).text(
			_exudGeneralsSortType == 0 ? _exudGeneralsGetLabel("ByName") : _exudGeneralsGetLabel("ByType")
		).prop("outerHTML") + ' ';
		out += $('<button>').attr({ "class": "btn btn-sm _exudHideGuestGeneralsBtn" }).text(
			_exudGeneralsHideGuest  ? _exudGeneralsGetLabel("ShowGuest") : _exudGeneralsGetLabel("HideGuest")
		).prop("outerHTML") + ' ';
		out += $('<button>').attr({ "class": "btn btn-sm _exudHideUnselectedGeneralsBtn" }).text(
			_exudGeneralsHideUnselected ? _exudGeneralsGetLabel("ShowUnselected") : _exudGeneralsGetLabel("HideUnselected")
		).prop("outerHTML") + ' ';
		
		out += '</br></br><div id="_exudGeneralsDivTable">{0}</div>'.format(_exudMakeGeneralsTable());

	} catch (error) {
		alert(error.message);
	}
	
	$('#udSpecModalData').html('<div class="container-fluid" id="exSpecMainDiv">' + out + '</div>');

	$('#udSpecModalData ._exudSelectAllGeneralsBtn').click(function() {
		_exudGeneralsToggleselected = !_exudGeneralsToggleselected;
		$('#udSpecModalData input[type="checkbox"]').each(function(i, item) { 
			item.checked = _exudGeneralsToggleselected;	
		});
	});

	$('#udSpecModalData ._exudChangeGeneralSortBtn').click(function(){
		if (++_exudGeneralsSortType == 2)
			_exudGeneralsSortType = 0;
		$('#udSpecModalData ._exudChangeGeneralSortBtn').html(_exudGeneralsSortType == 0 ? _exudGeneralsGetLabel("ByName") : _exudGeneralsGetLabel("ByType"));
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});
	$('#udSpecModalData ._exudHideGuestGeneralsBtn').click(function(){
		_exudGeneralsHideGuest = !_exudGeneralsHideGuest;
		$('#udSpecModalData ._exudHideGuestGeneralsBtn').html(_exudGeneralsHideGuest  ?_exudGeneralsGetLabel("ShowGuest") : _exudGeneralsGetLabel("HideGuest"));
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});
	$('#udSpecModalData ._exudHideUnselectedGeneralsBtn').click(function(){
		_exudGeneralsHideUnselected = !_exudGeneralsHideUnselected;
		$('#udSpecModalData ._exudHideUnselectedGeneralsBtn').html(_exudGeneralsHideUnselected ? _exudGeneralsGetLabel("ShowUnselected") : _exudGeneralsGetLabel("HideUnselected"));
		$('#_exudGeneralsDivTable').html(_exudMakeGeneralsTable());
	});
}

function _exudMakeGeneralsTable()
{
	var Selected = _exudGeneralsGetChecked();
	var out = createTableRow([
		[4, loca.GetText("LAB","Name")],
		[3, loca.GetText("LAB", "EliteUnits")],
		[3, loca.GetText("LAB", "Army")],
		[2, _exudGeneralsGetLabel("ColumnOwner")]
	], true);
	_exudGetSpecialists().forEach(function(item){
		if (_exudGeneralsHideGuest && !item.Owner) return;
		if (_exudGeneralsHideUnselected && Selected.indexOf(item.UID)<0) return;
		var checkbox = '<input type="checkbox" id="{0}"{1}/> {2}'.format(item.UID, (Selected.indexOf(item.UID) >= 0 ? ' checked' : ''), item.Name);
		out += createTableRow([
			[4, !_exudGeneralsIsSelectable(item) ? item.Name : checkbox],
			[3, (item.HasElites ? loca.GetText("LAB", "YES"): '')],
			[3, (item.TotalArmy>0?item.TotalArmy:'')],
			[2, (item.Owner ? loca.GetText("LAB", "YES"): '')]
		]);
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
	var listS = [];
	try{
	  listS = JSON.parse(event.target.data);
	} catch(e) {
	  alert("Bad template file");
	  return;
	}
	$('#udSpecModalData input[type="checkbox"]').each(function(i, item) { 
		item.checked = listS.indexOf(item.id) >= 0;
	});
}

function _exudGeneralsGetChecked()
{
	var GensUID = new Array();
	$('#udSpecModalData input[type="checkbox"]').each(function(i, item) { 
		if(item.checked) {
			GensUID.push(item.id); 
		}
	});
	return GensUID;
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
		 alert(error.message);
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
	catch (error) {	}
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
		listS.push({
			"UID" : item.GetUniqueID().toKeyString(),
			"BaseType" : item.GetBaseType(),
			"HasElites" : item.GetArmy().HasEliteUnits(),
			"HasUnits" : item.HasUnits(),
			"Name" : item.getName(false).replace('<b>', '').replace('</b>',''),
			"PlayerID" : item.getPlayerID(),
			"Type" : item.GetType(),
			"XP" : item.GetXP(),
			"Travelling" : item.isTravellingAway(),
			"InUse": item.IsInUse(),
			"Owner" : (PlayerID == item.getPlayerID()),
			"IsGeneral" : true,
			"TotalArmy" : item.GetArmy().GetUnitsCount()
		});
	});
	if (listS.length > 1)
		listS.sort(_exudCompareGenerals);
		
	return listS;	
}

function _exudCompareGenerals( a, b ) {
	try{
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
	}
	return 0;
}
