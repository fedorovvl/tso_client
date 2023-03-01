var armySPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
var armyMilitarySystem = swmmo.getDefinitionByName("MilitarySystem::cMilitaryUtil");
var dRaiseArmyVODef = swmmo.getDefinitionByName("Communication.VO::dRaiseArmyVO");
var dResourceVODef = swmmo.getDefinitionByName("Communication.VO::dResourceVO");
var armyPacket = {};
var armyInfo = {};
var armyFreeInfo = {};
var armyWindow;
var armyTemplates;

function updateFreeArmyInfo()
{
	var freeArmy = '<br><div class="container-fluid"><center>';
	game.zone.GetArmy(game.player.GetPlayerId()).GetSquadsCollection_vector().forEach(function(item){
		freeArmy += utils.getImageTag(item.GetType(), '20px') + ' ' + item.GetAmount() + '&nbsp;';
		armyFreeInfo[item.GetType()] = item.GetAmount();
	});
	freeArmy += '</center>';
	armyWindow.withHeader("").parent().find("#army").html(freeArmy + '</div>');
}

function armyMenuHandler(event)
{
	armyTemplates = new SaveLoadTemplate('army', function(data) {
		armyPacket = data;
		armyLoadData();
	});
	armyWindow = new Modal('armyWindow', utils.getImageTag('icon_general.png', '45px') + ' ' + loca.GetText("LAB","Army"));
	armyWindow.create();
	if(armyWindow.withHeader("").parent().find("#army").length === 0)
	{
		armyWindow.withHeader("").parent().append($('<div>', { id: "army" }));
	}
	updateFreeArmyInfo();
	armyWindow.Footer().prepend([
		$('<button>').attr({ "class": "btn btn-warning armyUnload" }).text(loca.GetText("LAB","UnloadUnits")).click(function(){ 
			var queue = new TimedQueue(1000);
			armyWindow.withBody('[type=checkbox]:checked').each(function(i, item) {
				var uniqueID = item.id.split(".")
				var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
				var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
				queue.add(function(){ 
					armyMilitarySystem.SendRaiseArmyToServer(game.gi, spec, null);
					$(item).closest('.row').remove();
				});
			});
			if(queue.len() > 0) {
				armyWindow.withFooter("button").prop('disabled',true);
				queue.add(function(){ updateFreeArmyInfo(); });
				queue.add(function(){ armyWindow.withFooter("button").prop('disabled',false); });
				queue.run();
			}
		}),
		$('<button>').attr({ "class": "btn btn-warning armyReset" }).text(getText('btn_reset')).click(function() {
			armyPacket = {};
			armyGetData();
		}),
		$('<button>').attr({ "class": "btn btn-success armySubmit" }).text(getText('btn_submit')).prop('disabled',true).click(armyLoadGenerals),
		$('<button>').attr({ "class": "btn btn-primary pull-left armySaveTemplate" }).text(getText('save_template')).click(function(){ 
			var savePacket = {};
			armyWindow.withBody('[type=checkbox]:checked').each(function(i, item) {
				savePacket[item.id] = armyInfo[item.id];
			});
			if(Object.keys(savePacket).length > 0) { armyTemplates.save(savePacket); }
		}),
		$('<button>').attr({ "class": "btn btn-primary pull-left armyLoadTemplate" }).text(getText('load_template')).click(function() { armyTemplates.load(); })
	]);
	
	armyGetData();
	armyWindow.show();
}
function armyLoadGenerals()
{
	var queue = new TimedQueue(1000);
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
			game.gi.mClientMessages.SendMessagetoServer(1031, game.gi.mCurrentViewedZoneID, dRaiseArmyVO);
		});
	});
	queue.run();
	game.showAlert(getText('command_sent'));
	armyWindow.hide();
}

function armyLoadData()
{
	if(Object.keys(armyPacket).length == 0) {
		return armyGetData();
	}
	var canSubmit = true;
	var out = '<div class="container-fluid" style="user-select: all;">';
	out += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [7, loca.GetText("LAB", "Army")], [1, loca.GetText("LAB", "ProductionStatus")]], true);
	$.each(armyPacket, function(item) { 
		var uniqueID = item.split(".")
		var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
		var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
		var info = '';
		$.each(armyPacket[item], function(res) {
			if(res == "name") { return; }
			info += utils.getImageTag(res) + ' ' + armyPacket[item][res] + '&nbsp;';
		});
		out += utils.createTableRow([
			[4, getImageTag(spec.getIconID(), '24px', '24px') + ' ' + spec.getName(false)], 
			[7, info],
			[1, (spec.GetGarrison() != null && spec.GetTask() == null ? 'OK' : 'FAIL')]]);
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
		out += utils.createTableRow([
			[7, loca.GetText("RES", item)], 
			[2, requiredArmy[item]],
			[2, armyFreeInfo[item]],
			[1, armyFreeInfo[item] > requiredArmy[item] ? 'OK' : 'FAIL']]);
		if(armyFreeInfo[item] < requiredArmy[item]) { canSubmit = false; }
	});
	if(canSubmit) {
		armyWindow.withFooter(".armySubmit").prop('disabled',false);
	}
	armyWindow.Body().html(out + '<div>');
}

function armyGetData()
{
	armyInfo = {};
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[4, loca.GetText("LAB", "Name")], [7, loca.GetText("LAB", "Army")], [1, loca.GetText("LAB", "ProductionStatus")]], true);
	game.zone.GetSpecialists_vector().sort(0).forEach(function(item){
		if(!armySPECIALIST_TYPE.IsGeneralOrAdmiral(item.GetType())) { return; }
		if(!item.HasUnits() || item.GetTask() != null) { return; }
		var info = '';
		item.GetArmy().GetSquadsCollection_vector().forEach(function(squad){
			(armyInfo[item.GetUniqueID().toKeyString()] = armyInfo[item.GetUniqueID().toKeyString()] || {})[squad.GetType()] = squad.GetAmount();
			info += utils.getImageTag(squad.GetType()) + ' ' + squad.GetAmount() + '&nbsp;';
		});
		armyInfo[item.GetUniqueID().toKeyString()]["name"] = item.getName(false);
		html += utils.createTableRow([
			[4, '<input type="checkbox" id="' + item.GetUniqueID().toKeyString() + '" />&nbsp;&nbsp;' + getImageTag(item.getIconID(), '24px', '24px') + ' ' + item.getName(false)], 
			[7, info],
			[1, 'OK']]);
		return true;
	});
	armyWindow.Body().html(html + '<div>');
}

