var battleEnemiesDrop;
var battleWindow;
var battleSearchFor;
var battlePacket;
var battleTemplates;
var battleTimedQueue;

function battleMenuHandler(event)
{
	try {
		if(game.gi.isOnHomzone()) {
			game.showAlert(loca.GetText("MEL", "ExplorerDidNotFindEventZone"));
			return;
		}
		if(battleTimedQueue && battleTimedQueue.index != battleTimedQueue.len())
		{
			game.showAlert(loca.GetText("ALT", "ServerOverstrained"));
			return;
		}
		battleTemplates = new SaveLoadTemplate('battle', function(data) {
			if(!data[Object.keys(data)[0]].grid) {
				getText("bad_template");
				return;
			}
			battlePacket = data;
			try{
				battleLoadData();
			} catch(e) {
				game.chatMessage("Error loading " + e, 'army_move');
			}
		});
		battleWindow = new Modal('battleWindow', utils.getImageTag('SummerEvent2022Bundle1') + ' ' + loca.GetText("ACL", "ExcelsiorLostCityBeforeRitual"));
		battleWindow.create();
		if(battleWindow.Title().find(".btn-army").length == 0) {
			battleWindow.Title().append($('<button>').attr({ "class": "btn btn-army pull-right", 'style': 'position:relative;top:2px;left:-5px;' }).text(loca.GetText("LAB","Army")));
			battleWindow.Title().find(".btn-army").click(armyMenuHandler);
		}
		if(battleWindow.withFooter(".armySaveTemplate").length == 0) {
			battleWindow.Footer().prepend([
				$('<button>').attr({ "class": "btn btn-primary pull-left armySaveTemplate" }).text(getText('save_template')).click(battleSaveDialog),
				$('<button>').attr({ "class": "btn btn-primary pull-left armyLoadTemplate" }).text(getText('load_template')).click(function() { battleTemplates.load(); }),
				$('<button>').attr({ "class": "btn btn-primary directAttack" }).text(loca.GetText("ACL", "WinSmallMapsFast")).click(battleAttackDirect),
				$('<button>').attr({ "class": "btn btn-primary reset" }).text(getText('btn_reset')).click(function(){
					battleGetData();
				}),
				$('<button>').attr({ "class": "btn btn-primary loadAttack" }).text(loca.GetText("ACL", "PvPAttacker")).click(battleAttack),
				$('<button>').attr({ "class": "btn btn-primary loadMove" }).text(loca.GetText("LAB", "Move")).click(battleMove),
			]);
		}
		if($('#battleWindow .modal-content #armyDrop').length == 0) {
			$('#battleWindow .modal-content').append($('<div>', { 'id': 'armyDrop' }));
			battleDropdown(game.zone.mStreetDataMap.GetBuildings_vector().filter(function(e) { return e && e.IsReadyToIntercept(); }));
		}
		battleGetData();
		battleWindow.show();
	} catch (e) { alert(e); }
}

function battleSaveDialog()
{
	if(battleWindow.withBody('[type=checkbox]:checked').length == 0) { return; }
	battleWindow.settings(battleSaveTemplate, '');
	battleWindow.sDialog().css("height", "80%");
	battleWindow.sTitle().html(loca.GetText("LAB", "ChangeSortingOrder"));
	var out = '<div class="container-fluid" style="user-select: all;">';
	var select = $('<select>').attr('class', 'form-control').append($('<option>', { value: 1000 }).text('1s'));
	for(var i = 2; i < 301; i++) {
		select.append($('<option>', { value: i * 1000 }).text(i+'s'));
	}
	var timeSelectRow = $(utils.createTableRow([[2, select.prop('outerHTML')]])).find("div:first");
	battleWindow.withBody('[type=checkbox]:checked').each(function(i, item) {
		var row = $(item).closest("div.row").clone();
		row.find("div").slice(-1).remove();
		row.find("[type=checkbox]").hide();
		row.find("div:first").html(function(index,html){ return '&#8597;&nbsp;' + html.replace(/\&nbsp;/g,''); }).attr('class', function(i, c){
			return c.replace(/4/g, '5');
		});
		row.find("div:last").attr('class', function(i, c){ return c.replace(/4/g, '5'); });
		row.append(timeSelectRow);
		out += row.prop('outerHTML');
	});
	battleWindow.sBody().html(out + '<div>');
	if(battlePacket && Object.keys(battlePacket).length > 0) {
		$.each(battlePacket, function(item) {
			battleWindow.sBody().find('input[id="'+item+'"]').closest("div.row").find("select").val(battlePacket[item].time);
		});
		var keys = Object.keys(battlePacket);
		var sorted = battleWindow.sBody().find("div.row").sort(function(a, b) {
			return keys.indexOf($(a).find("[type=checkbox]").prop("id")) > keys.indexOf($(b).find("[type=checkbox]").prop("id")) ? 1 : -1;
		});
		battleWindow.sBody().find('.container-fluid').html(sorted);
	}
	battleWindow.sBody().find("#specOpen").click(battleShowGeneral);
	battleWindow.sBody().find(".container-fluid").sortable();
	$('#' + battleWindow.rawsId).modal({backdrop: "static"});
}

function battleSaveTemplate()
{
	var sortOrder = {}, savePacket = {}, sortedPacket = {};
	battleWindow.sBody().find('[type=checkbox]').each(function(i, item) { sortOrder[item.id] = { 'order': i, 'time': parseInt($(item).closest("div.row").find("select").val()) }; });
	battleWindow.withBody('[type=checkbox]:checked').each(function(i, item) {
		var spec = armyGetSpecialistFromID(item.id);
		savePacket[item.id] = { 'grid': spec.GetGarrisonGridIdx(), 'name': spec.getName(false), 'order': sortOrder[item.id].order, 'time': sortOrder[item.id].time };
		var grid = $(item).closest("div.row").find("button").val();
		if(!grid || grid == 0 || grid == "0") { return; }
		savePacket[item.id].target = parseInt(grid);
		savePacket[item.id].targetName = loca.GetText("BUI", game.zone.mStreetDataMap.GetBuildingByGridPos(parseInt(grid)).GetBuildingName_string());
	});
	Object.keys(savePacket).sort(function(a, b){ return savePacket[a].order - savePacket[b].order; }).forEach(function(key) { sortedPacket[key] = savePacket[key]; });
	$('#' + battleWindow.rawsId).modal('hide');
	if(Object.keys(savePacket).length > 0) { battleTemplates.save(sortedPacket); }
	battlePacket = {};
}

function battleSendGeneral(spec, name, targetName, type, target)
{
	try
	{
		game.gi.mCurrentCursor.mCurrentSpecialist = spec;
		var stask = new armySpecTaskDef();
		stask.uniqueID = spec.GetUniqueID();
		stask.subTaskID = 0;
		swmmo.application.mGameInterface.SendServerAction(95, type, target, 0, stask);
		game.chatMessage(name.replace(/(<([^>]+)>)/gi, "") + (type == 5 ? ' x ' : ' > ') + targetName, 'battle');
	}
	catch (error) { }
}

function battleLoadDataCheck(data)
{
	$.each(data, function(item) { 
		var spec = armyGetSpecialistFromID(item);
		data[item].spec = spec;
		if(spec == null) { return; }
		data[item].onSameGrid = spec.GetGarrisonGridIdx() == data[item].grid;
		data[item].canMove = spec.GetTask() == null && 
		                     game.zone.mStreetDataMap.GetBlocked(data[item].grid) == 0 && 
							 !game.zone.mStreetDataMap.IsBlockedAllowedNothingOrFog(data[item].grid) && (
								spec.GetGarrisonGridIdx() == -1 ||
								game.gi.mPathFinder.CalculatePath(data[item].grid, spec.GetGarrisonGridIdx(), null, true).pathLenX10000 > 0
							 );
		data[item].canAttack = spec.GetTask() == null && 
		                       data[item].target > 0 && 
							   spec.GetTask() == null && 
							   spec.HasUnits() && 
							   game.zone.mStreetDataMap.GetBuildingByGridPos(data[item].target) != null &&
							   game.gi.mPathFinder.CalculatePath(game.zone.mStreetDataMap.GetBuildingByGridPos(data[item].target).GetStreetGridEntry(), spec.GetGarrisonGridIdx(), null, true).pathLenX10000 > 0;
		data[item].canSubmitMove = data[item].canMove && !data[item].onSameGrid;
		data[item].canSubmitAttack = data[item].canAttack && data[item].target > 0;
	});
	return data;
}

function battleLoadData()
{
	battleWindow.withFooter(".directAttack").hide();
	battleWindow.withFooter(".reset").show();
	var out = '<div class="container-fluid" style="user-select: all;">';
	out += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [4, getText('armyCurrentArmy')], [1, loca.GetText("LAB", "Objective")], [2, loca.GetText("LAB", "Attack")], [1, '#']], true);
	var canSubmitAttack = true, canSubmitMove = false, attackSubmitChecker = [];
	battlePacket = battleLoadDataCheck(battlePacket);
	$.each(battlePacket, function(item) { 
		if(battlePacket[item].spec == null) {
			out += utils.createTableRow([
				[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + battlePacket[item].name], 
				[8, 'spec is null', "buffNotReady"]]);
			canSubmitAttack = false, canSubmitMove = false;
			return;
		}
		var info = '';
		battlePacket[item].spec.GetArmy().GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(squad){
			info += utils.getImageTag(squad.GetType()) + ' ' + squad.GetAmount() + '&nbsp;';
		});
		out += utils.createTableRow([
			[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + getImageTag(battlePacket[item].spec.getIconID(), '24px', '24px') + ' ' + battlePacket[item].name], 
			[4, info],
			[1, battlePacket[item].grid, battlePacket[item].canMove || battlePacket[item].onSameGrid ? "buffReady" : "buffNotReady"],
			[2, battlePacket[item].target > 0 ? battlePacket[item].targetName : '', !battlePacket[item].target ? '' : battlePacket[item].canSubmitAttack ? "buffReady" : "buffNotReady"],
			[1, (battlePacket[item].time / 1000) + 's']]);
		if(battlePacket[item].canSubmitMove) { canSubmitMove = true; }
		if(!battlePacket[item].canSubmitAttack && battlePacket[item].target > 0) { canSubmitAttack = false; }
		if(battlePacket[item].target > 0) { attackSubmitChecker.push(battlePacket[item].canSubmitAttack); }
	});
	battleWindow.Body().html(out + '<div>');
	if(canSubmitAttack && attackSubmitChecker.indexOf(false) == -1 && attackSubmitChecker.length > 0) { battleWindow.withFooter(".loadAttack").show(); }
	if(canSubmitMove) { battleWindow.withFooter(".loadMove").show(); }
	battleWindow.withBody(".close").click(function(e) { 
		delete battlePacket[$(e.currentTarget).val()];
		$(e.currentTarget).closest('.row').remove();
		battleLoadData();
	});
}

function battleAttack(direct)
{
	direct = typeof direct === "boolean" ? direct : false;
	battleTimedQueue = new TimedQueue(1000);
	$.each(battlePacket, function(item) {
		if(!battlePacket[item].canAttack) { return; }
		var spec = armyGetSpecialistFromID(item);
		battleTimedQueue.add(function(){ battleSendGeneral(spec, battlePacket[item].name, battlePacket[item].targetName, 5, battlePacket[item].target); }, battlePacket[item].time);
	});
	if(battleTimedQueue.len() > 0) {
		battleTimedQueue.run();
		if(!direct) { battleWindow.hide(); }
		showGameAlert(getText('command_sent'));
	}
}

function battleMove(direct)
{
	direct = typeof direct === "boolean" ? direct : false;
	battleTimedQueue = new TimedQueue(1000);
	$.each(battlePacket, function(item) {
		if(!battlePacket[item].canMove) { return; }
		var spec = armyGetSpecialistFromID(item);
		battleTimedQueue.add(function(){ battleSendGeneral(spec, battlePacket[item].name, battlePacket[item].grid, 4, battlePacket[item].grid); });
	});
	if(battleTimedQueue.len() > 0) {
		battleTimedQueue.run();
		if(!direct) { battleWindow.hide(); }
		showGameAlert(getText('command_sent'));
	}
}

function battleAttackDirect()
{
	battleTimedQueue = new TimedQueue(1000);
	battleWindow.withBody('[type=checkbox]').each(function(i, item) {
		var spec = armyGetSpecialistFromID(item.id);
		var grid = $(item).closest("div.row").find("button").val();
		if(!grid || grid == 0 || grid == "0") { return; }
		if(game.gi.mPathFinder.CalculatePath(game.zone.mStreetDataMap.GetBuildingByGridPos(grid).GetStreetGridEntry(), spec.GetGarrisonGridIdx(), null, true).pathLenX10000 != 0) {
			battleTimedQueue.add(function(){ battleSendGeneral(spec, spec.getName(false), grid, 5, grid); });
		}
	});
	if(battleTimedQueue.len() > 0) {
		battleTimedQueue.run();
		battleWindow.hide();
		showGameAlert(getText('command_sent'));
	}
}

function battleTruncateName(str, n){ 
	return (str.length > n) ? str.slice(0, n-1) + '...' : str;
};

function battleDropdown(data)
{
	var groupSend = $('<div>', { 'class': 'dropdown' }).append([
			$('<button>').attr({ 
				"class": "btn btn-success dropdown-toggle",
				"style": 'height: 28px;display:none;',
				'aria-haspopup': 'true',
				'aria-expanded': 'false',
				'data-toggle': "dropdown"
			}).text(loca.GetText("LAB", "Select"))
	]);
	var groupSendItems = $('<div>', {
		'x-placement': 'bottom-start',
		'style': 'background: transparent; position: absolute; top: -70px; width:900px; height: 150px; overflow-y: scroll;',
		'class': 'dropdown-menu modal-content'
	});

	var buttonsBySector = {};
	var sectorModifier = game.def("Map::AdditionalDataTSO").Sector;
	data.forEach(function(item){
		try {
			var grid = item.GetGrid(),
				sectorId = game.zone.mStreetDataMap.mAdditionalData.get(grid, sectorModifier),
				info = '';
			item.GetArmy().GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(squad){
				info += utils.getImageTag(squad.GetType(), '24px', '24px') + ' ' + squad.GetAmount() + '&nbsp;';
			});
			buttonsBySector[sectorId] = buttonsBySector[sectorId] || [$('<li>', { 'style': 'float: left;' }).html($('<button>', { 'class': 'btn', 'style': 'clear: both;color:black;height:39px;', 'id': 0, 'value': loca.GetText("LAB", "Select") }).html(getText("btn_reset"))).prop('outerHTML')];
			buttonsBySector[sectorId].push($('<li>', { 'style': 'float: left;' }).html($('<button>', { 'class': 'btn', 'style': 'clear: both;color:black;', 'id': grid, 'value': loca.GetText("BUI", item.GetBuildingName_string()) }).html(info)).prop('outerHTML'));
		} catch (e) { }
	});
	var tabs = $('<ul>', { 'class': 'nav nav-pills nav-justified', 'style': 'width: 65%;' });
	var tabcontent = $('<div>', { 'class': 'tab-content' });
	Object.keys(buttonsBySector).sort().forEach(function(v, i) {
		tabs.append($('<li>', { 'class': v == 1 ? 'active' : '' }).append($('<a>', { 'data-toggle': 'tab', 'href': '#menu'+v }).text(v)));
		tabcontent.append($('<div>', { 'class': 'tab-pane fade' + (v == 1 ? ' in active' : ''), 'id': 'menu' + v }).append(buttonsBySector[v].join('')));
	});
	groupSendItems.append([tabs, tabcontent]);
	groupSend.append(groupSendItems);
	$("#battleWindow .modal-content #armyDrop").html(groupSend.prop("outerHTML"));
	$('#battleWindow .dropdown-menu a[data-toggle="tab"]').click(function (e) {
		e.stopPropagation();
		$(this).tab('show');
	});
}

function battleGetData()
{
	battleSearchFor = null;
	battleWindow.withFooter(".directAttack").show();
	battleWindow.withFooter(".loadAttack, .loadMove, .reset").hide();
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [4, getText('armyCurrentArmy')], [4, loca.GetText("LAB", "Attack")]], true);
	game.zone.GetSpecialists_vector().sort(specNameSorter).forEach(function(item){
		try {
			if(!armySPECIALIST_TYPE.IsGeneral(item.GetType()) || item.getPlayerID() != game.player.GetPlayerId()) { return; }
			if(item == null || typeof item == 'undefined' || item.GetTask() != null) { return; }
			var info = '';
			var uniqId = item.GetUniqueID().toKeyString();
			item.GetArmy().GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(squad){
				info += utils.getImageTag(squad.GetType()) + ' ' + squad.GetAmount() + '&nbsp;';
			});
			if (item.GetGarrisonGridIdx() > 0) {
				html += utils.createTableRow([
					[4, '<input type="checkbox" id="' + uniqId + '" />&nbsp;' + $(getImageTag(item.getIconID(), '24px', '24px')).css("cursor", "pointer").attr({ "id": "specOpen", 'name': item.GetGarrisonGridIdx() }).prop('outerHTML') + ' ' + item.getName(false)], 
					[4, info],
					[4, (item.HasUnits() ? $("<button>", { "class": "btn btn-sm btn-success", "style": 'height: 28px;', 'id': uniqId }).text(loca.GetText("LAB", "Select")).prop("outerHTML") + '&nbsp;&nbsp;'    + $(getImageTag("accuracy.png", '24px', '24px')).css("cursor", "pointer").attr({ "id": "specOpen" }).prop("outerHTML") : ''), 'armySelect']]);
			} else {
				html += utils.createTableRow([
					[4, '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + getImageTag(item.getIconID(), '24px', '24px') + ' ' + item.getName(false)], 
					[8, getImageTag("Star", '24px', '24px')]]);
			}
		} catch(e) {}
	});
	battleWindow.Body().html(html + '<div>');
	if(battlePacket && Object.keys(battlePacket).length > 0) {
		$.each(battlePacket, function(item) {
			if(battlePacket[item].target && game.zone.mStreetDataMap.GetBuildingByGridPos(battlePacket[item].target) != null) {
				battleWindow.withBody('button[id="'+item+'"]').text(battlePacket[item].targetName).val(battlePacket[item].target);
			}
			battleWindow.withBody('input[id="'+item+'"]').prop("checked", true);
		});
	}
	battleWindow.withBody("button").click(function(e){
		battleSearchFor = this.id;
		e.stopPropagation();
		$("#battleWindow .dropdown-toggle").dropdown('toggle');
	});
	battleWindow.withBody(".armySelect").css("overflow", "visible");
	battleWindow.withBody(".armySelect > div").css("overflow", "visible");
	battleWindow.Dialog().find(".dropdown-menu button").click(function() {
		battleWindow.withBody('button[id="'+battleSearchFor+'"]').text(battleTruncateName($(this).val(), 25)).val(this.id);
	});
	battleWindow.Dialog().find(".dropdown-menu button").hover(function() {
		var grid = this.id;
		if(!grid || grid == 0 || grid == "0") { return; }
		game.zone.ScrollToGrid(this.id);
		game.gi.SelectBuilding(game.zone.mStreetDataMap.GetBuildingByGridPos(this.id));
	});
	battleWindow.Dialog().find('.dropdown').on('show.bs.dropdown', function () {
		$("#battleWindow .modal-header, .modal-body, .modal-footer").css("opacity", 0);
	});
	battleWindow.Dialog().find('.dropdown').on('hide.bs.dropdown', function () {
		$("#battleWindow .modal-header, .modal-body, .modal-footer").css("opacity", 1);
	});
	battleWindow.withBody("#specOpen").click(battleShowGeneral);
}

function battleShowGeneral()
{
	var grid = this.name || $(this).closest("div").find("button").val();
	if(!grid || grid == 0 || grid == "0") { return; }
	game.zone.ScrollToGrid(grid);
	if(!this.name) { game.gi.SelectBuilding(game.zone.mStreetDataMap.GetBuildingByGridPos(grid)); }
	$("#battleWindow, #battleWindowsettings").css("opacity", 0);
	setTimeout(function() { $("#battleWindow, #battleWindowsettings").css("opacity", 1); }, 1500);
}
