var buffRecordEnabled = false;
var buffRecord;
var buffRecordFiltered;
var buffSourceRecord = false;
var buffsAvailable = {};
var buffInProgress = false;

addMenuItem(loca.GetText("LAB", "Buffs") + " (F5)", menuBuffsHandler, 116);

function menuBuffsHandler(event)
{
	$("div[role='dialog']:not(#buffModal):visible").modal("hide");
	createModalWindow('buffModal', getImageTag('ProductivityBuffLvl3', '45px') + ' '+loca.GetText("LAB", "Buffs"));
	if($('#buffModal .buffSaveTemplate').length == 0)
	{
		$("#buffModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-success buffSubmit" }).text(getText('btn_submit')),
			$('<button>').attr({ "class": "btn btn-warning buffReset" }).text(getText('btn_reset')),
			$('<button>').attr({ "class": "btn btn-primary pull-left buffSaveTemplate" }).text(getText('save_template')),
			$('<button>').attr({ "class": "btn btn-primary pull-left buffLoadTemplate" }).text(getText('load_template'))
		]);
		$('#buffModal .buffSaveTemplate').click(buffSaveTemplate);
		$('#buffModal .buffLoadTemplate').click(buffLoadTemplate);
		$('#buffModal .buffReset').click(buffResetData);
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
		out += '<p><h2 class="text-center">{0}</h2></p><button type="button" class="btn btn-primary btn-lg btn-block" id="stopRecording">{1}</button>'.format(
			getText('buff_rec_progress'),
			getText('buff_stop_record')
		);
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
	result = '<br><p>{0}</p>'.formcat(getText('buff_used'));
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
