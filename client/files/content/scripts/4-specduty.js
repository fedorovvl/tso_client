var dutyHideGuest = false;
var dutyType = 1;
var dutySPECIALIST_TASK_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TASK_TYPES");
var dutySpecTypes = { 'dutyExplorersBtn': 1,'dutyGeologistBtn': 2,'dutyGeneralsBtn': 3 };
var dutyTitleIconByType = {
	'dutyExplorersBtn': $(getImageTag('IntrepidExplorer')).prop('src'),
	'dutyGeologistBtn': $(getImageTag('icon_geologist.png')).prop('src'),
	'dutyGeneralsBtn': $(getImageTag('icon_general.png')).prop('src')
}
var dutyWindow;

function specDutyMenuHandler(event) {
	
	dutyWindow = new Modal('dutyWindow', getImageTag('IntrepidExplorer') + ' ' + loca.GetText("LAB", 'ProductionDetails'));
	dutyWindow.create();

	if(dutyWindow.withFooter('.dutyExplorersBtn').length == 0)
	{
		dutyWindow.Footer().prepend([
			$('<button>').attr({ "id": "dutyExplorersBtn", "class": "btn btn-primary pull-left dutyExplorersBtn" }).text(loca.GetText("SPE", "Explorer")),
			$('<button>').attr({ "id": "dutyGeologistBtn", "class": "btn btn-primary pull-left dutyGeologistBtn" }).text(loca.GetText("SPE", "Geologist")),
			$('<button>').attr({ "id": "dutyGeneralsBtn", "class": "btn btn-primary pull-left dutyGeneralsBtn" }).text(loca.GetText("SPE", "General")),
			$('<button>').attr({ "id": "dutydutyShowGuestBtn", "class": "btn btn-primary pull-left dutydutyShowGuestBtn" }).text(getText("dutyShowGuest")),
		]);
		dutyWindow.withFooter('.dutyExplorersBtn, .dutyGeologistBtn, .dutyGeneralsBtn').click(function(event) {
			dutyWindow.withHeader("img").prop('src', dutyTitleIconByType[this.id]);
			dutyType = dutySpecTypes[this.id];
			dutyRefreshView();
		});
		dutyWindow.withFooter('.dutydutyShowGuestBtn').click(function(event) {
			dutyHideGuest = !dutyHideGuest;
			dutyRefreshView();
		});
	}
	if(dutyWindow.withHeader('.container-fluid').length == 0) {
		dutyWindow.withHeader('').append('<div class="container-fluid"><br>' + createTableRow([
			[4, loca.GetText("LAB","Name")],
			[4, loca.GetText("LAB","TriggerRequiredActiveQuest").slice(0, -1)],
			[2, getText("spec_time_normal")],
			[2, getText("spec_time_arrival")]
			], true) + '</div>'
		);
	}
	dutyType = (game.gi.mCurrentPlayer.mIsAdventureZone ? 3 : 1);

	dutyWindow.withFooter('.dutyExplorersBtn, .dutyGeologistBtn').attr("disabled", game.gi.mCurrentPlayer.mIsAdventureZone);
	var out = '';
	var tabStat = [];
	game.getSpecialists().sort(specNameSorter).forEach(function(item){
		if(item.GetTask() == null) { return; }
		var playerOwner = game.gi.GetPlayerName_string(item.getPlayerID());
		var name = '{1} ({0})'.format(playerOwner, item.getName(false));
		var type = item.GetBaseType() < 3 ? item.GetBaseType() : 3;
		tabStat[type] = ++tabStat[type] || 1;
		var task;
		if(type < 3) {
			task = loca.GetText("LAB", item.GetTask().getTaskDefinition().mainTask.taskName_string+item.GetTask().getTaskDefinition().taskType_string);
		} else {
			task = loca.GetText("LAB","SpecialistTask"+dutySPECIALIST_TASK_TYPE.toString(item.GetTask().CreateTaskVOFromSpecialistTask().type));
		}
		var time = item.GetTask().GetRemainingTime();
		if(time > 0) {
			out += createTableRow([
				[4, getImageTag(item.getIconID(), '10%') + name, item.getPlayerID() + ' type' + type],
				[4, task],
				[2, loca.FormatDuration(time, 1)],
				[2, dtf.format(new window.runtime.Date(Date.now() + time))]
			]);
		} else {
			out += createTableRow([[3, getImageTag(item.getIconID(), '10%') + name, item.getPlayerID() + ' type' + type],[9, task]]);
		}
	});
	$.each(dutySpecTypes, function(i, item) {
		if(!tabStat[item]) { out += createTableRow([[12, loca.GetText("LAB", 'DepositMissing'), 'type'+item]]); }
	});
	dutyWindow.Body().html('<div class="container-fluid">{0}</div>'.format(out));
	dutyWindow.withBody('div.row').find(':first:not(.type'+dutyType+')').closest('div.row').hide()
	dutyWindow.show();
}

function dutyRefreshView()
{
	dutyWindow.withBody('div.row').find('.type'+dutyType).closest('div.row').show();
	dutyWindow.withBody('div.row').find(':first:not(.type'+dutyType+')').closest('div.row').hide();
	if(dutyHideGuest) {
		dutyWindow.withBody('div.row').find(':first:not(.'+game.player.GetPlayerId()+')').closest('div.row').hide();
	}
}
