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
	tabs.append($('<li>').append($('<a>', { 'data-toggle': 'tab', 'href': '#menulru' }).text("LRU")));
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
	html += utils.createTableRow([[6, getText("mwchat_desc")], [6, createSwitch('mwChatPanel', mainSettings.mwChatPanel)]]);

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
	html += utils.createTableRow([[6, getText('lru_desc')], [6, createLruDrop()]]);
	html += utils.createTableRow([[6, getText('lru_duplicates_desc')], [6, createSwitch('lruDisableDuplicates', mainSettings.lruDisableDuplicates)]]);
	html += '<br>';
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [6, loca.GetText("LAB", "AvatarCurrentSelection")]], true);
	$.each(moduleToName, function(item) {
		html += utils.createTableRow([[9, moduleToName[item].name], [3, createSwitch('lruSkip_'+item, mainSettings.lruSkipModules.indexOf(item) == -1)]]);
	});
	tabcontent.append($('<div>', { 'class': 'tab-pane fade', 'id': 'menulru' }).append(html+'</div>'));
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
	w.withBody('#lruDisableDuplicates').change(function(e) { mainSettings.lruDisableDuplicates = $(e.target).is(':checked'); });
	w.withBody('#shortAsGlobalRelative').click(function(e) { 
		if(mainSettings.shortcutsDir == "" && mainSettings.shortAsGlobalRelative) {
			alert("Shortcuts base path not set");
			e.preventDefault();
			mainSettings.shortAsGlobalRelative = false;
			return;
		}
	});
	w.withBody('[id^=lruSkip_]').change(function(e) {
		if($(e.target).is(':checked')) {
			mainSettings.lruSkipModules.splice(mainSettings.lruSkipModules.indexOf(e.target.id.replace("lruSkip_", '')), 1);
		} else {
			mainSettings.lruSkipModules.push(e.target.id.replace("lruSkip_", ''));
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
	w.withBody('#mwChatPanel').change(function(e) { mainSettings.mwChatPanel = $(e.target).is(':checked'); });	
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