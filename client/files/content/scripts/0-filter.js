filterSubMenu = new air.NativeMenu();
filterSubMenu.addEventListener(air.Event.SELECT, menuFilterHandler); 
filterMenuItems = [
	"none",
	"snownowater",
	"snowlight",
	"snow",
	"oven",
	"doomsday",
	"night",
	"desert",
	"tropical",
	"colormod",
	"blackandwhite",
	"spooky",
	"snow_medium",
	"tundra",
	"darkershadow",
	"magicsepia"
];
filterMenuItems.forEach(function(item){
  filterSubMenu.addItem(new air.NativeMenuItem(item));
});

addMenuItem(loca.GetText("LAB", "Filter"), filterSubMenu);

function menuFilterHandler(event)
{
  swmmo.getDefinitionByName("defines").CLIENT_FILTER = true;
  swmmo.getDefinitionByName("gGfxResource").applyFilter(event.target.label, swmmo.application.mGameInterface);
  swmmo.getDefinitionByName("defines").CLIENT_FILTER = false;
}