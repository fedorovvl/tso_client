var timedEnum = swmmo.getDefinitionByName("Enums::TIMED_PRODUCTION_TYPE"),
	timedbuildings = game.getBuildings(),
	timedqueue, timedbuilding, timedtypes = [], timedfailures = 0;

function TimedMenuHandler(event)
{
	try
	{
		$("div[role='dialog']:not(#timedModal):visible").modal("hide");
		createModalWindow('timedModal', getImageTag('BattleBuffDestroy_TMC_GateKit', '45px') + ' '+loca.GetText("LAB", "Production"));
		if(game.gi.isOnHomzone() == false) {
			game.showAlert(getText('not_home'));
			return;
		}
		let out = '<div class="container-fluid">';
		out += createTableRow([
			[4, loca.GetText("LAB", "Name")],
			[2, getText('prod_queuesize')],
			[3, getText('prod_estimate')],
			[3, getText('prod_finish')]
		], true);
		if(timedtypes.length == 0) {
			timedbuildings.forEach(function(item){
				if(item.productionQueue == null) { return; }
				if(timedtypes.indexOf(item.productionType) == -1) { timedtypes.push(item.productionType); }
			});
		}
		$.each(timedtypes, function(i, type) {
			timedqueue = game.zone.GetProductionQueue(type);
			if(!timedqueue) { return; }
			if(!timedqueue.mTimedProductions_vector) { return; }
			timedbuilding = timedqueue.productionBuilding;
			if(timedEnum.toString(type) == 'culturebuilding') { 
				out += getCultureInfo();
				return;
			}
			const estimate = calcTotalTime();
			out += createTableRow([
				[4, $('<span>', { 'id': timedbuilding.GetGrid() }).hide().prop('outerHTML') + loca.GetText("BUI", timedbuilding.GetBuildingName_string())],
				[2, timedqueue.mTimedProductions_vector.length],
				[3, estimate > 0 ? loca.FormatDuration(estimate, 1) : '-'],
				[3, estimate > 0 ? dtf.format(new window.runtime.Date(Date.now() + estimate)) : '-']
			]);
		});
		out += '</div>';
		$("#timedModalData").html(out);
		$("#timedModalData .container-fluid .row:gt(0)").click(timedRowClick);
		$("#timedModalData .container-fluid .row:gt(0) div:first-child").css('cursor', 'pointer');
		$('#timedModal:not(:visible)').modal({backdrop: "static"});
	} catch(e) { 
		timedfailures++;
		if(timedfailures > 10) {
			game.showAlert("Error opening timed window "+e);
		} else {
			TimedMenuHandler(null);
		}
	}
}

function timedRowClick(event)
{
	var grid = $(event.target).children('span')[0].id;
	var bui = game.zone.mStreetDataMap.GetBuildingByGridPos(grid);
	game.gi.SelectBuilding(bui);
	$('#timedModal .btnClose').trigger('click');
}

function getCultureInfo()
{
	var cooldown = timedbuilding.getRemainingCooldown();
	return createTableRow([
		[4, $('<span>', { 'id': timedbuilding.GetGrid() }).hide().prop('outerHTML') + loca.GetText("BUI", timedbuilding.GetBuildingName_string())],
		[5, cooldown <= 0 ? '' : "{0}: {1}".format(loca.GetText("LAB", "cooldown"), loca.FormatDuration(cooldown, 1)), 'text-center'],
		[3, cooldown <= 0 ? '' : dtf.format(new window.runtime.Date(Date.now() + cooldown)) ]
	]);
}

function calcTotalTime()
{
	var result = 0;
	timedqueue.mTimedProductions_vector.forEach(function(item) {
		result += (((item.GetAmount() - item.GetProducedItems()) * item.GetProductionTime()) - item.GetCollectedTime()) / item.GetProductionOrder().GetTimeBonus();
	});
	return result;
}