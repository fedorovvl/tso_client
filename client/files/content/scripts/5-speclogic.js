function createSpecWindow()
{
	const headerRow = createTableRow([
			[4, loca.GetText("LAB","Name")],
			[3, '<label class="switch"><input type="checkbox" id="specTimeType"><span class="slider round"></span></label><div style="position: absolute;left: 55px;top: 1px;" id="specTimeTypeLang">{0}</div>'.format(getText('spec_time_normal'))],
			[5, '', 'massSend']
		], true);
	$("#specModal .modal-header").append([$('<br/>'), $('<div>', {'class': 'container-fluid'}).html(headerRow)]);
	$("#specTimeType").change(function(){
		$('#specModalData select[id!="expl-mass"]').each(function(i, select){
			if(select.value != '0') {
				$(select.parentNode.parentNode.childNodes[1]).html(getTaskDurationText(select.id.replace('expl-', ''), select.value));
			}
		});
		$("#specTimeTypeLang").text($(this).is(':checked') ? getText('spec_time_arrival') : getText('spec_time_normal'));
	});
	$("#specModal .modal-footer").prepend([
		$('<button>').attr({ "class": "btn btn-success specSend" }).text(getText('btn_submit')),
		$('<button>').attr({ "class": "btn btn-primary pull-left specSaveTemplate" }).text(getText('save_template')),
		$('<button>').attr({ "class": "btn btn-primary pull-left specLoadTemplate" }).text(getText('load_template')),
	]);
	$('#specModal .btn-settings').click(specSettingsWindow);
	$('#specModal .specSaveTemplate').click(saveSpecTemplate);
	$('#specModal .specLoadTemplate').click(loadSpecTemplate);
	$('#specModal .specSend').click(sendSpec);
}

function multiSelectSpec()
{
	selected = $(event.target).val();
	multiselect = $(event.target.parentNode.parentNode.childNodes[0]).hasClass("ui-selected"); 
	if(multiselect) {
		$('#specModalData div .ui-selected:parent').each(function(i, item) {
			$(item.parentNode).find('select').each(function(i, select) {
				$('#' + select.id + ' option:first').prop('selected', true);
				$('#' + select.id + ' option[value="'+selected+'"]').prop('selected', true);
				if(selected != '0' && $('#' + select.id + ' option[value="'+selected+'"]').val() != undefined) {
					$(item.parentNode.childNodes[1]).html(getTaskDurationText(select.id.replace('expl-', ''), selected));
				} else {
					$(item.parentNode.childNodes[1]).html('&nbsp;');
				}
			});
		});
		$('#specModalData div .name').removeClass("ui-selected");
	} else {
		if(selected != '0') {
			$(event.target.parentNode.parentNode.childNodes[1]).html(getTaskDurationText(event.target.id.replace('expl-', ''), selected));
		} else {
			$(event.target.parentNode.parentNode.childNodes[1]).html('&nbsp;');
		}
	}
}
function massChangeSpecDropdown()
{
	selected = $( "#expl-mass" ).val();
	$('#specModalData select[id!="expl-mass"]').each(function(i, select){
		$('#' + select.id + ' option:first').prop('selected', true);
		$('#' + select.id + ' option[value="'+selected+'"]').prop('selected', true);
		if(selected != '0' && $('#' + select.id + ' option[value="'+selected+'"]').val() != undefined) {
			$(select.parentNode.parentNode.childNodes[1]).html(getTaskDurationText(select.id.replace('expl-', ''), selected));
		} else {
			$(select.parentNode.parentNode.childNodes[1]).html('&nbsp;');
		}
	});
}

function calculateSkillsOnTaskDuration(item, baseDuration, task)
{
	item.getSkillTree().getItems_vector().concat(item.skills.getItems_vector()).forEach(function(skill) {
		vectorIndex = skill.getLevel() - 1;
		if(vectorIndex == -1) { return; }
		skill.getDefinition().level_vector[vectorIndex].forEach(function(skillDef) {
			if ((((skillDef.type_string.length == 0) || (skillDef.type_string == task)) && (skillDef.modifier_string.toLowerCase() == "searchtime"))) {
				if (skillDef.value != 0) {
					baseDuration = skillDef.value;
				}
				baseDuration = ((baseDuration * skillDef.multiplier) + skillDef.adder);
			}
		});
	});
	return ((baseDuration / item.GetSpecialistDescription().GetTimeBonus()) * 100);
}

function getTaskDurationText(spec_id, task_id)
{
	try{
		cat_id = task_id.split(",");
		spec_id = spec_id.split("_");
		task = getTaskInfo(cat_id[0], cat_id[1]);
		uniqueID = swmmo.getDefinitionByName("Communication.VO::dUniqueID").Create(spec_id[0], spec_id[1]);
		spec = swmmo.application.mGameInterface.mCurrentPlayerZone.getSpecialist(swmmo.application.mGameInterface.mCurrentViewedZoneID, uniqueID);
		calculatedTime = calculateSkillsOnTaskDuration(spec, task.duration, task.taskName + task.subTaskName);
		if(!$('#specTimeType').is(':checked')) {
			return loca.FormatDuration(calculatedTime, 1);
		} else {
			return dtf.format(new window.runtime.Date(Date.now() + calculatedTime));
		}
	} catch(e) {
		return "Error";
	}
}

function getTaskInfo(taskId, subTaskId)
{
	task = swmmo.getDefinitionByName("global").specialistTaskDefinitions_vector[taskId];
	return { taskName: task.taskName_string, subTaskName: task.subtasks_vector[subTaskId].taskType_string, duration: task.subtasks_vector[subTaskId].duration };
}

function sendSpec()
{
	specToSend = {};
	$('#specModalData select[id!="expl-mass"] option:selected[value!="0"]').each(function(i, select){
		if(select.parentNode.parentNode.id == '') {
			specToSend[select.parentNode.id] = select.value;
		} else {
			specToSend[select.parentNode.parentNode.id] = select.value;
		}
	});
	if(Object.keys(specToSend).length == 0){ return; }
	var x = new TimedQueue(1000);
	$.each(specToSend, function(spec, val) {
		x.add(function(){ sendSpecPacket(spec, val); });
	});
	x.run();
	$('#specModal').modal('hide');
	showGameAlert(getText('command_sent'));
}
function sendSpecPacket(uniqueId, task)
{
	try{
		specTaskDef = swmmo.getDefinitionByName("Communication.VO::dStartSpecialistTaskVO");
		specTask = new specTaskDef();
		uniqueIdArr = uniqueId.replace("expl-", "").split("_");
		taskArr = task.split(",");
		specTask.subTaskID = taskArr[1];
		specTask.paramString = "";
		specTask.uniqueID = swmmo.getDefinitionByName("Communication.VO::dUniqueID").Create(uniqueIdArr[0], uniqueIdArr[1]);
		serverAction = swmmo.getDefinitionByName("Communication.VO::dServerAction").create(taskArr[0], 0, 0, specTask);
		swmmo.application.mGameInterface.mClientMessages.SendMessagetoServer(95, swmmo.application.mGameInterface.mCurrentViewedZoneID, serverAction);
	} catch (ex) {
		alert(ex);
	}
}

function saveSpecTemplate()
{
	dataToSave = {};
	$('#specModalData select[id!="expl-mass"]').map(function() { dataToSave[$(this).attr('id')] = $(this).val(); })
	file = new air.File(readLastDir('spec')).resolvePath("specTemplate.txt");
	file.addEventListener(air.Event.COMPLETE, specTemplateSaved); 
	file.save(JSON.stringify(dataToSave, null, "  "));
}
function specTemplateSaved(event) 
{ 
    saveLastDir('spec', event.target.parent.nativePath); 
}
function loadSpecTemplate()
{
	file = new air.File(readLastDir('spec'));
	txtFilter = new air.FileFilter("All files", "*.*"); 
	file.browseForOpen("Open", [txtFilter]); 
	file.addEventListener(air.Event.SELECT, loadSpecTemplateComplete); 
}
function loadSpecTemplateComplete(event)
{
	event.target.addEventListener(air.Event.COMPLETE, loadSpecTemplateLoaded); 
	event.target.load();
}
function loadSpecTemplateLoaded(event)
{
	savedData = {};
	try{
	  savedData = JSON.parse(event.target.data);
	} catch(e) {
	  alert(getText('bad_template'));
	  return;
	}
	$('#specModalData select[id!="expl-mass"]').map(function() { $(this).val(0); });
	$.each(savedData, function(spec, val) { $('#' + spec).val(val);	});
	$('#specModalData select[id!="expl-mass"]').each(function(i, select){
		if($('#' + select.id).val() != undefined && $('#' + select.id).val() != '0') {
			$(select.parentNode.parentNode.childNodes[1]).html(getTaskDurationText(select.id.replace('expl-', ''), $('#' + select.id).val()));
		} else {
			$(select.parentNode.parentNode.childNodes[1]).html('&nbsp;');
		}
	});

}