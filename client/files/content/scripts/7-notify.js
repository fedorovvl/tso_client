var notifySettings = {
	enabled: false,
	displayTime: 3,
	position: "auto",
	sound: false,
	theme: 'dark',
	compact: false,
	mentionGroup: true,
	mentionWords: [],
	newsCustom: false,
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

function notificationLast5Handler(event)
{
	notificationManager.replayLatestFiveUpdates();
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
	if(notifySettings.newsCustom && notifySettings.mentionWords.length > 0 && notifySettings.mentionWords.some(function(word) { var t = new RegExp(word,"gi"); return t.test(event.data.text); })) {
		return notificationShow(event.data.text);
	}
	if(!notifySettings.news && event.data.room == "news") { return; }
	var bbmsg = event.data.getExtension("bbmsg");
	if((notifySettings.mentionGroup && notificationPattern.test(event.data.text)) || !event.data.groupMessage) { 
		return notificationShow(loca.GetText("LAB", getRoomNameLoca(event.data.room)) + "\n" + bbmsg.mPlayerName + ": " + event.data.text);
	}
	if(notifySettings.mentionWords.length > 0 && notifySettings.mentionWords.some(function(word) { var t = new RegExp(word,"gi"); return t.test(event.data.text); })) {
		return notificationShow(loca.GetText("LAB", getRoomNameLoca(event.data.room)) + "\n" + bbmsg.mPlayerName + ": " + event.data.text);
	}
}


//init
$.extend(notifySettings, settings.read(null, "notify"));
// typefix
if(Object.prototype.toString.call(notifySettings.mentionWords) == "[object Object]") {
	notifySettings.mentionWords = [];
}
setupNotifications();