var buildingSelectedTracker = game.getTracker('bui', buildingSelectedHandler),
	buildingRecordEnabled = false,
	buildingRecord,
	buildingTemplates;


function menuBuildingHandler(event)
{
	$("div[role='dialog']:not(#buildingModal):visible").modal("hide");
	createModalWindow('buildingModal', getImageTag('BattleBuffDestroy_TMC_GateKit', '45px') + ' '+loca.GetText("LAB", "Production"));
	if(game.gi.isOnHomzone() == false) {
		game.showAlert(getText('not_home'));
		return;
	}
	if($('#buildingModal .buildingSubmit').length == 0)
	{
		buildingTemplates = new SaveLoadTemplate('bui', function(data) {
			buildingRecord = data;
			menuBuildingHandler(null);
		});
		$("#buildingModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-warning buildingReset" }).text(getText('btn_reset')),
			$('<button>').attr({ "class": "btn btn-success buildingSubmit" }).text(getText('btn_submit')),
			$('<button>').attr({ "class": "btn btn-primary pull-left buildingSaveTemplate" }).text(getText('save_template')),
			$('<button>').attr({ "class": "btn btn-primary pull-left buildingLoadTemplate" }).text(getText('load_template'))
		]);
		$('#buildingModal .buildingReset').click(function() {
			buildingRecord = null;
			menuBuildingHandler(null);
		});
		$('#buildingModal .buildingSubmit').click(buildingDoJob);
		$('#buildingModal .buildingSaveTemplate').click(function(){ 
			$('#buildingModalData input[id!="buiMassChange"]').each(function(i, item){
				buildingRecord[item.id].status = item.checked;
			});
			buildingTemplates.save(buildingRecord);
		});
		$('#buildingModal .buildingLoadTemplate').click(function() { buildingTemplates.load(); });
	}
	$('.buildingSubmit, .buildingReset, .buildingSaveTemplate').attr('disabled', 'true');
	let out = '<div class="container-fluid">';
	if(!buildingRecordEnabled && buildingRecord == null) {
		out += '<strong>{0}</strong></p>{1}{2}'.format(
			getText('prod_welcome'),
			getText('prod_welcome_block'),
			$('<button>', { 'class': "btn btn-primary btn-lg btn-block", 'id' :"buildingStartRecording"}).text(getText('buff_start_record')).prop('outerHTML')
		);
	}
	if(buildingRecordEnabled) {
		out += $('<p>').append($('<h2>', { 'class': 'text-center' }).text(getText('buff_rec_progress'))).prop('outerHTML');
		out += $('<button>', { 'class': 'btn btn-primary btn-lg btn-block', 'id': 'buildingStopRecording' }).text(getText('buff_stop_record')).prop('outerHTML');
	}
	if(!buildingRecordEnabled && buildingRecord != null) {
		out += buildingGetHTMLData() + '<br><button type="button" class="btn btn-primary btn-lg btn-block" id="buildingStartRecording">' + getText('buff_record_more') + '</button>';
		$('.buildingReset, .buildingSaveTemplate, .buildingSubmit').attr('disabled', false);
	}
	out += '</div>';
	$("#buildingModalData").html(out);
	$("#buiMassChange").change(function(){
		var state = this.checked;
		$('#buildingModalData input[id!="buiMassChange"]').each(function(i, item){
			item.checked = state;
		});
	});
	$("#buildingModalData .close").click(function(e) { 
		grid = $(e.currentTarget).val();
		delete buildingRecord[grid];
		$(e.currentTarget).closest('.row').remove();
		menuBuildingHandler(null);
	});
	$( "#buildingStartRecording" ).click(function(){
		$('#buildingModal').modal('hide');
		game.showAlert(getText('buff_rec_start'));
		game.gi.channels.BUILDING.addPropertyObserver("buildingSelected", buildingSelectedTracker);
		buildingRecordEnabled = true;
	});
	$( "#buildingStopRecording" ).click(function(){
		buildingRecordEnabled = false;
		game.showAlert(getText('buff_rec_stop'));
		game.gi.channels.BUILDING.removePropertyObserver("buildingSelected", buildingSelectedTracker);
		menuBuildingHandler(null);
	});
	$('#buildingModal:not(:visible)').modal({backdrop: "static"});
}

function buildingGetHTMLData()
{
	var result = createTableRow([
		[1, "#"],
		[7, loca.GetText("LAB","Name")],
		[2, loca.GetText("LAB","ProductionStatus")],
		[2, createSwitch('buiMassChange') + $('<div>', { 'style': 'position: absolute;left: 55px;top: 1px;' }).text(loca.GetText("LAB","Quests")).prop('outerHTML')]
	], true);
	$.each(buildingRecord, function(item) {
		var bui = buildingGetBui(item, 0);
		if(bui == null) {
			result += createTableRow([
				[1, item],
				[7, loca.GetText("BUI", buildingRecord[item].name), 'name'],
				[4, getText('buff_not_exist')],
			]);
			delete buildingRecord[item];
			return;
		}
		buildingRecord[item].real_status = bui.IsProductionActive();
		result += createTableRow([
			[1, item],
			[7, loca.GetText("BUI", buildingRecord[item].name), 'name'],
			[2, loca.GetText("LAB", (buildingRecord[item].real_status ? 'StatusWorking' : 'StatusStopped'))],
			[2, createSwitch(item, buildingRecord[item].status) + $('<button>', { 'class': 'close', 'value': item }).html('<span>&times;</span>').prop('outerHTML')]
		]);
	});
	return result;
}

function buildingDoJob()
{
	var queue = new TimedQueue(1000);
	$('#buildingModalData input[id!="buiMassChange"]').each(function(i, item){
		if(buildingRecord[item.id].real_status != item.checked) {
			queue.add(function() {
				game.gi.SendServerAction(107, item.checked ? 1 : 0, item.id, 0, null);
			});
		}
	});
	queue.run();
	$('#buildingModal').modal('hide');
	game.showAlert(getText('command_sent'));

}

function buildingGetBui(grid, tries)
{
	if(tries > 5) 
		return null;
	try {
		return game.zone.GetBuildingFromGridPosition(grid);
	} catch(e) { 
		return buildingGetBui(grid, ++tries);
	}
}

function buildingSelectedHandler(event){
	if(!buildingRecordEnabled) { return; }
	var building = event.data;
	var panelClass = globalFlash.gui.GetInfoPanel(building.GetBuildingName_string());
	var className = window.runtime.flash.utils.getQualifiedClassName(panelClass);
	if(className != "GUI.GAME::cBuildingInfoPanel") { return; }
	if(buildingRecord == null) { buildingRecord = {}; }
	buildingRecord[building.GetGrid()] = { 'status': !building.IsProductionActive(), 'name': building.GetBuildingName_string() };
}
