const _exudspecDutyLang = { 
	"en-uk": {
		"menuItemName": "Spec Duty"  ,
		"menuTitle": "Specialists duty time"  ,
		"ColumnEstimated": "Estimated"  ,
		"ColumnArrival": "Arrival"  ,
		"NoData": "No data found!" 
	},
	"pt-br": {
		"menuItemName": "Tarefas Ativas"  ,
		"menuTitle": "Tempo das tarefas dos especialistas"  ,
		"ColumnEstimated": "Estimado"  ,
		"ColumnArrival": "Chegada"  ,
		"NoData": "Nenhuma tarefa encontrada!" 
	}
};
var _exudSpecDutyType = 1; // 1 = explorer 2 = geologist 3 = generals
var _exudDutySPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
var _exudBtnToSpecType = { 'dutyExplorersBtn': 1,'dutyGeologistBtn': 2,'dutyGeneralsBtn': 3 };
var idL = loca.getSelectedLanguage();			
addToolsMenuItem(_exudspecDutyGetLabel("menuItemName"), specDutyTime);

function specDutyTime(event) {
	// close all modals
	$("div[role='dialog']:not(#dutyModal):visible").modal("hide");
	// create modal
	createModalWindow('dutyModal', _exudspecDutyGetLabel("menuTitle"));
	if($('#dutyModal .modal-footer .dutyExplorersBtn').length == 0)
	{
		$("#dutyModal .modal-footer").prepend([
			$('<button>').attr({ "id": "dutyExplorersBtn", "class": "btn btn-primary pull-left dutyExplorersBtn" }).text(loca.GetText("SPE", "Explorer")),
			$('<button>').attr({ "id": "dutyGeologistBtn", "class": "btn btn-primary pull-left dutyGeologistBtn" }).text(loca.GetText("SPE", "Geologist")),
			$('<button>').attr({ "id": "dutyGeneralsBtn", "class": "btn btn-primary pull-left dutyGeneralsBtn" }).text(loca.GetText("SPE", "General")),
		]);
		$('button.dutyExplorersBtn, button.dutyGeologistBtn, button.dutyGeneralsBtn').click(function(event) {
			_exudSpecDutyType = _exudBtnToSpecType[this.id];
			$('#_exudDutyResultDiv').html(dutyGetData());
		});
	}
	// fill modal data 
	$('#dutyModalData').html('<div class="container-fluid"><div id="_exudDutyResultDiv">'+dutyGetData()+'</div></div>');
	// show modal
	$('#dutyModal:not(:visible)').modal({ backdrop: "static" });

}

function _exudspecDutyGetLabel(id)
{
	if(!_exudspecDutyLang[idL] && !_exudspecDutyLang["en-uk"][id]) { return "RES not found : " + id; }
	return _exudspecDutyLang[idL] && _exudspecDutyLang[idL][id] ? _exudspecDutyLang[idL][id] : _exudspecDutyLang["en-uk"][id];
}	

function dutyGetData() {
	out = createTableRow([
			[4, loca.GetText("LAB","Name")],
			[4, loca.GetText("LAB","TriggerRequiredActiveQuest")],
			[2, _exudspecDutyGetLabel("ColumnEstimated")],
			[2, _exudspecDutyGetLabel("ColumnArrival")]
	], true);
	var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
	isThereAnySpec = false;
	var listSpec = new Array();
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().sort(0).forEach(function(item){
		var isValid = item.GetBaseType() == _exudSpecDutyType || (_exudSpecDutyType == 3 && _exudDutySPECIALIST_TYPE.IsGeneral(item.GetType()));
		if(item.GetTask() == null || !isValid) { return; }
		var ItemName = item.getName(false);
		try{
		if(_exudSpecDutyType == 3 && PlayerID != item.getPlayerID()) {
			var pname = swmmo.application.mGameInterface.GetPlayerName_string(item.getPlayerID());
			if (pname != null)
				ItemName += ' (' + pname + ')';
		}
		} catch (e) {} // looking for something better
		if(_exudSpecDutyType != 3) {
			task = loca.GetText("LAB", item.GetTask().getTaskDefinition().mainTask.taskName_string+item.GetTask().getTaskDefinition().taskType_string);
		} else {
			task = loca.GetText("LAB", "SpecialistTask8");
		}
		listSpec.push( [ ItemName , item.GetTask().GetRemainingTime(), getImageTag(item.getIconID(), '10%'), task  ]  );
		isThereAnySpec = true;
	});
	
	if(!isThereAnySpec)
		return out + _exudspecDutyGetLabel("NoData");

	listSpec.sort(dutyCompare);
	listSpec.forEach(function(item){
		out += createTableRow([
			[4, item[2] + item[0]],
			[4, item[3]],
			[2, loca.FormatDuration(item[1], 1)],
			[2, dtf.format(new window.runtime.Date(Date.now() + item[1]))]
		]);
	});
	
	return out;
}

function dutyCompare(a, b)
{
	try{
		if (a[1] > b[1]) return 1;
		if (a[1] < b[1]) return -1;
		return a[0].toLowerCase().localCompare(b[0].toLowerCase());
	}
	catch (e) {}
	return 0;
}