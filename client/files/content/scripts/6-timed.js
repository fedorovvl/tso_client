var timedEnum = swmmo.getDefinitionByName("Enums::TIMED_PRODUCTION_TYPE");

function TimedMenuHandler(event)
{
	$("div[role='dialog']:not(#timedModal):visible").modal("hide");
	createModalWindow('timedModal', getImageTag('BattleBuffDestroy_TMC_GateKit', '45px') + ' '+loca.GetText("LAB", "Production"));
	if(game.gi.isOnHomzone() == false) {
		game.showAlert(getText('not_home'));
		return;
	}
	out = '<div class="container-fluid">';
	out += createTableRow([
			[4, loca.GetText("LAB", "Name")],
			[2, getText('prod_queuesize')],
			[3, getText('prod_estimate')],
			[3, getText('prod_finish')]
	], true);
	var types = [];
	game.getBuildings().forEach(function(item){
		if(item.productionQueue == null) { return; }
		if(types.indexOf(item.productionType) == -1) { types.push(item.productionType); }
	});
	$.each(types, function(i, type) {
		var queue = game.zone.GetProductionQueue(type);
		if(!queue) { return; }
		if(!queue.mTimedProductions_vector) { return; }
		if(timedEnum.toString(type) == 'culturebuilding') { 
			out += getCultureInfo(queue);
			return;
		}
		var estimate = calcTotalTime(queue);
		out += createTableRow([
			[4, $('<span>', { 'id': queue.productionBuilding.GetGrid() }).hide().prop('outerHTML') + loca.GetText("BUI", queue.productionBuilding.GetBuildingName_string())],
			[2, queue.mTimedProductions_vector.length],
			[3, estimate > 0 ? loca.FormatDuration(estimate, 1) : '-'],
			[3, estimate > 0 ? dtf.format(new window.runtime.Date(Date.now() + estimate)) : '-']
		]);
	});
	out += '</div>';
	$("#timedModalData").html(out);
	$("#timedModalData .container-fluid .row:gt(0)").click(timedRowClick);
	$("#timedModalData .container-fluid .row:gt(0) div:first-child").css('cursor', 'pointer');
	$('#timedModal:not(:visible)').modal({backdrop: "static"});
}

function timedRowClick(event)
{
	var grid = $(event.target).children('span')[0].id;
	var bui = game.zone.mStreetDataMap.GetBuildingByGridPos(grid);
	game.gi.SelectBuilding(bui);
	$('#timedModal .btnClose').trigger('click');
}

function getCultureInfo(queue)
{
	var cooldown = queue.productionBuilding.getRemainingCooldown();
	return createTableRow([
		[4, $('<span>', { 'id': queue.productionBuilding.GetGrid() }).hide().prop('outerHTML') + loca.GetText("BUI", queue.productionBuilding.GetBuildingName_string())],
		[5, cooldown <= 0 ? '' : "{0}: {1}".format(loca.GetText("LAB", "cooldown"), loca.FormatDuration(cooldown, 1)), 'text-center'],
		[3, cooldown <= 0 ? '' : dtf.format(new window.runtime.Date(Date.now() + cooldown)) ]
	]);
}

function calcTotalTime(queue)
{
	var result = 0;
	queue.mTimedProductions_vector.forEach(function(item) {
		result += (((item.GetAmount() - item.GetProducedItems()) * item.GetProductionTime()) - item.GetCollectedTime()) / item.GetProductionOrder().GetTimeBonus();
	});
	return result;
}