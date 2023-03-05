const toolsItem = new air.NativeMenuItem("Languages");
const langs = ['ar-ae', 'cz-cz', 'de-de', 'el-gr', 'en-au', 'en-uk', 'en-us', 'es-es', 'es-mx', 'fr-fr', 'it-it', 'nl-nl', 'pl-pl', 'pt-br', 'ro-ro', 'ru-ru', 'tr-tr', 'zh-cn'];
toolsItem.name = "Languages";
toolsItem.submenu = new air.NativeMenu();		
menu.nativeMenu.getItemByName("Tools").submenu.addItem(toolsItem);


langsMakeMenu()

function langsMakeMenu()
{
	var m = [];
	for(adv in langs)
	{
		m.push({ label: langs[adv], name: langs[adv], onSelect: langsMenuSelectedHandler });
	};
	menu.nativeMenu.getItemByName("Tools").submenu.getItemByName("Languages").submenu = air.ui.Menu.createFromJSON(m);
}

function langsMenuSelectedHandler(event)
{
	loca.LoadLanguage(event.target.name);
}
