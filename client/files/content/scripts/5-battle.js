var battleEnemiesDrop;
var battleWindow;
var battleSearchFor;
var battlePacket;
var battleTemplates;
var battleTimedQueue;
var battleOkStatus = $('<img>', { 'src': 'images/863_GUI.Assets.gAssetManager_AchievementCompletedCheckedIcon.png' }).prop('outerHTML');
var battleFailStatus = utils.getImage(new(game.def("GUI.Assets::gAssetManager_ExpeditionStateAttention"))().bitmapData, 'auto', '24px');
var battleSearchIcon = utils.getImage(new(game.def("GUI.Assets::gAssetManager_SearchBtnIcon"))().bitmapData, 'auto', '24px');
var battleMoveToStar = $('<img>', { 'src': 'images/1143_GUI.Assets.gAssetManager_ReturnToStarIcon.png' }).prop('outerHTML');
var battleMoveToGrid = $('<img>', { 'src': 'images/1632_GUI.Assets.gAssetManager_UnloadTroopsIcon.png' }).prop('outerHTML');

function battleMenuHandler(event)
{
	try {
		if(battleTimedQueue && battleTimedQueue.index != battleTimedQueue.len())
		{
			game.showAlert(loca.GetText("ALT", "ServerOverstrained"));
			return;
		}
		battleTemplates = new SaveLoadTemplate('battle', function(data, name) {
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
		if(battleWindow.withHeader("#army").length === 0)
		{
			battleWindow.withHeader("").append($('<div>', { id: "army" }));
		}
		var groupSend = $('<div>', { 'class': 'btn-group dropup' }).append([
			$('<button>').attr({ 
				"id": "armySendGeneralsBtn",
				"class": "btn btn-success armySendGeneralsBtn dropdown-toggle",
				'aria-haspopup': 'true',
				'aria-expanded': 'false',
				'data-toggle': "dropdown"
			}).text(loca.GetText("LAB", "Send")), 
			$('<div>', { 'class': 'dropdown-menu' })
		]);
		if(battleWindow.withFooter(".armySaveTemplate").length == 0) {
			battleWindow.Footer().prepend([
				$('<div>').attr({ "class": "span12 text-center" }),
				$('<button>').attr({ "class": "btn btn-primary pull-left armySaveTemplate" }).text(getText('save_template')).click(battleSaveDialog),
				$('<button>').attr({ "class": "btn btn-primary pull-left armyLoadTemplate" }).text(getText('load_template')).click(function() { battleTemplates.load(); }),
				$('<button>').attr({ "class": "btn btn-primary directAttack" }).text(loca.GetText("ACL", "PvPAttacker")).click(battleAttackDirect),
				$('<button>').attr({ "class": "btn btn-primary reset", 'data-toggle': "tooltip", 'data-placement': "top", 'title': loca.GetText("LAB", "CloseDetails") }).html($('<img>', { 'src': 'images/918_GUI.Assets.gAssetManager_BackIcon.png' })).click(battleGetData),
				$('<button>').attr({ "class": "btn btn-primary loadAttack", 'data-toggle': "tooltip", 'data-placement': "top", 'title': loca.GetText("ACL", "PvPAttacker") }).html($('<img>', { 'src': 'images/1647_GUI.Assets.gAssetManager_ButtonIconFindWildZone.png' })).click(battleAttack),
				$('<button>').attr({ "class": "btn btn-primary loadMove", 'data-toggle': "tooltip", 'data-placement': "top", 'title': loca.GetText("LAB", "Move") }).html($('<img>', { 'src': 'images/1648_GUI.Assets.gAssetManager_ButtonIconTrumpet.png' })).click(battleMove),
				$('<button>').attr({ "class": "btn btn-warning armyUnload" }).text(getText('armyUnload')).click(function(){ 
					var queue = new TimedQueue(1000);
					var counter = 1, total = battleWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').length;
					armyProgressCounter = total;
					armyUpdateProgress(-1);
					battleWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').each(function(i, item) {
						var spec = armyGetSpecialistFromID(item);
						if(!spec.HasUnits()) { 
							total--;
							armyProgressCounter--;
							return;
						}
						var dRaiseArmyVO = new dRaiseArmyVODef();
						dRaiseArmyVO.armyHolderSpecialistVO = spec.CreateSpecialistVOFromSpecialist();
						queue.add(function(){ 
							try {
								armyUpdateProgress(Math.round(Math.round((100 * counter) / total) / 10) * 10 / 10);
								game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO, armyResponder);
								counter++;
							} catch(e) { 
								game.chatMessage("Error unloading " + e, 'army');
							}
						});
					});
					if(queue.len() > 0) {
						queue.add(function(){ battleGetData(); }, 6000);
						battleWindow.withFooter("button").prop('disabled',true);
						queue.run();
					}
				}),
				$('<button>').attr({ "class": "btn btn-success armySubmit", 'data-toggle': "tooltip", 'data-placement': "top", 'title': getText('armyLoad') }).html($('<img>', { 'src': 'images/1213_GUI.Assets.gAssetManager_ButtonIconUnitSwitchToOld.png' })).click(armyLoadGenerals),
				$('<span>').html('&nbsp;'),
				groupSend
			]);
			battleWindow.withFooter('[data-toggle="tooltip"]').tooltip();
		}
		try {
			var AdvManager = swmmo.getDefinitionByName("com.bluebyte.tso.adventure.logic::AdventureManager").getInstance();
			battleWindow.withFooter(".dropdown-menu").html($('<li>').html($('<a>', {'href': '#', 'value': '98'}).text(loca.GetText("LAB", "StarMenu"))));
			if (game.gi.mCurrentPlayer.mIsAdventureZone){
				battleWindow.withFooter(".dropdown-menu").append($('<li>').html($('<a>', {'href': '#', 'value': game.player.GetHomeZoneId()}).text(loca.GetText("LAB", "ReturnHome"))));
			}
			AdvManager.getAdventures().forEach(function(item){
				if (item.zoneID !== game.gi.mCurrentViewedZoneID) {
					battleWindow.withFooter(".dropdown-menu").append($('<li>').html($('<a>', {'href': '#', 'value': item.zoneID}).text((item.ownerPlayerID !== game.player.GetPlayerId() ? '*' : '') + loca.GetText("ADN", item.adventureName))));
				}
			});
			battleWindow.withFooter(".dropdown-menu a").click(armyGeneralsSend);
		} catch (error) {
			alert("Err (retry): " + error.message);
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
	try {
		var sortOrder = {}, savePacket = {};
		battleWindow.withBody('[type=checkbox]:not(.toggleSelect)').each(function(i, item) { 
			var delay = $(item).closest("div.row").find("select").val();
			sortOrder[item.id] = { 'order': i, 'time': parseInt(delay||1000) };
		});
		battleWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').each(function(i, item) {
			var spec = armyGetSpecialistFromID(item.id);
			savePacket[item.id] = { 
				'grid': spec.GetGarrisonGridIdx(),
				'name': spec.getName(false),
				'order': sortOrder[item.id].order,
				'time': sortOrder[item.id].time,
				'skills': armyInfo[item.id].skills,
				'army': armyInfo[item.id].army,
				'type': spec.GetType()
			};
			var grid = $(item).closest("div.row").find("button").val();
			if(!grid || grid == 0 || grid == "0") { return; }
			savePacket[item.id].target = parseInt(grid);
			savePacket[item.id].targetName = $(item).closest("div.row").find("button").text();
		});
		if(Object.keys(savePacket).length > 0) { battleTemplates.save(savePacket); }
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
	updateFreeArmyInfo();
	battleWindow.withFooter(".directAttack, .armyUnload, .armySubmit").hide();
	battleWindow.withFooter(".reset").show();
	var out = '<div class="container-fluid" style="user-select: all;">';
	out += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [4, loca.GetText("LAB","MilitaryHelp")], [1, loca.GetText("LAB", "Objective")], [2, loca.GetText("LAB", "Attack")], [1, '#']], true);
	var canSubmitAttack = true, canSubmitMove = false, attackSubmitChecker = [];
	battlePacket = battleLoadDataCheck(battlePacket);
	var checkedPacket = armyLoadDataCheck(battlePacket);
	$.each(battlePacket, function(item) { 
		if(battlePacket[item].spec == null) {
			out += utils.createTableRow([
				[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + battlePacket[item].name], 
				[8, '<b>' + getText('NoData') + '</b>']]);
			canSubmitAttack = false, canSubmitMove = false;
			return;
		}
		var info = '';
		if(!battlePacket[item].army) {
			battlePacket[item].spec.GetArmy().GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(squad){
				info += utils.getImageTag(squad.GetType()) + ' ' + squad.GetAmount() + '&nbsp;';
			});
		} else {
			info += armyPacketMatches[item] ? battleOkStatus : battleFailStatus;
			$.each(checkedPacket[item]['data'].army, function(res) {
				info += utils.getImageTag(res) + ' ' + checkedPacket[item]["data"].army[res] + '&nbsp;';
			});
		}
		var gStatus = checkedPacket[item].gStatus ? battleOkStatus : battleFailStatus;
		out += utils.createTableRow([
			[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + gStatus + getImageTag(battlePacket[item].spec.getIconID(), '24px', '24px') + ' ' + battlePacket[item].name], 
			[4, info],
			[1, (battlePacket[item].canMove || battlePacket[item].onSameGrid ? battleOkStatus : battleFailStatus) + (battlePacket[item].grid > 0 ? battleMoveToGrid : battleMoveToStar), battlePacket[item].canMove ? "buffReady" : battlePacket[item].onSameGrid ? "specSamegrid" : "buffNotReady"],
			[2, (!battlePacket[item].target ? '' : battlePacket[item].canSubmitAttack ? battleOkStatus : battleFailStatus) + (battlePacket[item].target > 0 ? battlePacket[item].targetName : ''), !battlePacket[item].target ? '' : battlePacket[item].canSubmitAttack ? "buffReady" : "buffNotReady"],
			[1, (battlePacket[item].time / 1000) + 's']]);
		if(battlePacket[item].canSubmitMove) { canSubmitMove = true; }
		if(!battlePacket[item].canSubmitAttack && battlePacket[item].target > 0) { canSubmitAttack = false; }
		if(battlePacket[item].target > 0) { attackSubmitChecker.push(battlePacket[item].canSubmitAttack); }
	});
	if(Object.keys(checkedPacket.army).length > 0) {
		out += '<br><p>'+loca.GetText("LAB","MilitaryHelp") + '</p>';
		out += utils.createTableRow([[7, loca.GetText("LAB", "Name")], [2, loca.GetText("LAB", "Requires")], [2, loca.GetText("LAB", "Available")], [1, loca.GetText("LAB", "ProductionStatus")]], true);
		$.each(checkedPacket.army, function(item) {
			var aStatus = armyFreeInfo[item] >= checkedPacket.army[item];
			out += utils.createTableRow([
				[7, loca.GetText("RES", item)], 
				[2, checkedPacket.army[item]],
				[2, armyFreeInfo[item] ? armyFreeInfo[item] : 0],
				[1, aStatus ? 'OK' : 'FAIL', aStatus ? "buffReady" : "buffNotReady"]]);
		});
		if(checkedPacket.canSubmit) {
			battleWindow.withFooter(".armySubmit").show();
		}
	}
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
	battleWindow.withBody('[type=checkbox]:not(.toggleSelect)').each(function(i, item) {
		var spec = armyGetSpecialistFromID(item.id);
		var grid = $(item).closest("div.row").find("button").val();
		if(!grid || grid == 0 || grid == "0") { return; }
		var delay = parseInt($(item).closest("div.row").find("select").val());
		if(game.gi.mPathFinder.CalculatePath(game.zone.mStreetDataMap.GetBuildingByGridPos(grid).GetStreetGridEntry(), spec.GetGarrisonGridIdx(), null, true).pathLenX10000 != 0) {
			battleTimedQueue.add(function(){ battleSendGeneral(spec, spec.getName(false), grid, 5, grid); }, delay);
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
	var first = true;
	Object.keys(buttonsBySector).sort().forEach(function(v, i) {
		tabs.append($('<li>', { 'class': first ? 'active' : '' }).append($('<a>', { 'data-toggle': 'tab', 'href': '#menu'+v }).text(v)));
		tabcontent.append($('<div>', { 'class': 'tab-pane fade' + (first ? ' in active' : ''), 'id': 'menu' + v }).append(buttonsBySector[v].join('')));
		first = false;
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
	updateFreeArmyInfo();
	armyUpdateProgress(-1);
	battleWindow.withFooter(".loadAttack, .loadMove, .reset, .directAttack, .armySubmit, .armyReset").hide();
	battleWindow.withFooter(".armyUnload, .armySendGeneralsBtn").show();
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[4, $('<input>', { 'type': 'checkbox', 'class': 'toggleSelect' }).prop('outerHTML') + '&nbsp;&nbsp;' + loca.GetText("LAB", "Name")], [4, getText('armyCurrentArmy')], [3, loca.GetText("LAB", "Attack")], [1, '#']], true);
	var select = $('<select>').attr('class', 'form-control').append($('<option>', { value: 1000 }).text('1s'));
	for(var i = 2; i < 301; i++) {
		select.append($('<option>', { value: i * 1000 }).text(i+'s'));
	}
	game.zone.GetSpecialists_vector().sort(specNameSorter).forEach(function(item){
		try {
			if(!armySPECIALIST_TYPE.IsGeneral(item.GetType()) || item.getPlayerID() != game.player.GetPlayerId()) { return; }
			if(item == null || typeof item == 'undefined' || item.GetTask() != null) { return; }
			var info = '';
			var uniqId = item.GetUniqueID().toKeyString();
			$.each(armyInfo[uniqId].army, function(item) {
				info += utils.getImageTag(item) + ' ' + armyInfo[uniqId].army[item] + '&nbsp;';
			});
			if (item.GetGarrisonGridIdx() > 0) {
				html += utils.createTableRow([
					[4, '&#8597;&nbsp;<input type="checkbox" id="' + uniqId + '" />&nbsp;' + $(getImageTag(item.getIconID(), '24px', '24px')).css("cursor", "pointer").attr({ "id": "specOpen", 'name': item.GetGarrisonGridIdx() }).prop('outerHTML') + ' ' + item.getName(false)], 
					[4, info],
					[3, (item.HasUnits() && !item.GetSpecialistDescription().isTransportGeneral() ? $("<button>", { "class": "btn btn-sm btn-success", "style": 'height: 28px;', 'id': uniqId }).text(loca.GetText("LAB", "Select")).prop("outerHTML") + '&nbsp;' + $(battleSearchIcon).css("cursor", "pointer").attr({ "id": "specOpen" }).prop("outerHTML") : ''), 'armySelect'],
					[1, item.HasUnits() && !item.GetSpecialistDescription().isTransportGeneral() ? select.clone() : '']
				]);
			} else {
				html += utils.createTableRow([
					[4, '&#8597;&nbsp;<input type="checkbox" id="' + uniqId + '" />&nbsp;' + getImageTag(item.getIconID(), '20px', '20px') + ' ' + item.getName(false)], 
					[8, getImageTag("Star", '20px', '20px')]]);
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
			battleWindow.withBody('input[id="'+item+'"]').closest("div.row").find("select").val(battlePacket[item].time);
			battleWindow.withBody('input[id="'+item+'"]').prop("checked", true);
		});
		var keys = Object.keys(battlePacket);
		battleWindow.withBody("div.row:gt(0)").sort(function(a, b) {
			return $(a).find('[type=checkbox]').is(':checked') ? -1 : 1;
		}).sort(function(a, b) {
			var aVal = $(a).find("[type=checkbox]").prop("id");
			var bVal = $(b).find("[type=checkbox]").prop("id");
			if(keys.indexOf(aVal) == -1 || keys.indexOf(bVal) == -1) { return 0; }
			return keys.indexOf(aVal) > keys.indexOf(bVal) ? 1 : -1;
		}).appendTo(battleWindow.withBody('.container-fluid'));
	}
	battleWindow.withBody(".container-fluid").sortable();
	battleWindow.withBody("button").click(function(e){
		battleSearchFor = this.id;
		e.stopPropagation();
		$("#battleWindow .dropdown-toggle").dropdown('toggle');
	});
	battleWindow.Dialog().find(".dropdown-menu button").click(function() {
		battleWindow.withBody('button[id="'+battleSearchFor+'"]').text(battleTruncateName($(this).val(), 25)).val(this.id);
		battleWindow.withBody('button[id="'+battleSearchFor+'"]').closest('div').removeClass( [ "buffReady", "buffNotReady" ] );
		if(this.id > 0) {
			battleWindow.withBody('button[id="'+battleSearchFor+'"]').closest('div').addClass(battlecheckCanAttack(battleSearchFor, this.id) ? "buffReady" : "buffNotReady");
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
		battleWindow.Dialog().find('.modal-content:eq(0)').css('box-shadow', 'none');
	});
	battleWindow.Dialog().find('.dropdown').on('hide.bs.dropdown', function () {
		$("#battleWindow .modal-header, .modal-body, .modal-footer").css("opacity", 1);
		battleWindow.Dialog().find('.modal-content:eq(0)').css('box-shadow', '');
	});
	battleWindow.withBody(".toggleSelect").change(function() {
		battleWindow.withBody('input[type="checkbox"]').prop("checked", this.checked);
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
