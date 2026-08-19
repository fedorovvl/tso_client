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
	news: false,
	explorerDone: false,
	geologistDone: false,
	generalDone: false,
	newsExplorerStarted: false,
	newsGeologistStarted: false,
	newsStorehouseAdded: false
};
// News channel messages are plain server-generated text with no structured
// "type" field, so categories are recognized by keyword. Anything in the
// news channel that doesn't match one of these falls through to the
// generic "news" (catch-all) toggle instead. Add more entries here as new
// categories are identified.
var newsCategories = [
	{ key: 'newsExplorerStarted', pattern: /explorer started/i },
	{ key: 'newsGeologistStarted', pattern: /geologist started/i },
	{ key: 'newsStorehouseAdded', pattern: /added to the storehouse/i }
];
var specialistLastRemaining = {};
var specialistPollIntervalId = null;
var specialistTypeToSetting = { 1: 'explorerDone', 2: 'geologistDone', 3: 'generalDone' };
var specialistTypeToLoca = { 1: 'Explorer', 2: 'Geologist', 3: 'General' };
var notificationTracker = game.getTracker('tsochat', notificationHandler);
var notificationPattern = new RegExp(game.playerName,"gi");
game.gi.channels.ZONE.addPropertyObserver("CHAT_MESSAGE", notificationTracker);

function specialistPollHandler()
{
	if(!notifySettings.enabled) { return; }
	if(!notifySettings.explorerDone && !notifySettings.geologistDone && !notifySettings.generalDone) { return; }
	if(window.nativeWindow.active) { return; }
	try
	{
		if(!game.gi.mCurrentPlayerZone) { return; }
		var myId = game.player.GetPlayerId();
		var seen = {};
		game.gi.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item) {
			if(item.getPlayerID() != myId) { return; }
			var task = item.GetTask();
			var key = item.GetUniqueID().toKeyString();
			var remaining = task ? task.GetRemainingTime() : 0;
			seen[key] = true;
			var last = specialistLastRemaining[key];
			specialistLastRemaining[key] = remaining;
			// Only fire once we've actually observed this specialist mid-task
			// (last is a number) and it just dropped to/below zero, or the
			// task disappeared entirely (finished & already collected).
			if(typeof last == "number" && last > 0 && remaining <= 0) {
				var type = [1,2].indexOf(item.GetBaseType()) != -1 ? item.GetBaseType() : 3;
				var settingKey = specialistTypeToSetting[type];
				if(!notifySettings[settingKey]) { return; }
				notificationShow(loca.GetText("SPE", specialistTypeToLoca[type]) + " " + item.getName(false) + " " + getText('spec_done_desc'));
			}
		});
		Object.keys(specialistLastRemaining).forEach(function(key) {
			if(!(key in seen)) { delete specialistLastRemaining[key]; }
		});
	}
	catch(e) { }
}

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
	if(event.data.room == "news") {
		var newsCategory = newsCategories.filter(function(c) { return c.pattern.test(event.data.text); })[0];
		// Categorized messages are governed only by their own toggle; anything
		// that doesn't match a known category falls under the generic/catch-all
		// "News chat trigger" toggle instead.
		var newsWanted = newsCategory ? notifySettings[newsCategory.key] : notifySettings.news;
		if(newsWanted) { return notificationShow(event.data.text); }
		if(notifySettings.newsCustom && notifySettings.mentionWords.length > 0 && notifySettings.mentionWords.some(function(word) { var t = new RegExp(word,"gi"); return t.test(event.data.text); })) {
			return notificationShow(event.data.text);
		}
		return;
	}
	if(notifySettings.newsCustom && notifySettings.mentionWords.length > 0 && notifySettings.mentionWords.some(function(word) { var t = new RegExp(word,"gi"); return t.test(event.data.text); })) {
		return notificationShow(event.data.text);
	}
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
// Specialist completion isn't pushed as an event by the game client, so poll
// for it instead -- same GetSpecialists_vector()/GetTask() API the duty menu
// (4-specduty.js) already uses to read specialist state.
specialistPollIntervalId = setInterval(specialistPollHandler, 15000);