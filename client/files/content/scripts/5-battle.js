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
		battleTemplates = new SaveLoadTemplate('battle', function(data, name) {
			if(!data[Object.keys(data)[0]].grid) {
				showGameAlert(getText("bad_template"));
				return;
			}
			battlePacket = data;
			battleWindow.withHeader('.templateFile').html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
			try{
				battleLoadData();
			} catch(e) {
				game.chatMessage("Error loading " + e, 'army_move');
			}
		});
		battlePacket = {};
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
		battleWindow.withHeader('.templateFile').html("");
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
	try {
		var sortOrder = {}, savePacket = {}, sortedPacket = {};
		battleWindow.sBody().find('[type=checkbox]').each(function(i, item) { sortOrder[item.id] = { 'order': i, 'time': parseInt($(item).closest("div.row").find("select").val()) }; });
		battleWindow.withBody('[type=checkbox]:checked').each(function(i, item) {
			var spec = armyGetSpecialistFromID(item.id);
			savePacket[item.id] = { 
				'grid': spec.GetGarrisonGridIdx(),
				'name': spec.getName(false),
				'order': sortOrder[item.id].order,
				'time': sortOrder[item.id].time,
				'skills': {},
				'type': spec.GetType()
			};
			spec.getSkillTree().getItems_vector().forEach(function(skill, index){
				if(skill.getLevel() > 0) { savePacket[item.id].skills[index] = skill.getLevel(); }
			});
			var grid = $(item).closest("div.row").find("button").val();
			if(!grid || grid == 0 || grid == "0") { return; }
			savePacket[item.id].target = parseInt(grid);
			savePacket[item.id].targetName = $(item).closest("div.row").find("button").text();
		});
		Object.keys(savePacket).sort(function(a, b){ return savePacket[a].order - savePacket[b].order; }).forEach(function(key) { sortedPacket[key] = savePacket[key]; });
		$('#' + battleWindow.rawsId).modal('hide');
		if(Object.keys(savePacket).length > 0) { battleTemplates.save(sortedPacket); }
		battlePacket = {};
	} catch (e) { alert("Error save " + e); }
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
	game.gi.mMouseCursor.SetCursorEditMode(86);
	$.each(data, function(item) { 
		var spec = armyGetSpecialistFromID(item);
		data[item].spec = spec;
		if(spec == null) { return; }
		data[item].onSameGrid = spec.GetGarrisonGridIdx() == data[item].grid;
		game.gi.mCurrentCursor.mCurrentSpecialist = spec;
		data[item].canMove = spec.GetTask() == null && (game.gi.mMouseCursor.CheckIfGarrisonIsPlacableInGame(data[item].grid, true) == 0 || (data[item].grid == -1 && spec.GetGarrisonGridIdx() > 0));
		data[item].canAttack = battlecheckCanAttack(spec, data[item].target) && data[item].onSameGrid;
		data[item].canSubmitMove = data[item].canMove && !data[item].onSameGrid;
		data[item].canSubmitAttack = data[item].canAttack && data[item].target > 0;
	});
	game.gi.mMouseCursor.SetToLastEditMode();
	return data;
}

function battlecheckCanAttack(id, target)
{
	var spec = typeof id == 'object' ? id : armyGetSpecialistFromID(id);
	if(spec == null) { return false; }
	return target > 0 && 
		   spec.GetTask() == null && 
		   spec.HasUnits() && 
		   game.zone.mStreetDataMap.GetBuildingByGridPos(target) != null &&
		   game.gi.mPathFinder.CalculatePath(game.zone.mStreetDataMap.GetBuildingByGridPos(target).GetStreetGridEntry(), spec.GetGarrisonGridIdx(), null, true).pathLenX10000 > 0;
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
				[8, '<b>' + getText('NoData') + '</b>']]);
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
			[1, battlePacket[item].grid > 0 ? battlePacket[item].grid : 'star', battlePacket[item].canMove ? "buffReady" : battlePacket[item].onSameGrid ? "specSamegrid" : "buffNotReady"],
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
		if(battlePacket[item].grid > 0) {
			battleTimedQueue.add(function(){ battleSendGeneral(spec, battlePacket[item].name, battlePacket[item].grid, 4, battlePacket[item].grid); });
		} else {
			battleTimedQueue.add(function(){ armySendGeneralToStar(spec); });
		}
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
	battleWindow.withFooter(".loadAttack, .loadMove, .reset, .directAttack").hide();
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
					[4, '<input type="checkbox" id="' + uniqId + '" />&nbsp;' + getImageTag(item.getIconID(), '24px', '24px') + ' ' + item.getName(false)], 
					[8, getImageTag("Star", '24px', '24px')]]);
			}
		} catch(e) {}
	});
	battleWindow.Body().html(html + '<div>');
	if(battlePacket && Object.keys(battlePacket).length > 0) {
		$.each(battlePacket, function(item) {
			if(battlePacket[item].target > 0) {
				battleWindow.withBody('button[id="'+item+'"]').text(battleTruncateName(battlePacket[item].targetName, 25)).val(battlePacket[item].target);
				battleWindow.withBody('button[id="'+item+'"]').closest('div').addClass(battlecheckCanAttack(item, battlePacket[item].target) ? "buffReady" : "buffNotReady");
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
		if(this.id > 0) {
			battleWindow.withBody('button[id="'+battleSearchFor+'"]').closest('div').addClass(battlecheckCanAttack(battleSearchFor, this.id) ? "buffReady" : "buffNotReady");
		} else {
			battleWindow.withBody('button[id="'+battleSearchFor+'"]').closest('div').removeClass( [ "buffReady", "buffNotReady" ] );
		}
		var count = battleWindow.withBody('button').closest('div .buffReady, .buffNotReady').length;
		battleWindow.withFooter('.directAttack').css('display', count > 0 && count == battleWindow.withBody('button').closest('div .buffReady').length ? '' : 'none');
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
	var count = battleWindow.withBody('button').closest('div .buffReady, .buffNotReady').length;
	battleWindow.withFooter('.directAttack').css('display', count > 0 && count == battleWindow.withBody('button').closest('div .buffReady').length ? '' : 'none');
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
