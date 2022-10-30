var buff = new window.runtime.ClientBuff();
buff.addEventListener("buffApply", buffAplied);

function buffAplied(event){
	if(!buffRecordEnabled) { return; }
    if(event.data.buffOwnerID != swmmo.application.mGameInterface.mCurrentPlayer.getPlayerID()) { return; }
	if(!checkBuffType(event.data.buff.GetType())) { 
		if(isDebug) {
			showGameAlert(getText('buff_not_recorded') + event.data.buff.GetType());
		}
		return; 
	}
	if(buffRecord == null) { 
		zoneUser = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerName_string();
		if(swmmo.application.mGameInterface.isOnHomzone() == false) {
			try{
				zoneUser = swmmo.getDefinitionByName("globalFlash").gui.mFriendsList.GetFriendById(swmmo.application.mGameInterface.mCurrentViewedZoneID).username;
			} catch(e) {
				zoneUser = swmmo.getDefinitionByName("globalFlash").gui.mFriendsList.GetGuildMemberById(swmmo.application.mGameInterface.mCurrentViewedZoneID).username;
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
	if(type.indexOf("ProductivityBuff") >= 0) {
		return true;
	} else if(type.indexOf("RecruitingBuff") >= 0) {
		return true;
	} else if(type.indexOf("ProvisionerBuff") >= 0) {
		return true;
	} else if(type.indexOf("BookbinderBuff") >= 0) {
		return true;
	} else if(type.indexOf("AreaBuff") >= 0) {
		return true;
	} else if(type.indexOf("RemoveBuff") >= 0) {
		return true;
	} else {
		return false;
	}
	return false;
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

function startRecording()
{
	try{
		$('#buffModal').modal('hide');
		showGameAlert(getText('buff_rec_start'));
		swmmo.application.mGameInterface.channels.BUFF.addPropertyObserver("buffApplied", buff);
		buffRecordEnabled = true;
	} catch(e) {
		alert(e);
	}
}
function stopRecording()
{
	buffRecordEnabled = false;
	showGameAlert(getText('buff_rec_stop'));
	swmmo.application.mGameInterface.channels.BUFF.removePropertyObserver("buffApplied", buff);
	menuBuffsHandler(null);
}

function buffSaveTemplate()
{
	file = new air.File(readLastDir('buff')).resolvePath("buffTemplate_"+buffRecord['zoneUser']+".txt");
	file.addEventListener(air.Event.COMPLETE, buffTemplateSaved); 
	file.save(JSON.stringify(buffRecord, null, "  "));
}
function buffTemplateSaved(event) 
{ 
    saveLastDir('buff', event.target.parent.nativePath); 
}
function buffLoadTemplate()
{
	file = new air.File(readLastDir('buff'));
	txtFilter = new air.FileFilter("All files", "*.*"); 
	file.browseForOpen("Open", [txtFilter]); 
	file.addEventListener(air.Event.SELECT, buffLoadTemplateComplete); 
}
function buffLoadTemplateComplete(event)
{
	event.target.addEventListener(air.Event.COMPLETE, buffLoadTemplateLoaded); 
	event.target.load();
}
function buffLoadTemplateLoaded(event)
{
	try{
	  buffRecord = JSON.parse(event.target.data);
	} catch(e) {
	  alert(getText('bad_template'));
	  return;
	}
	buffSourceRecord = false;
	menuBuffsHandler(null);
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
	showGameAlert(getText('command_sent'));
}
function sendBuffPacket(buffId, grid)
{
	try{
		uniqueIdArr = buffId.split("_");
		uniqueID = swmmo.getDefinitionByName("Communication.VO::dUniqueID").Create(uniqueIdArr[0], uniqueIdArr[1]);
		swmmo.application.mGameInterface.SendServerAction(61, 0, grid, 0, uniqueID);
	} catch (ex) {
		alert(ex);
	}
}
function buffResetData()
{
	buffRecord = null;
	menuBuffsHandler(null);
}