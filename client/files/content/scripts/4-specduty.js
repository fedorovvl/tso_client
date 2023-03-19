var dutyType = 1, dutyCounter = [];
var dutySPECIALIST_TASK_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TASK_TYPES");
var dutySpecTypes = { 'dutyExplorersBtn': 1,'dutyGeologistBtn': 2,'dutyGeneralsBtn': 3 };
var dutyTitleIconByType = {
	'dutyExplorersBtn': $(getImageTag('IntrepidExplorer')).prop('src'),
	'dutyGeologistBtn': $(getImageTag('icon_geologist.png')).prop('src'),
	'dutyGeneralsBtn': $(getImageTag('icon_general.png')).prop('src')
}
var dutyWindow;

function specDutyMenuHandler(event)
{
	if(game.gi.isOnHomzone() == false) {
		game.showAlert(getText('not_home'));
		return;
	}
	dutyWindow = new Modal('dutyWindow', getImageTag('IntrepidExplorer') + ' ' + getText('dutymenuTitle') + '<span id="dutyCounter"/>');
	dutyWindow.create();

	if(dutyWindow.withFooter('.dutyExplorersBtn').length == 0)
	{
		dutyWindow.Footer().prepend([
			$('<button>').attr({ "id": "dutyExplorersBtn", "class": "btn btn-primary pull-left dutyExplorersBtn type1" }).text(loca.GetText("SPE", "Explorer")),
			$('<button>').attr({ "id": "dutyGeologistBtn", "class": "btn btn-primary pull-left dutyGeologistBtn type2" }).text(loca.GetText("SPE", "Geologist")),
			$('<button>').attr({ "id": "dutyGeneralsBtn", "class": "btn btn-primary pull-left dutyGeneralsBtn type3" }).text(loca.GetText("SPE", "General"))
		]);
		dutyWindow.withFooter('.dutyExplorersBtn, .dutyGeologistBtn, .dutyGeneralsBtn').click(function(event) {
			dutyWindow.withHeader("img").prop('src', dutyTitleIconByType[this.id]);
			dutyType = dutySpecTypes[this.id];
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
	var tabStat = [], listSpec = [];
	game.getSpecialists().sort(0).forEach(function(item){
		if(item.GetTask() == null) { return; }
		var playerOwner = game.gi.GetPlayerName_string(item.getPlayerID());
		var name = item.getName(false);
		var type = [1,2].indexOf(item.GetBaseType()) != -1 ? item.GetBaseType() : 3;
		tabStat[type] = ++tabStat[type] || 1;
		var task;
		if(type < 3) {
			task = loca.GetText("LAB", item.GetTask().getTaskDefinition().mainTask.taskName_string+item.GetTask().getTaskDefinition().taskType_string);
		} else {
			task = loca.GetText("LAB","SpecialistTask"+dutySPECIALIST_TASK_TYPE.toString(item.GetTask().CreateTaskVOFromSpecialistTask().type));
		}
		var time = item.GetTask().GetRemainingTime();
		listSpec.push( [ name, time, item.getIconID(), task, type, item.getPlayerID()  ]  );
	});
	listSpec.sort(function (a, b){
		if (a[1] > b[1]) return 1;
		if (a[1] < b[1]) return -1;
		return a[0].toLowerCase().localeCompare(b[0].toLowerCase());
	});
	listSpec.forEach(function(item){
		if(item[1] > 0) {
			out += createTableRow([
				[4, getImageTag(item[2], '10%') + item[0], item[5] + ' type' + item[4]],
				[4, item[3]],
				[2, loca.FormatDuration(item[1], 1)],
				[2, dtf.format(new window.runtime.Date(Date.now() + item[1]))]
			]);
		} else {
			out += createTableRow([[3, getImageTag(item[2], '10%') + item[0], item[5] + ' type' + item[4]],[9, item[3]]]);
		}
	});
	dutyCounter = tabStat;
	$.each(dutySpecTypes, function(i, item) {
		dutyWindow.withFooter('.type'+item).prop('disabled', !tabStat[item]);
	});
	dutyWindow.Body().html('<div class="container-fluid">{0}</div>'.format(out));
	dutyWindow.withBody('div.row').find(':first:not(.type'+dutyType+')').closest('div.row').hide();
	dutyWindow.withHeader('#dutyCounter').html(" ({0})".format(dutyCounter[dutyType]||0));
	dutyWindow.show();
}

function dutyRefreshView()
{
	dutyWindow.withHeader('#dutyCounter').html(" ({0})".format(dutyCounter[dutyType]||0));
	dutyWindow.withBody('div.row').find('.type'+dutyType).closest('div.row').show();
	dutyWindow.withBody('div.row').find(':first:not(.type'+dutyType+')').closest('div.row').hide();
}
