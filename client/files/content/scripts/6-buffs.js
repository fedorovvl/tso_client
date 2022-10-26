var buffRecordEnabled = false;
var buffRecord;
var buffRecordFiltered;
var buffSourceRecord = false;
var buffsAvailable = {};
var buffInProgress = false;

$("#buffModal").on('show.bs.modal hide.bs.modal', function(){ window.nativeWindow.stage.swapChildrenAt(0, 1); });
addMenuItem(loca.GetText("LAB", "Buffs") + " (F5)", menuBuffsHandler, 116);

function menuBuffsHandler(event)
{
	$( "div[role='dialog']:not(#buffModal):visible").modal("hide");
	$('#buffModal .modal-title').html(getImageTag('ProductivityBuffLvl3', '45px') + ' '+loca.GetText("LAB", "Buffs"));
	$('#buffSubmit, #buffReset, #buffSaveTemplate').hide();
	out = '<div class="container-fluid">';
	if(!buffRecordEnabled && buffRecord == null) {
		out = out + '<strong>Welcome to buff manager.</strong></p><p>You can record what you need to buff and then replay it automatically. Press "Start recording" button and buff your (or friend) buildings. After that come back and press "Stop recording". You will see list of buildings and its buffs. Save it as temlate and next time just load template and press Submit.</p><p>Buildings with red background will not be buffed.. also if one of available buff rows be red not all buildings with this buff will be buffed</p><button type="button" class="btn btn-primary btn-lg btn-block" id="startRecording">Start recording</button>';
	}
	if(buffRecordEnabled) {
		out = out + '<p><h2 class="text-center">Recording in progress!</h2></p><button type="button" class="btn btn-primary btn-lg btn-block" id="stopRecording">Stop recording</button>';
	}
	if(!buffRecordEnabled && buffRecord != null) {
		out = out + getBuffHTML() + getBuffsAvailableHTML()+'<br><button type="button" class="btn btn-primary btn-lg btn-block" id="startRecording">Record more</button>';
		if(buffRecordFiltered.length > 0){
			$('#buffSubmit').show();
		}
		$('#buffReset, #buffSaveTemplate').show();
	}
	out += '</div>';
	$("#buffModalData").html(out);
	$("#buffModalData .close").click(function(e) { 
		grid = $(e.currentTarget).val();
		buffRecordFiltered = buffRecordFiltered.filter(function(e) { return e.buiGrid != grid; });
		buffRecord['data'] = buffRecord['data'].filter(function(e) { return e.buiGrid != grid; });
		$(e.currentTarget).closest('.row').remove();
		if(buffRecordFiltered.length == 0){
			buffResetData();
		} else {
			menuBuffsHandler(null);
		}
	});
	$( "#startRecording" ).click(startRecording);
	$( "#stopRecording" ).click(stopRecording);
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
	result = '<br><p>Buffs will be used:</p><div class="row" style="margin-bottom:1rem!important"><div class="col-xs-8 col-sm-8 col-lg-8"  style="background-color:gray;height:23px">Buff</div><div class="col-xs-2 col-sm-2 col-lg-2"  style="background-color:gray;height:23px">Needed</div><div class="col-xs-2 col-sm-2 col-lg-2" style="background-color:gray;height:23px">Available</div></div>';
	for ( buffName in buffNeeded ) {
		count = getBuffAvailableCount(buffName);
		style = "#ffebee";
		if(count >= buffNeeded[buffName]) { style = "#f1f8e9"; }
		result = result + '<div class="row" style="background-color:'+style+';"><div class="col-xs-8 col-sm-8 col-lg-8" >'+loca.GetText("RES", buffName)+'</div><div class="col-xs-2 col-sm-2 col-lg-2">'+buffNeeded[buffName]+'</div><div class="col-xs-2 col-sm-2 col-lg-2">'+count+'</div></div>';
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
	result = '<p>BuffList ZoneID: ' + buffRecord["zoneId"] + '</p><p>BuffList ZoneOwner: ' + buffRecord["zoneUser"] + '</p>';
	isZoneRight = true;
	if(buffRecord["zoneId"] != swmmo.application.mGameInterface.mCurrentViewedZoneID) {
		result = result + '<p><strong>This buff list not for your zone!</strong></p>';
		isZoneRight = false;
	}
	result = result + '<div class="row" style="margin-bottom:1rem!important"><div class="col-xs-1 col-sm-1 col-lg-1"  style="background-color:gray;height:23px">Grid</div><div class="col-xs-4 col-sm-4 col-lg-4"  style="background-color:gray;height:23px">Builing</div><div class="col-xs-5 col-sm-5 col-lg-5"  style="background-color:gray;height:23px">Buff</div><div class="col-xs-2 col-sm-2 col-lg-2"  style="background-color:gray;height:23px">Status</div></div>';
	buffRecordFiltered = [];
	$.each(buffRecord['data'], function(index, data) { 
		status = getBuffStatus(data, isZoneRight);
		style = "#ffebee";
		// too dirty
		if(data['buffName'].indexOf("RemoveBuff") >= 0) { 
			if(status == 'already buffed') { status = 'ready'; } 
			else if(status == 'ready') { status = 'not buffed'; } 
		}
		if(status == 'ready') { buffRecordFiltered.push(data); style = "#f1f8e9"; }
		result = result + '<div class="row" style="background-color:'+style+';"><div class="col-xs-1 col-sm-1 col-lg-1">'+data['buiGrid']+'</div><div class="col-xs-4 col-sm-4 col-lg-4">'+loca.GetText("BUI", data['buiName'])+'</div><div class="col-xs-5 col-sm-5 col-lg-5 name">'+loca.GetText("RES", data['buffName'])+'</div><div class="col-xs-2 col-sm-2 col-lg-2">'+status+'<button type="button" class="close" value="'+data['buiGrid']+'"><span>&times;</span></button></div></div>';
	});
	return result;
}

