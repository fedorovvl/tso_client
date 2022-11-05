var timedEnum = swmmo.getDefinitionByName("Enums::TIMED_PRODUCTION_TYPE");

function TimedMenuHandler(event)
{
	try
	{
		$("div[role='dialog']:not(#timedModal):visible").modal("hide");
		createModalWindow('timedModal', getImageTag('BattleBuffDestroy_TMC_GateKit', '45px') + ' '+loca.GetText("LAB", "Production"));
		if(swmmo.application.mGameInterface.isOnHomzone() == false) {
			showGameAlert(getText('not_home'));
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
		swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector().forEach(function(item){
			if(item.productionQueue == null) { return; }
			if(types.indexOf(item.productionType) == -1) { types.push(item.productionType); }
		});
		$.each(types, function(i, type) {
			var queue = swmmo.application.mGameInterface.mCurrentPlayerZone.GetProductionQueue(type);
			if(!queue) { return; }
			if(!queue.mTimedProductions_vector) { return; }
			if(timedEnum.toString(type) == 'culturebuilding') { 
				out += getCultureInfo(queue);
				return;
			}
			var estimate = calcTotalTime(queue);
			out += createTableRow([
				[4, $('<button>', { 
					'class': 'close',
					'style': 'float: left;',
					'value': type,
					'data-toggle': "collapse",
					'data-target': "#collapse" + type,
					'aria-expanded': "false",
					'aria-controls': "collapse" + type
				}).html('<span style="color:#fff;">&#8645;&nbsp;&nbsp;</span>').prop('outerHTML') + loca.GetText("BUI", queue.productionBuilding.GetBuildingName_string())],
				[2, queue.mTimedProductions_vector.length],
				[3, estimate > 0 ? loca.FormatDuration(estimate, 1) : '-'],
				[3, estimate > 0 ? dtf.format(new window.runtime.Date(Date.now() + calcTotalTime(queue))) : '-']
			]);
			out += '<div class="collapse" id="collapse'+type+'"><div class="container-fluid">';
			out += createTableRow([
				[4, loca.GetText("LAB", "Name")],
				[2, loca.GetText("QUL", "Adv_EoWEventQ2")],
				[3, getText('prod_estimate')],
				[3, getText('prod_finish')]
			], true);
			var timeByOrder = 0;
			queue.mTimedProductions_vector.forEach(function(item) {
				timeByOrder += calcTime(item);
				out += createTableRow([
					[4, loca.GetText("RES", item.GetType())],
					[2, item.GetProducedItems() + '/' + item.GetAmount()],
					[3, loca.FormatDuration(timeByOrder, 1)],
					[3, dtf.format(new window.runtime.Date(Date.now() + timeByOrder))]
				]);
			});
			out += '</div></div>';
		});
		out += '</div>';
		$("#timedModalData").html(out);
		$('#timedModal:not(:visible)').modal({backdrop: "static"});
	} catch(e) { 
		TimedMenuHandler(null);
	}
}

function getCultureInfo(queue)
{
	var cooldown = queue.productionBuilding.getRemainingCooldown();
	return createTableRow([
		[4, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + loca.GetText("BUI", queue.productionBuilding.GetBuildingName_string())],
		[5, cooldown <= 0 ? '-' : "{0}: {1}".format(loca.GetText("LAB", "cooldown"), loca.FormatDuration(cooldown, 1)), 'text-center'],
		[3, cooldown <= 0 ? '-' : dtf.format(new window.runtime.Date(Date.now() + cooldown)) ]
	]);
}

function calcTime(item)
{
	return (((item.GetAmount() - item.GetProducedItems()) * item.GetProductionTime()) - item.GetCollectedTime()) / item.GetProductionOrder().GetTimeBonus();
}

function calcTotalTime(queue)
{
	var result = 0;
	queue.mTimedProductions_vector.forEach(function(item) {
		result += calcTime(item);
	});
	return result;
}