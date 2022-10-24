
// ========== Generals COMMAND
/*
Green send
Blue for all
Red for ? 
*/

addToolsMenuItem("Generals", _exudGeneralsMenuHandler);

var _exudGeneralsSortType = 0; // 0 = type/name  1 = name/type
var _exudGeneralsHideGuest = false;
var _exudGeneralsHideUnselected = false;

function _exudGeneralsMenuHandler(event)
{
	// close all modals
	$( "div[role='dialog']:not(#udSpecModal):visible").modal("hide");
	// check if modal window already exist
	if($("#udSpecModal").length == 0)
	{
		// create new one by copying buffmodal
		$("#buffModal").clone().attr('id', 'udSpecModal').appendTo(".container");
		// change title
		$("#udSpecModal .modal-title").text("Generals");
		// change data id
		$("#udSpecModal .modal-body").attr('id', 'udSpecModalData');
		// remove buttons except close
		$("#udSpecModal .modal-footer button:not(.btn-danger)").remove();
		// add flipflop
		$("#udSpecModal").on('show.bs.modal hide.bs.modal', function(){ window.nativeWindow.stage.swapChildrenAt(0, 1); });
	}

	_exudGetGeneralsData();

	$('#udSpecModal:not(:visible)').modal({backdrop: "static"});
}

function _exudGetGeneralsData() {

	var out = '';
	var GI = null;
	var CPZ_ID = 0;
	var AdvManager = null;
	var PlayerID = 0;
	var isAdventureZone = false;
	var Adventures = null;
	var hasAdv = false;


	try {
		GI = swmmo.application.mGameInterface;
		CPZ_ID = GI.mCurrentViewedZoneID;
		AdvManager = swmmo.getDefinitionByName("com.bluebyte.tso.adventure.logic::AdventureManager").getInstance();
		PlayerID = GI.mCurrentPlayer.GetPlayerId();
		isAdventureZone = GI.mCurrentPlayer.mIsAdventureZone;
		Adventures = AdvManager.getAdventures(); //Vector.<dAdventureClientInfoVO>
		hasAdv = (Adventures != null && Adventures.length > 0);
		
		out += 'Send to <select id="udcboSendZones">';
		out += '<option value="-1">-----</option>';
		out += '<option value="98">Star Menu</option>';
		
		if (isAdventureZone)
			out += '<option value="99">Home</option>';

		if (hasAdv)
		{
			var y = 0;
			for(y = 0 ; y < Adventures.length; y++)
			{
				var A = Adventures[y];
				if (A.zoneID != CPZ_ID)
				{
					if (A.ownerPlayerID == PlayerID)
						out += '<option value="'+y+'">'+A.adventureName+'</option>';
					else
						out += '<option value="'+y+'">*'+A.adventureName+'</option>';
				}
					
			}
		}
		
		out += '</select> (* = guest)';
		out += ' <button type="button" class="btn btn-sm _exudSendGeneralsBtn">Send</button>';
		out += ' <button type="button" class="btn btn-sm _exudSelectAllGeneralsBtn">Select All</button>';
		out += ' <button type="button" class="btn btn-sm _exudChangeGeneralSortBtn">' + (_exudGeneralsSortType == 0 ? 'Sort by name' : 'Sort by Type')+'</button>';

		out += ' <button type="button" class="btn btn-sm _exudHideGuestGeneralsBtn">'+(_exudGeneralsHideGuest  ? 'Show  Guest' : 'Hide Guest')+'</button>';
		out += ' <button type="button" class="btn btn-sm _exudHideUnselectedGeneralsBtn">'+(_exudGeneralsHideUnselected ? 'Show Unselected' : 'Hide Unselected')+'</button>';


		out += ' <button type="button" class="btn btn-sm _exudSpecLoadTemplateBtn">Load</button>';
		out += ' <button type="button" class="btn btn-sm _exudSpecSaveTemplateBtn">Save</button>';
		out += '</br>';
		
		out += '<div id="_exudGeneralsDivTable">';
		out += _exudMakeGeneralsTable(null);
		out += '</div>';
		
	}
	catch (error) {
		alert(error.message);
	}
	
	out = '<div class="container-fluid" id="exSpecMainDiv">' + out + '</div>';
	$('#udSpecModalData').html(out);
	
	$('#udSpecModalData ._exudSendGeneralsBtn').click(_exudGeneralsSend);
	$('#udSpecModalData ._exudSelectAllGeneralsBtn').click(_exudSelectAllGenerals);
	$('#udSpecModalData ._exudSpecLoadTemplateBtn').click(_exudGeneralsLoadData);
	$('#udSpecModalData ._exudSpecSaveTemplateBtn').click(_exudGeneralsSaveData);
	$('#udSpecModalData ._exudChangeGeneralSortBtn').click(_exudChangeGeneralSort);
	$('#udSpecModalData ._exudHideGuestGeneralsBtn').click(_exudChangeHideGuestGenerals);
	$('#udSpecModalData ._exudHideUnselectedGeneralsBtn').click(_exudChangeHideUnselectedGenerals);
}

function _exudChangeHideGuestGenerals()
{
	_exudGeneralsHideGuest = !_exudGeneralsHideGuest;
	$('#udSpecModalData ._exudHideGuestGeneralsBtn').html((_exudGeneralsHideGuest  ? 'Show Guest' : 'Hide Guest'));
		_exudRefreshGeneralsTable();

}
function _exudChangeHideUnselectedGenerals()
{
	_exudGeneralsHideUnselected = !_exudGeneralsHideUnselected;
	$('#udSpecModalData ._exudHideUnselectedGeneralsBtn').html((_exudGeneralsHideUnselected ? 'Show Unselected' : 'Hide Unselected'));
		_exudRefreshGeneralsTable();
}

function _exudChangeGeneralSort() {
	if (++_exudGeneralsSortType == 2)
		_exudGeneralsSortType = 0;

	$('#udSpecModalData ._exudChangeGeneralSortBtn').html((_exudGeneralsSortType == 0 ? 'Sort by Name' : 'Sort by Type'));
	
	_exudRefreshGeneralsTable();
}

function _exudRefreshGeneralsTable()
{
	var checks = _exudGeneralsGetChecked();
	
	var out = _exudMakeGeneralsTable(checks);
	$('#_exudGeneralsDivTable').html(out);
}

function _exudMakeGeneralsTable(Selected) {

	var out = '';

	try {	
		out = '<table id="udSpecTable"><tr>';	
		out += '<td width="350px">Name</td>';
		out += '<td width="80px">Has Units</td>';
		out += '<td width="80px">Has Elites</td>';
		out += '<td width="100px">Total Army</td>';
		out += '<td width="80px">Owner</td>';
		out += '</tr>'; 
		
		var y = 0;
		var listS = _exudGetSpecialists();
				
		for(y = 0 ; y < listS.length ; y++)
		{
			try {
				var S = listS[y];
				if (_exudGeneralsHideGuest &&  !S.Owner) continue;
				if (_exudGeneralsHideUnselected && Selected != null && Selected.indexOf(S.UID)<0) continue;
				
				out += '<tr>'; 

				if (_exudGeneralsIsSelectable(S))
					out += '<td><input type="checkbox" id="udSpecChk_'+S.UID+'"'+(Selected != null && Selected.indexOf(S.UID)>=0?' checked':'')+'/> '+S.Name+'</td>';
				else
					out += '<td>   '+S.Name+'</td>';
			
				out += '<td>'+(S.HasUnits ? 'yes' : '')+'</td>';
				out += '<td>'+(S.HasElites ? 'yes' : '')+'</td>';
				out += '<td>'+(S.TotalArmy>0?S.TotalArmy:'')+'</td>';
				out += '<td>'+(S.Owner ? 'yes': '')+'</td>';
				out += '</tr>'; 
			}
			catch (error2) {
			}
		}
		
		out += '</table>';
		
	}
	catch (error) {
		alert(error.message);
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
		var checks = document.getElementById('_exudGeneralsDivTable').getElementsByTagName('input');
		if (checks.length > 0)
		 {
			 for(y = 0 ; y < checks.length ; y++)
			 {
				 var c = checks[y];
				if (c.type == "checkbox" &&  _exudGeneralsIsMyCheck(c) && c.checked)
					 listS.push(c.id); 
			 }
		 }
		 
		if (listS.length > 0)
		{
			var dataToSave = JSON.stringify(listS);
			var file = new air.File(readLastDir('genspec')).resolvePath("specGenerals.txt");
			file.addEventListener(air.Event.COMPLETE, _exudGenTemplateSaved); 
			file.save(dataToSave);
		}
}
function _exudGenTemplateSaved(event) 
{ 
    saveLastDir('genspec', event.target.parent.nativePath); 
}
function _exudGeneralsLoadData()
{
	file = new air.File(readLastDir('genspec'));
	txtFilter = new air.FileFilter("All files", "*.*"); 
	file.browseForOpen("Open", [txtFilter]); 
	file.addEventListener(air.Event.SELECT, _exudGenloadTemplateComplete); 
}
function _exudGenloadTemplateComplete(event)
{
	event.target.addEventListener(air.Event.COMPLETE, _exudGenLoadTemplateLoaded); 
	event.target.load();
}
function _exudGenLoadTemplateLoaded(event)
{
	var listS;
	try{
	  listS = JSON.parse(event.target.data);
	} catch(e) {
	  alert("Bad template file");
	  return;
	}
	
		var checks = document.getElementById('_exudGeneralsDivTable').getElementsByTagName('input');
		
		if (checks.length > 0)
		 {
			 for(y = 0 ; y < checks.length ; y++)
			 {
				 var c = checks[y];
				 try {
					 
					 if (c.type == "checkbox" &&  _exudGeneralsIsMyCheck(c))
					 {
						
						c.checked = (listS.indexOf(c.id)>=0);
					 }
				 }
				 catch(e) {}
			 }
		 }
}

function _exudSelectAllGenerals()
{
		var checks = document.getElementById('_exudGeneralsDivTable').getElementsByTagName('input');
		if (checks.length > 0)
		 {
			 for(y = 0 ; y < checks.length ; y++)
			 {
				 var c = checks[y];
				 if (c.type == "checkbox" &&  _exudGeneralsIsMyCheck(c) && !c.checked)
					c.checked = true;
			 }
		 }
}

function _exudGeneralsGetChecked()
{
	var GensUID = new Array();
	var checks = document.getElementById('_exudGeneralsDivTable').getElementsByTagName('input');

	if (checks.length > 0)
		for(y = 0 ; y < checks.length ; y++)
		{
			try{
				
				var c = checks[y];
				
				if (c.type == "checkbox" && c.checked && _exudGeneralsIsMyCheck(c) )
					 GensUID.push(c.id.replace('udSpecChk_', '')); 

			}
			catch (e) {alert(e.message);}
		}
	return GensUID;
}

function _exudGeneralsIsMyCheck(c)
{
	try{
		return (c.id.substr(0,10) == 'udSpecChk_');
	}
	catch (e) {
		
	}
}

function _exudGeneralsSend()
{

	 try {
		var OptionSelected = $('#udcboSendZones option:selected').val();
		if (OptionSelected == -1) return;
		var AdvManager = swmmo.getDefinitionByName("com.bluebyte.tso.adventure.logic::AdventureManager").getInstance();
		var checkedUID = _exudGeneralsGetChecked();
		var GI = swmmo.application.mGameInterface;
		var CPZ = GI.mCurrentPlayerZone;	
		var Specialists = CPZ.GetSpecialists_vector(); // Vector.<cSpecialist>		
		var Adventures = AdvManager.getAdventures();
		var y = 0;
		var GHZ_ID = GI.mCurrentPlayer.GetHomeZoneId();
		
		if (checkedUID.length > 0)
		 {
			 for(y = 0 ; y < checkedUID.length ; y++)
			 {
				 try {
					 var suid = checkedUID[y];
					 var S = _exudGetSpecialistbyUID(Specialists,suid);
					 if (S != null)
					 {
						 switch(OptionSelected)
						 {
							 case '0':  // adv 0
								 _exudSendToZone( S, Adventures[0].zoneID);
								break;
							 case '1': // adv 1
								 _exudSendToZone(S, Adventures[1].zoneID);
								break;
							 case '98': // star menu
								if (S.GetGarrisonGridIdx() > 0) // not in star menu
									_exudSendGeneralToStar(S);//setTimeout(_exudSendGeneralToStar, offset_func, S);
								break;
							 case '99': // home
								 _exudSendToZone( S, GHZ_ID);
								break;
							default:
								break;
						 }
					 }
				 }
				 catch (error2) {
					 alert(error2.message);
				 }												 
			 }

			$('#udSpecModal').modal('hide');	
			showAlert("Command Sent", false, 'success');			
		 }
		 
	 }
	 catch (error) {
		 alert(error.message);
	 }
}

function _exudSendToZone(S, Z)
{
	try{
	var Services = swmmo.getDefinitionByName("com.bluebyte.tso.service::ServiceManager").getInstance();
	Services.specialist.sendToZone(S,Z);
	}
	catch (error) {
	}
}

function _exudSendGeneralToStar(S)
{
	try {			
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
	}
}


function _exudGetSpecialistbyUID(specs, uid)
{
	try {
	var y = 0;
	for(y = 0 ; y < specs.length ; y++)
		try{
		if (specs[y].GetUniqueID().toKeyString() == uid)
			return specs[y];
		}
		catch (error2) {
		}
	}
	catch (error) {
	}
		
	return null;
}

function _exudGetSpecialists()
{
		var GI = swmmo.application.mGameInterface;
		var CPZ = GI.mCurrentPlayerZone;	
		var SPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
		var Specialists = CPZ.GetSpecialists_vector(); // Vector.<cSpecialist>
		var PlayerID = GI.mCurrentPlayer.GetPlayerId();

		var y = 0;
		var listS = new Array();
		
		for(y = 0 ; y < Specialists.length ; y++)
		{
			var S = Specialists[y];
			if (!SPECIALIST_TYPE.IsGeneral(S.GetType()))
				continue;

			try {
				var army = S.GetArmy();
				
			const iS = {
				"UID" : S.GetUniqueID().toKeyString(),
				"BaseType" : S.GetBaseType(),
				"HasElites" : army.HasEliteUnits(),
				"HasUnits" : S.HasUnits(),
				"Name" : S.getName(false).replace('<b>', '').replace('</b>',''),
				"PlayerID" : S.getPlayerID(),
				"Type" : S.GetType(),
				"XP" : S.GetXP(),
				"Travelling" : S.isTravellingAway(),
				"InUse": S.IsInUse(),
				"Owner" : (PlayerID == S.getPlayerID()),
				"IsGeneral" : SPECIALIST_TYPE.IsGeneral(S.GetType()),
				"TotalArmy" : army.GetUnitsCount()
				};
			listS.push(iS);
			
			}
			catch (error) {
			}
		}
		
		if (listS.length > 1)
			listS.sort(_exudCompareGenerals);
		
		return listS;
}

function _exudCompareGenerals( a, b ) {
	try{
		if (!b.Owner && a.Owner) return -1;
		if (!a.Owner && b.Owner) return 1;
		if (a.IsGeneral && !b.IsGeneral) return -1;
		if (!a.IsGeneral && b.IsGeneral) return 1;
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
