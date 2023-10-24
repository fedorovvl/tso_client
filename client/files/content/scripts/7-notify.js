var notifySettings = {
	enabled: false,
	displayTime: 3,
	position: "auto",
	sound: false,
	theme: 'dark',
	compact: false,
	mentionGroup: true,
	mentionWords: {},
	news: false
};
var notificationTracker = game.getTracker('tsochat', notificationHandler);
var notificationPattern = new RegExp(game.playerName,"gi");
game.gi.channels.ZONE.addPropertyObserver("CHAT_MESSAGE", notificationTracker);

function setupNotifications()
{
	var notificationManagerDef = notifications.getDefinitionByName("com.charlesbihis.engine.notification::NotificationManager");
	notificationManager = new notificationManagerDef(
		"images/" + notifySettings.theme + ".swf",
		"images/Icon2.png",
		"images/Icon4.png",
		notifySettings.sound ? "images/drop.mp3" : null,
		notifySettings.displayTime,
		notifySettings.position
	);
}

function notificationSettingsHandler(event)
{
	var w = new Modal('notificationSettings', utils.getImageTag('icon_dice.png', '45px') + ' '+loca.GetText("LAB", "ToggleOptionsPanel"));
	var createButton = function(id, text) {
		return $('<button>', { 
			'style': 'cursor: pointer;text-decoration:none;color:#000;height: 20px;padding: 0px;',
			'class': 'btn form-control',
			'id': id
		}).text(text)
	}
	w.size = '';
	w.create();
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [6, loca.GetText("LAB", "AvatarCurrentSelection")]], true);
	var themeSelector = $('<select>', { 'class': 'form-control theme' });
	themeSelector.append([$('<option>', { 'value': 'dark' }).text("Dark"), $('<option>', { 'value': 'light' }).text("Light")]);
	var positionSelector = $('<select>', { 'class': 'form-control position' });
	positionSelector.append([
		$('<option>', { 'value': 'auto' }).text('auto'),
		$('<option>', { 'value': 'topLeft' }).text('topLeft'),
		$('<option>', { 'value': 'topRight' }).text('topRight'),
		$('<option>', { 'value': 'bottomLeft' }).text('bottomLeft'),
		$('<option>', { 'value': 'bottomRight' }).text('bottomRight')
	]);
	var timeSelector = $('<select>', { 'class': 'form-control displayTime' });
	timeSelector.append([$('<option>', { 'value': 3 }).text('3'), $('<option>', { 'value': 5 }).text('5'), $('<option>', { 'value': 7 }).text('7'), $('<option>', { 'value': 10 }).text('10')]);
	html += utils.createTableRow([[9, 'Enabled'], [3, createSwitch('enabled', notifySettings.enabled)]]);
	html += utils.createTableRow([[6, 'Theme'], [6, themeSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[6, 'Display time'], [6, timeSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[6, 'Position'], [6, positionSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[9, 'Sound'], [3, createSwitch('sound', notifySettings.sound)]]);
	html += utils.createTableRow([[9, 'Compact'], [3, createSwitch('compact', notifySettings.compact)]]);
	html += utils.createTableRow([[3, ''],[6, createButton('test', "Test notification")],[3, '']]);
	html += utils.createTableRow([[9, 'News chat trigger'], [3, createSwitch('news', notifySettings.news)]]);
	html += utils.createTableRow([[9, 'Group chat mention trigger'], [3, createSwitch('mentionGroup', notifySettings.news)]]);
	
	w.Body().html(html + '<div>');
	w.withBody('div.row').addClass('nohide');
	w.withBody('button').click(function(e) {
		setupNotifications();
		var title = notifySettings.compact ? loca.GetText("SD2", "ChangeSkinBuffMason") : game.gw + ' - ' + game.playerName;
		notificationManager.show(title, loca.GetText("SD2", "ChangeSkinBuffMason"), "images/Icon2.png", null, notifySettings.compact);
		
	});
	w.withBody('.theme').val(notifySettings.theme).change(function(e) { notifySettings.theme = $(e.target).val(); });
	w.withBody('.position').val(notifySettings.position).change(function(e) { notifySettings.position = $(e.target).val(); });
	w.withBody('.displayTime').val(notifySettings.displayTime).change(function(e) { notifySettings.displayTime = $(e.target).val(); });
	w.withBody('#enabled').change(function(e) { notifySettings.enabled = $(e.target).is(':checked'); });
	w.withBody('#compact').change(function(e) { notifySettings.compact = $(e.target).is(':checked'); });
	w.withBody('#sound').change(function(e) { notifySettings.sound = $(e.target).is(':checked'); });
	w.withBody('#news').change(function(e) { notifySettings.news = $(e.target).is(':checked'); });
	w.withBody('#mentionGroup').change(function(e) { notifySettings.mentionGroup = $(e.target).is(':checked'); });
	
	w.Footer().prepend($("<button>").attr({'class':"btn btn-primary pull-left"}).text(loca.GetText("LAB","Save")).click(function(){
		settings.settings["notify"] = {};
		settings.store(notifySettings, "notify");
		setupNotifications();
		w.hide();
	}));
	w.show();
}

function notificationShow(message)
{
	notificationManager.show(notifySettings.compact ? message : game.gw + ' - ' + game.playerName, message, null, null, notifySettings.compact);
	return true;
}

function getRoomNameLoca(room, group)
{
	if(room.indexOf("global") == 0) { return "ChatGlobal"; }
	if(room == "help") { return "ChatHelp"; }
	if(room == "trade") { return "ChatTrade"; }
	if(room.indexOf("gco") == 0) { return "ChatOfficers"; }
	if(room.indexOf("gc") == 0) { return "ChatGuild"; }
	if(!group) { return "ChatWhisper"; }
	if(room == "news") { return "ChatNews"; }
	if(room.indexOf("myAdv") == 0) { return "ChatGlobal"; }
	if(room.indexOf("frAdv") == 0) { return "ChatGlobal"; }
}

function notificationHandler(event)
{
	if(window.nativeWindow.active || !notifySettings.enabled) { return; }
	if(!event.data.text) { return; }
	if(notifySettings.news && event.data.room == "news") { return notificationShow(event.data.text); }
	if(!notifySettings.news && event.data.room == "news") { return; }
	var bbmsg = event.data.getExtension("bbmsg");
	if((notifySettings.mentionGroup && notificationPattern.test(event.data.text)) || !event.data.groupMessage) { 
		return notificationShow(loca.GetText("LAB", getRoomNameLoca(event.data.room)) + "\n" + bbmsg.mPlayerName + ": " + event.data.text);
	}
}


//init
$.extend(notifySettings, settings.read(null, "notify"));
setupNotifications();