var armySPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
var armyMilitarySystem = swmmo.getDefinitionByName("MilitarySystem::cMilitaryUtil");
var dRaiseArmyVODef = swmmo.getDefinitionByName("Communication.VO::dRaiseArmyVO");
var dResourceVODef = swmmo.getDefinitionByName("Communication.VO::dResourceVO");
var armySpecTaskDef = swmmo.getDefinitionByName("Communication.VO::dStartSpecialistTaskVO");
var armySpecTravelDef = swmmo.getDefinitionByName("Specialists::cSpecialistTask_TravelToStarMenu");
var armyServices = swmmo.getDefinitionByName("com.bluebyte.tso.service::ServiceManager").getInstance();
var armyResponder = game.createResponder(armyResponderHandler, armyResponderHandler);
var armyPacket = {};
var armyInfo = {};
var armyFreeInfo = {};
var armyWindow;
var armyTemplates;
var armyProgress = [
	utils.getImage(new(game.def("GUI.Assets::gAssetManager_BuildQueueTempSlotTimeLeftIcon"))().bitmapData),
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
	armyUpdateProgress(0);
	setTimeout(function() {
		armyFreeInfo = {};
		updateFreeArmyInfo();
		armyUpdateProgress(-1);
		armyWindow.withFooter("button").prop('disabled',false);
		armyGetData();
	}, 3000);
}

function updateFreeArmyInfo()
{
	var freeArmy = '<br><div class="container-fluid"><center>';
	armyFreeInfo = {};
	game.zone.GetArmy(game.player.GetPlayerId()).GetSquadsCollection_vector().sort(0).forEach(function(item){
		freeArmy += utils.getImageTag(item.GetType(), '20px') + ' ' + item.GetAmount() + '&nbsp;';
		armyFreeInfo[item.GetType()] = item.GetAmount();
	});
	freeArmy += '</center>';
	armyWindow.withHeader("").parent().find("#army").html(freeArmy + '</div>');
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

function armyMenuHandler(event)
{
	armyTemplates = new SaveLoadTemplate('army', function(data) {
		armyPacket = data;
		try{
			armyLoadData();
		} catch(e) {
			game.chatMessage("Error loading " + e, 'army');
		}
	});
	armyWindow = new Modal('armyWindow', utils.getImageTag('icon_general.png', '45px') + ' ' + loca.GetText("LAB","Army"));
	armyWindow.create();
	if(armyWindow.withHeader("").parent().find("#army").length === 0)
	{
		armyWindow.withHeader("").parent().append($('<div>', { id: "army" }));
	}
	updateFreeArmyInfo();
	var groupSend = $('<div>', { 'class': 'btn-group' }).append([
		$('<button>').attr({ 
			"id": "armySendGeneralsBtn",
			"class": "btn btn-success armySendGeneralsBtn dropdown-toggle",
			'aria-haspopup': 'true',
			'aria-expanded': 'false',
			'data-toggle': "dropdown"
		}).text(loca.GetText("LAB", "Send")), 
		$('<div>', {
			'x-placement': 'bottom-start',
			'style': 'position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;',
			'class': 'dropdown-menu'
		})
	]);
	if(armyWindow.withFooter(".armyUnload").length == 0) {
		armyWindow.Footer().prepend([
			$('<div>').attr({ "class": "span12 text-center" }),
			$('<button>').attr({ "class": "btn btn-warning armyUnload" }).text(getText('armyUnload')).click(function(){ 
				var queue = new TimedQueue(1000);
				var counter = 1, total = armyWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').length;
				armyUpdateProgress(-1);
				armyWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)').each(function(i, item) {
					var uniqueID = item.id.split(".")
					var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
					var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
					if(!spec.HasUnits()) { 
						$(item).closest('.row').remove();
						total--;
						return;
					}
					var dRaiseArmyVO = new dRaiseArmyVODef();
					dRaiseArmyVO.armyHolderSpecialistVO = spec.CreateSpecialistVOFromSpecialist();
					queue.add(function(){ 
						try {
							armyUpdateProgress(Math.round(Math.round((100 * counter) / total) / 10) * 10 / 10);
							if(counter == total) {
								game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO, armyResponder);
							} else {
								game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO);
							}
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
			$('<button>').attr({ "class": "btn btn-warning armyReset" }).text(getText('btn_reset')).click(function() {
				armyPacket = {};
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
				if(Object.keys(savePacket).length > 0) { armyTemplates.save(savePacket); return; }
				if(Object.keys(armyPacket).length > 0) { armyTemplates.save(armyPacket); }
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
	armyWindow.withFooter(".armySubmit, .armyReset").hide();
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
			var uniqueID = item.id.split(".")
			var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
			var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
			if (OptionSelected == '98' && spec.GetGarrisonGridIdx() > 0) {
				queue.add(function(){ armySendGeneralToStar(spec); });
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
	$.each(armyPacket, function(item) { 
		var dRaiseArmyVO = new dRaiseArmyVODef();
		var uniqueID = item.split(".")
		var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
		var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
		dRaiseArmyVO.armyHolderSpecialistVO = spec.CreateSpecialistVOFromSpecialist();
		$.each(armyPacket[item], function(res) {
			if(res == "name") { return; }
			var dResourceVO = new dResourceVODef();
			dResourceVO.name_string = res;
			dResourceVO.amount = armyPacket[item][res];
			dRaiseArmyVO.unitSquads.addItem(dResourceVO);
		});
		queue.add(function(){ 
			if(!direct) {
				armyWindow.withBody('.close[value="'+item+'"]').closest("div.row div:first-child").addClass("buffReady");
				armyUpdateProgress(Math.round(Math.round(100 * counter / total) / 10) * 10 / 10);
				if(counter == total) {
					game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO, armyResponder);
				} else {
					game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO);
				}
				counter++;
			} else {
				game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO);
			}
		});
		
		
	});
	if(!direct) {
		armyWindow.withFooter("button").prop('disabled',true);
	}
	queue.run();
	
}

function armyLoadData()
{
	if(Object.keys(armyPacket).length == 0) {
		return armyGetData();
	}
	updateFreeArmyInfo();
	var canSubmit = true;
	armyWindow.withFooter(".armyUnload, .armySendGeneralsBtn").hide();
	armyWindow.withFooter(".armyReset").show();
	var out = '<div class="container-fluid" style="user-select: all;">';
	out += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [7, getText('armyNewArmy')], [1, loca.GetText("LAB", "ProductionStatus")]], true);
	$.each(armyPacket, function(item) { 
		var uniqueID = item.split(".")
		var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
		var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
		if(spec == null) {
			out += utils.createTableRow([
				[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + armyPacket[item]["name"]], 
				[7, 'spec is null'],
				[1, 'FAIL', "buffNotReady"]]);
			canSubmit = false
			return;
		}
		var info = '';
		$.each(armyPacket[item], function(res) {
			if(res == "name") { return; }
			info += utils.getImageTag(res) + ' ' + armyPacket[item][res] + '&nbsp;';
		});
		var gStatus = spec.GetGarrison() != null && spec.GetTask() == null;
		out += utils.createTableRow([
			[4, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>&nbsp;' + getImageTag(spec.getIconID(), '24px', '24px') + ' ' + spec.getName(false)], 
			[7, info],
			[1, gStatus ? 'OK' : 'FAIL', gStatus ? "buffReady" : "buffNotReady"]]);
		if(spec.GetGarrison() == null || spec.GetTask() != null) { canSubmit = false; }
	});
	out += '<br><p>'+loca.GetText("LAB","MilitaryHelp") + '</p>';
	out += utils.createTableRow([[7, loca.GetText("LAB", "Name")], [2, loca.GetText("LAB", "Requires")], [2, loca.GetText("LAB", "Available")], [1, loca.GetText("LAB", "ProductionStatus")]], true);
	var requiredArmy = {};
	$.each(armyPacket, function(item) {
		$.each(armyPacket[item], function(res) {
			if(res == "name") { return; }
			requiredArmy[res] = requiredArmy[res] + armyPacket[item][res] || armyPacket[item][res];
		});
	});
	$.each(requiredArmy, function(item) {
		var aStatus = armyFreeInfo[item] >= requiredArmy[item];
		out += utils.createTableRow([
			[7, loca.GetText("RES", item)], 
			[2, requiredArmy[item]],
			[2, armyFreeInfo[item]],
			[1, aStatus ? 'OK' : 'FAIL', aStatus ? "buffReady" : "buffNotReady"]]);
		if(armyFreeInfo[item] < requiredArmy[item]) { canSubmit = false; }
	});
	if(canSubmit) {
		armyWindow.withFooter(".armySubmit").show();
	}
	armyWindow.Body().html(out + '<div>');
	armyWindow.withBody(".close").click(function(e) { 
		delete armyPacket[$(e.currentTarget).val()];
		$(e.currentTarget).closest('.row').remove();
		armyLoadData();
	});
}

function armyGetData()
{
	armyInfo = {};
	armyUpdateProgress(-1);
	armyWindow.withFooter(".armyUnload, .armySendGeneralsBtn").show();
	armyWindow.withFooter(".armyReset, .armySubmit").hide();
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[4, $('<input>', { 'type': 'checkbox', 'class': 'toggleSelect' }).prop('outerHTML') + '&nbsp;&nbsp;' + loca.GetText("LAB", "Name")], [7, getText('armyCurrentArmy')], [1, '#']], true);
	game.zone.GetSpecialists_vector().sort(0).forEach(function(item){
		if(!armySPECIALIST_TYPE.IsGeneralOrAdmiral(item.GetType()) || item.getPlayerID() == -1) { return; }
		if(item == null || item.GetTask() != null) { return; }
		var info = '';
		var uniqId = item.GetUniqueID().toKeyString();
		armyInfo[uniqId] = armyInfo[uniqId] || {};
		item.GetArmy().GetSquadsCollection_vector().sort(0).forEach(function(squad){
			armyInfo[uniqId][squad.GetType()] = squad.GetAmount();
			info += utils.getImageTag(squad.GetType()) + ' ' + squad.GetAmount() + '&nbsp;';
		});
		armyInfo[uniqId]["name"] = item.getName(false);
		html += utils.createTableRow([
			[4, '<input type="checkbox" id="' + uniqId + '" ' + (armyPacket[uniqId] ? "checked" : "") + ' />&nbsp;&nbsp;' + getImageTag(item.getIconID(), '24px', '24px') + ' ' + armyInfo[uniqId]["name"]], 
			[7, info],
			[1, (item.GetGarrisonGridIdx() > 0 ? $(getImageTag("accuracy.png", '24px', '24px')).css("cursor", "pointer").attr("id", "specOpen") : getImageTag("Star", '24px', '24px'))]]);
		return true;
	});
	armyWindow.Body().html(html + '<div>');
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

