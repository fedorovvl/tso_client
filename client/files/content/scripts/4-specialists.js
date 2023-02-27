var specTemplates;
var geoDropSpec = [
	{ 'val': '0', 'text': loca.GetText("LAB", "Cancel"), 'req': 0 },
	{ 'val': '0,0', 'text': loca.GetText("TOT", "FindDepositStone"), 'req': 0 },
	{ 'val': '0,1', 'text': loca.GetText("TOT", "FindDepositBronzeOre"), 'req': 9 },
	{ 'val': '0,2', 'text': loca.GetText("TOT", "FindDepositMarble"), 'req': 19 },
	{ 'val': '0,3', 'text': loca.GetText("TOT", "FindDepositIronOre"), 'req': 20 },
	{ 'val': '0,4', 'text': loca.GetText("TOT", "FindDepositGoldOre"), 'req': 23 },
	{ 'val': '0,5', 'text': loca.GetText("TOT", "FindDepositCoal"), 'req': 24 },
	{ 'val': '0,6', 'text': loca.GetText("TOT", "FindDepositGranite"), 'req': 60 },
	{ 'val': '0,7', 'text': loca.GetText("TOT", "FindDepositAlloyOre"), 'req': 61 },
	{ 'val': '0,8', 'text': loca.GetText("TOT", "FindDepositSalpeter"), 'req': 62 }
];
var explorerDropSpec = [
  { 'label': loca.GetText("LAB", "FindTreasure"), 'data': [
	  { 'val': '1,0', 'text': loca.GetText("LAB", "FindTreasureShort"), 'req': [0,0,8] },
	  { 'val': '1,1', 'text': loca.GetText("LAB", "FindTreasureMedium"), 'req': [0,0,20] },
	  { 'val': '1,2', 'text': loca.GetText("LAB", "FindTreasureLong"), 'req': [0,0,32] },
	  { 'val': '1,3', 'text': loca.GetText("LAB", "FindTreasureEvenLonger"), 'req': [0,0,40] },
 	  { 'val': '1,6', 'text': loca.GetText("LAB", "FindTreasureLongest"), 'req': [0,0,54] },
	  { 'val': '1,4', 'text': loca.GetText("LAB", "FindTreasureTravellingErudite"), 'req': [1,0,0] },
	  { 'val': '1,5', 'text': loca.GetText("LAB", "FindTreasureBeanACollada"), 'req': [0,1,0] }
  ]},
  { 'label': loca.GetText("LAB", "SpecialistTaskFindAdventureZone"), 'data': [
	  { 'val': '2,0', 'text': loca.GetText("LAB", "FindAdventureZoneShort"), 'req': [0,0,26] },
	  { 'val': '2,1', 'text': loca.GetText("LAB", "FindAdventureZoneMedium"), 'req': [0,0,36] },
	  { 'val': '2,2', 'text': loca.GetText("LAB", "FindAdventureZoneLong"), 'req': [0,0,42] },
	  { 'val': '2,3', 'text': loca.GetText("LAB", "FindAdventureZoneVeryLong"), 'req': [0,0,56] }
  ]}
];

function specSharedHandler(type)
{
	const isExplorer = type === 1,
		isGeologist = type === 2;
	$( "div[role='dialog']:not(#specModal):visible").modal("hide");
	createModalWindow('specModal', '');
	$("#specModal .modal-title").html("{0} {1}".format(
		getImageTag(isGeologist ? 'icon_geologist.png' : 'icon_explorer.png'),
		loca.GetText("SPE", isGeologist ? "Geologist" : "Explorer"))
	);
	if(game.gi.isOnHomzone() == false) {
		game.showAlert(getText('not_home'));
		return;
	}
	$('#specModal .specSaveTemplate').length === 0 && createSpecWindow();
	specTemplates.setModule(isExplorer ? 'expl' : 'geo');
	const playerLevel = game.player.GetPlayerLevel();
    var out = '<div class="container-fluid">', isThereAnySpec = false, specialistsUniqueId;
	game.getSpecialists().sort(0).forEach(function(item){
		if (item.GetTask() != null || item.GetBaseType() != type) { return; }
		specialistsUniqueId = item.GetUniqueID();
		isThereAnySpec = true;
		if(isExplorer) {
			var skills = [];
			item.getSkillTree().getItems_vector().forEach(function(skill){
				skills[skill.getId()] = skill.getLevel() > 0;
			});
		}
		out += createTableRow([
			[4, getImageTag(item.getIconID(), '8%') + item.getName(false), 'name'],
			[3, '&nbsp;'],
			[5, isExplorer ? createExplorerDropdown(specialistsUniqueId, skills[39], skills[40], false, true) : createGeologistDropdown(specialistsUniqueId, playerLevel, false, true)]
		]);
	});
	if(!isThereAnySpec) {
		game.showAlert(getText(isGeologist ? 'no_free_geo' : 'no_free_expl'));
		return;
	}
	$("#specModal .massSend").html(isGeologist ? createGeologistDropdown(1, 1, true) : createExplorerDropdown(null, true, true, true));
	$("#specModalData").html(out + '</div>');
	$('#specModalData select').each(function(i, select){
		updateSpecTimeRow(select, $(select).val(), $(select).val());
	});
	$('#specModalData select').change(multiSelectSpec);
	$("#specModal #specMassChange").change(massChangeSpecDropdown);
	$('#specModalData .container-fluid').selectable({
		filter: ".name",
		selecting: function(e, ui) {
			var curr = $(ui.selecting.tagName, e.target).index(ui.selecting);
			if(e.shiftKey && prev > -1) {
				$(ui.selecting.tagName, e.target).slice(Math.min(prev, curr), 1 + Math.max(prev, curr)).filter(".name").addClass('ui-selected');
				prev = -1;
			} else {
				prev = curr;
			}
		}
	});
	$('#specModal:not(:visible)').modal({backdrop: "static"});
}

function createSpecWindow()
{
	specTemplates = new SaveLoadTemplate('spec', function(data) {
		$('#specModalData select').val(0);
		$.each(data, function(spec, val) { $('#' + spec.replace('expl-','')).val(val); });
		$('#specModalData select').each(function(i, select){
			updateSpecTimeRow(select, $(select).val(), $(select).val());
		});
	});
	const headerRow = createTableRow([
			[4, loca.GetText("LAB","Name")],
			[3, utils.createSwitch('specTimeType', mainSettings.specDefTimeType)+'<div style="position: absolute;left: 55px;top: 1px;" id="specTimeTypeLang">{0}</div>'.format(mainSettings.specDefTimeType ? getText('spec_time_arrival') : getText('spec_time_normal'))],
			[5, '', 'massSend']
		], true);
	$("#specModal .modal-header").append([$('<br/>'), $('<div>', {'class': 'container-fluid'}).html(headerRow)]);
	$("#specTimeType").change(function(){
		$('#specModalData select').each(function(i, select){
			updateSpecTimeRow(select, $(select).val(), $(select).val());
		});
		$("#specTimeTypeLang").text($(this).is(':checked') ? getText('spec_time_arrival') : getText('spec_time_normal'));
	});
	$("#specModal .modal-footer").prepend([
		$('<button>').attr({ "class": "btn btn-success specSend" }).text(getText('btn_submit')),
		$('<button>').attr({ "class": "btn btn-primary pull-left specSaveTemplate" }).text(getText('save_template')),
		$('<button>').attr({ "class": "btn btn-primary pull-left specLoadTemplate" }).text(getText('load_template')),
	]);
	$('#specModal .specSaveTemplate').click(function(){
		var dataToSave = {};
		$('#specModalData select').map(function() { dataToSave[$(this).attr('id')] = $(this).val(); });
		specTemplates.save(dataToSave);
	});
	$('#specModal .specLoadTemplate').click(function() { specTemplates.load(); });
	$('#specModal .specSend').click(sendSpec);
}

function createGeologistDropdown(id, level, mass, def)
{
	var select = $('<select>', { id: mass ? 'specMassChange' : "{0}_{1}".format(id.uniqueID1, id.uniqueID2) }).attr('class', 'form-control');
	$.each(geoDropSpec, function(i, item){
		if(level >= item.req || mass)
			select.append($('<option>', { value: item.val, selected: def && mainSettings.geoDefTask == item.val ? 'selected' : false }).text(item.text));
	});
	return select.prop("outerHTML");
}

function createExplorerDropdown(id, art, bean, mass, def)
{
	var select = $('<select>', { id: mass ? 'specMassChange' : "{0}_{1}".format(id.uniqueID1, id.uniqueID2) }).attr('class', 'form-control');
	select.append($('<option>', { value: '0' }).text(loca.GetText("LAB", "Cancel")));
	const playerLevel = game.player.GetPlayerLevel();
	$.each(explorerDropSpec, function(i, optgroup){
		var group = $('<optgroup>', { label: optgroup.label });
		$.each(optgroup.data, function(n, item){
			if(mass || (item.req[0] && art) || (item.req[1] && bean) || (!item.req[0] && !item.req[1] && playerLevel >= item.req[2]))
				group.append($('<option>', { value: item.val, selected: def && mainSettings.explDefTask == item.val ? 'selected' : false }).text(item.text));
		});
		select.append(group);
	});
	return select.prop("outerHTML");
}

function updateSpecTimeRow(select, val, selected)
{
	try
	{
		var row = $(select).closest('.row').children('div').eq(1);
		row.html((val != undefined && val != '0') ? getTaskDurationText(select.id, selected) : '&nbsp;');
	} catch(e) {
		return "Error " + e;
	}
}

function multiSelectSpec()
{
	var selected = $(event.target).val(),
		multiselect = $(event.target.parentNode.parentNode.childNodes[0]).hasClass("ui-selected");
	if(multiselect) {
		$('#specModalData div .ui-selected:parent').each(function(i, item) {
			$(item.parentNode).find('select').each(function(i, select) {
				$(select).val(selected);
				updateSpecTimeRow(select, $(select).val(), selected);
			});
		});
		$('#specModalData div .name').removeClass("ui-selected");
	} else {
		updateSpecTimeRow(event.target, selected, selected);
	}
}
function massChangeSpecDropdown()
{
	var selected = $( "#specMassChange" ).val();
	$('#specModalData select').each(function(i, select){
		$(select).val(selected);
		if($(select).val() == undefined)
			$(select).val(0);
		updateSpecTimeRow(select, $(select).val(), selected);
	});
}

function getTaskDurationText(spec_id, task_id)
{
	var cat_id = task_id.split(","),
		task = getTaskInfo(cat_id[0], cat_id[1]);
	spec_id = spec_id.split("_");
	var uniqueID = game.def("Communication.VO::dUniqueID").Create(spec_id[0], spec_id[1]),
		spec = game.zone.getSpecialist(swmmo.application.mGameInterface.mCurrentViewedZoneID, uniqueID),
		calculatedTime = task.duration,
		vectorIndex;
	spec.getSkillTree().getItems_vector().concat(spec.skills.getItems_vector()).forEach(function(skill) {
		vectorIndex = skill.getLevel() - 1;
		if(vectorIndex == -1) { return; }
		skill.getDefinition().level_vector[vectorIndex].forEach(function(skillDef) {
			if ((((skillDef.type_string.length === 0) || (skillDef.type_string == task.taskName + task.subTaskName)) && (skillDef.modifier_string.toLowerCase() == "searchtime"))) {
				calculatedTime = (skillDef.value != 0) ? skillDef.value : ((calculatedTime * skillDef.multiplier) + skillDef.adder);
			}
		});
	});
	calculatedTime = (calculatedTime / spec.GetSpecialistDescription().GetTimeBonus()) * 100;
	return !$('#specTimeType').is(':checked') ? loca.FormatDuration(calculatedTime, 1) : dtf.format(new window.runtime.Date(Date.now() + calculatedTime));
}

function getTaskInfo(taskId, subTaskId)
{
	var task = swmmo.getDefinitionByName("global").specialistTaskDefinitions_vector[taskId];
	return { taskName: task.taskName_string, subTaskName: task.subtasks_vector[subTaskId].taskType_string, duration: task.subtasks_vector[subTaskId].duration };
}

function sendSpec()
{
	var specToSend = {};
	$('#specModalData select option:selected[value!="0"]').each(function(i, select){
		specToSend[$(select).closest('select').prop('id')] = select.value;
	});
	if(Object.keys(specToSend).length > 0){
		var queue = new TimedQueue(1000);
		$.each(specToSend, function(spec, val) {
			queue.add(function(){ sendSpecPacket(spec, val); });
		});
		queue.run();
		$('#specModal').modal('hide');
		game.showAlert(getText('command_sent'));
	}
}

function sendSpecPacket(uniqueId, task)
{
	try{
		var specTask = game.def("Communication.VO::dStartSpecialistTaskVO", true),
			uniqueIdArr = uniqueId.split("_"),
			taskArr = task.split(",");
		specTask.subTaskID = taskArr[1];
		specTask.paramString = "";
		specTask.uniqueID = game.def("Communication.VO::dUniqueID").Create(uniqueIdArr[0], uniqueIdArr[1]);
		game.gi.SendServerAction(95, taskArr[0], 0, 0, specTask);
	} catch (ex) {
		alert(ex);
	}
}
