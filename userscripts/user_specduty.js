const _exudspecDutyLang = { 
	"en-uk": {
		"menuItemName": "Spec Duty"  ,
		"menuTitle": "Specialists duty time"  ,
		"ColumnEstimated": "Estimated"  ,
		"ColumnArrival": "Arrival"  ,
		"NoData": "No data found!"  ,
		"YOU": "you",
		"HideShowGuest" : "Hide/Show Guest"
	},
	"pt-br": {
		"menuItemName": "Tarefas em andamento"  ,
		"menuTitle": "Tarefas em andamento dos especialistas"  ,
		"ColumnEstimated": "Estimado"  ,
		"ColumnArrival": "Chegada"  ,
		"NoData": "Nenhuma tarefa encontrada!"  ,
		"YOU": "Você",
		"HideShowGuest" : "Todos/Apenas meus"
	},
	"fr-fr": {
        	"menuItemName": "Tâches des Spécialistes"  ,
        	"menuTitle": "Temps d'exécution des Spécialistes"  ,
        	"ColumnEstimated": "Estimé"  ,
        	"ColumnArrival": "Arrivée"  ,
        	"NoData": "Pas d'information !",
        	"YOU": "Vous",
        	"HideShowGuest" : "Masquer/Afficher Invité(s)"
	},
	"it-it": {
		"menuItemName": "Azioni in corso"  ,
		"menuTitle": "Azioni in corso degli specialisti"  ,
		"ColumnEstimated": "Durata"  ,
		"ColumnArrival": "Arrivo"  ,
		"NoData": "Nessuna azione trovata!"  ,
		"YOU": "Tu",
		"HideShowGuest" : "Tutti/Solo i miei"
	},
	"es-es": {
		"menuItemName": "Especialistas"  ,
		"menuTitle": "Tareas de los especialistas"  ,
		"ColumnEstimated": "Duración"  ,
		"ColumnArrival": "Hora de llegada"  ,
		"NoData": "Sin datos"  ,
		"YOU": "Tú",
		"HideShowGuest" : "Todos/Solo míos"
	},
	"es-mx": {
		"menuItemName": "Especialistas"  ,
		"menuTitle": "Tareas de los especialistas"  ,
		"ColumnEstimated": "Duración"  ,
		"ColumnArrival": "Hora de llegada"  ,
		"NoData": "Sin datos"  ,
		"YOU": "Tú",
		"HideShowGuest" : "Todos/Solo míos"
	}
};
var _exudSpecDutyHideGuest = false;
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
			$('<button>').attr({ "id": "dutyHideShowGuestBtn", "class": "btn btn-primary pull-left dutyHideShowGuestBtn" }).text(_exudspecDutyGetLabel("HideShowGuest")),
		]);
		$('button.dutyExplorersBtn, button.dutyGeologistBtn, button.dutyGeneralsBtn').click(function(event) {
			_exudSpecDutyType = _exudBtnToSpecType[this.id];
			$('#_exudDutyResultDiv').html(dutyGetData());
		});
		$('button.dutyHideShowGuestBtn').click(function(event) {
			_exudSpecDutyHideGuest = !_exudSpecDutyHideGuest;
			$('#_exudDutyResultDiv').html(dutyGetData());
		});
	}
	if($('#dutyModal .modal-header .container-fluid').length == 0)
	{
		$('#dutyModal .modal-header').append('<div class="container-fluid"><br>' + createTableRow([
			[4, loca.GetText("LAB","Name")],
			[4, loca.GetText("LAB","TriggerRequiredActiveQuest")],
			[2, _exudspecDutyGetLabel("ColumnEstimated")],
			[2, _exudspecDutyGetLabel("ColumnArrival")]
			], true) + '</div>'
		);
	}
	// fill modal data 
	_exudSpecDutyType = (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone ? 3 : 1);

	$('#dutyExplorersBtn').attr("disabled", swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone);
	$('#dutyGeologistBtn').attr("disabled", swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone);


	$('#dutyModalData').html('<div class="container-fluid"><div id="_exudDutyResultDiv">'+dutyGetData()+'</div></div>');
	
	$("#dutyModal .modal-footer .btn-danger").html(loca.GetText("LAB", "Close"));
	// show modal
	$('#dutyModal:not(:visible)').modal({ backdrop: "static" });

}

function _exudspecDutyGetLabel(id)
{
	if(!_exudspecDutyLang[idL] && !_exudspecDutyLang["en-uk"][id]) { return "RES not found : " + id; }
	return _exudspecDutyLang[idL] && _exudspecDutyLang[idL][id] ? _exudspecDutyLang[idL][id] : _exudspecDutyLang["en-uk"][id];
}	

function dutyGetData() {
	out = '';
	var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
	isThereAnySpec = false;
	var listSpec = new Array();
	var mySpecTot = 0;
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().sort(0).forEach(function(item){
		var isValid = item.GetBaseType() == _exudSpecDutyType || (_exudSpecDutyType == 3 && _exudDutySPECIALIST_TYPE.IsGeneral(item.GetType()));
		if(item.GetTask() == null || !isValid) { return; }
		var ItemName = item.getName(false);
		var i_pid = -1;
		try{
			i_pid = item.getPlayerID();
		}
		catch (e) {
		}
		if ((PlayerID == item.getPlayerID()) || !_exudSpecDutyHideGuest)
			{
				var pname = "";
				if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone)
				{
					if (PlayerID == i_pid)
					{
						++mySpecTot;
						pname = _exudspecDutyGetLabel("YOU");
					}
					
					try{
						if(_exudSpecDutyType == 3 && i_pid > 0 && PlayerID != i_pid) {
							pname = swmmo.application.mGameInterface.GetPlayerName_string(i_pid);
						}
					} catch (e) {} 
				}			
				
				if (pname != null && pname != "")
					ItemName += ' ({0})'.format(pname);
				
				if(_exudSpecDutyType != 3) {
					task = loca.GetText("LAB", item.GetTask().getTaskDefinition().mainTask.taskName_string+item.GetTask().getTaskDefinition().taskType_string);
				} else {
					task = loca.GetText("LAB", "SpecialistTask8");
				}
				listSpec.push( [ ItemName , item.GetTask().GetRemainingTime(), getImageTag(item.getIconID(), '10%'), task  ]  );
				isThereAnySpec = true;
			}
	});
	
	$('#dutyModal .modal-title').html( 
							(_exudSpecDutyType == 1 ? getImageTag('IntrepidExplorer') : _exudSpecDutyType == 2 ? getImageTag('icon_geologist.png') : getImageTag('icon_general.png'))
							+ ' ' 
							+ _exudspecDutyGetLabel("menuTitle") 
							+ ( mySpecTot > 0 ? " (" + mySpecTot + ")" : "")
							+ (  swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone ?	' : ' + loca.GetText("ADN", swmmo.application.mGameInterface.getAdventureName()) : 
								(swmmo.application.mGameInterface.isOnHomzone() ? '' : " (" + swmmo.application.mGameInterface.mHomePlayer.GetPlayerName_string() + " - " + swmmo.application.mGameInterface.mHomePlayer.GetPlayerLevel() + ")")
							  )
						);	
	
	if(!isThereAnySpec)
		return out + _exudspecDutyGetLabel("NoData");

	listSpec.sort(dutyCompare);
	listSpec.forEach(function(item){
		out += createTableRow([
			[4,item[2] + item[0]],
			[4, item[3]],
			[2, (item[1] > 0 ? loca.FormatDuration(item[1], 1) : "")],
			[2, (item[1] > 0 ? dtf.format(new window.runtime.Date(Date.now() + item[1])) : "")]
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
