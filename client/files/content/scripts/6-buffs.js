var buffEventTracker = new window.runtime.ClientBuff();
buffEventTracker.addEventListener("buffApply", buffApliedHandler);
const availableBuffTypes = ["ProductivityBuff", "RecruitingBuff", "ProvisionerBuff", "BookbinderBuff", "AreaBuff", "RemoveBuff"];
var buffRecordEnabled = false;
var buffRecord;
var buffRecordFiltered;
var buffSourceRecord = false;
var buffsAvailable = {};
var buffInProgress = false;
var buffTemplates;

function menuBuffsHandler(event)
{
	$("div[role='dialog']:not(#buffModal):visible").modal("hide");
	createModalWindow('buffModal', getImageTag('ProductivityBuffLvl3', '45px') + ' '+loca.GetText("LAB", "Buffs"));
	buffTemplates = new SaveLoadTemplate('buff', function(data) {
		buffRecord = data;
		buffSourceRecord = false;
		menuBuffsHandler(null);
	});
	if($('#buffModal .buffSaveTemplate').length == 0)
	{
		$("#buffModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-success buffSubmit" }).text(getText('btn_submit')),
			$('<button>').attr({ "class": "btn btn-warning buffReset" }).text(getText('btn_reset')),
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
	out = '<div class="container-fluid">';
	if(!buffRecordEnabled && buffRecord == null) {
		out += '<strong>{0}</strong></p>{1}{2}'.format(
			getText('buff_welcome'),
			getText('buff_welcome_block'),
			$('<button>', { 'class': "btn btn-primary btn-lg btn-block", 'id' :"startRecording"}).text(getText('buff_start_record')).prop('outerHTML')
		);
	}
	if(buffRecordEnabled) {
		out += $('<p>').append($('<h2>', { 'class': 'text-center' }).text(getText('buff_rec_progress'))).prop('outerHTML');
		out += $('<button>', { 'class': 'btn btn-primary btn-lg btn-block', 'id': 'stopRecording' }).text(getText('buff_stop_record')).prop('outerHTML');
	}
	if(!buffRecordEnabled && buffRecord != null) {
		out += getBuffHTML() + getBuffsAvailableHTML() + '<br><button type="button" class="btn btn-primary btn-lg btn-block" id="startRecording">' + getText('buff_record_more') + '</button>';
		if(buffRecordFiltered.length > 0){
			$('.buffSubmit').attr('disabled', false);
		}
		$('.buffReset, .buffSaveTemplate').attr('disabled', false);
	}
	out += '</div>';
	$("#buffModalData").html(out);
	$("#buffModalData .close").click(function(e) { 
		grid = $(e.currentTarget).val();
		buffRecordFiltered = buffRecordFiltered.filter(function(e) { return e.buiGrid != grid; });
		buffRecord['data'] = buffRecord['data'].filter(function(e) { return e.buiGrid != grid; });
		$(e.currentTarget).closest('.row').remove();
		if(buffRecordFiltered.length == 0) { buffRecord = null; }
		menuBuffsHandler(null);
	});
	$( "#startRecording" ).click(function(){
		$('#buffModal').modal('hide');
		showGameAlert(getText('buff_rec_start'));
		swmmo.application.mGameInterface.channels.BUFF.addPropertyObserver("buffApplied", buffEventTracker);
		buffRecordEnabled = true;
	});
	$( "#stopRecording" ).click(function(){
		buffRecordEnabled = false;
		showGameAlert(getText('buff_rec_stop'));
		swmmo.application.mGameInterface.channels.BUFF.removePropertyObserver("buffApplied", buffEventTracker);
		menuBuffsHandler(null);
	});
	$('#buffModal:not(:visible)').modal({backdrop: "static"});
}

function getBuffsAvailableHTML()
{
	var buffNeeded = {};
	$.each(buffRecordFiltered, function(i, item) {
		if(buffNeeded[item.buffName] == null){
			buffNeeded[item.buffName] = 1;
		} else {
			buffNeeded[item.buffName] += 1;
		}
	});
	if(Object.keys(buffNeeded).length == 0){ return '';	}
	result = '<br><p>{0}</p>'.format(getText('buff_used'));
	result += createTableRow([
			[8, loca.GetText("LAB", 'Buff')],
			[2, loca.GetText("LAB", 'Requires')],
			[2, loca.GetText("LAB", 'Available')]
	], true);
	for ( buffName in buffNeeded ) {
		count = getBuffAvailableCount(buffName);
		style = count >= buffNeeded[buffName] ? "buffReady" : "buffNotReady";
		result += createTableRow([
			[8, loca.GetText("RES", buffName)],
			[2, buffNeeded[buffName]],
			[2, count, style]
		]);
	}
	return result;
}

function getBuffAvailableCount(buffName)
{
	buffsAvailable[buffName] = {count: 0, id: ''};
	swmmo.application.mGameInterface.mCurrentPlayer.getAvailableBuffs_vector().every(function(item){
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
	result = '<p>{0} {1}</p>'.format(getText('buff_zoneowner'), buffRecord["zoneUser"]);
	isZoneRight = true;
	if(buffRecord["zoneId"] != swmmo.application.mGameInterface.mCurrentViewedZoneID) {
		result += '<p><strong>' + getText('buff_not_your_zone') + '</strong></p>';
		isZoneRight = false;
	}
	result += createTableRow([
			[1, '#'],
			[4, loca.GetText("LAB", 'Name')],
			[5, loca.GetText("LAB", 'Buff')],
			[2, loca.GetText("LAB", 'ProductionStatus')]
	], true);
	buffRecordFiltered = [];
	$.each(buffRecord['data'], function(index, data) { 
		status = getBuffStatus(data, isZoneRight);
		// too dirty
		if(data['buffName'].indexOf("RemoveBuff") >= 0) { 
			if(status == 'buff_buffed') { status = 'buff_ready'; } 
			else if(status == 'buff_ready') { status = 'buff_not_buffed'; } 
		}
		if(status == 'buff_ready') { buffRecordFiltered.push(data); }
		result += createTableRow([
			[1, data['buiGrid']],
			[4, loca.GetText("BUI", data['buiName'])],
			[5, loca.GetText("RES", data['buffName'])],
			[2, getText(status) + '<button type="button" class="close" value="'+data['buiGrid']+'"><span>&times;</span></button>', (status == 'buff_ready') ? "buffReady" : "buffNotReady"]
		]);
	});
	return result;
}

function buffApliedHandler(event){
	if(!buffRecordEnabled) { return; }
    if(event.data.buffOwnerID != swmmo.application.mGameInterface.mCurrentPlayer.getPlayerID()) { return; }
	if(!checkBuffType(event.data.buff.GetType())) { 
		showGameAlert(getText('buff_not_recorded') + event.data.buff.GetType());
		return; 
	}
	if(buffRecord == null) { 
		zoneUser = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerName_string();
		if(swmmo.application.mGameInterface.isOnHomzone() == false) {
			try{
				zoneUser = globalFlash.gui.mFriendsList.GetFriendById(swmmo.application.mGameInterface.mCurrentViewedZoneID).username;
			} catch(e) {
				zoneUser = globalFlash.gui.mFriendsList.GetGuildMemberById(swmmo.application.mGameInterface.mCurrentViewedZoneID).username;
			}
		}
		buffRecord = { 
			zoneId: swmmo.application.mGameInterface.mCurrentViewedZoneID, 
			zoneUser: zoneUser, 
			data: []
		};
	} else {
		if(swmmo.application.mGameInterface.mCurrentViewedZoneID != buffRecord['zoneId']) { return; }
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

function getBuffStatus(data, zoneStatus)
{
	if(!zoneStatus) { return 'buff_wrong_zone'; }
	bui = swmmo.application.mGameInterface.mCurrentPlayerZone.GetBuildingFromGridPosition(data['buiGrid']);
	if(bui == null) { return 'buff_not_exist'; }
	if(bui.GetBuildingName_string() != data['buiName']) { return 'buff_wrong_name'; }
	if(bui.productionBuff != null && checkBuffType(bui.productionBuff.GetBuffDefinition().GetName_string())) { return 'buff_buffed'; }
	return 'buff_ready';
}

function buffDoJob()
{
	var x = new TimedQueue(1000);
	$.each(buffRecordFiltered, function(i, item) {
		if(buffsAvailable[item.buffName].count > 0) {
			buffsAvailable[item.buffName].count -= 1;
			uniqueIdArr = buffsAvailable[item.buffName].id.split("_");
			x.add(function(){ 
				uniqueID = swmmo.getDefinitionByName("Communication.VO::dUniqueID").Create(uniqueIdArr[0], uniqueIdArr[1]);
				swmmo.application.mGameInterface.SendServerAction(61, 0, grid, 0, uniqueID);
			});
		}
	});
	x.run();
	$('#buffModal').modal('hide');
	showGameAlert(getText('command_sent'));
}