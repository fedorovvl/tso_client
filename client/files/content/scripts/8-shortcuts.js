
var shortcutsTypes = { '[b]': 'a ', '[a]': 'l ', '[m]': 'm ', '[g]': 'g ', '[e]': 'e ', '[u]': 'b ', '[p]': 'p ' };
var shortcutsWindow;
var shortcutsTypesLang = {
	'a ': loca.GetText("ACL", "PvPAttacker"),
	'l ': loca.GetText("LAB","Army"),
	'm ': loca.GetText("LAB", "Move"),
	'g ': loca.GetText("SPE", "Geologist"),
	'e ': loca.GetText("SPE", "Explorer"),
	'b ': loca.GetText("LAB", "Buffs"),
	'p ': loca.GetText("LAB", "Production"),
};

var shortcutsSettings = [];
$.extend(shortcutsSettings, readSettings(null, 'shortcuts'));

function shortcutsMakeMenu()
{
	var m = [
		{ label: loca.GetText("LAB","ToggleOptionsPanel"), onSelect: shortcutsAddHandler },
		{ label: loca.GetText("LAB","UnloadUnits"), onSelect: shortcutsFreeAllUnits },
		{ label: getText('shortcutsToStar'), onSelect: shortcutsReturnAll },
		{ type: 'separator' }
	];
	shortcutsGenMenuRecursive(shortcutsSettings, m);
	menu.nativeMenu.getItemByName("Shortcuts").submenu = air.ui.Menu.createFromJSON(m);
}

function shortcutsGenMenuRecursive(item, m)
{
	item.forEach(function(data){
		var s = { label: data.name, items: [] };
		data.items.forEach(function(i) {
			if(typeof i == 'object') {
				return shortcutsGenMenuRecursive([i], s.items);
			}
			if(i == '--sep--') {
				s.items.push({ type: 'separator' });
			} else {
				s.items.push({ label: shortcutsStripType(i)[1] + shortcutsStripType(i)[0].split("\\").pop().replace(/_/g, "[UNDERSCORE]"), name: i, onSelect: shortcutsMenuSelectedHandler });
			}
		});
		m.push(s);
	});
}

function shortcutsStripType(value)
{
	var possibleType = value.slice(-3);
	if(shortcutsTypes[possibleType] == null)
		return [value, '^ '];
	return [value.slice(0, -3), shortcutsTypes[possibleType]]; 
}

function shortcutsMenuSelectedHandler(event)
{
	try {
		var filetype = shortcutsStripType(event.target.name);
		var file = new air.File(filetype[0]);
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.READ);
		var data = fileStream.readUTFBytes(file.size);
		fileStream.close();
		if (data == "") { return; }
		shortcutsProceedFile(JSON.parse(data), filetype[1]);
	} catch(e) {
		getText("bad_template");
	}
}

function shortcutsProceedFile(data, type)
{
	switch(type) {
		case 'l ':
			armyMenuHandler(null);
			armyPacket = data;
			armyLoadData();
		break;
		case 'm ':
		case 'a ':
			battleMenuHandler(null);
			if(game.gi.isOnHomzone()) { return; }
			battlePacket = data;
			battleLoadData();
		break;
		case 'e ':
		case 'g ':
			specSharedHandler(type == 'e ' ? 1 : 2);
			$('#specModalData select').val(0);
			$.each(data, function(spec, val) { $('#' + spec.replace('expl-','')).val(val); });
			$('#specModalData select').each(function(i, select){
				updateSpecTimeRow(select, $(select).val(), $(select).val());
			});
		break;
		case 'b ':
			buffRecord = data;
			buffSourceRecord = false;
			menuBuffsHandler(null);
		break;
		case 'p ':
			buildingRecord = data;
			menuBuildingHandler(null);
		break;
	}
}

function shortcutsReturnAll()
{
	var queue = new TimedQueue(1000);
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
		if (game.player.GetPlayerId() == item.getPlayerID() && 
		    armySPECIALIST_TYPE.IsGeneral(item.GetType()) && 
			item.GetGarrisonGridIdx() > 0  && !item.IsInUse() && !item.isTravellingAway())
		{
			queue.add(function(){ armySendGeneralToStar(item); });
		}
	});
	if(queue.len() > 0)
	{
		queue.run();
		game.showAlert(getText('command_sent'));
	}
}
function shortcutsFreeAllUnits()
{
	var queue = new TimedQueue(1000);
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
		if (game.player.GetPlayerId() == item.getPlayerID() && 
		    armySPECIALIST_TYPE.IsGeneral(item.GetType()) && 
			item.GetGarrisonGridIdx() > 0  && item.HasUnits() && !item.IsInUse() && !item.isTravellingAway())
		{
			queue.add(function(){ armyMilitarySystem.SendRaiseArmyToServer(game.gi, item, null); });
		}
	});
	if(queue.len() > 0)
	{
		queue.run();
		game.showAlert(getText('command_sent'));
	}
}

function shortcutsAddHandler(event)
{
	shortcutsWindow = new Modal('shortcutsWindow', utils.getImageTag('icon_advanced_paper_wholesale.png') + ' ' + getText('shortcutsTitle'));
	shortcutsWindow.create();
	
	if(shortcutsWindow.withHeader('.container-fluid').length == 0){
		var select = $('<select>', { id: 'shortcutsSelect', 'class': "form-control" }).append($('<option>', { value:"---" }).text("---"));
		shortcutsWindow.withHeader('').append($('<div>', { 'class': 'container-fluid' }).append([
			createTableRow([
				[2, getText('shortcutsFolder')],
				[6, select],
				[4, $('<center>').append($('<span>', { 'class': "shortcutsSaved", 'style': "display:none;" }).html("<b>{0}</b>".format(getText('shortcutsSaved')))) ]
			], true),
			createTableRow([[3, loca.GetText("LAB", "Type")],[9, getText('shortcutsFilename')]], true)
		]));
		shortcutsWindow.withHeader('#shortcutsSelect').change(shortcutsUpdateView);
	}
	var groupSelect = $('<div>', { 'class': 'btn-group dropup' }).append([
		$('<button>').attr({ 
			"id": "shortcutsAddItem",
			"class": "btn btn-success shortcutsAddItem dropdown-toggle",
			'aria-haspopup': 'true',
			'style': 'margin-left: 4px;',
			'aria-expanded': 'false',
			'data-toggle': "dropdown"
		}).text(getText('shortcutsAddItem')), 
		$('<ul>', { 'class': 'dropdown-menu' }).append([
			$('<li>').html($('<a>', {'href': '#', 'name': 'geo'}).text(shortcutsTypesLang['g '])),
			$('<li>').html($('<a>', {'href': '#', 'name': 'expl'}).text(shortcutsTypesLang['e '])),
			$('<li>').html($('<a>', {'href': '#', 'name': 'buff'}).text(shortcutsTypesLang['b '])),
			$('<li>').html($('<a>', {'href': '#', 'name': 'bui'}).text(shortcutsTypesLang['p '])),
			$('<li>').html($('<a>', {'href': '#', 'name': 'army'}).text(shortcutsTypesLang['l '])),
			$('<li>').html($('<a>', {'href': '#', 'name': 'move'}).text(shortcutsTypesLang['m '])),
			$('<li>').html($('<a>', {'href': '#', 'name': 'battle'}).text(shortcutsTypesLang['a '])),
			$('<li>').html($('<a>', {'href': '#', 'name': 'sep'}).text(getText('shortcutsSeparator')))
		])
	]);

	shortcutsWindow.Footer().prepend([
		$('<button>').attr({ "id": "shortcutsSave", "class": "btn btn-primary shortcutsSave" }).text(loca.GetText("LAB","GuildSave")),
		$('<button>').attr({ "id": "shortcutsAdd","class": "btn btn-primary pull-left"}).text("{0} {1}".format(getText('shortcutsAdd'),getText('shortcutsFolder'))),
		$('<button>').attr({ "id": "shortcutsRemove","class": "btn btn-primary pull-left"}).text(loca.GetText("LAB","Delete")),
		groupSelect
	]);
	shortcutsWindow.withFooter('#shortcutsRemove, #shortcutsAddItem').hide();
	shortcutsWindow.withFooter('#shortcutsAdd').click(function() {
		var des = prompt("Folder name", '');
		if(des == null || des == "") { return; }
		var newid = Date.now();
		(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings).push({
			'id' : newid,
			'name' : des,
			'items' : new Array()
		});
		shortcutsRefresh();
		shortcutsWindow.withHeader("#shortcutsSelect").val(newid).change();
	});
	shortcutsWindow.withFooter('.dropdown-menu a').click(function() {
		var item = shortcutsGetActive();
		if (item != null) {
			if(this.name == 'sep') {
				item.items.push('--sep--');
				shortcutsUpdateView();
				return;
			}
			shortcutsselectTextFile(this.name); 
		}
	});
	shortcutsWindow.withFooter('#shortcutsRemove').click(function() {
		var active = shortcutsWindow.withHeader('#shortcutsSelect option:selected').val();
		for(var i = 0 ; i < shortcutsSettings.length; i++) {
			if (shortcutsSettings[i].id == active) {
				shortcutsSettings.splice(i, 1);
				break;
			}
			shortcutsRemoveRecursive(shortcutsSettings[i].items, active);
		}
		shortcutsRefresh();
	});
	shortcutsWindow.withFooter('.shortcutsSave').click(function(){
		var active = shortcutsGetActive();
		if (active != null) {
			var sortOrder = {};
			$.each(shortcutsWindow.withBody('.close'), function(i, item) { sortOrder[$(item).val()] = i; });
			active.items.sort(function(a,b) { return sortOrder[active.items.indexOf(a)] > sortOrder[active.items.indexOf(b)] ? 1 : -1; });
		}
		settings.settings['shortcuts'] = [];
		storeSettings(shortcutsSettings, 'shortcuts');
		shortcutsMakeMenu();
		shortcutsWindow.withHeader('.shortcutsSaved').fadeIn();
		setTimeout(function() { shortcutsWindow.withHeader('.shortcutsSaved').fadeOut(); }, 1000);
	});

	shortcutsWindow.Body().html($('<div>', { 'id': 'shortcutsRows' }));
	shortcutsRefresh();
	shortcutsWindow.show();
}

function shortcutsRemoveRecursive(t, idToRemove) {
	for (i in t) {
		if(typeof t[i] == 'object') {
			if(t[i].id == idToRemove) {
				t.splice(i, 1);
				continue;
			}
			shortcutsRemoveRecursive(t[i].items, idToRemove);
		}
	}
}

function shortcutsselectTextFile(type) 
{ 
    var txtFilter = new air.FileFilter("Template", "*.*");
	var root = new air.File();
	root.nativePath = readLastDir(type);
    root.browseForOpenMultiple("Open", new window.runtime.Array(txtFilter)); 
    root.addEventListener(window.runtime.flash.events.FileListEvent.SELECT_MULTIPLE, function(event) {
		var nametotype = { 'buff': 'u', 'bui': 'p', 'battle': 'b' };
		var active = shortcutsGetActive();
		if (active == null) { return; }
		event.files.forEach(function(item) {
			active.items.push(item.nativePath + "[{0}]".format(nametotype[type] ? nametotype[type] : type.charAt(0)));
		});
		shortcutsUpdateView();
	});
}

function shortcutsUpdateView()
{
	
	shortcutsWindow.withBody('#shortcutsRows').html("");
	var active = shortcutsGetActive();
		
	if (active == null) {
		shortcutsWindow.withFooter('#shortcutsRemove, #shortcutsAddItem').hide();
		return;
	}
	shortcutsWindow.withFooter('#shortcutsRemove, #shortcutsAddItem').show();
	if (active.items != null && active.items.length > 0) {
		var out = "";
		active.items.forEach(function(i, idx) {
			if(typeof i == 'object') { 
				out += createTableRow([
					[3, '&#8597;&nbsp;&nbsp; '+getText('shortcutsFolder')],
					[9, i.name + $('<button>', { 'type': 'button', 'class': 'close', 'value': idx, 'style': 'display:none;' }).prop('outerHTML')]
				], false);
			} else if(i == '--sep--') {
				out += createTableRow([
				[1, '&#8597;&nbsp;&nbsp;'],
				[10, $('<hr>', { 'style': 'margin: 10px 0;' })],
				[1,  $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))],
				], false);
			} else {
				var typename = shortcutsStripType(i.split("\\").pop());
				out += createTableRow([
					[3, '&#8597;&nbsp;&nbsp;' + shortcutsTypesLang[typename[1]]],
					[9, typename[0] + $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;')).prop('outerHTML')],
				], false);
			}
		});
		shortcutsWindow.withBody('#shortcutsRows').html($('<div>', { 'class': "container-fluid", 'style': "user-select: none;cursor:move;" }).html(out));
		shortcutsWindow.withBody('.container-fluid').sortable();
		shortcutsWindow.withBody('.close').click(function(e){
			shortcutsGetActive().items.splice(parseInt($(this).val()), 1);
			shortcutsUpdateView();
		});
	}
}

function shortcutsGetActive()
{
	if(shortcutsWindow.withHeader('#shortcutsSelect option:selected').val() == '---') { return null; }
	return shortcutsGetActiveRecursive(shortcutsSettings, shortcutsWindow.withHeader('#shortcutsSelect option:selected').val());
}

function shortcutsGetActiveRecursive(t, s)
{
	var result = null;
	for(n in t) {
		if (t[n].id == s) return t[n];
		debug("check " + t[n].id);
		debug(t[n]);
		t[n].items.forEach(function(item){
			if(typeof item == 'object')
				result = shortcutsGetActiveRecursive([item], s) || result;
		});
	};
	return result;
}


// Refresh comboBox and table
function shortcutsRefresh()
{
	shortcutsWindow.withHeader('#shortcutsSelect').html('');
	shortcutsWindow.withHeader('#shortcutsSelect').append($('<option>', { value:"---" }).text("---"));
	shortcutsSettings.sort(function(a, b) {
		return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
	});
	shortcutsSettings.forEach(function(item){
		shortcutsWindow.withHeader('#shortcutsSelect').append($('<option>', { value: item.id }).text(item.name));
		for (i in item.items) {
			if(typeof item.items[i] == 'object') {
				shortcutsRefreshRecursive(item.items[i], [item.name], 1);
			}
		}
	});
	shortcutsUpdateView();
}

function shortcutsRefreshRecursive(t, dim, depth)
{
	dim = dim.slice(0, depth);
	dim.push(t.name);
	shortcutsWindow.withHeader('#shortcutsSelect').append($('<option>', { value: t.id }).text(dim.join(" > ")));
	for (i in t.items) {
		if(typeof t.items[i] == 'object') {
			shortcutsRefreshRecursive(t.items[i], dim, ++depth);
		}
	}
}
