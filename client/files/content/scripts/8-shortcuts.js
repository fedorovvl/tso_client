
var shortcutsTypes = { '[b]': 'a ', '[a]': 'l ', '[m]': 'm ', '[g]': 'g ', '[e]': 'e ', '[u]': 'b ', '[p]': 'p ' };
var shortcutsWindow;
var shortcutsLRUItem;
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
		{ label: loca.GetText("LAB","ToggleOptionsPanel"), mnemonicIndex: 0, onSelect: shortcutsAddHandler },
		{ label: loca.GetText("LAB","UnloadUnits"), mnemonicIndex: 0, onSelect: shortcutsFreeAllUnits },
		{ label: getText('shortcutsToStar'), mnemonicIndex: 0, onSelect: shortcutsReturnAll },
		{ label: loca.GetText("LAB", "WarehouseTab7"), mnemonicIndex: 0, onSelect: shortcutsPickupAll },
		{ type: 'separator' }
	];
	shortcutsGenMenuRecursive(shortcutsSettings, m);
	menu.nativeMenu.getItemByName("Shortcuts").submenu = air.ui.Menu.createFromJSON(m);
}

function shortcutsGenMenuRecursive(item, m)
{
	item.forEach(function(data){
		var s = { label: data.name, mnemonicIndex: 0, items: [] };
		data.items.forEach(function(i, index) {
			if(typeof i == 'object' && !Array.isArray(i)) {
				return shortcutsGenMenuRecursive([i], s.items);
			}
			if(/--s[0-9]+p--/.test(i)) {
				s.items.push({ type: 'separator' });
			} else {
				var label = "{0}. [{1}] {2}".format(index, shortcutsTypesLang[shortcutsStripType(i[0])[1]], i[1] == null ? shortcutsStripType(i[0])[0].split("\\").pop().replace(/_/g, "[UNDERSCORE]") : i[1]);
				s.items.push({ label: label, mnemonicIndex: 0, name: i[0], onSelect: shortcutsMenuSelectedHandler });
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
	if(shortcutsLRUItem) {
		shortcutsLRUItem.label = shortcutsLRUItem.label.slice(2);
	}
	shortcutsLRUItem = event.target;
	shortcutsLRUItem.label = "->{0}".format(shortcutsLRUItem.label);
	try {
		var filetype = shortcutsStripType(event.target.name);
		var file = new air.File(filetype[0]);
		if(!file.exists) {
			alert(getText("bad_template"));
			return;
		}
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.READ);
		var data = fileStream.readUTFBytes(file.size);
		fileStream.close();
		if (data == "") { return; }
		shortcutsProceedFile(JSON.parse(data), filetype[1]);
	} catch(e) {
		alert(getText("bad_template"));
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
		queue.add(function(){ game.showAlert(loca.GetText("LAB", "GuildQuestCompleted")); });
		queue.run();
		game.showAlert(getText('command_sent'));
	}
}

function shortcutsPickupAll(event) {
    var collectionsManager = swmmo.getDefinitionByName("Collections::CollectionsManager").getInstance(),
        queue = new TimedQueue(1000),
        questTriggersMap = {},
        itemBuildingName, itemGOContainer;
    if (game.gi.mCurrentPlayer.mIsAdventureZone && game.gi.mNewQuestManager.GetQuestPool().IsAnyQuestsActive()) {
		$.each(game.gi.mNewQuestManager.GetQuestPool().GetQuest_vector(), function(i, item) {
			if (item.isFinished() || !item.IsQuestActive()) { return; }
			$.each(item.mQuestDefinition.questTriggers_vector, function(n, trigger) {
				if(trigger.name_string != null && trigger.name_string != '')
					questTriggersMap[trigger.name_string] = true;
			});
		});
    }

    game.zone.mStreetDataMap.GetBuildings_vector().forEach(function(item){
        if (item === null) { return; }
        itemGOContainer = item.GetGOContainer();
        if (
            collectionsManager.getBuildingIsCollectible(item.GetBuildingName_string()) ||
            (
                questTriggersMap[item.GetBuildingName_string()] &&
                item.mIsSelectable &&
                itemGOContainer.mIsAttackable &&
                !itemGOContainer.mIsLeaderCamp &&
                itemGOContainer.ui !== "enemy" &&
                (item.GetArmy() == null || !item.GetArmy().HasUnits())
            )
        ) {
            queue.add(function(){
                game.gi.SelectBuilding(item);
            });
        }
    });

    if (queue.len() === 0) {
        showGameAlert("No collectibles found");
        return;
    }
    showGameAlert(getText('command_sent'));
    queue.run();
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
		queue.add(function(){ game.showAlert(loca.GetText("LAB", "GuildQuestCompleted")); });
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
			createTableRow([[3, loca.GetText("LAB", "Type")],[5, getText('shortcutsFilename')],[4, '']], true)
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
				item.items.push('--s'+Date.now()+'p--');
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
	var sortOrder = {};
	$.each(shortcutsWindow.withBody('.close'), function(i, item) { sortOrder[$(item).val()] = i; });
	shortcutsWindow.withFooter('.shortcutsSave').click(function(){
		var active = shortcutsGetActive();
		var sortOrder = {};
		if (active != null) {
			$.each(shortcutsWindow.withBody('.close'), function(i, item) { sortOrder[$(item).val()] = i; });
			active.items.sort(function(a,b) { return sortOrder[active.items.indexOf(a)] > sortOrder[active.items.indexOf(b)] ? 1 : -1; });
			$.each(shortcutsWindow.withBody('div.row'), function(i, item) { 
				if($(item).find('.form-control').length > 0) {
					active.items[i][1] = $(item).find('.form-control').val() || null;
				}
			});
		} else {
			$.each(shortcutsWindow.withBody('.close'), function(i, item) { sortOrder[$(item).val()] = i; });
			shortcutsSettings.sort(function(a,b) { return sortOrder[shortcutsSettings.indexOf(a)] > sortOrder[shortcutsSettings.indexOf(b)] ? 1 : -1; });
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
		if(typeof t[i] == 'object'  && !Array.isArray(t[i])) {
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
	root.nativePath = readLastDir(type == 'move' ? 'army' : type);
    root.browseForOpenMultiple("Open", new window.runtime.Array(txtFilter)); 
    root.addEventListener(window.runtime.flash.events.FileListEvent.SELECT_MULTIPLE, function(event) {
		var nametotype = { 'buff': 'u', 'bui': 'p', 'battle': 'b' };
		var active = shortcutsGetActive();
		if (active == null) { return; }
		event.files.forEach(function(item) {
			active.items.push([item.nativePath + "[{0}]".format(nametotype[type] ? nametotype[type] : type.charAt(0)), null]);
		});
		shortcutsUpdateView();
	});
}

function shortcutsUpdateView()
{
	
	shortcutsWindow.withBody('#shortcutsRows').html("");
	var active = shortcutsGetActive();
	var out = "";

	if (active == null) {
		shortcutsWindow.withFooter('#shortcutsRemove, #shortcutsAddItem').hide();
		shortcutsSettings.forEach(function(i, idx) {
			if(typeof i == 'object' && !Array.isArray(i)) { 
				out += createTableRow([
					[3, '&#8597;&nbsp;&nbsp; '+getText('shortcutsFolder')],
					[6, $('<span>', { 'class': 'folder', 'id': i.id, 'style': 'cursor:pointer;' }).text(i.name)],
					[3, $('<button>', { 'type': 'button', 'class': 'close', 'value': idx, 'style': 'display:none;' })]
				], false);
			}
		});
		shortcutsWindow.withBody('#shortcutsRows').html($('<div>', { 'class': "container-fluid", 'style': "user-select: none;cursor:move;" }).html(out));
		shortcutsWindow.withBody('.close').click(function(e){
			shortcutsSettings.splice(parseInt($(this).val()), 1);
			shortcutsUpdateView();
		});
	}
	if(active != null) { 
		shortcutsWindow.withFooter('#shortcutsRemove, #shortcutsAddItem').show();
	}
	if (active != null && active.items != null && active.items.length > 0) {
		active.items.forEach(function(i, idx) {
			if(typeof i == 'object' && !Array.isArray(i)) { 
				out += createTableRow([
					[3, '&#8597;&nbsp;&nbsp; '+getText('shortcutsFolder')],
					[6, $('<span>', { 'class': 'folder', 'id': i.id, 'style': 'cursor:pointer;' }).text(i.name)],
					[3, $('<button>', { 'type': 'button', 'class': 'close', 'value': idx, 'style': 'display:none;' })]
				], false);
			} else if(/--s[0-9]+p--/.test(i) || i == '--sep--') {
				out += createTableRow([
				[1, '&#8597;&nbsp;&nbsp;'],
				[10, $('<hr>', { 'style': 'margin: 10px 0;' })],
				[1,  $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))],
				], false);
			} else {
				var typename = shortcutsStripType(i[0].split("\\").pop());
				out += createTableRow([
					[3, '&#8597;&nbsp;&nbsp;' + shortcutsTypesLang[typename[1]]],
					[4, typename[0]],
					[3, $('<input>', { 'type': 'text', 'class': 'form-control', 'style': 'background:none;color:white;', 'value': i[1] == null ? '' : i[1] })],
					[2, $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))],
				], false);
			}
		});
		shortcutsWindow.withBody('#shortcutsRows').html($('<div>', { 'class': "container-fluid", 'style': "user-select: none;cursor:move;" }).html(out));
		shortcutsWindow.withBody('.close').click(function(e){
			shortcutsGetActive().items.splice(parseInt($(this).val()), 1);
			shortcutsUpdateView();
		});
	}
	shortcutsWindow.withBody('.container-fluid').sortable();
	shortcutsWindow.withBody('.folder').click(function(e){
		shortcutsWindow.withHeader("#shortcutsSelect").val(this.id).change();
	});
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
		t[n].items.forEach(function(item){
			if(typeof item == 'object' && !Array.isArray(item))
				result = shortcutsGetActiveRecursive([item], s) || result;
		});
	};
	return result;
}


function shortcutsRefresh()
{
	shortcutsWindow.withHeader('#shortcutsSelect').html('');
	shortcutsWindow.withHeader('#shortcutsSelect').append($('<option>', { value:"---" }).text("root"));
	shortcutsSettings.forEach(function(item){
		shortcutsWindow.withHeader('#shortcutsSelect').append($('<option>', { value: item.id }).text(item.name));
		for (i in item.items) {
			if(typeof item.items[i] == 'object' && !Array.isArray(item.items[i])) {
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
		if(typeof t.items[i] == 'object' && !Array.isArray(t.items[i])) {
			shortcutsRefreshRecursive(t.items[i], dim, ++depth);
		}
	}
}
