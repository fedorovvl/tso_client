var child;

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