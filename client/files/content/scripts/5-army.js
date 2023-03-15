var armySPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
var armyMilitarySystem = swmmo.getDefinitionByName("MilitarySystem::cMilitaryUtil");
var armyMilitaryBase = swmmo.getDefinitionByName("MilitarySystem::cMilitaryUnitBase");
var dRaiseArmyVODef = swmmo.getDefinitionByName("Communication.VO::dRaiseArmyVO");
var dResourceVODef = swmmo.getDefinitionByName("Communication.VO::dResourceVO");
var armySpecTaskDef = swmmo.getDefinitionByName("Communication.VO::dStartSpecialistTaskVO");
var armySpecTravelDef = swmmo.getDefinitionByName("Specialists::cSpecialistTask_TravelToStarMenu");
var armyServices = swmmo.getDefinitionByName("com.bluebyte.tso.service::ServiceManager").getInstance();
var armyResponder = game.createResponder(armyResponderHandler, armyResponderHandler);
var armyPacket = {};
var armyPacketMatches = {};
var armyInfo = {};
var armyFreeInfo = {};
var armyProgressCounter = 0;
var armyWindow;
var armyTemplates;
var armyProgress = [
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_BuildQueueTempSlotTimeLeftIcon"))().bitmapData) + ' 5s',
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar1"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar2"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar3"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar3"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar4"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar4"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar5"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar6"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar7"))().bitmapData),
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_WinConditionHealthBar7"))().bitmapData)
];

function armyResponderHandler(event, data)
{
	armyProgressCounter--;
	if(armyProgressCounter <= 0) {
		armyUpdateProgress(0);
		setTimeout(function() {
			armyFreeInfo = {};
			updateFreeArmyInfo();
			armyUpdateProgress(-1);
			armyWindow.withFooter("button").prop('disabled',false);
			armyGetData();
		}, 5000);
	}
}

function armyGetChecksum(army)
{
	var result = 0;
	$.each(army.army, function(res) {
		result = result ^ (armyMilitaryBase.GetUnitBaseForType(res).GetCombatPriority() + (army.army[res] << 6));
	});
	return result;
}

function updateFreeArmyInfo(direct)
{
	direct = typeof direct === "boolean" ? direct : false;
	var freeArmy = '<div class="container-fluid"><center>';
	var armyCategory = [];
	armyFreeInfo = {};
	game.zone.GetArmy(game.player.GetPlayerId()).GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(item){
		var cat = item.GetUnitBase().GetUnitCategory() + +item.GetUnitBase().GetIsElite();
		armyCategory[cat] = armyCategory[cat] || '';
		armyCategory[cat] += utils.getImageTag(item.GetType(), '20px') + ' ' + item.GetAmount() + '&nbsp;';
		armyFreeInfo[item.GetType()] = item.GetAmount();
	});
	freeArmy += armyCategory.filter(function(a) { return '<p>' + a; }).join('</p>');
	freeArmy += '</center>';
	if(!direct) {
		armyWindow.withHeader("#army").html(freeArmy + '</div>');
	}
}

function armyUpdateProgress(num)
{
	if(num == -1) {
		armyWindow.withFooter(".span12").html("");
		return;
	}
	if(armyProgress[num]) {
		armyWindow.withFooter(".span12").html(armyProgress[num]);
	}
}

function armyConvertTemplate(data)
{
	if(data[Object.keys(data)[0]].army) { return data; }
	var newData = {};
	$.each(data, function(item) { 
		newData[item] = { 'name': data[item].name, 'army': {} };
		delete data[item].name;
		newData[item].army = data[item];
	});
	return newData;
}

function armyMenuHandler(event)
{
	armyTemplates = new SaveLoadTemplate('army', function(data) {
		try{
			armyPacket = armyConvertTemplate(data);
			armyLoadData();
		} catch(e) {
			game.chatMessage("Error loading " + e, 'army');
		}
	});
	armyWindow = new Modal('armyWindow', utils.getImageTag('icon_general.png', '45px') + ' ' + loca.GetText("LAB","Army"));
	armyWindow.create();
	if(armyWindow.Title().find(".btn-wartime").length == 0) {
		armyWindow.Title().append($('<button>').attr({ "class": "btn btn-wartime pull-right", 'style': 'position:relative;top:2px;left:-5px;' }).text(loca.GetText("ACL", "ExcelsiorLostCityBeforeRitual")));
		armyWindow.Title().find(".btn-wartime").click(battleMenuHandler);
	}
	if(armyWindow.withHeader("#army").length === 0)
	{
		armyWindow.withHeader("").append($('<div>', { id: "army" }));
	}
	updateFreeArmyInfo();
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
	if(armyWindow.withFooter(".armyUnload").length == 0) {
		armyWindow.Footer().prepend([
			$('<div>').attr({ "class": "span12 text-center" }),
			$('<button>').attr({ "class": "btn btn-warning armyUnload" }).text(getText('armyUnload')).click(function(){ 
				var queue = new TimedQueue(1000);
				var counter = 1, total = armyWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').length;
				armyProgressCounter = total;
				armyUpdateProgress(-1);
				armyWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').each(function(i, item) {
					var uniqueID = item.id.split(".")
					var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
					var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
					if(!spec.HasUnits()) { 
						$(item).closest('.row').remove();
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
							$(item).closest('.row').remove();
						} catch(e) { 
							game.chatMessage("Error unloading " + e, 'army');
						}
					});
				});
				if(queue.len() > 0) {
					armyWindow.withFooter("button").prop('disabled',true);
					queue.run();
				}
			}),
			$('<button>').attr({ "class": "btn btn-warning armyReload" }).text(loca.GetText("LAB", "Update")).click(function() {
				try{
					armyLoadData();
				} catch(e) {
					game.chatMessage("Error reloading " + e, 'army');
				}
			}),
			$('<button>').attr({ "class": "btn btn-warning armyReset" }).text(getText('btn_reset')).click(function() {
				armyWindow.withFooter(".armySubmit, .armyReset").hide();
				armyWindow.withFooter(".armySaveTemplate, .armyLoadTemplate, .armyUnload, .armySendGeneralsBtn").show();
				armyGetData();
			}),
			$('<button>').attr({ "class": "btn btn-success armySubmit" }).text(getText('armyLoad')).click(armyLoadGenerals),
			$('<span>').html('&nbsp;'),
			groupSend,
			$('<button>').attr({ "class": "btn btn-primary pull-left armySaveTemplate" }).text(getText('save_template')).click(function(){ 
				var savePacket = {};
				armyWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').each(function(i, item) {
					savePacket[item.id] = armyInfo[item.id];
				});
				if(Object.keys(savePacket).length > 0) { 
					armyTemplates.save(savePacket);
				}
			}),
			$('<button>').attr({ "class": "btn btn-primary pull-left armyLoadTemplate" }).text(getText('load_template')).click(function() { armyTemplates.load(); })
		]);
	}
	try {
		var AdvManager = swmmo.getDefinitionByName("com.bluebyte.tso.adventure.logic::AdventureManager").getInstance();
		armyWindow.withFooter(".dropdown-menu").html($('<li>').html($('<a>', {'href': '#', 'value': '98'}).text(loca.GetText("LAB", "StarMenu"))));
		if (game.gi.mCurrentPlayer.mIsAdventureZone){
			armyWindow.withFooter(".dropdown-menu").append($('<li>').html($('<a>', {'href': '#', 'value': game.player.GetHomeZoneId()}).text(loca.GetText("LAB", "ReturnHome"))));
		}
		AdvManager.getAdventures().forEach(function(item){
			if (item.zoneID !== game.gi.mCurrentViewedZoneID) {
				armyWindow.withFooter(".dropdown-menu").append($('<li>').html($('<a>', {'href': '#', 'value': item.zoneID}).text((item.ownerPlayerID !== game.player.GetPlayerId() ? '*' : '') + loca.GetText("ADN", item.adventureName))));
			}
		});
		armyWindow.withFooter(".dropdown-menu a").click(armyGeneralsSend);
	} catch (error) {
		alert("Err (retry): " + error.message);
	}
	armyWindow.withFooter(".armySubmit, .armyReset, .armyReload").hide();
	armyWindow.withFooter(".armySaveTemplate, .armyLoadTemplate").show();
	armyGetData();
	armyWindow.show();
}

function armyGeneralsSend(e)
{
	try
	{
		var queue = new TimedQueue(1000);
		var OptionSelected = $(e.target).attr('value');
		armyWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').each(function(i, item) {
			var spec = armyGetSpecialistFromID(item);
			if(spec == null) { return; }
			if (OptionSelected == '98') {
				if(spec.GetGarrisonGridIdx() > 0) {
					queue.add(function(){ armySendGeneralToStar(spec); });
				}
			} else {
				queue.add(function(){ armyServices.specialist.sendToZone(spec, OptionSelected); });
			}
		});
		if(queue.len() > 0) {
			queue.run();
			armyWindow.hide();
			showGameAlert(getText('command_sent'));
		}
	}
	catch (error) {
		alert("send error : " + error.message);
	}
}

function armyGetSpecialistFromID(item)
{
	try{
		var uniqueID = item.id !== undefined ? item.id.split(".") : item.split(".");
		var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
		var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
		return spec;
	} catch (e) {
		game.chatMessage("Error parse id " + item + " - " + e, 'army');
	}
	return null;
}

function armySendGeneralToStar(spec)
{
	try
	{
		game.gi.mCurrentCursor.mCurrentSpecialist = spec;
		var stask = new armySpecTaskDef();
		stask.uniqueID = spec.GetUniqueID();
		stask.subTaskID = 0;
		swmmo.application.mGameInterface.SendServerAction(95,12,swmmo.application.mGameInterface.mCurrentCursor.GetGridPosition(),0,stask);
		spec.SetTask(new armySpecTravelDef(swmmo.application.mGameInterface,spec,0,12));
	}
	catch (error) {
		alert("Send to star error : " + error.message);
	}
}

function armyLoadGenerals(direct)
{
	direct = typeof direct === "boolean" ? direct : false;
	var queue = new TimedQueue(1000);
	var counter = 1, total = Object.keys(armyPacket).length;
	armyProgressCounter = total;
	$.each(armyPacket, function(item) { 
		if(!direct && armyPacketMatches[item]) {
			total--;
			armyProgressCounter--;
			return;
		}
		var dRaiseArmyVO = new dRaiseArmyVODef();
		var spec = armyGetSpecialistFromID(item);
		if(spec == null) { return; }
		dRaiseArmyVO.armyHolderSpecialistVO = spec.CreateSpecialistVOFromSpecialist();
		$.each(armyPacket[item].army, function(res) {
			var dResourceVO = new dResourceVODef();
			dResourceVO.name_string = res;
			dResourceVO.amount = armyPacket[item].army[res];
			dRaiseArmyVO.unitSquads.addItem(dResourceVO);
		});
		queue.add(function(){ 
			if(!direct) {
				armyWindow.withBody('.close[value="'+item+'"]').closest("div.row div:first-child").addClass("buffReady");
				armyUpdateProgress(Math.round(Math.round(100 * counter / total) / 10) * 10 / 10);
				game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO, armyResponder);
				counter++;
			} else {
				game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO);
			}
		});
		
		
	});
	if(!direct && queue.len() > 0) {
		armyWindow.withFooter("button").prop('disabled',true);
	}
	queue.run();
}

function armyLoadDataCheck(data)
{
	var result = { 'canSubmit': true }, requiredArmy = {};
	armyPacketMatches = {};
	var canFree = false;
	$.each(data, function(item) { 
		result[item] = result[item] || { 'data': data[item] };
		var spec = armyGetSpecialistFromID(item);
		result[item].spec = spec;
		if(spec == null) { return; }
		var curArmyChecksum = armyInfo[item]&&armyGetChecksum(armyInfo[item]);
		var alreadyMatch = armyGetChecksum(data[item]) == curArmyChecksum;
		armyPacketMatches[item] = alreadyMatch;
		$.each(data[item].army, function(res) {
			if(!alreadyMatch) {
				var req = data[item].army[res] - armyGetSquadCount(item, res);
				if(req > 0) { 
					requiredArmy[res] = requiredArmy[res] + req || req;
				} else {
					canFree = true;
				}
			}
		});
		var gStatus = spec.GetGarrison() != null && spec.GetTask() == null;
		result[item].gStatus = gStatus;
		if(!gStatus && !alreadyMatch) { 
			result.canSubmit = false;
		}
	});
	result["army"] = requiredArmy;
	$.each(requiredArmy, function(item) {
		var aStatus = armyFreeInfo[item] >= requiredArmy[item];
		if(!aStatus) { result.canSubmit = false; }
	});
	if(Object.keys(requiredArmy).length == 0 && !canFree) { result.canSubmit = false; }
	return result;
}

function armyLoadData()
{
	if(Object.keys(armyPacket).length == 0) {
		return armyGetData();
	}
	updateFreeArmyInfo();
	armyWindow.withFooter(".armyUnload, .armySendGeneralsBtn").hide();
	armyWindow.withFooter(".armyReset, .armyReload").show();
	var out = '<div class="container-fluid" style="user-select: all;">';
	out += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [7, getText('armyNewArmy')], [1, loca.GetText("LAB", "ProductionStatus")]], true);
	var checkedPacket = armyLoadDataCheck(armyPacket);
	$.each(checkedPacket, function(item) {
		if(item == 'army' || item == 'canSubmit') { return; }
		if(checkedPacket[item].spec == null) {
			out += utils.createTableRow([
				[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + checkedPacket[item]["data"]["name"]], 
				[7, getGext('NoData')],
				[1, 'FAIL', "buffNotReady"]]);
			return;
		}
		var info = '';
		$.each(checkedPacket[item]['data'].army, function(res) {
			info += utils.getImageTag(res) + ' ' + checkedPacket[item]["data"].army[res] + '&nbsp;';
		});
		out += utils.createTableRow([
			[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + getImageTag(checkedPacket[item].spec.getIconID(), '24px', '24px') + ' ' + checkedPacket[item]["data"]["name"], armyPacketMatches[item] ? "buffReady" : ""], 
			[7, info],
			[1, checkedPacket[item].gStatus ? 'OK' : 'FAIL', checkedPacket[item].gStatus ? "buffReady" : "buffNotReady"]]);
	});
	out += '<br><p>'+loca.GetText("LAB","MilitaryHelp") + '</p>';
	out += utils.createTableRow([[7, loca.GetText("LAB", "Name")], [2, loca.GetText("LAB", "Requires")], [2, loca.GetText("LAB", "Available")], [1, loca.GetText("LAB", "ProductionStatus")]], true);
	$.each(checkedPacket.army, function(item) {
		var aStatus = armyFreeInfo[item] >= checkedPacket.army[item];
		out += utils.createTableRow([
			[7, loca.GetText("RES", item)], 
			[2, checkedPacket.army[item]],
			[2, armyFreeInfo[item]],
			[1, aStatus ? 'OK' : 'FAIL', aStatus ? "buffReady" : "buffNotReady"]]);
	});
	if(checkedPacket.canSubmit) {
		armyWindow.withFooter(".armySubmit").show();
	}
	armyWindow.Body().html(out + '<div>');
	armyWindow.withBody(".close").click(function(e) { 
		delete armyPacket[$(e.currentTarget).val()];
		$(e.currentTarget).closest('.row').remove();
		armyLoadData();
	});
}

function armyGetSquadCount(spec, squad)
{
	if(!armyInfo[spec]) { return 0; }
	return armyInfo[spec].army[squad] || 0;
}

function armyGetData()
{
	armyInfo = {};
	armyUpdateProgress(-1);
	armyWindow.withFooter(".armyUnload, .armySendGeneralsBtn").show();
	armyWindow.withFooter(".armyReset, .armySubmit, .armyReload").hide();
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[4, $('<input>', { 'type': 'checkbox', 'class': 'toggleSelect' }).prop('outerHTML') + '&nbsp;&nbsp;' + loca.GetText("LAB", "Name")], [7, getText('armyCurrentArmy')], [1, '#']], true);
	game.zone.GetSpecialists_vector().sort(specNameSorter).forEach(function(item){
		try {
			if(!armySPECIALIST_TYPE.IsGeneralOrAdmiral(item.GetType()) || item.getPlayerID() == -1) { return; }
			if(item == null || typeof item == 'undefined' || item.GetTask() != null) { return; }
			var info = '';
			var uniqId = item.GetUniqueID().toKeyString();
			armyInfo[uniqId] = armyInfo[uniqId] || { 'name': item.getName(false), 'type': item.GetType(), 'army': {}, 'skills': {} };
			item.getSkillTree().getItems_vector().forEach(function(skill, index){
				if(skill.getLevel() > 0) { armyInfo[uniqId].skills[index] = skill.getLevel(); }
			});
			item.GetArmy().GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(squad){
				armyInfo[uniqId].army[squad.GetType()] = squad.GetAmount();
				info += utils.getImageTag(squad.GetType()) + ' ' + squad.GetAmount() + '&nbsp;';
			});
			html += utils.createTableRow([
				[4, '<input type="checkbox" id="' + uniqId + '" ' + (armyPacket[uniqId] ? "checked" : "") + ' />&nbsp;&nbsp;' + getImageTag(item.getIconID(), '24px', '24px') + ' ' + armyInfo[uniqId]["name"]], 
				[7, info],
				[1, (item.GetGarrisonGridIdx() > 0 ? $(getImageTag("accuracy.png", '24px', '24px')).css("cursor", "pointer").attr("id", "specOpen") : getImageTag("Star", '24px', '24px'))]]);
		} catch(e) {}
	});
	armyWindow.Body().html(html + '<div>');
	if(armyWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').length > 0) {
		var headerRow = armyWindow.withBody(".container-fluid div:first");
		var sortedRows = armyWindow.withBody(".container-fluid > div:gt(0)").sort(function(a, b) { return $(a).find('[type=checkbox]').is(':checked') ? -1 : 1; });
		armyWindow.withBody(".container-fluid").html('').append([headerRow, sortedRows]);
	}
	armyPacket = {};
	armyWindow.withBody("#specOpen").click(function() { 
		var uniqueID = $(this).closest("div.row").find('input[type="checkbox"]').prop("id").split(".")
		var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
		var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
		game.zone.ScrollToGrid(spec.GetGarrisonGridIdx());
	});
	armyWindow.withBody(".toggleSelect").change(function() {
		armyWindow.withBody('input[type="checkbox"]').prop("checked", this.checked);
	});
}

