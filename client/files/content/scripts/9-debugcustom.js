var child;

if(isDebug) {
	addMenuItem("CustomCode", menuCustomHandler);
	addMenuItem("SaveHTML", menuSaveHandler);
}
addKeybBind(menuCollectibleHandler, 116, true);

function menuCustomHandler(event)
{
	try{
		if(child) {	$( child ).remove(); }
		file = new air.File("file:///" + air.File.applicationDirectory.resolvePath("custom.js").nativePath);
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.WRITE);
		fileStream.writeMultiByte("(function () { try {" + prompt("Code") + "} catch (err) { alert(err);} })();", "utf-8");
		fileStream.close();
		var script = document.createElement("script");
		script.setAttribute("src", "custom.js?" + Date.now());
		script.setAttribute("type", "text/javascript");
		script.setAttribute("id", "custom"+ (Math.random() + 1).toString(36).substring(7));
		child = document.body.appendChild(script);
	} catch (e) { alert(e); }
}

function menuSaveHandler(event)
{
	file = air.File.documentsDirectory.resolvePath("swmmo.html");
	file.save($('html').prop('outerHTML'));
}

function menuCollectibleHandler(event)
{
  col = swmmo.getDefinitionByName("Collections::CollectionsManager").getInstance();
  var x = new TimedQueue(1000);
  swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector().forEach(function(item){
    if(col.getBuildingIsNormalCollectible(item.GetBuildingName_string()) || col.getBuildingIsEventCollectible(item.GetBuildingName_string())) {
	  x.add(function(){ item.handleSelectBuilding(); });
	}
  });
  if(x.len() == 0) {
	showGameAlert("No collectibles found");
	return;
  }
  showGameAlert("Don't tell ubisoft about what happened here =)");
  x.run();
}