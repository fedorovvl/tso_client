var Menu = function(type){
	this.groupedMenu = function() {
		return [
			{ label: loca.GetText("ACL", "BuffAdventuresGeneral"), mnemonicIndex: 0, items: [
				{ label: loca.GetText("LAB", "ToggleOptionsPanel"), mnemonicIndex: 0, onSelect: mainSettingsHandler },
				{ label: getText("notifi_last_desc"), mnemonicIndex: 0, onSelect: notificationLast5Handler },
				{ label: getText('hotkeysTitle'), mnemonicIndex: 0, onSelect: keybindsMenuHandler },
				{ label: loca.GetText("LAB", "Filter"), mnemonicIndex: 0, items: [
						{ label: "none", name: "none", onSelect: menuFilterHandler },
						{ label: "snownowater", name: "snownowater", onSelect: menuFilterHandler },
						{ label: "snowlight", name: "snowlight", onSelect: menuFilterHandler },
						{ label: "snow", name: "snow", onSelect: menuFilterHandler },
						{ label: "oven", name: "oven", onSelect: menuFilterHandler },
						{ label: "doomsday", name: "doomsday", onSelect: menuFilterHandler },
						{ label: "night", name: "night", onSelect: menuFilterHandler },
						{ label: "desert", name: "desert", onSelect: menuFilterHandler },
						{ label: "tropical", name: "tropical", onSelect: menuFilterHandler },
						{ label: "blackandwhite", name: "blackandwhite", onSelect: menuFilterHandler },
						{ label: "spooky", name: "spooky", onSelect: menuFilterHandler },
						{ label: "snow_medium", name: "snow_medium", onSelect: menuFilterHandler },
						{ label: "tundra", name: "tundra", onSelect: menuFilterHandler },
						{ label: "darkershadow", name: "darkershadow", onSelect: menuFilterHandler },
						{ label: "magicsepia", name: "magicsepia", onSelect: menuFilterHandler }
				]},
				{ label: loca.GetText("LAB", "Update"), mnemonicIndex: 0, keyCode: 113, onSelect: menuZoneRefreshHandler},
				{ label: 'Debug', items: [
					{ label: "Toggle introspector", onSelect: menuDebugHandler },
					{ label: "Toggle showIsoGrid", onSelect: menuDebugShowHandler },
					{ label: "Toggle showIsoDebugGrid", onSelect: menuDebugShowHandler },
					{ label: "Toggle showBackgroundGrid", onSelect: menuDebugShowHandler },
					{ label: "Toggle showBuildingDebugGrid", onSelect: menuDebugShowHandler },
					{ label: "Toggle showCollectibleBuildingDebugGrid", onSelect: menuDebugShowHandler },
					{ label: "Toggle showBlockingGrid", onSelect: menuDebugShowHandler },
					{ label: "Toggle showSectorGrid", onSelect: menuDebugShowHandler },
					{ label: "Toggle showDepositMap", onSelect: menuDebugShowHandler },
					{ label: "Toggle showLandingFields", onSelect: menuDebugShowHandler },
					{ label: "Toggle showWatchAreas", onSelect: menuDebugShowHandler },
				    { label: "Copy AuthToken", onSelect: copyAuthTokenHandler }
				]}
			]},
			{ label: "LRU", name: 'LRU', mnemonicIndex: 0, items: [] },
			{ label: loca.GetText("LAB", "Specialists"), mnemonicIndex: 0, items: [
				{ label: loca.GetText("SPE", "Explorer"), mnemonicIndex: 0, keyCode: 114, onSelect: specExplorerMenuHandler },
				{ label: loca.GetText("SPE", "Geologist"), mnemonicIndex: 0, keyCode: 115, onSelect: specGeologistMenuHandler },
				{ label: loca.GetText("ACL", "ExcelsiorLostCityBeforeRitual"), mnemonicIndex: 0, keyCode: 121, onSelect: battleMenuHandler },
				{ label: getText('dutymenuTitle'), mnemonicIndex: 0, onSelect: specDutyMenuHandler },
				{ label: getText('specHideTitle'), mnemonicIndex: 0, onSelect: hideSpecMenuHandler },
				{ label: getText('itemshide_desc'), mnemonicIndex: 0, onSelect: hideItemsMenuHandler }
			]},
			{ label: loca.GetText("LAB", "Buildings"), mnemonicIndex: 0, items: [
				{ label: loca.GetText("LAB", "Buffs"), mnemonicIndex: 0, keyCode: 116, onSelect: menuBuffsHandler },
				{ label: loca.GetText("LAB", "Production"), mnemonicIndex: 0, keyCode: 118, onSelect: menuBuildingHandler },
				{ label: getText('prod_timed'), mnemonicIndex: 0, keyCode: 119, onSelect: TimedMenuHandler },
				{ label: loca.GetText("LAB", "BlackMarketAuction"), mnemonicIndex: 0, keyCode: 117, onSelect: menuAuctionHandler },
				{ label: loca.GetText("LAB", "Visit"), mnemonicIndex: 0, items: [
					{ label: loca.GetText("LAB", "Specialbuildings"), mnemonicIndex: 0, items: [
						{ label: loca.GetText("BUI", "ProvisionHouse"), name: "ProvisionHouse", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "ProvisionHouse2"), name: "ProvisionHouse2", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Barracks"), name: "Barracks", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "EliteBarracks"), name: "EliteBarracks", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Bookbinder"), name: "Bookbinder", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "AdventureBookbinder"), name: "AdventureBookbinder", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "WhiteCastle"), name: "WhiteCastle", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Logistics"), name: "Logistics", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "EpicWorkyardWood"), name: "EpicWorkyardWood", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "EpicWorkyardCorn"), name: "EpicWorkyardCorn", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "GiftChristmasTree"), name: "GiftChristmasTree", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "FlyingHouse"), name: "FlyingHouse", onSelect: buiFastAccessMenuHandler }
					]},
					{ label: loca.GetText("LAB", "AdventureLevelSuperHigh"), mnemonicIndex: 0, items: [
						{ label: loca.GetText("BUI", "Observatory"), name: "Observatory", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "EspionageBuilding"), name: "EspionageBuilding", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "MedicGarrison"), name: "MedicGarrison", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "OutdoorCanteen"), name: "OutdoorCanteen", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "S4Lazaret"), name: "S4Lazaret", onSelect: buiFastAccessMenuHandler }
					]},
					{ label: loca.GetText("SHI", "ChristmasBreweryBuff"), mnemonicIndex: 0, items: [
						{ label: loca.GetText("BUI", "SpringPark"), name: "SpringPark", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "ConcertHall"), name: "ConcertHall", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Meadhall"), name: "Meadhall", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "SoccerField"), name: "SoccerField", onSelect: buiFastAccessMenuHandler }
					]},
					{ label: loca.GetText("QUL", "TutZoneWideBuffs1"), mnemonicIndex: 0, items: [
						{ label: loca.GetText("BUI", "LoveTree"), name: "LoveTree", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Snowglobe"), name: "Snowglobe", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "ChristmasBakery"), name: "ChristmasBakery", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "ChristmasMarket_Player"), name: "ChristmasMarket_Player", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "LoveGarden"), name: "LoveGarden", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "CarnivalGrounds"), name: "CarnivalGrounds", onSelect: buiFastAccessMenuHandler }
					]},
					{ label: loca.GetText("LAB", "Production"), mnemonicIndex: 0, items: [

						{ label: loca.GetText("BUI", "ArtificerStudy"), name: "ArtificerStudy", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Stronghold"), name: "Stronghold", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Smokehouse"), name: "Smokehouse", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "OilRefinery"), name: "OilRefinery", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Oilmill"), name: "Oilmill", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "SiegeWorkshop"), name: "SiegeWorkshop", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "SnackStand"), name: "SnackStand", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "LoversStatue"), name: "LoversStatue", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "ToyFactory"), name: "ToyFactory", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "CandyFactory"), name: "CandyFactory", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "Chocolatier"), name: "Chocolatier", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "BlackTree_Blue"), name: "BlackTree_Blue", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "BlackTree_Gold"), name: "BlackTree_Gold", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "BlackTree_Green"), name: "BlackTree_Green", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "BlackTree_Purple"), name: "BlackTree_Purple", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "BlackTree_Red"), name: "BlackTree_Red", onSelect: buiFastAccessMenuHandler },
						{ label: loca.GetText("BUI", "CrystalShardPit"), name: "CrystalShardPit", onSelect: buiFastAccessMenuHandler }
					]}
				]}
			]},
			{ label: getText('shortcutsTitle'), name: 'Shortcuts', mnemonicIndex: 0 },
			{ label: loca.GetText("RES", "Tool"), name: 'Tools', mnemonicIndex: 0, items: [
				{label: loca.GetText("LAB", "Update"), onSelect: reloadScripts },
				{label: loca.GetText("LAB", "ToggleOptionsPanel"), onSelect: scriptsManager },
				{type: 'separator' }
			]},
			{ type: 'separator' },
			{ label: loca.GetText("LAB", "ChatHelp"), name: 'Help', mnemonicIndex: 0, items: [
				{ label: "Wiki", onSelect: openWikiHandler },
				{ label: "Discord (RU)", onSelect: openDiscordHandler },
				{ label: "Discord (EN)", onSelect: openDiscordENHandler },
				{ label: "Discord (DE)", onSelect: openDiscordDEHandler },
				{ label: "Discord (ES)", onSelect: openDiscordESHandler },
				{ type: 'separator' },
				{ label: "Donate (Ko-fi)", onSelect: openDonateHandler },
				{ label: "Donate (Tinkoff RU)", onSelect: openDonateTfHandler },
				{ type: 'separator' },
				{ label: getText('feedbacktitle'), onSelect: feedbackMenuHandler }
			]},
			{ label: 'v' + version + (mainSettings.experimental ? "-Ex" : ""), enabled: false },
			{ label: '', name: 'memusage', enabled: false }
		];
	};
	this.linearSkip = ['LRU', 'Shortcuts', 'Tools', 'Help'];
	this.linearMenu = function(){
		var result = [],
		    menu   = this.groupedMenu();
		for(var i in menu) {
			if(menu[i].items && this.linearSkip.indexOf(menu[i].name) == -1) {
				for(var n in menu[i].items) {
					result.push(menu[i].items[n]);
				}
			} else { result.push(menu[i]); }
		}
		return result;
	};
	this.type = type;
	this.nativeMenu = null;
	this.keybindings = {};
};
Menu.prototype = {
	show:function(){
		this.keybindings = { '115.true.false.false': { 'fn': shortcutsPickupAll } };
		var menu = this.type == 'grouped' ? this.groupedMenu() : this.linearMenu();
		air.ui.Menu.setAsMenu(air.ui.Menu.createFromJSON(menu), true);
		this.nativeMenu = window.nativeWindow.menu;
		swmmo.application.isoengine.contextMenu = window.nativeWindow.menu;
		var keybindsSettings = {};
		$.extend(keybindsSettings, readSettings(null, 'keybinds'));
		if(Object.keys(keybindsSettings).length > 0) {
			this.keybindings = keybindsSettings;
		} else {
			this.buildKeybinds(menu);
		}
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
	addKeybBind: function(fn, key, ctrlKey, isUser, shiftKey, altKey) {
		var keyComb = '{0}.{1}.{2}.{3}'.format(key.toString(), (ctrlKey ? ctrlKey : false).toString(), (shiftKey ? shiftKey : false).toString(), (altKey ? altKey : false).toString());
		if (this.keybindings[keyComb]) {
			  game.showAlert("Key combination {0} for {1} already binded on {2}".format(keyComb, fn.name, this.keybindings[keyComb].fn.name||this.keybindings[keyComb].fn));
			  return;
		}
		this.keybindings[keyComb] = { 'isUser': isUser, 'fn': fn };
	},
	checkKeybind: function(event) {
		if(window.nativeWindow.stage.focus && /TextField/.test(window.nativeWindow.stage.focus.name)) { return; }
		if(document.activeElement.type && /text/.test(document.activeElement.type)) { return; }
		var keyComb = '{0}.{1}.{2}.{3}'.format(event.keyCode.toString(), event.ctrlKey.toString(), event.shiftKey.toString(), event.altKey.toString());
		if(this.keybindings[keyComb]) {
			if(typeof this.keybindings[keyComb].fn == 'function') {
				this.keybindings[keyComb].fn(null);
			} else {
				window[this.keybindings[keyComb].fn](this.keybindings[keyComb].arg != null ? { 'target': { 'name': this.keybindings[keyComb].arg } } : null);
			}
		}
	},
	createItem: function(name, fn) {
		var item = new air.NativeMenuItem(name);
		item.mnemonicIndex = 0;
		item.data = { 'item': { 'onSelect': fn } };
		item.addEventListener(air.Event.SELECT, fn);
		return item;
	},
	addToolsItem: function(name, fn, key, ctrl, shiftKey, altKey) {
		this.nativeMenu.getItemByName("Tools").submenu.addItem(this.createItem(name, fn));
		if(key) { this.addKeybBind(fn, key, ctrl, true, shiftKey, altKey); }
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
setInterval(function() { menu.nativeMenu.getItemByName("memusage").label = 'Mem: ' + humanMemorySize(air.System.privateMemory, 1); }, 5000);
reloadScripts(null);
shortcutsMakeMenu();