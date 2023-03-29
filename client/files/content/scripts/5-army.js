var armySPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
var armyMilitarySystem = swmmo.getDefinitionByName("MilitarySystem::cMilitaryUtil");
var armyMilitaryBase = swmmo.getDefinitionByName("MilitarySystem::cMilitaryUnitBase");
var dRaiseArmyVODef = swmmo.getDefinitionByName("Communication.VO::dRaiseArmyVO");
var dResourceVODef = swmmo.getDefinitionByName("Communication.VO::dResourceVO");
var armySpecTaskDef = swmmo.getDefinitionByName("Communication.VO::dStartSpecialistTaskVO");
var armySpecTravelDef = swmmo.getDefinitionByName("Specialists::cSpecialistTask_TravelToStarMenu");
var armyServices = swmmo.getDefinitionByName("com.bluebyte.tso.service::ServiceManager").getInstance();
var armyResponder = game.createResponder(armyResponderHandler, armyResponderHandler);
var armyPacketMatches = {};
var armyInfo = {};
var armyFreeInfo = {};
var armyProgressCounter = 0;
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
			armyUpdateProgress(-1);
			battleWindow.withFooter("button").prop('disabled',false);
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
	armyInfo = {};
	armyFreeInfo = {};
	game.zone.GetArmy(game.player.GetPlayerId()).GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(item){
		var cat = item.GetUnitBase().GetUnitCategory() + +item.GetUnitBase().GetIsElite();
		armyCategory[cat] = armyCategory[cat] || '';
		armyCategory[cat] += utils.getImageTag(item.GetType(), '20px') + ' ' + item.GetAmount() + '&nbsp;';
		armyFreeInfo[item.GetType()] = item.GetAmount();
	});
	game.zone.GetSpecialists_vector().forEach(function(item){
		try {
			if(!armySPECIALIST_TYPE.IsGeneral(item.GetType()) || item.getPlayerID() != game.player.GetPlayerId()) { return; }
			if(item == null || typeof item == 'undefined' || item.GetTask() != null) { return; }
			var uniqId = item.GetUniqueID().toKeyString();
			armyInfo[uniqId] = armyInfo[uniqId] || { 'name': item.getName(false), 'type': item.GetType(), 'army': {}, 'skills': {} };
			item.getSkillTree().getItems_vector().forEach(function(skill, index){
				if(skill.getLevel() > 0) { armyInfo[uniqId].skills[index] = skill.getLevel(); }
			});
			item.GetArmy().GetSquadsCollection_vector().sort(game.def("MilitarySystem::cSquad").SortByCombatPriority).forEach(function(squad){
				armyInfo[uniqId].army[squad.GetType()] = squad.GetAmount();
			});
		} catch(e) {}
	});
	freeArmy += armyCategory.filter(function(a) { return '<p>' + a; }).join('</p>');
	freeArmy += '</center>';
	if(!direct) {
		battleWindow.withHeader("#army").html(freeArmy + '</div>');
	}
}

function armyUpdateProgress(num)
{
	if(num == -1) {
		battleWindow.withFooter(".span12").html("");
		return;
	}
	if(armyProgress[num]) {
		battleWindow.withFooter(".span12").html(armyProgress[num]);
	}
}

function armyGeneralsSend(e)
{
	try
	{
		var queue = new TimedQueue(1000);
		var OptionSelected = $(e.target).attr('value');
		var source = battleWindow.withBody('[type=checkbox]').length > 0 ? battleWindow.withBody('[type=checkbox]:checked:not(.toggleSelect)') : battleWindow.withBody('.close');
		source.each(function(i, item) {
			var spec = armyGetSpecialistFromID(item.id ? item : $(item).val());
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
			battleWindow.hide();
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
		var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]);
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
	battleWindow.withFooter('[data-toggle="tooltip"]').tooltip( "hide" );
	var queue = new TimedQueue(1000);
	var counter = 1, total = Object.keys(battlePacket).length;
	armyProgressCounter = total;
	$.each(battlePacket, function(item) { 
		if(!direct && armyPacketMatches[item]) {
			total--;
			armyProgressCounter--;
			return;
		}
		var dRaiseArmyVO = new dRaiseArmyVODef();
		var spec = armyGetSpecialistFromID(item);
		if(spec == null) { 
			total--;
			armyProgressCounter--;
			return;
		}
		dRaiseArmyVO.armyHolderSpecialistVO = spec.CreateSpecialistVOFromSpecialist();
		$.each(battlePacket[item].army, function(res) {
			var dResourceVO = new dResourceVODef();
			dResourceVO.name_string = res;
			dResourceVO.amount = battlePacket[item].army[res];
			dRaiseArmyVO.unitSquads.addItem(dResourceVO);
		});
		queue.add(function(){ 
			if(!direct) {
				battleWindow.withBody('.close[value="'+item+'"]').closest("div.row div:first-child").addClass("buffReady");
				armyUpdateProgress(Math.round(Math.round(100 * counter / total) / 10) * 10 / 10);
				game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO, armyResponder);
				counter++;
			} else {
				game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO);
			}
		});
		
		
	});
	if(!direct && queue.len() > 0) {
		queue.add(function(){ battleLoadData(); }, 6000);
		battleWindow.withFooter("button").prop('disabled',true);
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

function armyGetSquadCount(spec, squad)
{
	if(!armyInfo[spec]) { return 0; }
	return armyInfo[spec].army[squad] || 0;
}

