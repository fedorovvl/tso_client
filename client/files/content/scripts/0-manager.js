var info = {};
var infoTree = {};
var missMatch = {};
var currentCheckboxes = '';

function scriptsManagerWindow()
{
	$( "div[role='dialog']:not(#managerModal):visible").modal("hide");
	createModalWindow('managerModal', getImageTag('BattleBuffKill_random_unit_type_limited') + ' ' + loca.GetText("LAB", 'EventProgression'));
	if($('#managerModal .managerSubmit').length == 0)
	{
		$("#managerModal .btnClose").text(getText('btn_close'));
		$("#managerModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-primary managerFix" }).text(getText('btn_fix')),
			$('<button>').attr({ "class": "btn btn-primary managerSubmit" }).text(getText('btn_submit'))
		]);
		$('#managerModal .managerFix').click(managerReinstall);
		$('#managerModal .managerSubmit').click(managerProceed);
	}
	$('.managerSubmit, .managerFix').attr("disabled", true);
	currentCheckboxes = '';
	missMatch = {};
	out = '<div class="container-fluid">';
	if(info == '') {
		out += '<p>Unable to get info from github</p>';
	}
	out += managerGetData();
	$("#managerModalData").html(out);
	$("#managerModalData input[type=checkbox]").change(function(){
		var checkboxes = '';
		$("#managerModalData input[type=checkbox]").each(function(i, item) { checkboxes += + item.checked; });
		$('.managerSubmit').attr("disabled", checkboxes == currentCheckboxes);
	});
	if(Object.keys(missMatch).length > 0) {
		$('.managerFix').attr("disabled", false);
	}
	$('#managerModalData a').click(function(event) { 
		event.preventDefault();
		air.navigateToURL(new air.URLRequest(this)); 
	});
	$('#managerModal:not(:visible)').modal({backdrop: "static"});
}

function managerGetData()
{
	currentScripts = getCurrentScripts();
	out = createTableRow([[2,"Filename"],[2,"ScriptName"],[2,"Author"],[3,"Description"],[2,"Status"],[1,"Installed"]], true);
	info = (info == 'error') ? {} : info;
	for(name in info) {
		st = checkSize(info[name].size, currentScripts[name]);
		out += createTableRow([
			[2,name],
			[2,getScriptField(info[name])],
			[2,info[name].author],
			[3,'<span data-tooltip="'+info[name].longDesc+'">'+info[name].shortDesc+'</span>'],
			[2,st == 'ok' ? st : getText('manager_mismatch')],
			[1,'<input type="checkbox" id="'+name+'" '+(currentScripts[name] ? 'checked' : '')+'>']
		]);
		if(st != 'ok') { missMatch[name] = true; }
		currentCheckboxes += (currentScripts[name] ? '1' : '0');
		delete currentScripts[name];
	}
	for(item in currentScripts) {
		out += createTableRow([
			[2,item],
			[2,'You'],
			[2,'trust'],
			[3,'this'],
			[2,'file?'],
			[1,'<input type="checkbox" id="'+item+'" checked>']
		]);
		currentCheckboxes += '1';
	}
	return out;
}

function managerReinstall()
{
	out = '';
	for(item in missMatch)
	{
		$.get("https://raw.githubusercontent.com/fedorovvl/tso_client/master/userscripts/"+item, function(data) {
			fileName = this.url.replace(/^.*[\\\/]/, '');
			out += '<p>Reinstall '+fileName+'<\p>';
			$("#managerModalData").html('<div class="container-fluid">'+out+'<\p>');
			file = new air.File(air.File.applicationDirectory.resolvePath("userscripts/"+fileName).nativePath);
			var fileStream = new air.FileStream();
			fileStream.open(file, air.FileMode.WRITE);
			fileStream.writeUTFBytes(data);
			fileStream.close();
			delete missMatch[fileName];
			if(Object.keys(missMatch).length == 0) { finishProceed(); }
		});
	}
}

function getScriptField(data)
{
	if(data.url && data.url != '') {
		return '<a href="'+data.url+'">'+data.name+'</a>';
	}
	return data.name;
}

function checkSize(a, b)
{
	if(!a || !b) { return 'ok'; }
	return a == b ? 'ok' : 'mismatch';
}

function navigateToUrl(event, url) 
{
	alert(url);
	event.preventDefault();
	air.navigateToURL(new air.URLRequest(url));
}

function getCurrentScripts()
{
	scripts = {};
	air.File.applicationDirectory.resolvePath("userscripts").getDirectoryListing().forEach(function(item) {
		if(item.name != "99-example.js") { scripts[item.name] = item.size; }
	});
	return scripts;
}

function managerProceed()
{
	var installed = getCurrentScripts();
	var checkboxes = {};
	var result = {};
	$("#managerModalData input[type=checkbox]").each(function(i, item) { checkboxes[item.id] = + item.checked; });
	for(item in installed) {
		if(!checkboxes[item] && installed[item]) { result[item] = false; }
	}
	for(item in checkboxes) {
		if(checkboxes[item] && !installed[item]) { result[item] = true; }
	}
	out = '';
	for(item in result)
	{
		//remove
		if(result[item] == false)
		{
			out += '<p>Remove '+item+'<\p>';
			$("#managerModalData").html('<div class="container-fluid">'+out+'<\p>');
			new air.File(air.File.applicationDirectory.resolvePath("userscripts/"+item).nativePath).deleteFile();
			delete result[item];
		} else {
			//install
			$.get("https://raw.githubusercontent.com/fedorovvl/tso_client/master/userscripts/"+item, function(data) {
				fileName = this.url.replace(/^.*[\\\/]/, '');
				out += '<p>Install '+fileName+'<\p>';
				$("#managerModalData").html('<div class="container-fluid">'+out+'<\p>');
				file = new air.File(air.File.applicationDirectory.resolvePath("userscripts/"+fileName).nativePath);
				var fileStream = new air.FileStream();
				fileStream.open(file, air.FileMode.WRITE);
				fileStream.writeUTFBytes(data);
				fileStream.close();
				delete result[fileName];
				if(Object.keys(result).length == 0) { finishProceed(); }
			});
		}
	}
	if(Object.keys(result).length == 0) { finishProceed(); }
}

function finishProceed()
{
	reloadScripts(null);
	setTimeout(scriptsManagerWindow, 1000); 
}

function scriptsManager(event)
{
	info = 'error';
	var req = $.get("https://raw.githubusercontent.com/fedorovvl/tso_client/master/userscripts/info.json", function(data) {
		info = JSON.parse(data);
	});
	req.always(function(){
		getInfoTree();
	});
}

function getInfoTree()
{
	if(info == 'error')
	{
		scriptsManagerWindow();
		return;
	}
	var req = $.get("https://api.github.com/repos/fedorovvl/tso_client/contents/userscripts", function(data) {
		data.forEach(function(item) {
			if(info[item.name]) { 
				info[item.name].size = item.size;
				info[item.name].sha = item.sha;
			}
		});
	});
	req.always(function(){
		scriptsManagerWindow();
	});
}