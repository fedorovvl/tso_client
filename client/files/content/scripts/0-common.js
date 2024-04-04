var forcegcIntervalId = null;
var enabledScripts = {};
var buiFastAccess = [];
var lruTemplate = {};
var highlightCircle;
var mainSettings = {
	menuStyle: 'grouped',
	geoDefTask: 0,
	geoDefTaskByType: {},
	explDefTask: 0,
	explDefTaskByType: {},
	specDefTimeType: false,
	defFilter: 'unset',
	persistFilter: false,
	dtfFormat: "MM-dd HH:mm",
	forcegc: true,
	sortOrder: 6,
	statusColorOk: '#CEFF9B',
	statusColorFail: '#FFC1BF',
	statusColorSameGrid: '#668cff',
	buiFastAccessType: 0,
	buffOnlyActive: false,
	changeTemplateFolder: true,
	lruCacheSize: 3,
	highlight: true,
	highlightSize: 45,
	highlightColor: '#ff0000',
	highlightGlowColor: '#ffffff',
	chatFontSize: 12,
	chatPanelWidth: 350,
	starColsCount: 9,
	starRowsCount: 4,
	experimental: false,
	mwWindowSize: 'default',
	useCustomChatCSS: false, 
	chatCSS: { 
		'bbmsg': '#8CA8FF', 'modmsg': '#E5CD2D', 'communityleadmsg': '#99ff99', 'globaltstamp': '#7FFF7F', 'globalsender': '#00FF33', 'globalmsg': '#E2E2E2', 'globalownname': '#FF8644', 'globalimportant': '#E2E2E2', 'findcooptstamp': '#00FF33', 'findcoopsender': '#00FF33', 'findcoopmsg': '#E2E2E2', 'findcoopownname': '#FF8644', 'findcoopimportant': '#E2E2E2', 'tradetstamp': '#00FF33', 'tradesender': '#00FF33', 'trademsg': '#E2E2E2', 'tradeownname': '#FF9347', 'tradeimportant': '#E2E2E2', 'helptstamp': '#00FF33', 'helpsender': '#00FF33', 'helpmsg': '#E2E2E2', 'helpownname': '#FF9347', 'helpimportant': '#E2E2E2', 'newststamp': '#FFFF00', 'newssender': '#FFFF00', 'newsmsg': '#FFFF00', 'newsimportant': '#FFFF00', 'newsownname': '#FF9347', 'guildtstamp': '#7FFF7F', 'guildsender': '#7FFF7F', 'guildmsg': '#7FFF7F', 'guildownname': '#7FFF7F', 'guildimportant': '#7FFF7F', 'officerststamp': '#7FFF7F', 'officerssender': '#7FFF7F', 'officersmsg': '#7FFF7F', 'officersownname': '#7FFF7F', 'officersimportant': '#7FFF7F', 'whispertstamp': '#FC68FF', 'whispersender': '#FC68FF', 'whispermsg': '#FC68FF', 'whisperownname': '#FF9347', 'whisperimportant': '#FC68FF', 'cooptstamp': '#00FF33', 'coopsender': '#00FF33', 'coopmsg': '#E2E2E2', 'coopownname': '#FF8644' 
	},
	infoBarResources: ["Tool", "Coin", "Plank", "RealPlank", "Stone", "Marble"],
	showOnlyActiveGuildMembers: false,
	shortcutsDir: "",
	shortAsGlobalRelative: false
};
var chatCSSTemplate = '.bbmsg {#bbmsg;font-weight: bold;}.modmsg {#modmsg;font-weight: bold;}.communityleadmsg {#communityleadmsg;font-weight: bold;}.globaltstamp {#globaltstamp;}.globalsender {#globalsender;text-decoration: underline;}.globalmsg {#globalmsg;}.globalownname {#globalownname;font-weight: bold;}.globalimportant {#globalimportant;font-weight: bold;}.findcooptstamp {#findcooptstamp;}.findcoopsender {#findcoopsender;text-decoration: underline;}.findcoopmsg {#findcoopmsg;}.findcoopownname {#findcoopownname;font-weight: bold;}.findcoopimportant {#findcoopimportant;font-weight: bold;}.tradetstamp {#tradetstamp;}.tradesender {#tradesender;text-decoration: underline;}.trademsg {#trademsg;}.tradeownname {#tradeownname;font-weight: bold;}.tradeimportant {#tradeimportant;font-weight: bold;}.helptstamp {#helptstamp;}.helpsender {#helpsender;text-decoration: underline;}.helpmsg {#helpmsg;}.helpownname {#helpownname;font-weight: bold;}.helpimportant {#helpimportant;font-weight: bold;}.newststamp {#newststamp;}.newssender {#newssender;text-decoration: underline;}.newsmsg {#newsmsg;}.newsimportant {#newsimportant;font-weight: bold;}.newsownname {#newsownname;font-weight: bold;}.guildtstamp {#guildtstamp;}.guildsender {#guildsender;text-decoration: underline;}.guildmsg {#guildmsg;}.guildownname {#guildownname;font-weight: bold;}.guildimportant {#guildimportant;font-weight: bold;}.officerststamp {#officerststamp;}.officerssender {#officerssender;text-decoration: underline;}.officersmsg {#officersmsg;}.officersownname {#officersownname;font-weight: bold;}.officersimportant {#officersimportant;font-weight: bold;}.whispertstamp {#whispertstamp;}.whispersender {#whispersender;text-decoration: underline;}.whispermsg {#whispermsg;}.whisperownname {#whisperownname;font-weight: bold;}.whisperimportant {#whisperimportant;font-weight: bold;}.*coop*tstamp {#cooptstamp;}.*coop*sender {#coopsender;text-decoration: underline;}.*coop*msg {#coopmsg;}.*coop*ownname {#coopownname;}';
var cssRoomToLoca = {
	'global': loca.GetText("LAB", "ChatGlobal"),
	'findcoop': loca.GetText("LAB", "ChatFindcooperation"),
	'trade': loca.GetText("LAB", "ChatTrade"),
	'help': loca.GetText("LAB", "ChatHelp"),
	'news': loca.GetText("LAB", "ChatNews"),
	'guild': loca.GetText("LAB", "ChatGuild"),
	'officers': loca.GetText("LAB", "ChatOfficers"),
	'whisper': loca.GetText("LAB", "ChatWhisper")
};
var highlightTracker = game.getTracker('highlightTracker', highlightModifyFrame);
var scaleFactor = game.def("global").mGraphicScaleFactor;
var ResourceGroupToWarehouseTab = { 
	"CL1": "WarehouseTab1",
	"CL2": "WarehouseTab2",
	"CL3": "WarehouseTab3",
	"CL4": "WarehouseTab4",
	"CL5": "WarehouseTab8",
	"Collectibles": "WarehouseTab7",
	"Event": "WarehouseTab6"
};

function toggleExperimental()
{
	swmmo.getDefinitionByName("defines").CLIENT_EXPERIMENTAL = !swmmo.getDefinitionByName("defines").CLIENT_EXPERIMENTAL;
}

function reloadScripts(event)
{
	menu.clearTools();
	air.File.applicationDirectory.resolvePath("userscripts").getDirectoryListing().forEach(function(item) {
		if(enabledScripts[item.name] || enabledScripts[item.name] == undefined) {
			$('head').append($("<script>").attr({ "src": "userscripts/" + item.name + "?" + new Date().getTime(), "id": "user", "type": "text/javascript"}));
		}
	});
}

function humanMemorySize(bytes, dp) {
	const units = ['kB', 'MB', 'GB', 'TB'];
	var u = -1;
	do {
		bytes /= 1024;
		u++;
	} while (Math.round(Math.abs(bytes) * 10) / 10 >= 1024 && u < units.length - 1);
	return bytes.toFixed(dp) + ' ' + units[u];
}
function getText(id, module)
{
	var searchPath = !module ? baseTranslation[gameLang] : baseTranslation[module][gameLang],
		backupPath = !module ? baseTranslation["en-uk"] : baseTranslation[module]["en-uk"];
	searchPath = typeof searchPath == "undefined" ? {} : searchPath;
	backupPath = typeof backupPath == "undefined" ? {} : backupPath;
	if(!searchPath[id] && !backupPath[id]) { return "RES not found : " + id; }
	return searchPath[id] ? searchPath[id] : backupPath[id];
}

function extendBaseLang(data, module)
{
	var extend_data = {};
	if(module) {
		extend_data[module] = data;
	} else {
		extend_data = data;
	}
	$.extend(baseTranslation, extend_data);
}

function debug(obj)
{
	if(typeof air.Introspector !== 'undefined') {
		air.Introspector.Console.log(obj);
	}
}

function specNameSorter(a, b)
{
	try {
		switch(mainSettings.sortOrder) {
			case 0:
				return a.GetType() > b.GetType() ? -1 : 1;
			break;
			case 1:
				return a.GetType() > b.GetType() ? 1 : -1;
			break;
			case 2:
				if (a.GetType() < b.GetType()) return -1;
				if (a.GetType() > b.GetType()) return 1;
				return b.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase().localeCompare(a.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase());
			break;
			case 3:
				if (a.GetType() < b.GetType()) return -1;
				if (a.GetType() > b.GetType()) return 1;
				return a.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase().localeCompare(b.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase());
			break;
			case 4:
				return b.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase().localeCompare(a.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase());
			break;
			case 5:
				return a.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase().localeCompare(b.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase());
			break;
			case 6:
				var res = a.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase().localeCompare(b.getName(false).replace(/(<([^>]+)>)/gi, "").toLowerCase());
				return res != 0 ? res : a.GetType() > b.GetType() ? -1 : 1;
			break;
			default:
				return 0;
			break;
		}
	} catch (e) { return 0; }
}

function buiFastAccessMenuHandler(event) {
	try {
		var vector = game.gi.mCurrentPlayerZone.mStreetDataMap.getBuildingsByName_vector(event.target.name);
		if(!vector) { return true; }
		if(mainSettings.buiFastAccessType == 1) {
			vector.sort(function(a, b) { return a.GetUpgradeLevel() > b.GetUpgradeLevel() ? -1 : 1; });
			game.zone.ScrollToGrid(vector[0].GetGrid());
			game.gi.SelectBuilding(vector[0]);
			return;
		}
		buiFastAccess[event.target.name] = buiFastAccess[event.target.name] || 0;
		if(!vector[buiFastAccess[event.target.name]]) { buiFastAccess[event.target.name] = 0; }
		game.zone.ScrollToGrid(vector[buiFastAccess[event.target.name]].GetGrid());
		game.gi.SelectBuilding(vector[buiFastAccess[event.target.name]]);
		buiFastAccess[event.target.name]++;
	} catch (e) { debug(e); }
}

function cssGetText(id)
{
	//global
	var result = "";
	$.each(cssRoomToLoca, function(k, v) {
		if(id.indexOf(k) == 0) { result = "[{0}] {1}".format(v, getText("css_" + id.replace(k, ''))); }
	});
	if(id.indexOf('coop') == 0) { 
		return "[{0}] {1}".format(getText("css_adventure"), getText("css_" + id.replace('coop', '')));
	}
	if(result != "") { return result; }
	return getText("css_" + id);
}

function mainSettingsHandler(event)
{
	var w = new Modal('mainSettings', utils.getImageTag('icon_dice.png', '45px') + ' '+loca.GetText("LAB", "ToggleOptionsPanel"));
	var getDefFolder = function(id){
		return $('<span>', { 'class': id }).html(mainSettings[id] ? mainSettings[id] : air.File.documentsDirectory.nativePath).prop('outerHTML');
	};
	var getDefTimeType = function(){
		return !mainSettings.specDefTimeType ? getText('spec_time_normal') : getText('spec_time_arrival');
	};
	var getBuiFastAccessType = function(){
		return mainSettings.buiFastAccessType == 0 ? getText('buiFastCarousel') : getText('buiFastLevel');
	};
	var getBuffOnlyActive = function(){
		return mainSettings.buffOnlyActive ? getText('buffonlyactive') : getText('buffall');
	};
	var createResourceDrop = function(){
		var sortedResources = {};
		resources.GetResources_Vector().sort(function(a, b) { return a.group_string > b.group_string ? 1 : -1; }).forEach(function(item) {
			if(item.group_string == "DEF_MODE") { return; }
			var group = item.group_string == "" ? "Collectibles": item.group_string;
			(sortedResources[group] = sortedResources[group] ? sortedResources[group] : []).push({ name: item.name_string, loca: loca.GetText("RES", item.name_string) });
		});
		var select = $('<select>', { 'class': 'form-control', 'position': 'absolute', 'size': 1 });
		$.each(ResourceGroupToWarehouseTab, function(key, label) {
			var group = $('<optgroup>', { label: loca.GetText("LAB", label) });
			sortedResources[key].forEach(function(item) { 
				group.append($('<option>', { value: item.name }).text(item.loca));
			});
			select.append(group);
		});
		return select;
	}
	var createFilterDrop = function(){
		const filters = ["unset", "none","snownowater","snowlight","snow","oven","doomsday","night","desert","tropical","blackandwhite","spooky","snow_medium","tundra","darkershadow","magicsepia"];
		var select = $('<select>', { 'class': 'form-control defFilter' });
		for(var i in filters) {
			select.append($('<option>', { value: filters[i] }).text(filters[i]));
		}
		return select.prop('outerHTML');
	};
	var createDateFormatterDrop = function(){
		const formats = ['M-d H:m','d-M H:m','MM-dd HH:mm','dd-MM-yyyy hh:mm','yyyy-MM-dd HH:mm','dd-MM-yyyy HH:mm'];
		var select = $('<select>', { 'class': 'form-control dtfFormat' });
		for(var i in formats) {
			select.append($('<option>', { value: formats[i] }).text(formats[i]));
		}
		return select.prop('outerHTML');
	}
	var createMwSizeDrop = function(){
		const sizes = ['default','same','fullscreen','maximized','minimized'];
		var select = $('<select>', { 'class': 'form-control mwWindowSize' });
		for(var i in sizes) {
			select.append($('<option>', { value: sizes[i] }).text(getText("wmsize_" + sizes[i])));
		}
		return select.prop('outerHTML');
	}
	var createLruDrop = function(){
		var select = $('<select>', { 'class': 'form-control lruSize' });
		for(var i=1; i < 21; i++) {
			select.append($('<option>', { value: i }).text(i));
		}
		return select.prop('outerHTML');
	}
	var createChatFontDrop = function(){
		var select = $('<select>', { 'class': 'form-control chatFontSize' });
		const num = [12,14,16,18,20];
		for(var i in num) {
			select.append($('<option>', { value: num[i] }).text(num[i]));
		}
		return select.prop('outerHTML');
	}
	var createChatWidthDrop = function(){
		var select = $('<select>', { 'class': 'form-control chatWidth' });
		for(var i=350; i < 600; i+=10) {
			select.append($('<option>', { value: i }).text(i + 'px'));
		}
		return select.prop('outerHTML');
	}
	var createStarColsDrop = function(){
		var select = $('<select>', { 'class': 'form-control starCols' });
		// += 57
		for(var i=9; i < 20; i++) {
			select.append($('<option>', { value: i }).text(i));
		}
		return select.prop('outerHTML');
	}
	var createStarRowsDrop = function(){
		var select = $('<select>', { 'class': 'form-control starRows' });
		// += 70
		for(var i=4; i < 15; i++) {
			select.append($('<option>', { value: i }).text(i));
		}
		return select.prop('outerHTML');
	}
	var createHighlightSizeDrop = function(){
		var select = $('<select>', { 'class': 'form-control hSize' });
		const num = [45,55,65,75];
		for(var i in num) {
			select.append($('<option>', { value: num[i] }).text(num[i]));
		}
		return select.prop('outerHTML');
	}
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
	var tabs = $('<ul>', { 'class': 'nav nav-pills nav-justified', 'style': 'width: 100%' });
	var tabcontent = $('<div>', { 'class': 'tab-content' });
	tabs.append($('<li>', { 'class': 'active' }).append($('<a>', { 'data-toggle': 'tab', 'href': '#menumain' }).text(loca.GetText("ACL", "BuffAdventuresGeneral"))));
	tabs.append($('<li>').append($('<a>', { 'data-toggle': 'tab', 'href': '#menutemplates' }).text(getText("templates_desc"))));
	tabs.append($('<li>').append($('<a>', { 'data-toggle': 'tab', 'href': '#menuui' }).text("UI")));
	tabs.append($('<li>').append($('<a>', { 'data-toggle': 'tab', 'href': '#menunotify' }).text(getText("notifi_desc"))));
	tabs.append($('<li>').append($('<a>', { 'data-toggle': 'tab', 'href': '#menuchat' }).text(getText("chat_desc"))));
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [6, loca.GetText("LAB", "AvatarCurrentSelection")]], true);
	var themeSelector = $('<select>', { 'class': 'form-control theme' });
	themeSelector.append([$('<option>', { 'value': 'dark' }).text(getText("theme_dark")), $('<option>', { 'value': 'light' }).text(getText("theme_light"))]);
	var positionSelector = $('<select>', { 'class': 'form-control position' });
	positionSelector.append([
		$('<option>', { 'value': 'auto' }).text(getText("position_auto")),
		$('<option>', { 'value': 'topLeft' }).text(getText("position_topLeft")),
		$('<option>', { 'value': 'topRight' }).text(getText("position_topRight")),
		$('<option>', { 'value': 'bottomLeft' }).text(getText("position_bottomLeft")),
		$('<option>', { 'value': 'bottomRight' }).text(getText("position_bottomRight"))
	]);
	var timeSelector = $('<select>', { 'class': 'form-control displayTime' });
	timeSelector.append([$('<option>', { 'value': 3 }).text('3'), $('<option>', { 'value': 5 }).text('5'), $('<option>', { 'value': 7 }).text('7'), $('<option>', { 'value': 10 }).text('10')]);
	var menuStyleSelector = $('<select>', { 'class': 'form-control menuStyle' });
	menuStyleSelector.append([
		$('<option>', { 'value': 'grouped' }).text(getText('menustyle_grouped')),
		$('<option>', { 'value': 'linear' }).text(getText('menustyle_linear')),		
	]);
	var sortNameSelector = $('<select>', { 'class': 'form-control sortOrder' });
	sortNameSelector.append([
		$('<option>', { 'value': 0 }).text('{0} (DESC)'.format(getText('sortbytype'))),
		$('<option>', { 'value': 1 }).text('{0} (ASC)'.format(getText('sortbytype'))),
		$('<option>', { 'value': 2 }).text('{0} > {1} (DESC)'.format(getText('sortbytype'), getText('sortbyname'))),
		$('<option>', { 'value': 3 }).text('{0} > {1} (ASC)'.format(getText('sortbytype'), getText('sortbyname'))),
		$('<option>', { 'value': 4 }).text('{0} (DESC)'.format(getText('sortbyname'))),
		$('<option>', { 'value': 5 }).text('{0} (ASC)'.format(getText('sortbyname'))),
		$('<option>', { 'value': 6 }).text(loca.GetText("LAB", "StarMenu")),
	]);
	html += utils.createTableRow([[6, getText('menustyle_desc')], [6, menuStyleSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[6, getText('deffilter_desc')], [6, createFilterDrop()]]);
	html += utils.createTableRow([[6, "{0} {1}".format(loca.GetText("LAB", "Filter"), loca.GetText("QUL", "TutFreeHomezone3"))], [6, createSwitch('persistFilter', mainSettings.persistFilter)]]);
	html += utils.createTableRow([[6, getText('dateformat_desc')], [6, createDateFormatterDrop()]]);
	html += utils.createTableRow([[6, getText('lru_desc')], [6, createLruDrop()]]);
	html += utils.createTableRow([
		[6, getText('spectimetype_desc')], 
		[6, createSwitch('specDefTimeType', mainSettings.specDefTimeType) + '<div style="position: absolute;left: 55px;top: 1px;" id="specTimeTypeLang">{0}</div>'.format(getDefTimeType())]
	]);
	html += utils.createTableRow([[6, getText('sortorder_desc')], [6, sortNameSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[6, getText('forcegc_desc')], [6, createSwitch('forcegc', mainSettings.forcegc)]]);
	html += utils.createTableRow([
		[6, getText('buiFastdesc')], 
		[6, createSwitch('buiFastAccessType', mainSettings.buiFastAccessType == 0 ? false : true) + '<div style="position: absolute;left: 55px;top: 1px;" id="buiFastAccessTypeLang">{0}</div>'.format(getBuiFastAccessType())]
	]);
	html += utils.createTableRow([
		[6, getText('buffactive_desc')], 
		[6, createSwitch('buffOnlyActive', mainSettings.buffOnlyActive) + '<div style="position: absolute;left: 55px;top: 1px;" id="buffOnlyActiveLang">{0}</div>'.format(getBuffOnlyActive())]
	]);
	html += utils.createTableRow([[6, getText("experimental_desc")], [6, createSwitch('experimental', mainSettings.experimental)]]);
	html += utils.createTableRow([[6, getText("mwmode_desc")], [6, createMwSizeDrop()]]);

	tabcontent.append($('<div>', { 'class': 'tab-pane fade in active', 'id': 'menumain' }).append(html + '</div>'));
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [6, loca.GetText("LAB", "AvatarCurrentSelection")]], true);
	html += utils.createTableRow([[9, getText('geotemplates_desc') + getDefFolder('geolastDir')], [3, createButton('geolastDir', loca.GetText("LAB", "Select"))]]);
	html += utils.createTableRow([[9, getText('expltemplates_desc') + getDefFolder('expllastDir')], [3, createButton('expllastDir', loca.GetText("LAB", "Select"))]]);
	html += utils.createTableRow([[9, getText('bufftemplates_desc') + getDefFolder('bufflastDir')], [3, createButton('bufflastDir', loca.GetText("LAB", "Select"))]]);
	html += utils.createTableRow([[9, getText('buitemplates_desc') + getDefFolder('builastDir')], [3, createButton('builastDir', loca.GetText("LAB", "Select"))]]);
	html += utils.createTableRow([[9, getText('armytemplates_desc') + getDefFolder('armylastDir')], [3, createButton('armylastDir', loca.GetText("LAB", "Select"))]]);
	html += utils.createTableRow([[9, getText('battletemplates_desc') + getDefFolder('battlelastDir')], [3, createButton('battlelastDir', loca.GetText("LAB", "Select"))]]);
	html += utils.createTableRow([[9, getText("short_path_desc") + $('<span>', { 'class': 'shortcutsDir' }).html(mainSettings.shortcutsDir).prop('outerHTML')], [2, createButton('shortcutsDir', loca.GetText("LAB", "Select"))], [1, createButton('x_shortcutsDir', 'x')]]);
	html += utils.createTableRow([[9, getText("short_use_for_tmpl_desc")], [3, createSwitch('shortAsGlobalRelative', mainSettings.shortAsGlobalRelative)]]);
	html += utils.createTableRow([[9, getText('dontchangefolder_desc')], [3, createSwitch('changeTemplateFolder', mainSettings.changeTemplateFolder)]]);
	html += utils.createTableRow([[6, getText('geodeftask_desc')], [6, createGeologistDropdown(0, 0, true), 'geoMass']]);
	html += utils.createTableRow([[6, getText('expldeftask_desc')], [6, createExplorerDropdown(0, 0, 0, true), 'explMass']]);
	tabcontent.append($('<div>', { 'class': 'tab-pane fade', 'id': 'menutemplates' }).append(html+'</div>'));
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [6, loca.GetText("LAB", "AvatarCurrentSelection")]], true);
	html += utils.createTableRow([[6, getText('okfieldcolor_desc')], [6, '<input type="text" value="'+mainSettings.statusColorOk+'" id="statusColorOk" class="kolorPicker form-control shortercontrol"><span class="colorcell"/>']]);
	html += utils.createTableRow([[6, getText('failfieldcolor_desc')], [6, '<input type="text" value="'+mainSettings.statusColorFail+'" id="statusColorFail" class="kolorPicker form-control shortercontrol"><span class="colorcell"/>']]);
	html += utils.createTableRow([[6, getText('samefieldcolor_desc')], [6, '<input type="text" value="'+mainSettings.statusColorSameGrid+'" id="statusColorSameGrid" class="kolorPicker form-control shortercontrol"><span class="colorcell"/>']]);
	html += utils.createTableRow([[6, getText('highlight_desc')], [6, createSwitch('highlight', mainSettings.highlight) + '<div style="position: absolute;left: 55px;top: 1px;">{0}</div>'.format(getText('highlight_reboot'))]]);
	html += utils.createTableRow([[6, getText('highlightSize_desc')], [6, createHighlightSizeDrop()]]);
	html += utils.createTableRow([[6, getText('highlightColor_desc')], [6, '<input type="text" value="'+mainSettings.highlightColor+'" id="highlightColor" class="kolorPicker form-control shortercontrol"><span class="colorcell"/>']]);
	html += utils.createTableRow([[6, getText('highlightGlow_desc')], [6, '<input type="text" value="'+mainSettings.highlightGlowColor+'" id="highlightGlowColor" class="kolorPicker form-control shortercontrol"><span class="colorcell"/>']]);
	html += utils.createTableRow([[6, getText('starmenurows_desc')], [6, createStarRowsDrop()]]);
	html += utils.createTableRow([[6, getText('starmenucols_desc')], [2, createStarColsDrop()], [4, getText('highlight_reboot')]]);
	html += utils.createTableRow([[6, getText("only_guild_online_desc")], [6, createSwitch('showOnlyActiveGuildMembers', mainSettings.showOnlyActiveGuildMembers)]]);
	var resDrop = createResourceDrop();
	for(var i = 1; i < 7; i++) {
		html += utils.createTableRow([[6, getText('infobarresource_desc') + i], [6, resDrop.clone().attr("id", "InfoBarRes_" + i).prop('outerHTML')]]);
	}
	tabcontent.append($('<div>', { 'class': 'tab-pane fade', 'id': 'menuui' }).append(html+'</div>'));
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [6, loca.GetText("LAB", "AvatarCurrentSelection")]], true);
	html += utils.createTableRow([[9, getText('enabled_desc')], [3, createSwitch('enabled', notifySettings.enabled)]]);
	html += utils.createTableRow([[6, getText('theme_desc')], [6, themeSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[6, getText('displaytime_desc')], [6, timeSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[6, getText("position_desc")], [6, positionSelector.prop('outerHTML')]]);
	html += utils.createTableRow([[9, getText('sound_desc')], [3, createSwitch('sound', notifySettings.sound)]]);
	html += utils.createTableRow([[9, getText("compact_desc")], [3, createSwitch('compact', notifySettings.compact)]]);
	html += utils.createTableRow([[3, ''],[6, createButton('testnotify', getText("notifitest_desc"))],[3, '']]);
	html += utils.createTableRow([[9, getText('newschattrigger_desc')], [3, createSwitch('news', notifySettings.news)]]);
	html += utils.createTableRow([[9, getText('customwordsnewschannel_desc')], [3, createSwitch('newsCustom', notifySettings.newsCustom)]]);
	html += utils.createTableRow([[9, getText('groupchatmentiontrigger_desc')], [3, createSwitch('mentionGroup', notifySettings.mentionGroup)]]);
	html += utils.createTableRow([[3, getText('customwordstrigger_desc')], [9, '<input type="text" value="'+notifySettings.mentionWords.join(", ")+'" id="mentionWords" class="form-control">']]);
	tabcontent.append($('<div>', { 'class': 'tab-pane fade', 'id': 'menunotify' }).append(html+'</div>'));
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [6, loca.GetText("LAB", "AvatarCurrentSelection")]], true);
	html += utils.createTableRow([[6, getText('chatpanelwidth_desc')], [6, createChatWidthDrop()]]);
	html += utils.createTableRow([[6, getText('chatfontsize_desc')], [2, createChatFontDrop()], [4, getText('highlight_reboot')]]);
	html += utils.createTableRow([[6, getText('usecustomchatcss_desc')], [6, createSwitch('useCustomChatCSS', mainSettings.useCustomChatCSS)]]);
	$.each(mainSettings.chatCSS, function(k, v) {
		html += utils.createTableRow([[6, cssGetText(k)], [6, '<input type="text" value="'+v+'" id="'+k+'" class="kolorPicker form-control shortercontrol"><span class="colorcell"/>']]);
	});
	tabcontent.append($('<div>', { 'class': 'tab-pane fade', 'id': 'menuchat' }).append(html+'</div>'));
	w.Body().html(tabs.prop("outerHTML") + '<br>' + tabcontent.prop("outerHTML"));
	w.withBody('div.row').addClass('nohide');
	w.withBody('.nav-justified > li').css("width", "20%");
	w.withBody('.kolorPicker').change(function() {
		$(this).closest('div').find('span').css('background-color', this.value);
		if(mainSettings[this.id]) {	mainSettings[this.id] = this.value; }
		if(mainSettings.chatCSS[this.id]) {	mainSettings.chatCSS[this.id] = this.value; }
		switch(this.id) {
			case 'statusColorOk':
				document.styleSheets[0].insertRule(".buffReady{background-color:"+this.value+";}", document.styleSheets[0].rules.length);
			break;
			case 'statusColorFail':
				document.styleSheets[0].insertRule(".buffNotReady{background-color:"+this.value+";}", document.styleSheets[0].rules.length);
			break;
			case 'statusColorSameGrid':
				document.styleSheets[0].insertRule(".specSamegrid{background-color:"+this.value+";}", document.styleSheets[0].rules.length);
			break;
		}
	});
	w.withBody('.kolorPicker').change();
	w.withBody('button').click(function(e) { 
		var id = $(e.target).attr('id');
		if(id == 'testnotify') {
			setupNotifications();
			var title = notifySettings.compact ? loca.GetText("SD2", "ChangeSkinBuffMason") : game.gw + ' - ' + game.playerName;
			notificationManager.show(title, loca.GetText("SD2", "ChangeSkinBuffMason"), "images/Icon2.png", null, notifySettings.compact);
			return;
		}
		if(id[0] == 'x') {
			mainSettings[id.replace("x_", "")] = '';
			w.withBody('.' + id.replace("x_", "")).html("");
			return;
		}
		var file = new air.File(); 
		file.addEventListener(air.Event.SELECT, function(event){
			if(mainSettings.shortcutsDir != "" && mainSettings.shortAsGlobalRelative && file.nativePath.indexOf(mainSettings.shortcutsDir) != 0) {
				alert(getText("dir_not_match_base_path")+mainSettings.shortcutsDir+"!");
				return;
			}
			mainSettings[id] = mainSettings.shortAsGlobalRelative ? file.nativePath.replace(mainSettings.shortcutsDir, "") : file.nativePath;
			w.withBody('.' + id).html(mainSettings[id]);
		}); 
		file.browseForDirectory("Select a directory"); 
	});
	for(var i = 1; i < 7; i++) {
		var slot = i - 1;
		w.withBody('#InfoBarRes_' + i).val(mainSettings.infoBarResources[slot]);
	}
	w.withBody("select[id^='InfoBar']").change(function(e) { 
		var slot = $(e.target).attr('id').slice(-1) - 1;
		mainSettings.infoBarResources[slot] = $(e.target).val();
	});
	w.withBody("select[id^='InfoBar']").click(function(e) { this.size=(this.size!=1)?1:10; });
	w.withBody('.menuStyle').val(mainSettings.menuStyle).change(function(e) { mainSettings.menuStyle = $(e.target).val(); });
	w.withBody('.sortOrder').val(mainSettings.sortOrder).change(function(e) { mainSettings.sortOrder = parseInt($(e.target).val()); });
	w.withBody('.defFilter').val(mainSettings.defFilter).change(function(e) { mainSettings.defFilter = $(e.target).val(); });
	w.withBody('.dtfFormat').val(mainSettings.dtfFormat).change(function(e) { mainSettings.dtfFormat = $(e.target).val(); });
	w.withBody('.mwWindowSize').val(mainSettings.mwWindowSize).change(function(e) { mainSettings.mwWindowSize = $(e.target).val(); });
	w.withBody('.lruSize').val(mainSettings.lruCacheSize).change(function(e) { mainSettings.lruCacheSize = parseInt($(e.target).val()); });
	w.withBody('.chatFontSize').val(mainSettings.chatFontSize).change(function(e) { 
		mainSettings.chatFontSize = parseInt($(e.target).val());
		game.def("defines").CHAT_FONT_SIZE = mainSettings.chatFontSize;
	});
	w.withBody('.chatWidth').val(mainSettings.chatPanelWidth).change(function(e) { 
		mainSettings.chatPanelWidth = parseInt($(e.target).val());
		swmmo.application.blueFireComponent.width = mainSettings.chatPanelWidth;
	});
	w.withBody('.starCols').val(mainSettings.starColsCount).change(function(e) { mainSettings.starColsCount = parseInt($(e.target).val()); });
	w.withBody('.starRows').val(mainSettings.starRowsCount).change(function(e) { mainSettings.starRowsCount = parseInt($(e.target).val()); });
	w.withBody('.hSize').val(mainSettings.highlightSize).change(function(e) { mainSettings.highlightSize = parseInt($(e.target).val()); });
	w.withBody('.geoMass select').val(mainSettings.geoDefTask).change(function(e) { mainSettings.geoDefTask = $(e.target).val(); });
	w.withBody('.explMass select').val(mainSettings.explDefTask).change(function(e) { mainSettings.explDefTask = $(e.target).val(); });
	w.withBody('#specDefTimeType').change(function(e) {
		mainSettings.specDefTimeType = $(e.target).is(':checked');
		w.withBody('#specTimeTypeLang').html(getDefTimeType());
	});
	w.withBody('#buiFastAccessType').change(function(e) {
		mainSettings.buiFastAccessType = $(e.target).is(':checked') ? 1 : 0;
		w.withBody('#buiFastAccessTypeLang').html(getBuiFastAccessType());
	});
	w.withBody('#buffOnlyActive').change(function(e) {
		mainSettings.buffOnlyActive = $(e.target).is(':checked');
		w.withBody('#buffOnlyActiveLang').html(getBuffOnlyActive());
	});
	w.withBody('#changeTemplateFolder').change(function(e) { mainSettings.changeTemplateFolder = $(e.target).is(':checked'); });
	w.withBody('#shortAsGlobalRelative').click(function(e) { 
		if(mainSettings.shortcutsDir == "" && mainSettings.shortAsGlobalRelative) {
			alert("Shortcuts base path not set");
			e.preventDefault();
			mainSettings.shortAsGlobalRelative = false;
			return;
		}
	});
	w.withBody('#shortAsGlobalRelative').change(function(e) { 
		mainSettings.shortAsGlobalRelative = $(e.target).is(':checked');
	});
	w.withBody('#forcegc').change(function(e) {	
		mainSettings.forcegc = $(e.target).is(':checked');
		toggleForceGC();
	});
	w.withBody('#persistFilter').change(function(e) { mainSettings.persistFilter = $(e.target).is(':checked'); });
	w.withBody('#highlight').change(function(e) { mainSettings.highlight = $(e.target).is(':checked'); });	
	w.withBody('#experimental').change(function(e) { 
		mainSettings.experimental = $(e.target).is(':checked');
		toggleExperimental();
	});	
	w.withBody('#useCustomChatCSS').change(function(e) {	
		mainSettings.useCustomChatCSS = $(e.target).is(':checked');
	});
	w.withBody('.theme').val(notifySettings.theme).change(function(e) { notifySettings.theme = $(e.target).val(); });
	w.withBody('.position').val(notifySettings.position).change(function(e) { notifySettings.position = $(e.target).val(); });
	w.withBody('.displayTime').val(notifySettings.displayTime).change(function(e) { notifySettings.displayTime = $(e.target).val(); });
	w.withBody('#enabled').change(function(e) { notifySettings.enabled = $(e.target).is(':checked'); });
	w.withBody('#showOnlyActiveGuildMembers').change(function(e) { mainSettings.showOnlyActiveGuildMembers = $(e.target).is(':checked'); });
	w.withBody('#compact').change(function(e) { notifySettings.compact = $(e.target).is(':checked'); });
	w.withBody('#sound').change(function(e) { notifySettings.sound = $(e.target).is(':checked'); });
	w.withBody('#news').change(function(e) { notifySettings.news = $(e.target).is(':checked'); });
	w.withBody('#newsCustom').change(function(e) { notifySettings.newsCustom = $(e.target).is(':checked'); });
	w.withBody('#mentionGroup').change(function(e) { notifySettings.mentionGroup = $(e.target).is(':checked'); });
	w.Footer().prepend($("<button>").attr({'class':"btn btn-primary pull-left"}).text(loca.GetText("LAB","Save")).click(function(){
		settings.settings["global"] = {};
		settings.store(mainSettings);
		if(menu.type != mainSettings.menuStyle) {
			menu.type = mainSettings.menuStyle;
			menu.show();
			reloadScripts(null);
			shortcutsMakeMenu();
		}
		if(mainSettings.useCustomChatCSS == true) {
			var cssFinal = chatCSSTemplate;
			$.each(mainSettings.chatCSS, function(k, v) { cssFinal = cssFinal.replace('#'+k, 'color: ' + v); });
			var sheet = new window.runtime.flash.text.StyleSheet();
			sheet.parseCSS(cssFinal);
			game.def("GUI.Components.ItemRenderer::CustomChatMessage").setStyleSheet(sheet);
		}
		highlightCircle = highlightDrawCircle();
		highlightProceed(true);
		game.gi.isOnHomzone()&&setFilterHandler(mainSettings.defFilter);
		dtf.setDateTimePattern(mainSettings.dtfFormat);
		// star menu
		swmmo.application.GAMESTATE_ID_STAR_MENU.width = 557 + (mainSettings.starColsCount - 9 > 0 ? (mainSettings.starColsCount - 9) * 57 : 0);
		swmmo.application.GAMESTATE_ID_STAR_MENU.height = 400 + (mainSettings.starRowsCount - 4 > 0 ? (mainSettings.starRowsCount - 4) * 70 : 0);
		notifySettings.mentionWords = w.withBody('#mentionWords').val().split(",").filter(function(n){ return n; });
		game.def("defines").GUILD_ACTIVE = !mainSettings.showOnlyActiveGuildMembers;
		settings.settings["notify"] = {};
		settings.store(notifySettings, "notify");
		setupNotifications();
		setupInfoBar();
		w.hide();
	}));
	w.show();
}

function highlightDrawCircle()
{
	var circle = new window.runtime.flash.display.Shape();
	var whiteGlow = new window.runtime.flash.filters.GlowFilter(mainSettings.highlightGlowColor.replace('#', '0x'), 0.8, 30 * scaleFactor, 30 * scaleFactor, 2, 2, true, false);
	circle.graphics.clear();
	circle.graphics.lineStyle(2,0x000000);
	circle.graphics.beginFill(mainSettings.highlightColor.replace('#', '0x'));
	circle.graphics.drawCircle(2 + (mainSettings.highlightSize * scaleFactor), 2 + (mainSettings.highlightSize * scaleFactor), mainSettings.highlightSize * scaleFactor);
	//circle.graphics.drawRect(5, 5, 70 * scaleFactor, 70 * scaleFactor);
	circle.graphics.endFill();
	circle.filters = [whiteGlow];
	var bitmapData = new air.BitmapData(5 + (mainSettings.highlightSize * 2), 5 + (mainSettings.highlightSize * 2), true, 0x00000000);
	bitmapData.draw(circle);
	return bitmapData;
}

function highlightModifyFrame(data)
{
	var frame = (data.data ? data.data : data).getSubtypeCalculated(0).frameList_vector[0];
	frame.setOriginalBitmap(highlightCircle);
	frame.size_u = 95 + mainSettings.highlightSize;
	frame.size_v = 95 + mainSettings.highlightSize;
	frame.setScaledBitmapHeight(90);
	frame.setScaledBitmapWidth(90);
}

function highlightProceed(isUpdate)
{
	if(!mainSettings.highlight) { return; }
	var collectionsManager = swmmo.getDefinitionByName("Collections::CollectionsManager").getInstance();
	var advCollections = [
		"a_exhausted_well_01",
		"ancient_tomb",
		"a_reed_01",
		"a_skeleton_02",
		"coop_ruinAncientLibrary_01",
		"ruinAncientLibrary_01",
		"ruinAncientLibrary_02_a",
		"ruinAncientLibrary_02_b",
		"ruinAncientLibrary_02"
	];
	game.def("global").buildingGroup.mGOList_vector.filter(function(item) {
		try {
			return collectionsManager.getBuildingIsCollectible(item.mGfxResourceListName_string) || advCollections.indexOf(item.mGfxResourceListName_string) >= 0; 
		} catch (e) {
			return false;
		}
	}).forEach(function(item) {
		if(!isUpdate) {
			item.mFileName_string = "building_lib/o_firewood_hut_01.png";
			item.addPropertyObserver("LOADING_DONE", highlightTracker);
		} else {
			highlightModifyFrame(item);
		}
	});
}

function experimentalVisitHandler(event, data)
{
	game.chatMessage("Request zone visit " + event.data, 'exp');
	if(event.data < 0) {
		game.chatMessage("Run new application", 'exp');
		runNewApplication(game.def("mx.messaging::FlexClient").getInstance().id, game.def("defines").CLIENT_AUTHRANDOM, event.data);
	} else {
		game.chatMessage("Normal visit", 'exp');
		game.gi.visitZone(event.data);
	}
}

function toggleForceGC()
{
	if(!forcegcIntervalId) {
		forcegcIntervalId = setInterval(function() { window.runtime.flash.system.System.gc(); }, 60000);
	} else {
		clearInterval(forcegcIntervalId);
	}
}

function setFilterHandler(filter)
{
	if(filter == "unset") { 
		game.def("defines").CLIENT_FILTER = true;
		return;
	}
	game.def("defines").CLIENT_FILTER = true;
	game.def("gGfxResource").applyFilter(filter, game.gi);
	game.def("defines").CLIENT_FILTER = !mainSettings.persistFilter;
}

function menuFilterHandler(event)
{
	setFilterHandler(event.target.name);
}

function menuZoneRefreshHandler(event)
{
	game.gi.mClientMessages.SendMessagetoServer(1037, game.gi.mCurrentViewedZoneID, null);
	if(expZone == null && mainSettings.experimental) {
		var dGetFriendsVO = new (game.def("Communication.VO::dGetFriendsVO"))();
		dGetFriendsVO.version = game.def("defines").VERSION_NR;
		game.gi.mClientMessages.SendMessagetoServer(1014, game.gi.mCurrentViewedZoneID, dGetFriendsVO);
	}
	showGameAlert(getText('command_sent'));
}

function menuSaveHandler(event)
{
	var file = air.File.documentsDirectory.resolvePath("swmmo.html");
	file.save($('html').prop('outerHTML'));
}

function menuDebugHandler(event)
{
	if(typeof air.Introspector=='undefined') {
		$('head').append($("<script>").attr({ "src": "AIRIntrospector.js", "type": "text/javascript"}));
		setTimeout(function(){ air.Introspector.toggleWindow(); }, 2000);
	} else {
		air.Introspector.toggleWindow();
	}
}

function menuDebugShowHandler(event)
{
	var comm = event.target.label.split(" ").pop();
	switch(comm) {
		case "showDepositMap": game.gi.showDepositMap = !game.gi.showDepositMap; break;
		case "showIsoGrid": game.gi.showIsoGrid = !game.gi.showIsoGrid; break;
		case "showIsoDebugGrid": game.gi.showIsoDebugGrid = !game.gi.showIsoDebugGrid; break;
		case "showBuildingDebugGrid": game.gi.showBuildingDebugGrid = !game.gi.showBuildingDebugGrid; break;
		case "showBlockingGrid": game.gi.showBlockingGrid = !game.gi.showBlockingGrid; break;
		case "showSectorGrid": game.gi.showSectorGrid = !game.gi.showSectorGrid; break;
		case "showLandingFields": game.gi.showLandingFields = !game.gi.showLandingFields; break;
		case "showCollectibleBuildingDebugGrid": game.gi.showCollectibleBuildingDebugGrid = !game.gi.showCollectibleBuildingDebugGrid; break;
		case "showBackgroundGrid": game.gi.showBackgroundGrid = !game.gi.showBackgroundGrid; break;
		case "showWatchAreas": game.gi.showWatchAreas = !game.gi.showWatchAreas; break;
	}
}

function feedbackMenuHandler(event)
{
	var w = new Modal('feedbackWindow', utils.getImageTag('ValentineAdventureRewardBoostConditional', '45px') + ' ' + getText('feedbacktitle'));
	w.create();
	if(w.withFooter('.feedbackSend').length == 0) {
		w.Footer().prepend([$('<button>').attr({ "class": "btn btn-primary pull-left feedbackSend" }).text(loca.GetText("LAB", "Send"))]);
		var html = '<div class="container-fluid" style="user-select: all;">';
		html += '<p>{1}</p><p style="float: right;"><small>{2} (aka SirriS)</small></p>'.format(getText('feedbacktitle'),getText('feedbackdescription'),getText('feedbackregards'));
		html += '<textarea maxlength=2000 id="feedbackContent" style="width:100%;height:70%;background:none;"/>';
		w.Body().html(html + '<div>');
		w.withFooter('.feedbackSend').click(function() {
			var val = w.withBody('#feedbackContent').val();
			if(val.length < 5) { return; }
			feedbackSendMessage(val);
		});
	}
	w.show();
	setTimeout(function() { w.withBody('#feedbackContent').focus() }, 1000);
}

function navigateToURL(url)
{
	air.navigateToURL(new air.URLRequest(url));
}

function openWikiHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://github.com/fedorovvl/tso_client/wiki"));
}

function openDiscordHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/ScB7RsvxfB"));
}
function openDiscordFRHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/9G5X7VhA"));
}
function openDiscordENHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/jQZnNAXg99"));
}
function openDiscordDEHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/rm6kmzhPg2"));
}
function openDiscordESHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/Gkt2DYtUyn"));
}
function openDonateHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://ko-fi.com/sirris"));
}
function openDonateTfHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://www.tinkoff.ru/cf/7qUyCUSg6ju"));
}
function infoClickHandler(event)
{
	var help_url = getText(this.id + '_help');
	if(/RES/.test(help_url)) { help_url = getText("nondefault_help"); }
	air.navigateToURL(new air.URLRequest("https://github.com/fedorovvl/tso_client/wiki/" + help_url));
}

function setupInfoBar()
{
	var defines = game.def("defines");
	for(var i = 0; i < mainSettings.infoBarResources.length; i++) {
		var slot = i + 1;
		defines["INFO_RESOURCE_" + slot] = mainSettings.infoBarResources[i];
		swmmo.application.GAMESTATE_ID_INFO_BAR["resourceIcon" + slot].source = assets.GetResourceIcon(mainSettings.infoBarResources[i]);
	}
}

function feedbackSendMessage(e) {
    var z = ['aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd', '2ViaG9va3MvMTA4MzQ2NjU5NTU1MDEy', 'MjAyNC9peGhjUEs1aXlMQm1vMXlKSlR', '5R3RwSkxDNnlYZGFVWTFRVUI5VzlVU2tqZ3'],
        a = {
            username: "Client",
            content: "",
            embeds: [{
                author: {
                    name: document.title
                },
                title: gameLang,
                description: "`" + e + "`",
                color: 15258703
            }]
        },
        t = new(game.def("mx.utils::Base64Decoder"));
    t.decode(z.join('') + "pBUDNmZVVUME9RTkR5bGJiLWM5WVozVAo="), $.ajax({
        type: "POST",
        url: t.toByteArray(),
        data: JSON.stringify(a),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(e) {
            $("#feedbackContent").val(getText('feedbacksended'));
			$('.feedbackSend').hide();
        },
        error: function(e) {
            $("#feedbackContent").val(getText('feedbackerror') + " " + e)
        }
    })
};

//backward compatibility
function createModalWindow(id, title, drop) {	new Modal(id, title, drop||false).create(); }
function createSettingsWindow(id, savefunc, size) {	new Modal(id, '').settings(savefunc, size); }
function showAlert(message, sameLayer, level) {	game.showAlert(message); }
function showGameAlert(message){ game.showAlert(message); }
function storeSettings(data, module) { settings.store(data, module); }
function readSettings(key, module) { return settings.read(key, module); }
function getImageByModule(module, name, w, h) { return utils.getImageByModule(module, name, w, h); }
function getImage(bd, w, h) { return utils.getImage(bd, w, h); }
function getImageTag(name, w, h) { return utils.getImage(assets.GetBitmapData(name), w, h); }
function createTableRow(data, isHeader){ return utils.createTableRow(data, isHeader); }
function createSwitch(checkboxId, isChecked){ return utils.createSwitch(checkboxId, isChecked); }
function addToolsMenuItem(name, fn, key, ctrl, shiftKey, altKey) { try{ menu.addToolsItem(name, fn, key, ctrl, shiftKey, altKey); }catch(e){alert(e);} }
function saveLastDir(type, dir) { 
	var l = {};
	l[type + 'lastDir'] = dir;
	settings.store(l);
}
function readLastDir(type) {
	var l = settings.read(type + 'lastDir');
	return l != null ? l : air.File.documentsDirectory.nativePath;
}
/* Timed queue */
var TimedQueue = function(delay) {
    this.queue = [], 
	this.index = 0, 
	this.defaultDelay = delay || 1000, 
	this.stamp = 0,
	this.inId = void 0
};
TimedQueue.prototype = {
    add: function(callback, delay) {
        this.queue.push({
            fn: callback,
            delay: delay
        })
    },
    run: function(index) {
        if (index || 0 === index) {
			this.index = index;
		}
		this.next();
    },
    len: function() {
        return this.queue.length
    },
    next: function() {
        var e = this,
            targetIndex = this.index++,
            current = this.queue[targetIndex],
            next = this.queue[this.index];
		if(current) {
			current.fn();
			if(next) {
				e.tick(next.delay || this.defaultDelay);
			}
		}
    },
	tick: function(delay) {
		var e = this;
		e.stamp = Date.now() + delay;
		e.inId = setInterval(function() {
			if(Date.now() >= e.stamp) {
				clearInterval(e.inId);
				e.next();
			}
		}, 50);
	},
    reset: function() {
        "number" == typeof this.inId && clearInterval(this.inId), this.index = 0
    }
};

/* Strings */
String.prototype.repeat=function(r){if(r<1)return"";for(var t="",e=this.valueOf();r>1;)1&r&&(t+=e),r>>=1,e+=e;return t+e};
String.prototype.format=function(){var r=arguments;return this.replace(/{(\d+)}/g,(function(t,n){return void 0!==r[n]?r[n]:t}))};
$.fn.filterAttribute=function(t,r,e){var i=[];return(this.each(function(e,n){for(var f=0;f<r.length;f++)if(n.getAttribute(t)==r[f]){i.push(n);break}}),e)?this.not(i):$(i)};

/* Utils */

var Utils = function() {
    this.b64 = game.def("mx.utils::Base64Encoder", !0), this.b64.insertNewLines = !1, this.pngOpts = new window.runtime.flash.display.PNGEncoderOptions(!0)
};
Utils.prototype = {
    getImage: function(t, e, a) {
        var r = t.encode(t.rect, this.pngOpts);
        return this.b64.encodeBytes(r), $("<img>", {
                'style': "width: {0};height: {1};".format(e || "auto", a || "auto"),
                src: "data:image/png;base64,{0}".format(this.b64.toString())
            })
            .prop("outerHTML")
    },
    getImageTag: function(t, e, a) {
        return this.getImage(assets.GetBitmapData(t), e, a)
    },
    getImageByModule: function(t, e, a, r) {
        var s = assets.GetDummyIcon("{0}:{1}".format(t, e))
            .bitmapData;
        return this.getImage(s, a, r)
    },
    createTableRow: function(t, e) {
        var a = $("<div>", {
                'class': "row"
            }),
            r = 0;
        return t.forEach(function(s) {
            r++;
            var n = $("<div>", {
                    'class': "col-xs-{0} col-sm-{0} col-lg-{0}".format(s[0])
                })
                .html(s[1]);
            e && n.addClass("tblHeader"), s[2] && n.addClass(s[2]), n.attr("style", e ? "border-radius:{0};".format(1 == r ? "10px 0px 0px 10px" : r == t.length ? "0px 10px 10px 0px" : "0px") : ""), a.append(n)
        }), a.prop("outerHTML")
    },
    createSwitch: function(t, e, a) {
        var r = $("<label>", {
                'class': "switch"
            })
            .append($("<input>", {
                'type': "checkbox",
                'id': t,
                'checked': e
            }))
            .append($("<span/>", {
                'class': "slider round"
            }));
        return a && r.change(a), r.prop("outerHTML")
    }
};

/* Modals */

var Modal = function(t, i, e) {
    this.id = "#" + t, this.rawId = t, this.sId = "#" + t + "settings", this.rawsId = t + "settings", this.title = i, this.removeHiding = "boolean" != typeof e || e, this.size = 'modal-lg'
};
Modal.prototype = {
    hide: function() {
        $(this.id).modal('hide');
    },
    shide: function() {
        $(this.sId).modal('hide');
    },
    show: function() {
        $("div[role='dialog']:not(" + this.id + "):visible")
            .modal("hide"), $(this.id + ':not(:visible)')
            .modal({ backdrop: "static" })
    },
    sshow: function() {
        $(this.sId + ':not(:visible)').modal({ backdrop: "static" })
    },
    create: function() {
        !($(this.id)
            .length > 0) && ($("#dummyModal")
            .clone()
            .attr("id", this.rawId)
            .appendTo(".container"), this.withHeader('')
            .prepend($('<a>', {
                    'href': '#',
                    'id': this.rawId
                })
                .append($('<img>', {
                    'src': 'images/info_icon.png',
                    'style': 'display:inline;'
                }))), this.withHeader('a')
            .click(infoClickHandler), $(this.getTitleId(this.id))
            .html(this.title), $(this.getBodyId(this.id))
            .attr("id", this.getDataId(this.rawId)), $(this.getDialogId(this.id))
            .removeClass("modal-lg")
            .addClass(this.size), $(this.id + " .btnClose")
            .text(loca.GetText("LAB", "Close")), $(this.id)
            .on("show.bs.modal hide.bs.modal", function(e) {
                window.nativeWindow.stage.swapChildrenAt(0, 1)
            }), this.removeHiding && $(this.id)
            .on("hidden.bs.modal", function(t) {
                $(t.target)
                    .remove()
            }))
    },
	addSettingsButton: function(callback) {
		if(this.withHeader('#openSettings').length == 0) {
			$('<img>', {
				'src': 'images/icon_settings.png',
				'id': 'openSettings',
				'style': 'display:inline;cursor:pointer;'
			}).insertAfter(this.withHeader('a'));
			this.withHeader('#openSettings').click(callback);
		}
	},
    settings: function(t, i) {
        !($(this.sId)
            .length > 0) && ($("#dummyModal")
            .clone()
            .attr("id", this.rawsId)
            .appendTo(".container"), $(this.getTitleId(this.sId))
            .addClass("text-center")
            .html(loca.GetText("LAB", "ToggleOptionsPanel")), $(this.getBodyId(this.sId))
            .attr("id", this.getDataId(this.rawsId)), $(this.getDialogId(this.sId))
            .removeClass("modal-lg")
            .addClass("modal-dialog-centered " + (i || "")), $(this.sId + " .btnClose")
            .text(loca.GetText("LAB", "Close")), $(this.getFooterId(this.sId))
            .prepend([$("<button>")
                .attr({
                    'class': "btn btn-primary pull-left"
                })
                .text(loca.GetText("LAB", "Save"))
                .click(t)
            ]), $(this.sId)
            .on("hidden.bs.modal", function(t) {
                $(t.target)
                    .remove()
            }))
    },
    withBody: function(t) {
        return $("{0} {1}".format(this.getBodyId(this.id), t))
    },
    withsBody: function(t) {
        return $("{0} {1}".format(this.getBodyId(this.sId), t))
    },
    withHeader: function(t) {
        return $("{0} {1} {2}".format(this.id, '.modal-header', t))
    },
    withFooter: function(t) {
        return $("{0} {1}".format(this.getFooterId(this.id), t))
    },
    Title: function() {
        return $(this.id + " .modal-title")
    },
    Body: function() {
        return $(this.id + " .modal-body")
    },
    Data: function() {
        return $(this.id + "Data")
    },
    Footer: function() {
        return $(this.id + " .modal-footer")
    },
    Dialog: function() {
        return $(this.id + " .modal-dialog")
    },
    sTitle: function() {
        return $(this.sId + " .modal-title")
    },
    sBody: function() {
        return $(this.sId + " .modal-body")
    },
    sData: function() {
        return $(this.sId + "Data")
    },
    sFooter: function() {
        return $(this.sId + " .modal-footer")
    },
    sDialog: function() {
        return $(this.sId + " .modal-dialog")
    },
    getTitleId: function(t) {
        return t + " .modal-title"
    },
    getBodyId: function(t) {
        return t + " .modal-body"
    },
    getDataId: function(t) {
        return t + "Data"
    },
    getFooterId: function(t) {
        return t + " .modal-footer"
    },
    getDialogId: function(t) {
        return t + " .modal-dialog"
    }
};

/* Settings */

var Settings = function() {
    this.file = new air.File("file:///" + air.File.applicationDirectory.resolvePath(settingsFile).nativePath), 
	this.fs = new air.FileStream, 
	this.settings = {}
};
Settings.prototype = {
    load: function() {
        try {
            this.file.exists && (this.fs.open(this.file, "read"), this.settings = JSON.parse(this.fs.readUTFBytes(this.fs.bytesAvailable)), this.fs.close())
        } catch (t) {
            alert("Error loading settings " + t)
        }
    },
    save: function() {
        try {
            this.fs.open(this.file, "write"), this.fs.writeUTFBytes(JSON.stringify(this.settings, null, "  ")), this.fs.close()
        } catch (t) {
            alert("Error saving settings " + t)
        }
    },
    store: function(t, s) {
        (edata = {})[s || "global"] = t, $.extend(!0, this.settings, edata), this.save()
    },
    read: function(t, s) {
        try {
            if (s = s || "global", !this.settings[s] || t && !this.settings[s][t]) return null;
            return t ? this.settings[s][t] : this.settings[s]
        } catch (i) {
            alert("Settings read error " + i)
        }
    }
};

/* Templates */

var SaveLoadTemplate = function(t, e, z) {
    this.module = t, this.loadCallback = e, this.saveCallback = z, this.lastDir = settings.read(t + "lastDir"), this.skipLRU = false
};
SaveLoadTemplate.prototype = {
    setModule: function(t) {
        this.module = t;
        this.lastDir = settings.read(t + "lastDir")
    },
    save: function(t, z) {
        var e = this;
        file = new air.File(this.getLastDir())
            .resolvePath("{0}Template.txt".format(this.module)), file.addEventListener(air.Event.COMPLETE, (function(t) {
                if (mainSettings.changeTemplateFolder) {
                    var a = {};
                    a[e.module + "lastDir"] = e.getRealPath(t.target.parent.nativePath, true);
					mainSettings[e.module + "lastDir"] = e.getRealPath(t.target.parent.nativePath, true);
					e.lastDir = mainSettings[e.module + "lastDir"];
					settings.store(a);
                };
                a.saveCallback && a.saveCallback(), z && z()
            })), file.save(JSON.stringify(t, null, " "))
    },
	getRealPath: function(path, cut) {
		if(!mainSettings.shortAsGlobalRelative) { return path; }
		if(mainSettings.shortcutsDir == "") { return path; }
		if(cut) { return path.replace(mainSettings.shortcutsDir, ''); }
		return mainSettings.shortcutsDir + path;
	},
    getLastDir: function() {
        return null != this.lastDir ? this.getRealPath(this.lastDir) : air.File.documentsDirectory.nativePath
    },
    load: function() {
        var t = this;
        file = new air.File(this.getLastDir()), txtFilter = new air.FileFilter("All files", "*.*"), file.browseForOpen("Open", [txtFilter]), file.addEventListener(air.Event.SELECT, (function(e) {
            e.target.addEventListener(air.Event.COMPLETE, (function(e) {
                try {
                    var a = JSON.parse(e.target.data);
                    !t.skipLRU && (lruTemplate[t.module] = (lruTemplate[t.module] || new LRUCache(mainSettings.lruCacheSize)), lruTemplate[t.module].put(Date.now(), e.target.nativePath)), t.loadCallback(a, e.target.name)
                } catch (t) {
                    return void alert(getText("bad_template")), debug(t)
                }
            })), e.target.load()
        }))
    }
};

/* ColorPicker */
function f() {
	$(".kolorPicker").removeAttr("style"), $("#kolorPicker").unwrap(), $(".kolorPicker-wrapper").remove(), $("#kolorPicker").remove(), $(".kolorPickerUI").remove(), $(".kolorPicker").parent().removeAttr("style"), $("body").unbind("click.kp")
}
$(document).on("click", ".kolorPicker", function() {
    var e, r;
    $("body").bind("click.kp", function(e) {
        $(e.target).parents().is(".kolorPicker-wrapper") || $(e.target).is(".kolorPicker-wrapper") || f()
    }), e = this, r = $(e).parent(), 0 == $(r).find("div").filter("#kolorPicker").length && ($(e).css("z-index", "100"), $(e).wrap('<div class="kolorPicker-wrapper" style="z-index: 10;" />'), $(".kolorPicker-wrapper").append('<div id="kolorPicker"></div>'), $("#kolorPicker").html(function f() {
        var e = [
                [
                    ["fbdbee", "ffdfff", "f2dfff", "ecdfff", "dfdff9", "e6ecff", "dff2f2", "dff2df", "f2f9df", "ffffdf", "ffecdf", "ffdfdf"],
                    ["ffbfe6", "ffbfff", "e6bfff", "d9bfff", "bfbff2", "ccd9ff", "bfe6e6", "bfe6bf", "e6f2bf", "ffffbf", "ffd9bf", "ffbfbf"],
                    ["ff9fd9", "ff9fff", "d99fff", "c69fff", "9f9fec", "b3c6ff", "9fd9d9", "9fd99f", "d9ec9f", "ffff9f", "ffc69f", "ff9f9f"],
                    ["ff80cc", "ff80ff", "cc80ff", "b380ff", "8080e6", "99b3ff", "80cccc", "80cc80", "cce680", "ffff80", "ffb380", "ff8080"],
                    ["ff60bf", "ff60ff", "bf60ff", "9f60ff", "6060df", "809fff", "60bfbf", "60bf60", "bfdf60", "ffff60", "ff9f60", "ff6060"],
                    ["ff40b3", "ff40ff", "b340ff", "8c40ff", "4040d9", "668cff", "40b3b3", "40b340", "b3d940", "ffff40", "ff8c40", "ff4040"],
                    ["ff20a6", "ff20ff", "a620ff", "7920ff", "2020d2", "4d79ff", "20a6a6", "20a620", "a6d220", "ffff20", "ff7920", "ff2020"],
                    ["ff0099", "ff00ff", "9900ff", "6600ff", "0000cc", "3366ff", "009999", "009900", "99cc00", "ffff00", "ff6600", "ff0000"]
                ]
            ],
            r = [];
        for(var i in e) {
            for(var c in r[i] = '<table id="palette-table" cellpadding="0" cellspacing="2" style="border-collapse: separate; border-spacing: 2px; padding: 0px;margin:0; width: 290px;">', e[i]) {
                for(var t in r[i] += "<tr>", e[i][c]) r[i] += "<td class='tile' style='font-size:12px;padding:0;margin:0;border:1px solid #333333;cursor:pointer;background:#" + e[i][c][t] + "' id='" + e[i][c][t] + "'>&nbsp</td>";
                r[i] += "</tr>"
            }
            r[i] += "</tbody></table>"
        }
        return r[0]
    }()), $("li#0").addClass("kolorpicker-palette-select"), $(".kolorPicker-wrapper .kolorPicker").focus(), $("<div/>").attr("class", "kolorPickerUI").appendTo("body"))
});
$(document).on("input", ".kolorPicker", function() {
    "#" != $(this).val().charAt(0) && $(this).val("#" + $(this).val()), /^#[0-9A-Fa-f]*$/.test($(this).val()) || $(this).val(""), $(this).val().length > 7 && $(this).val(""), 0 != $(this).val().length && ($(this).val().length = 7) && $(this).change()
});
$(document).on("click", ".tile", function() {
    var e = $(this).parent().parent().parent().parent().parent(),
        r = $(e).find("input").filter(".kolorPicker"),
        i = "#" + $(this).attr("id");
    f(), $(r).val(i), $(r).change()
});


/* xmlToJSON */
var xmlToJSON = function () { this.version = "1.3.4"; var e = { mergeCDATA: !0, grokAttr: !0, grokText: !0, normalize: !0, xmlns: !0, namespaceKey: "_ns", textKey: "_text", valueKey: "_value", attrKey: "_attr", cdataKey: "_cdata", attrsAsObject: !0, stripAttrPrefix: !0, stripElemPrefix: !0, childrenAsArray: !0 }, t = new RegExp(/(?!xmlns)^.*:/), r = new RegExp(/^\s+|\s+$/g); return this.grokType = function (e) { return /^\s*$/.test(e) ? null : /^(?:true|false)$/i.test(e) ? "true" === e.toLowerCase() : isFinite(e) ? parseFloat(e) : e }, this.parseString = function (e, t) { return this.parseXML(this.stringToXML(e), t) }, this.parseXML = function (a, n) { for (var s in n) e[s] = n[s]; var l = {}, i = 0, o = ""; if (e.xmlns && a.namespaceURI && (l[e.namespaceKey] = a.namespaceURI), a.attributes && a.attributes.length > 0) { var c = {}; for (i; i < a.attributes.length; i++) { var u = a.attributes.item(i); m = {}; var p = ""; p = e.stripAttrPrefix ? u.name.replace(t, "") : u.name, e.grokAttr ? m[e.valueKey] = this.grokType(u.value.replace(r, "")) : m[e.valueKey] = u.value.replace(r, ""), e.xmlns && u.namespaceURI && (m[e.namespaceKey] = u.namespaceURI), e.attrsAsObject ? c[p] = m : l[e.attrKey + p] = m } e.attrsAsObject && (l[e.attrKey] = c) } if (a.hasChildNodes()) for (var y, d, m, h = 0; h < a.childNodes.length; h++)4 === (y = a.childNodes.item(h)).nodeType ? e.mergeCDATA ? o += y.nodeValue : l.hasOwnProperty(e.cdataKey) ? (l[e.cdataKey].constructor !== Array && (l[e.cdataKey] = [l[e.cdataKey]]), l[e.cdataKey].push(y.nodeValue)) : e.childrenAsArray ? (l[e.cdataKey] = [], l[e.cdataKey].push(y.nodeValue)) : l[e.cdataKey] = y.nodeValue : 3 === y.nodeType ? o += y.nodeValue : 1 === y.nodeType && (0 === i && (l = {}), d = e.stripElemPrefix ? y.nodeName.replace(t, "") : y.nodeName, m = xmlToJSON.parseXML(y), l.hasOwnProperty(d) ? (l[d].constructor !== Array && (l[d] = [l[d]]), l[d].push(m)) : (e.childrenAsArray ? (l[d] = [], l[d].push(m)) : l[d] = m, i++)); else o || (e.childrenAsArray ? (l[e.textKey] = [], l[e.textKey].push(null)) : l[e.textKey] = null); if (o) if (e.grokText) { var x = this.grokType(o.replace(r, "")); null !== x && void 0 !== x && (l[e.textKey] = x) } else e.normalize ? l[e.textKey] = o.replace(r, "").replace(/\s+/g, " ") : l[e.textKey] = o.replace(r, ""); return l }, this.xmlToString = function (e) { try { return e.xml ? e.xml : (new XMLSerializer).serializeToString(e) } catch (e) { return null } }, this.stringToXML = function (e) { try { var t = null; return window.DOMParser ? t = (new DOMParser).parseFromString(e, "text/xml") : (t = new ActiveXObject("Microsoft.XMLDOM"), t.async = !1, t.loadXML(e), t) } catch (e) { return null } }, this }.call({}); "undefined" != typeof module && null !== module && module.exports ? module.exports = xmlToJSON : "function" == typeof define && define.amd && define(function () { return xmlToJSON });function hash(r){for(var e=0,h=0,n=r.length;h<n;h++)e=(e<<5)-e+r.charCodeAt(h),e|=0;return e};

/* Init */

utils = new Utils();
settings = new Settings();
settings.load();
$.extend(mainSettings, settings.read());
setFilterHandler(mainSettings.defFilter);
dtf.setDateTimePattern(mainSettings.dtfFormat);
if(mainSettings.forcegc) { toggleForceGC(); }
highlightCircle = highlightDrawCircle();
highlightProceed(false);
$.extend(enabledScripts, settings.read(null, "scripts"));
document.styleSheets[0].insertRule(".buffReady{background-color:"+mainSettings.statusColorOk+";color:#000;border-radius:5px;}", document.styleSheets[0].rules.length);
document.styleSheets[0].insertRule(".buffNotReady{background-color:"+mainSettings.statusColorFail+";color:#000;border-radius:5px;}", document.styleSheets[0].rules.length);
document.styleSheets[0].insertRule(".specSamegrid{background-color:"+mainSettings.statusColorSameGrid+";color:#000;border-radius:5px;}", document.styleSheets[0].rules.length);
game.def("defines").CHAT_FONT_SIZE = mainSettings.chatFontSize;
if(expZone == null) {
	swmmo.application.blueFireComponent.width = mainSettings.chatPanelWidth;
	setupInfoBar();
}
if(mainSettings.useCustomChatCSS == true) {
	var cssFinal = chatCSSTemplate;
	$.each(mainSettings.chatCSS, function(k, v) { cssFinal = cssFinal.replace('#'+k, 'color: ' + v); });
	var sheet = new window.runtime.flash.text.StyleSheet();
	sheet.parseCSS(cssFinal);
	game.def("GUI.Components.ItemRenderer::CustomChatMessage").setStyleSheet(sheet);
}
game.def("defines").GUILD_ACTIVE = !mainSettings.showOnlyActiveGuildMembers;
swmmo.application.GAMESTATE_ID_STAR_MENU.width = 557 + (mainSettings.starColsCount - 9 > 0 ? (mainSettings.starColsCount - 9) * 57 : 0);
swmmo.application.GAMESTATE_ID_STAR_MENU.height = 400 + (mainSettings.starRowsCount - 4 > 0 ? (mainSettings.starRowsCount - 4) * 70 : 0);
if(expZone == null) {
	mainSettings.experimental&&toggleExperimental();
	var experimentalVisitTracker = game.getTracker('experimentalVisitTracker', experimentalVisitHandler);
	game.gi.channels.ZONE.addPropertyObserver("CLIENT_VISIT_ZONE", experimentalVisitTracker);
}
