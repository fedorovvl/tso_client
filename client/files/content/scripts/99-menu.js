var Menu = function(type){
	this.groupedMenu = function() {
		return [
			{ label: loca.GetText("ACL", "BuffAdventuresGeneral"), items: [
				{ label: loca.GetText("LAB", "ToggleOptionsPanel"), onSelect: mainSettingsHandler },
				{ label: loca.GetText("LAB", "Filter"), items: [
						{ label: "none", onSelect: menuFilterHandler }, { label: "snownowater", onSelect: menuFilterHandler },
						{ label: "snowlight", onSelect: menuFilterHandler }, { label: "snow", onSelect: menuFilterHandler },
						{ label: "oven", onSelect: menuFilterHandler }, { label: "doomsday", onSelect: menuFilterHandler },
						{ label: "night", onSelect: menuFilterHandler }, { label: "desert", onSelect: menuFilterHandler },
						{ label: "tropical", onSelect: menuFilterHandler },	{ label: "blackandwhite", onSelect: menuFilterHandler },
						{ label: "spooky", onSelect: menuFilterHandler }, { label: "snow_medium", onSelect: menuFilterHandler },
						{ label: "tundra", onSelect: menuFilterHandler }, { label: "darkershadow", onSelect: menuFilterHandler },
						{ label: "magicsepia", onSelect: menuFilterHandler }
				]},
				{ label: loca.GetText("LAB", "Update") + ' (F2)', keyCode: 113, onSelect: menuZoneRefreshHandler},
				{ label: 'Debug window', onSelect: menuDebugHandler}
			]},
			{ label: loca.GetText("LAB", "Specialists"), items: [
				{ label: loca.GetText("SPE", "Explorer") + ' (F3)', keyCode: 114, onSelect: function() { specSharedHandler(1); } },
				{ label: loca.GetText("SPE", "Geologist") + ' (F4)', keyCode: 115, onSelect: function() { specSharedHandler(2); } },
				{ label: loca.GetText("LAB", "Army") + ' (F9)', keyCode: 120, onSelect: armyMenuHandler },
				{ label: loca.GetText("ACL", "ExcelsiorLostCityBeforeRitual") + ' (F10)', keyCode: 121, onSelect: battleMenuHandler },
				{ label: loca.GetText("LAB", 'ProductionDetails'), onSelect: specDutyMenuHandler },
				{ label: getText('specHideTitle'), onSelect: hideSpecMenuHandler }
			]},
			{ label: loca.GetText("LAB", "Buildings"), items: [
				{ label: loca.GetText("LAB", "Buffs") + ' (F5)', keyCode: 116, onSelect: menuBuffsHandler },
				{ label: loca.GetText("LAB", "Production") + ' (F7)', keyCode: 118, onSelect: menuBuildingHandler },
				{ label: getText('prod_timed') + ' (F8)', keyCode: 119, onSelect: TimedMenuHandler }
			]},
			{ label: loca.GetText("LAB", "BlackMarketAuction") + ' (F6)', keyCode: 117, onSelect: menuAuctionHandler },
			{ label: getText('shortcutsTitle'), name: 'Shortcuts' },
			{ label: loca.GetText("RES", "Tool"), name: 'Tools', items: [
				{label: loca.GetText("LAB", "Update"), onSelect: reloadScripts },
				{label: loca.GetText("LAB", "ToggleOptionsPanel"), onSelect: scriptsManager },
				{type: 'separator' }
			]}
		];
	};
	this.linearMenu = function(){
		var e=[],r=this.groupedMenu();for(var i in r)if(r[i].items&&"Tools"!=r[i].name&&"Shortcuts"!=r[i].name)for(var n in r[i].items)e.push(r[i].items[n]);else e.push(r[i]);return e;
	};
	this.type = type;
	this.nativeMenu = null;
	this.keybindings = {};
};
Menu.prototype = {
	show:function(){
		this.keybindings = {};
		var menu = this.type == 'grouped' ? this.groupedMenu() : this.linearMenu();
		if(isDebug) {
			menu.push({ label: "SaveHTML", onSelect: menuSaveHandler });
		}
		menu.push({type: 'separator' });
		menu.push({ label: loca.GetText("LAB", "ChatHelp"), name: 'Help', items: [
			{ label: "Wiki", onSelect: openWikiHandler }, { label: "Discord (RU)", onSelect: openDiscordHandler },
			{ label: "Discord (EN)", onSelect: openDiscordENHandler }, { label: "Discord (DE)", onSelect: openDiscordDEHandler },
			{ type: 'separator' }, { label: "Donate (Ko-fi)", onSelect: openDonateHandler },
			{ label: "Donate (Tinkoff RU)", onSelect: openDonateTfHandler }, { type: 'separator' },
			{ label: getText('feedbacktitle'), onSelect: feedbackMenuHandler }
		]});
		menu.push({ label: 'v' + version, enabled: false });
		menu.push({ label: '', name: 'memusage', enabled: false });
		air.ui.Menu.setAsMenu(air.ui.Menu.createFromJSON(menu), true);
		this.nativeMenu = window.nativeWindow.menu;
		this.buildKeybinds(menu);
	},
	buildKeybinds: function(menu){
		for(var i in menu) {
			if(menu[i].items) {
				this.buildKeybinds(menu[i].items);
				continue;
			}
			if(menu[i].keyCode)
				this.addKeybBind(menu[i].onSelect, menu[i].keyCode, false, false);
		}
	},
	addKeybBind: function(fn, key, ctrl, isUser) {
		var keyComb = key.toString() + (ctrl ? ctrl : false).toString();
		if (this.keybindings[keyComb]) {
			  game.showAlert("Key combination {0} for {1} already binded on {2}".format(keyComb, fn.name, this.keybindings[keyComb].fn.name));
			  return;
		}
		this.keybindings[keyComb] = { 'isUser': isUser, 'fn': fn };
	},
	checkKeybind: function(event) {
		var keyComb = '{0}{1}'.format(event.keyCode.toString(), event.ctrlKey.toString());
		if(this.keybindings[keyComb])
			this.keybindings[keyComb].fn(null);
	},
	createItem: function(name, fn) {
		var item = new air.NativeMenuItem(name);
		item.addEventListener(air.Event.SELECT, fn);
		return item;
	},
	addToolsItem: function(name, fn, key, ctrl) {
		this.nativeMenu.getItemByName("Tools").submenu.addItem(this.createItem(name, fn));
		if(key) { this.addKeybBind(fn, key, ctrl, true); }
	},
	clearTools: function() {
		$('script[id="user"]').remove();
		var toolsMenu = this.nativeMenu.getItemByName("Tools").submenu;
		while(toolsMenu.numItems > 3) { toolsMenu.removeItemAt(3); }
		for(var i in this.keybindings) {
			this.keybindings[i].isUser&&delete this.keybindings[i];
		}
	}
};
menu = new Menu(mainSettings.menuStyle);
menu.show();
menu.addKeybBind(shortcutsPickupAll, 115, true, false);
setInterval(function() { menu.nativeMenu.getItemByName("memusage").label = 'Mem: ' + humanMemorySize(air.System.privateMemory, 1); }, 5000);
reloadScripts(null);
shortcutsMakeMenu();