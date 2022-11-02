createMainMenu();

function createMainMenu()
{
	mainMenu = new air.NativeMenu();
	refreshItem = new air.NativeMenuItem(loca.GetText("LAB", "Update") + " (F2)");
	refreshItem.addEventListener(air.Event.SELECT, menuZoneRefreshHandler);
	filterSubMenu = new air.NativeMenu();
	filterSubMenu.addEventListener(air.Event.SELECT, menuFilterHandler); 
	filterMenuItems = [
		"none", "snownowater", "snowlight", "snow", "oven", "doomsday", "night", "desert", "tropical",
		"colormod", "blackandwhite", "spooky", "snow_medium", "tundra", "darkershadow", "magicsepia"
	];
	filterMenuItems.forEach(function(item){
	  filterSubMenu.addItem(new air.NativeMenuItem(item));
	});
	mainMenu.addSubmenu(filterSubMenu, loca.GetText("LAB", "Filter"));
	mainMenu.addItem(refreshItem);
	addMenuItem(loca.GetText("ACL", "BuffAdventuresGeneral"), mainMenu);
	addKeybBind(menuZoneRefreshHandler, 113);
}

function menuFilterHandler(event)
{
  swmmo.getDefinitionByName("defines").CLIENT_FILTER = true;
  swmmo.getDefinitionByName("gGfxResource").applyFilter(event.target.label, swmmo.application.mGameInterface);
  swmmo.getDefinitionByName("defines").CLIENT_FILTER = false;
}

function menuZoneRefreshHandler(event)
{
	swmmo.application.mGameInterface.mClientMessages.SendMessagetoServer(1037, swmmo.application.mGameInterface.mCurrentViewedZoneID, null);
	showGameAlert(getText('command_sent'));
}
