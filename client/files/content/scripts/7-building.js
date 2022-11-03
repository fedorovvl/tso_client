createProdMenu();

var buildingSelectedTracker = new window.runtime.ClientBuff();
buildingSelectedTracker.addEventListener("buffApply", buildingSelectedHandler);
var buildingRecordEnabled = false;
var buildingRecord;
var buildingTemplates;


function menuBuildingHandler(event)
{
	$("div[role='dialog']:not(#buildingModal):visible").modal("hide");
	createModalWindow('buildingModal', getImageTag('BattleBuffDestroy_TMC_GateKit', '45px') + ' '+loca.GetText("LAB", "Production"));
	if(swmmo.application.mGameInterface.isOnHomzone() == false) {
		showGameAlert(getText('not_home'));
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
	out = '<div class="container-fluid">';
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
		showGameAlert(getText('buff_rec_start'));
		swmmo.application.mGameInterface.channels.BUILDING.addPropertyObserver("buildingSelected", buildingSelectedTracker);
		buildingRecordEnabled = true;
	});
	$( "#buildingStopRecording" ).click(function(){
		buildingRecordEnabled = false;
		showGameAlert(getText('buff_rec_stop'));
		swmmo.application.mGameInterface.channels.BUILDING.removePropertyObserver("buildingSelected", buildingSelectedTracker);
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
		var bui = swmmo.application.mGameInterface.mCurrentPlayerZone.GetBuildingFromGridPosition(item);
		result += createTableRow([
			[1, item],
			[7, loca.GetText("BUI", buildingRecord[item].name), 'name'],
			[2, loca.GetText("LAB", (bui.IsProductionActive() ? 'StatusWorking' : 'StatusStopped'))],
			[2, createSwitch(item, buildingRecord[item].status) + $('<button>', { 'class': 'close', 'value': item }).html('<span>&times;</span>').prop('outerHTML')]
		]);
	});
	return result;
}

function buildingDoJob()
{
	var x = new TimedQueue(1000);
	$('#buildingModalData input[id!="buiMassChange"]').each(function(i, item){
		var bui = swmmo.application.mGameInterface.mCurrentPlayerZone.GetBuildingFromGridPosition(item.id);
		if(bui.IsProductionActive() != item.checked) {
			x.add(function() { bui.SetProductionActiveCommand(item.checked); });
		}
	});
	x.run();
	$('#buildingModal').modal('hide');
	showGameAlert(getText('command_sent'));

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

function createProdMenu()
{
	prodMenu = new air.NativeMenu();
	buffsItem = new air.NativeMenuItem(loca.GetText("LAB", "Buffs") + " (F5)");
	buffsItem.addEventListener(air.Event.SELECT, menuBuffsHandler);
	buiItem = new air.NativeMenuItem(loca.GetText("LAB", "Production") + " (F7)");
	buiItem.addEventListener(air.Event.SELECT, menuBuildingHandler);
	prodItem = new air.NativeMenuItem(getText('prod_timed'));
	prodItem.addEventListener(air.Event.SELECT, TimedMenuHandler);
	prodMenu.addItem(buffsItem);
	prodMenu.addItem(buiItem);
	prodMenu.addItem(prodItem);
	addMenuItem(loca.GetText("LAB", "Buildings"), prodMenu);
	addKeybBind(menuBuffsHandler, 116);
	addKeybBind(menuBuildingHandler, 118);
}
