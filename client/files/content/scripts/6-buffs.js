var buffEventTracker = game.getTracker('buff', buffApliedHandler),
	availableBuffTypes = ["ProductivityBuff", "RecruitingBuff", "ProvisionerBuff", "BookbinderBuff", "AreaBuff", "RemoveBuff"],
	buffRecordEnabled = false,
	buffRecord, buffRecordFiltered,
	buffSourceRecord = false,
	buffsAvailable = {},
	buffInProgress = false,
	buffTemplates, buffVector;

function menuBuffsHandler(event)
{
	$("div[role='dialog']:not(#buffModal):visible").modal("hide");
	createModalWindow('buffModal', getImageTag('ProductivityBuffLvl3', '45px') + ' '+loca.GetText("LAB", "Buffs"));
	buffTemplates = new SaveLoadTemplate('buff', function(data, name) {
		$("#buffModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
		buffRecord = data;
		buffSourceRecord = false;
		menuBuffsHandler(null);
	});
	if($('#buffModal .buffSaveTemplate').length === 0)
	{
		$("#buffModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-warning buffReset" }).text(getText('btn_reset')),
			$('<button>').attr({ "class": "btn btn-success buffSubmit" }).text(getText('btn_submit')),
			$('<button>').attr({ "class": "btn btn-primary pull-left buffSaveTemplate" }).text(getText('save_template')),
			$('<button>').attr({ "class": "btn btn-primary pull-left buffLoadTemplate" }).text(getText('load_template'))
		]);
		$('#buffModal .buffSaveTemplate').click(function(){ buffTemplates.save(buffRecord); });
		$('#buffModal .buffLoadTemplate').click(function() { buffTemplates.load(); });
		$('#buffModal .buffReset').click(function() {
			buffRecord = null;
			menuBuffsHandler(null);
		});
		$('#buffModal .buffSubmit').click(buffDoJob);
	}
	$('.buffSubmit, .buffReset, .buffSaveTemplate').attr('disabled', 'true');
	var out = '<div class="container-fluid">';
	if(!buffRecordEnabled && buffRecord == null) {
		$("#buffModal .templateFile").html("");
		out += '<strong>{0}</strong></p>{1}{2}'.format(
			getText('buff_welcome'),
			getText('buff_welcome_block'),
			$('<button>', { 'class': "btn btn-primary btn-lg btn-block", 'id' :"startRecording"}).text(getText('buff_start_record')).prop('outerHTML')
		);
	}
	if(buffRecordEnabled) {
		$("#buffModal .templateFile").html("");
		out += $('<p>').append($('<h2>', { 'class': 'text-center' }).text(getText('buff_rec_progress'))).prop('outerHTML');
		out += $('<button>', { 'class': 'btn btn-primary btn-lg btn-block', 'id': 'stopRecording' }).text(getText('buff_stop_record')).prop('outerHTML');
	}
	if(!buffRecordEnabled && buffRecord != null) {
		buffVector = game.gi.mCurrentPlayer.getAvailableBuffs_vector();
		var BuffHTML = getBuffHTML();
		var BuffsAvailableHTML = getBuffsAvailableHTML();
		out += BuffsAvailableHTML + '<br>' + BuffHTML + BuffsAvailableHTML + '<br><button type="button" class="btn btn-primary btn-lg btn-block" id="startRecording">' + getText('buff_record_more') + '</button>';
		if(buffRecordFiltered.length > 0){
			$('.buffSubmit').attr('disabled', false);
		}
		$('.buffReset, .buffSaveTemplate').attr('disabled', false);
	}
	out += '</div>';
	$("#buffModalData").html(out);
	$("#buffModalData .close").click(function(e) { 
		var grid = $(e.currentTarget).val();
		buffRecordFiltered = buffRecordFiltered.filter(function(e) { return e.buiGrid != grid; });
		buffRecord['data'] = buffRecord['data'].filter(function(e) { return e.buiGrid != grid; });
		$(e.currentTarget).closest('.row').remove();
		if(buffRecord['data'].length === 0) { buffRecord = null; }
		menuBuffsHandler(null);
	});
	$( "#startRecording" ).click(function(){
		$('#buffModal').modal('hide');
		game.showAlert(getText('buff_rec_start'));
		game.gi.channels.BUFF.addPropertyObserver("buffApplied", buffEventTracker);
		buffRecordEnabled = true;
	});
	$( "#stopRecording" ).click(function(){
		buffRecordEnabled = false;
		game.showAlert(getText('buff_rec_stop'));
		game.gi.channels.BUFF.removePropertyObserver("buffApplied", buffEventTracker);
		menuBuffsHandler(null);
	});
	$('#buffModal:not(:visible)').modal({backdrop: "static"});
}

function getBuffsAvailableHTML()
{
	var buffNeeded = {};
	$.each(buffRecordFiltered, function(i, item) {
		buffNeeded[item.buffName] = (buffNeeded[item.buffName]||0) + 1;
	});
	if(Object.keys(buffNeeded).length > 0){
		var result = '<br><p>{0}</p>'.format(getText('buff_used'));
		result += createTableRow([
			[8, loca.GetText("LAB", 'Buff')],
			[2, loca.GetText("LAB", 'Requires')],
			[2, loca.GetText("LAB", 'Available')]
		], true);
		var count;
		for (var buffName in buffNeeded) {
			count = getBuffAvailableCount(buffName);
			result += createTableRow([
				[8, loca.GetText("RES", buffName)],
				[2, buffNeeded[buffName]],
				[2, count, count >= buffNeeded[buffName] ? "buffReady" : "buffNotReady"]
			]);
		}
		return result;
	}
	return '';
}

function getBuffAvailableCount(buffName)
{
	buffsAvailable[buffName] = {count: 0, id: ''};
	buffVector.every(function(item){
		if(item.GetBuffDefinition().GetName_string() == buffName) {
			buffsAvailable[buffName].count = item.GetAmount();
			buffsAvailable[buffName].id = item.GetUniqueId().uniqueID1 + '_' + item.GetUniqueId().uniqueID2;
			return false;
		}
		return true;
	});
	return buffsAvailable[buffName].count;
}

function getBuffHTML()
{
	var result = '<p>{0} {1}</p>'.format(getText('buff_zoneowner'), buffRecord["zoneUser"]),
		isZoneRight = true;
	if(buffRecord["zoneId"] != game.gi.mCurrentViewedZoneID) {
		result += '<p><strong>' + getText('buff_not_your_zone') + '</strong></p>';
		isZoneRight = false;
	}
	result += createTableRow([
			[1, '#'],
			[4, loca.GetText("LAB", 'Name')],
			[1, loca.GetText("LAB", 'GuildLevel')],
			[4, loca.GetText("LAB", 'Buff')],
			[2, loca.GetText("LAB", 'ProductionStatus')]
	], true);
	buffRecordFiltered = [];
	var status;
	$.each(buffRecord['data'], function(index, data) { 
		status = getBuffStatus(data, isZoneRight);
		// too dirty
		if(data['buffName'].indexOf("RemoveBuff") >= 0) {
			if(status == 'buff_buffed') { status = 'buff_ready'; }
			else if(status == 'buff_ready') { status = 'buff_not_buffed'; }
		}

		var cssClass = '';

		switch (status) {
			case 'buff_ready':
				cssClass = 'buffReady'
				break;
			case 'buff_buffed':
				cssClass = 'buffed'
				break;
			case 'buff_notactive':
				cssClass = 'notActive'
				break;
			case 'buff_wrong_name':
				cssClass = 'wrongName specSamegrid'
				break;
			case 'buff_not_exist':
				cssClass = 'buffNotReady'
				break;
			default:
				cssClass = 'buffNotReady';
				break;
		}

		if(status == 'buff_ready') { buffRecordFiltered.push(data); }
		result += createTableRow([
			[1, data['buiGrid']],
			[4, loca.GetText("BUI", data['buiName'])],
			[1, getBuiLevel(data)],
			[4, loca.GetText("RES", data['buffName'])],
			[2, getText(status) + '<button type="button" class="close" value="'+data['buiGrid']+'"><span>&times;</span></button>', cssClass]
		]);
	});
	return result;
}

function buffApliedHandler(event){
	if(!buffRecordEnabled) { return; }
    if(event.data.buffOwnerID != game.player.getPlayerID()) { return; }
	if(!checkBuffType(event.data.buff.GetType())) { 
		showGameAlert(getText('buff_not_recorded') + event.data.buff.GetType());
		return; 
	}
	if(buffRecord == null) { 
		var zoneUser = game.player.GetPlayerName_string();
		if(game.gi.isOnHomzone() == false) {
			try{
				zoneUser = globalFlash.gui.mFriendsList.GetFriendById(game.gi.mCurrentViewedZoneID).username;
			} catch(e) {
				zoneUser = globalFlash.gui.mFriendsList.GetGuildMemberById(game.gi.mCurrentViewedZoneID).username;
			}
		}
		buffRecord = { 
			zoneId: game.gi.mCurrentViewedZoneID, 
			zoneUser: zoneUser, 
			data: []
		};
	} else {
		if(game.gi.mCurrentViewedZoneID != buffRecord['zoneId']) { return; }
		if($.grep(buffRecord['data'], function(e) { return e.buiGrid == event.data.target.GetGrid(); }).length > 0){ return; }
	}
	buffRecord['data'].push({
		buffName: event.data.buff.GetBuffDefinition().GetName_string(),
		buiGrid: event.data.target.GetGrid(),
		buiName: event.data.target.GetBuildingName_string()
	});
}

function checkBuffType(type)
{
	return availableBuffTypes.filter(function(item) { return type.indexOf(item); }).length > 0;
}

function getBuiLevel(data)
{
	var bui = game.zone.GetBuildingFromGridPosition(data['buiGrid']);
	if(bui == null) { return 0; }
	return bui.GetUpgradeLevel();
}

function getBuffStatus(data, zoneStatus)
{
	if(!zoneStatus) { return 'buff_wrong_zone'; }
	var bui = game.zone.GetBuildingFromGridPosition(data['buiGrid']);
	if(bui == null) { return 'buff_not_exist'; }
	if(bui.GetBuildingName_string() != data['buiName']) { return 'buff_wrong_name'; }
	if(bui.productionBuff != null && checkBuffType(bui.productionBuff.GetBuffDefinition().GetName_string())) { return 'buff_buffed'; }
	if(mainSettings.buffOnlyActive && (!bui.IsProductionActive() || bui.IsUpgradeInProgress())) { return 'buff_notactive'; }
	if(mainSettings.buffOnlyActive && bui.GetResourceCreation() != null && bui.GetResourceCreation().GetProductionState() != 0) { return 'buff_notactive'; }
	return 'buff_ready';
}

function buffDoJob()
{
	var x = new TimedQueue(1000);
	$.each(buffRecordFiltered, function(i, item) {
		if(buffsAvailable[item.buffName].count > 0) {
			buffsAvailable[item.buffName].count -= 1;
			x.add(function(){ sendBuffPacket(buffsAvailable[item.buffName].id, item.buiGrid); });
		}
	});
	x.run();
	$('#buffModal').modal('hide');
	game.showAlert(getText('command_sent'));
}

function sendBuffPacket(buffId, grid)
{
	try{
		var uniqueIdArr = buffId.split("_"),
			uniqueID = game.def("Communication.VO::dUniqueID").Create(uniqueIdArr[0], uniqueIdArr[1]);
		game.gi.SendServerAction(61, 0, grid, 0, uniqueID);
	} catch (ex) {
		alert(ex);
	}
}