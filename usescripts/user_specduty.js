addToolsMenuItem("Spec Duty", specDutyTime);

function specDutyTime(event) {
	// close all modals
	$("div[role='dialog']:not(#dutyModal):visible").modal("hide");
	// create modal
	createModalWindow('dutyModal', 'Specialists duty time');
	// fill modal data 
	$('#dutyModalData').html(dutyGetData());
	$('#dutySpecType').change(changeSpecType);
	// show modal
	$('#dutyModal:not(:visible)').modal({ backdrop: "static" });

}

function changeSpecType()
{
	$('#dutyModalData').html(dutyGetData());
	$('#dutySpecType').change(changeSpecType);
}

function dutyGetData(initial) {
	out = '<div class="container-fluid"><label class="switch"><input type="checkbox" id="dutySpecType" '+ ($('#dutySpecType').is(':checked') ? 'checked' : '')  +'><span class="slider round"></span></label><div style="position: absolute;left: 65px;top:17px;">Explorers/Geologists</div><div class="row"><div class="col-xs-4 col-sm-4 col-lg-4"  style="background-color:gray;height:23px">Name</div><div class="col-xs-4 col-sm-4 col-lg-4"  style="background-color:gray;height:23px">Task</div><div class="col-xs-2 col-sm-2 col-lg-2" style="background-color:gray;height:23px">Estimated</div><div class="col-xs-2 col-sm-2 col-lg-2" style="background-color:gray;height:23px">Arrival</div></div>';
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().sort(0).forEach(function(item){
		  if(item.GetBaseType() == $('#dutySpecType').is(':checked') + 1 && item.GetTask() != null) {
			  task = loca.GetText("LAB", item.GetTask().getTaskDefinition().mainTask.taskName_string+item.GetTask().getTaskDefinition().taskType_string);
			  out += '<div class="row"><div class="col-xs-4 col-sm-4 col-lg-4 name">' + item.getName(false) + '</div><div class="col-xs-4 col-sm-4 col-lg-4 name">' + task + '</div><div class="col-xs-2 col-sm-2 col-lg-2">'+loca.FormatDuration(item.GetTask().GetRemainingTime(), 1)+'</div><div class="col-xs-2 col-sm-2 col-lg-2">' + dtf.format(new window.runtime.Date(Date.now() + item.GetTask().GetRemainingTime())) + '</div></div>';
		  }
	});
	return out + '</div>';
}
