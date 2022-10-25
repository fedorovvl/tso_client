

const _exudspecDutyLang = [ 
								[ ["en-uk"] , 
									[
										[ "menuItemName", "Spec Duty" ] ,
										[ "menuTitle", "Specialists duty time" ] ,
										[ "ColumnEstimated", "Estimated" ] ,
										[ "ColumnArrival", "Arrival" ] ,
										[ "NoData", "No data found!" ] 
									]
								] ,
								[ ["pt-br"] , 
									[
										[ "menuItemName", "Tarefas Ativas" ] ,
										[ "menuTitle", "Tempo das tarefas dos especialistas" ] ,
										[ "ColumnEstimated", "Estimado" ] ,
										[ "ColumnArrival", "Chegada" ] ,
										[ "NoData", "Nenhuma tarefa encontrada!" ] 
									]
								]
						];
						
						
addToolsMenuItem(_exudspecDutyGetLabel("menuItemName"), specDutyTime);

function specDutyTime(event) {
	// close all modals
	$("div[role='dialog']:not(#dutyModal):visible").modal("hide");
	// create modal
	createModalWindow('dutyModal', _exudspecDutyGetLabel("menuTitle"));
	// change data id
	$("#dutyModal .modal-body").attr('id', 'dutyModalData');
	// fill modal data 
	dutySetMainWindow();
	// show modal
	$('#dutyModal:not(:visible)').modal({ backdrop: "static" });

}

var _exudSpecDutyType = 1; // 1 = explorer 2 = geologist 3 = generals
var _exudDutySPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");

function _exudspecDutyGetLabel(id)
{
	
	var idL = loca.getSelectedLanguage();
	var ls = _exudspecDutyGetLanguage(idL);
	
	var y = 0;

	for(y = 0 ; y < ls.length ; y++)
		if (ls[y][0] == id)
			return ls[y][1];

	return "RES not found : " + id;
}	

function _exudspecDutyGetLanguage(id)
{
	
	var y = 0;
	for(y = 0 ; y < _exudspecDutyLang.length ; y++)
		if (_exudspecDutyLang[y][0] == id)
			return _exudspecDutyLang[y][1];
		
	return _exudspecDutyLang[0][1]; // English default
}


function dutySetMainWindow()
{
	out = '<div class="container-fluid"><button type="button" id="dutyExplorersBtn" class="btn btn-primary dutyExplorersBtn">'+loca.GetText("SPE", "Explorer")+'</button>';
	out += ' <button type="button" class="btn btn-primary dutyGeologistBtn">'+loca.GetText("SPE", "Geologist")+'</button>';
	out += ' <button type="button" class="btn btn-primary dutyGeneralsBtn">'+loca.GetText("SPE", "General")+'</button>';
	out += '<br/>';	
	out += '<div id="_exudDutyResultDiv"></div></div>';

	
	$('#dutyModalData').html(out);

	$('#dutyModalData .dutyExplorersBtn').click(dutySelectExplorers);
	$('#dutyModalData .dutyGeologistBtn').click(dutySelectGeologists);
	$('#dutyModalData .dutyGeneralsBtn').click(dutySelectGenerals);

}

function dutySelectExplorers()
{
	$('#dutyModalData .dutyExplorersBtn').html("<b>"+loca.GetText("SPE", "Explorer")+"</b>");
	$('#dutyModalData .dutyGeologistBtn').html(loca.GetText("SPE", "Geologist"));
	$('#dutyModalData .dutyGeneralsBtn').html(loca.GetText("SPE", "General"));
	_exudSpecDutyType = 1;
	$('#_exudDutyResultDiv').html(dutyGetData());
}

function dutySelectGeologists()
{
	$('#dutyModalData .dutyExplorersBtn').html(loca.GetText("SPE", "Explorer"));
	$('#dutyModalData .dutyGeologistBtn').html("<b>"+loca.GetText("SPE", "Geologist")+"</b>");
	$('#dutyModalData .dutyGeneralsBtn').html(loca.GetText("SPE", "General"));
	
	_exudSpecDutyType = 2;
	$('#_exudDutyResultDiv').html(dutyGetData());
}

function dutySelectGenerals()
{
	$('#dutyModalData .dutyExplorersBtn').html(loca.GetText("SPE", "Explorer"));
	$('#dutyModalData .dutyGeologistBtn').html(loca.GetText("SPE", "Geologist"));
	$('#dutyModalData .dutyGeneralsBtn').html("<b>"+loca.GetText("SPE", "General")+"</b>");
	_exudSpecDutyType = 3;
	$('#_exudDutyResultDiv').html(dutyGetData());
}

function dutyGetData() {
	out = '<div><div class="row"><div class="col-xs-6 col-sm-6 col-lg-6"  style="background-color:gray;height:23px">'+loca.GetText("LAB","Name")+'</div><div class="col-xs-3 col-sm-3 col-lg-3"  style="background-color:gray;height:23px">'+_exudspecDutyGetLabel("ColumnEstimated")+'</div><div class="col-xs-3 col-sm-3 col-lg-3 massSend" style="background-color:gray;height:23px">'+_exudspecDutyGetLabel("ColumnArrival")+'</div></div>';
	var GI = swmmo.application.mGameInterface;
	var PlayerID = GI.mCurrentPlayer.GetPlayerId();
	isThereAnySpec = false;
	var listSpec = new Array();
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().sort(0).forEach(function(item){
	var isValid = false;
	var ItemName = item.getName(false);
	
		switch(_exudSpecDutyType) {
			case 1:
				isValid = (item.GetBaseType() == 1);
				break;
			case 2:
				isValid = (item.GetBaseType() == 2);
				break;
			case 3:
				var pid = item.getPlayerID();
				isValid = (_exudDutySPECIALIST_TYPE.IsGeneral(item.GetType()) && (pid == PlayerID));
				/** I see it later
				if (isValid && (PlayerID != pid))
				{
					var pname = GI.GetPlayerName_string(pid);
					if (pname != null)
						ItemName += ' (' + pname + ')';
				}
				*/
				break;
		}

		try {
		  if(isValid && (item.GetTask() != null)) {
			  var i =  [ ItemName , item.GetTask().GetRemainingTime() ];
			  listSpec.push( i  );
			  isThereAnySpec = true;
			
		  }
		} catch (e) {}
	});
	
	if(!isThereAnySpec)
		return _exudspecDutyGetLabel("NoData");

	listSpec.sort(dutyCompare);
	
	listSpec.forEach(function(item){
			out += '<div class="row"><div class="col-xs-6 col-sm-6 col-lg-6 name">' + item[0] + '</div><div class="col-xs-3 col-sm-3 col-lg-3">'+loca.FormatDuration(item[1], 1)+'</div><div class="col-xs-3 col-sm-3 col-lg-3">' + dtf.format(new window.runtime.Date(Date.now() + item[1])) + '</div></div>';
	});
	
	return out + '</div>';
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