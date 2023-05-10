addToolsMenuItem("Building licenses", licUsedMenuHandler);


function licUsedGetData()
{
	var result = {};
	game.gi.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector().forEach(function(item){
		if(item.mOrigin != 0 || !game.player.IsBuildingCounted(item.GetBuildingName_string())) { return; }
		result[item.GetBuildingName_string()] = result[item.GetBuildingName_string()] || [];
		result[item.GetBuildingName_string()].push({
			'grid': item.GetGrid(),
			'level': item.GetUpgradeLevel()
		});
	});
	var sorted = Object.keys(result).sort(function(a,b){
		return Object.keys(result[b]).length - Object.keys(result[a]).length;
	});
	var sortedResult = {};
	sorted.forEach(function(item) {
		sortedResult[item] = result[item];
	});
	return sortedResult;
}

function licUsedMenuHandler(event)
{
	var w = new Modal('licUsedWindow', utils.getImageTag('icon_dice.png', '45px') + ' Used building licenses');
	w.create();
	var data = licUsedGetData();
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [8, "Count"]], true);
	$.each(data, function(bui) {
		html += createTableRow([
				[4, $('<button>', { 
					'class': 'close',
					'style': 'float: left;',
					'value': bui,
					'data-toggle': "collapse",
					'data-target': "#collapse" + bui,
					'aria-expanded': "false",
					'aria-controls': "collapse" + bui
				}).html('<span style="color:#fff;">&#8645;&nbsp;&nbsp;</span>').prop('outerHTML') + loca.GetText("BUI", bui)],
				[8, Object.keys(data[bui]).length]
			]);
			html += '<div class="collapse" id="collapse'+bui+'"><div class="container-fluid" style="height:200px;">';
			html += createTableRow([
				[4, loca.GetText("LAB", "Name")],
				[2, "Level"],
				[2, "Grid"],
				[4, "Show"]
			], true);
			$.each(data[bui], function(item) {
				html += createTableRow([
					[4, loca.GetText("BUI", bui)],
					[2, data[bui][item].level],
					[2, data[bui][item].grid],
					[4, $(battleSearchIcon).css("cursor", "pointer").attr({ "id": "licUsedOpen", 'alt': data[bui][item].grid }).prop("outerHTML")]
				]);
			});
			html += '</div></div>';
	});
	w.Body().html(html + '</div>');
	w.withBody("#licUsedOpen").click(function(event) {
		var bui = game.zone.mStreetDataMap.GetBuildingByGridPos(event.target.alt);
		swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(event.target.alt);
		game.gi.SelectBuilding(bui);
	});
	w.show();
}