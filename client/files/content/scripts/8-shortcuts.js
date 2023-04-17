
var shortcutsTypes = { '[b]': 'a ', '[a]': 'l ', '[m]': 'm ', '[g]': 'g ', '[e]': 'e ', '[u]': 'b ', '[p]': 'p ', '[d]': 'd ', '[f]': 'f ', '[s]': 's ' };
var shortcutsWindow;
var shortcutsLRUItem;
var shortcutsMustHaveSkills = [3,8,9,12,13,19];
var shortcutsSkipSkills = [1, 6, 10, 11, 14, 17];
var shortcutsSkillsVector;
var shortcutsTransportSkillsVector;
var shortcutscSpecialist = game.def("Specialists::cSpecialist");
var shortcutsImported;
var shortcutsImportTransport = true;
var shortcutsImportSkills = true;
var shortcutsImportTotalGens = 0;
var shortcutsTypesLang = {
	'a ': loca.GetText("ACL", "PvPAttacker"),
	'l ': loca.GetText("LAB","Army"),
	'm ': loca.GetText("LAB", "Move"),
	'g ': loca.GetText("SPE", "Geologist"),
	'e ': loca.GetText("SPE", "Explorer"),
	'b ': loca.GetText("LAB", "Buffs"),
	'p ': loca.GetText("LAB", "Production"),
	'd ': loca.GetText("LAB", "Details"),
	'f ': loca.GetText("LAB","UnloadUnits"),
	's ': getText('shortcutsToStar'),
};
var shortcutsGeneralsReplacement = {
	3: [ 33, 36, 7, 8, 11, 9, 13, 47 ],
	7: [ 33, 36, 3, 8, 11, 9, 13, 47 ],
	8: [ 33, 36, 3, 7, 11, 9, 13, 47 ],
	9: [ 13, 47 ],
	11: [ 9, 13, 47 ],
	12: [ 54 ],
	12: [ 27 ],
	13: [ 47 ],
	27: [ 12 ],
	27: [ 54 ],
	33: [ 36, 3, 7, 8, 11, 9, 13, 47 ],
	36: [ 33, 3, 7, 8, 11, 9, 13, 47 ],
	43: [ 57 ],
	57: [ 43 ]
};

var shortcutsSettings = [];
$.extend(shortcutsSettings, readSettings(null, 'shortcuts'));

function shortcutsMakeMenu()
{
	var m = [
		{ label: loca.GetText("LAB","ToggleOptionsPanel"), mnemonicIndex: 0, onSelect: shortcutsAddHandler },
		{ label: loca.GetText("LAB","UnloadUnits"), mnemonicIndex: 0, onSelect: shortcutsFreeAllUnits },
		{ label: getText('shortcutsToStar'), mnemonicIndex: 0, onSelect: shortcutsReturnAll },
		{ label: loca.GetText("LAB","Retreat"), mnemonicIndex: 0, onSelect: shortcutsRetreatAll },
		{ label: loca.GetText("LAB", "WarehouseTab7"), mnemonicIndex: 0, onSelect: shortcutsPickupAll },
		{ type: 'separator' }
	];
	shortcutsGenMenuRecursive(shortcutsSettings, m);
	menu.nativeMenu.getItemByName("Shortcuts").submenu = air.ui.Menu.createFromJSON(m);
}

function shortcutsGenMenuRecursive(item, m)
{
	item.forEach(function(data, idx){
		if(/--s[0-9]+p--/.test(data)) {
			m.push({ type: 'separator' });
			return;
		}
		if(Array.isArray(data)) {
			switch(shortcutsStripType(data[0])[1]) {
				case 'd ':
					m.push({ label: "{0}. {1}".format(idx, data[1]), enabled: false });
				break;
				case 'f ':
					m.push({ label: "{0}. [{1}] {2}".format(idx, loca.GetText("LAB", "Commands"), loca.GetText("LAB","UnloadUnits")), mnemonicIndex: 0, onSelect: shortcutsFreeAllUnits });
				break;
				case 's ':
					m.push({ label: "{0}. [{1}] {2}".format(idx, loca.GetText("LAB", "Commands"), getText('shortcutsToStar')), mnemonicIndex: 0, onSelect: shortcutsReturnAll });
				break;
				default:
					var label = "{0}. [{1}] {2}".format(
						idx,
						shortcutsTypesLang[shortcutsStripType(data[0])[1]], data[1] == null ? shortcutsStripType(data[0])[0].split("\\").pop().replace(/_/g, "[UNDERSCORE]") : data[1].replace(/_/g, "[UNDERSCORE]")
					);
					m.push({ label: label, mnemonicIndex: 0, name: data[0], onSelect: shortcutsMenuSelectedHandler });
			}
			return;
		}
		var s = { label: data.name.replace(/_/g, "[UNDERSCORE]"), mnemonicIndex: 0, items: [] };
		data.items.forEach(function(i, index) {
			if(typeof i == 'object' && !Array.isArray(i)) {
				return shortcutsGenMenuRecursive([i], s.items);
			}
			if(/--s[0-9]+p--/.test(i)) {
				s.items.push({ type: 'separator' });
			} else {
				switch(shortcutsStripType(i[0])[1]) {
					case 'd ':
						s.items.push({ label: "{0}. {1}".format(index, i[1]), enabled: false });
					break;
					case 'f ':
						s.items.push({ label: "{0}. [{1}] {2}".format(index, loca.GetText("LAB", "Commands"), loca.GetText("LAB","UnloadUnits")), mnemonicIndex: 0, onSelect: shortcutsFreeAllUnits });
					break;
					case 's ':
						s.items.push({ label: "{0}. [{1}] {2}".format(index, loca.GetText("LAB", "Commands"), getText('shortcutsToStar')), mnemonicIndex: 0, onSelect: shortcutsReturnAll });
					break;
					default:
						var label = "{0}. [{1}] {2}".format(
							index,
							shortcutsTypesLang[shortcutsStripType(i[0])[1]], i[1] == null ? shortcutsStripType(i[0])[0].split("\\").pop().replace(/_/g, "[UNDERSCORE]") : i[1].replace(/_/g, "[UNDERSCORE]")
						);
						s.items.push({ label: label, mnemonicIndex: 0, name: i[0], onSelect: shortcutsMenuSelectedHandler });
				}
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
	shortcutsMenuSelectedRetryHandler(event.target.name, 0);
}

function shortcutsMenuSelectedRetryHandler(file, count)
{
	try {
		var filetype = shortcutsStripType(file);
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
		shortcutsProceedFile(JSON.parse(data), filetype[1], file.name);
	} catch(e) {
		if(count > 3) {
			alert(getText("bad_template"));
		} else {
			shortcutsMenuSelectedRetryHandler(file, ++count);
		}
	}
}

function shortcutsProceedFile(data, type, name)
{
	switch(type) {
		case 'l ':
		case 'm ':
		case 'a ':
			if(battleTimedQueue && battleTimedQueue.index != battleTimedQueue.len())
			{
				game.showAlert(loca.GetText("ALT", "ServerOverstrained"));
				return;
			}
			battleMenuHandler(null);
			battlePacket = data;
			battleWindow.withHeader('.templateFile').html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
			battleLoadData();
		break;
		case 'e ':
		case 'g ':
			if(game.gi.isOnHomzone() == false) {
				game.showAlert(getText('not_home'));
				return;
			}
			specSharedHandler(type == 'e ' ? 1 : 2);
			$('#specModalData select').val(0);
			$.each(data, function(spec, val) { $('#' + spec.replace('expl-','')).val(val); });
			$('#specModalData select').each(function(i, select){
				updateSpecTimeRow(select, $(select).val(), $(select).val());
			});
			$("#specModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
		break;
		case 'b ':
			buffRecord = data;
			buffSourceRecord = false;
			menuBuffsHandler(null);
			$("#buffModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
		break;
		case 'p ':
			buildingRecord = data;
			$("#buildingModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
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
        showGameAlert(getText("NoCollectibles"));
        return;
    }
    showGameAlert(getText('command_sent'));
    queue.run();
}

function shortcutsRetreatAll()
{
	var queue = new TimedQueue(1000);
	game.zone.GetSpecialists_vector().forEach(function(item){
		if (game.player.GetPlayerId() == item.getPlayerID() && item.GetGeneralState() == 1){
			queue.add(function(){ item.GetTask().Retreat(); });
		}
	});
	if(queue.len() > 0)
	{
		queue.add(function(){ game.showAlert(loca.GetText("LAB", "GuildQuestCompleted")); });
		queue.run();
		if(battleTimedQueue) { 
			battleTimedQueue.reset();
			battleTimedQueue = null;
		}
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
		queue.add(function(){ game.showAlert(loca.GetText("LAB", "GuildQuestCompleted")); });
		queue.run();
		game.showAlert(getText('command_sent'));
	}
}

function shortcutsAddHandler(event)
{
	shortcutsSkillsVector = game.def("global").skillTrees_vector.filter(function(t) { return t.name_string == 'general'; })[0].items_vector;
	shortcutsTransportSkillsVector = game.def("global").skillTrees_vector.filter(function(t) { return t.name_string == 'transporter'; })[0].items_vector;
	shortcutsWindow = new Modal('shortcutsWindow', utils.getImageTag('icon_advanced_paper_wholesale.png') + ' ' + getText('shortcutsTitle'));
	shortcutsWindow.create();
	
	if(shortcutsWindow.withHeader('.container-fluid').length == 0){
		var select = $('<select>', { id: 'shortcutsSelect', 'class': "form-control" }).append($('<option>', { value:"---" }).text("---"));
		shortcutsWindow.withHeader('').append($('<div>', { 'class': 'container-fluid' }).append([
			createTableRow([
				[2, getText('shortcutsFolder')],
				[6, select ],
				[1, $('<a>', { 'href': '#', 'class': 'renamePart' }).append(utils.getImage(new(game.def("GUI.Assets::gAssetManager_IconCombat3BonusTank"))().bitmapData))],
				[3, $('<center>').append($('<span>', { 'class': "shortcutsSaved", 'style': "display:none;" }).html("<b>{0}</b>".format(getText('shortcutsSaved')))) ]
			], true),
			createTableRow([[3, loca.GetText("LAB", "Type")],[5, getText('shortcutsFilename')],[4, '']], true)
		]));
		shortcutsWindow.withHeader('#shortcutsSelect').change(shortcutsUpdateView);
	
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
				$('<li>').html($('<a>', {'href': '#', 'name': 'descr'}).text(shortcutsTypesLang['d '])),
				$('<li>').html($('<a>', {'href': '#', 'name': 'funload'}).text(shortcutsTypesLang['f '])),
				$('<li>').html($('<a>', {'href': '#', 'name': 'star'}).text(shortcutsTypesLang['s '])),
				$('<li>').html($('<a>', {'href': '#', 'name': 'sep'}).text(getText('shortcutsSeparator'))),
				$('<li>').html($('<a>', {'href': '#', 'name': 'folder'}).text(getText('shortcutsFolder')))
			])
		]);

		shortcutsWindow.Footer().prepend([
			$('<button>').attr({ "id": "shortcutsSave", "class": "btn btn-primary pull-left shortcutsSave" }).text(loca.GetText("LAB","GuildSave")),
			$('<button>').attr({ "id": "shortcutsExport","class": "btn btn-primary pull-left"}).text(getText("shortExportTitle")),
			$('<button>').attr({ "id": "shortcutsImport","class": "btn btn-primary pull-left"}).text(getText("shortImportTitle")),
			groupSelect
		]);
		shortcutsWindow.withFooter('#shortcutsExport').hide();
		shortcutsWindow.withFooter('#shortcutsExport').click(shortcutsExport);
		shortcutsWindow.withFooter('#shortcutsImport').click(shortcutsImport);
		shortcutsWindow.withFooter('.dropdown-menu a').click(function() {
			switch(this.name) {
				case 'sep':
					(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings).push('--s'+Date.now()+'p--');
					shortcutsUpdateView();
				break;
				case 'descr':
				case 'funload':
				case 'star':
					(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings).push([Date.now() + "[{0}]".format(this.name.charAt(0)), null]);
					shortcutsUpdateView();
				break;
			    case 'folder':
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
				break;
				default:
					shortcutsselectTextFile(this.name); 
			}
		});
		shortcutsWindow.withFooter('.shortcutsSave').click(function(){
			$.each(shortcutsWindow.withBody('div.row'), function(i, item) { 
				if($(item).find('.form-control').length > 0) {
					(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings)[i][1] = $(item).find('.form-control').val() || null;
				}
			});
			settings.settings['shortcuts'] = [];
			storeSettings(shortcutsSettings, 'shortcuts');
			shortcutsMakeMenu();
			shortcutsWindow.withHeader('.shortcutsSaved').fadeIn();
			setTimeout(function() { shortcutsWindow.withHeader('.shortcutsSaved').fadeOut(); }, 1000);
		});
		shortcutsWindow.withHeader('.renamePart').click(function(){
			var des = prompt("New folder name", '');
			if(des == null || des == "") { return; }
			shortcutsGetActive()&&(shortcutsGetActive().name = des);
			var active = shortcutsGetActive().id;
			shortcutsRefresh();
			shortcutsWindow.withHeader("#shortcutsSelect").val(active).change();
		});
		shortcutsWindow.Body().html($('<div>', { 'id': 'shortcutsRows' }));
	}
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
	root.nativePath = readLastDir(type == 'move' ? 'battle' : type);
    root.browseForOpenMultiple("Open", new window.runtime.Array(txtFilter)); 
    root.addEventListener(window.runtime.flash.events.FileListEvent.SELECT_MULTIPLE, function(event) {
		var nametotype = { 'buff': 'u', 'bui': 'p', 'battle': 'b' };
		event.files.forEach(function(item) {
			(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings).push([item.nativePath + "[{0}]".format(nametotype[type] ? nametotype[type] : type.charAt(0)), null]);
		});
		shortcutsUpdateView();
	});
}

function shortcutsUpdateView()
{
	
	shortcutsWindow.withBody('#shortcutsRows').html("");
	var out = "";
	shortcutsWindow.withFooter('#shortcutsExport').hide();
	shortcutsWindow.withHeader('.renamePart').hide();
	if (shortcutsGetActive()) {
		shortcutsWindow.withFooter('#shortcutsExport').show();
		shortcutsWindow.withHeader('.renamePart').show();
	}
	(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings).forEach(function(i, idx) {
		if(typeof i == 'object' && !Array.isArray(i)) { 
			out += createTableRow([
				[3, '&#8597;&nbsp;&nbsp;'+getText('shortcutsFolder')],
				[6, $('<span>', { 'class': 'folder', 'id': i.id, 'style': 'cursor:pointer;' }).text(i.name)],
				[3, $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))]
			], false);
		} else if(/--s[0-9]+p--/.test(i) || i == '--sep--') {
			out += createTableRow([
			[1, '&#8597;&nbsp;&nbsp;'],
			[10, $('<hr>', { 'style': 'margin: 10px 0;' })],
			[1,  $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))],
			], false);
		} else {
			var typename = shortcutsStripType(i[0].split("\\").pop());
			switch(typename[1]) {
				case 'd ':
					out += createTableRow([
						[3, '&#8597;&nbsp;&nbsp;' + shortcutsTypesLang[typename[1]]],
						[8, $('<input>', { 'type': 'text', 'class': 'form-control', 'style': 'background:none;color:white;', 'value': i[1] == null ? '' : i[1] })],
						[1, $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))],
					], false);
				break;
				case 'f ':
				case 's ':
					out += createTableRow([
						[3, '&#8597;&nbsp;&nbsp;' + loca.GetText("LAB", "Commands")],
						[8, shortcutsTypesLang[typename[1]]],
						[1, $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))],
					], false);
				break;
				default:
					out += createTableRow([
						[3, '&#8597;&nbsp;&nbsp;' + shortcutsTypesLang[typename[1]]],
						[4, typename[0]],
						[3, $('<input>', { 'type': 'text', 'class': 'form-control', 'style': 'background:none;color:white;', 'value': i[1] == null ? '' : i[1] })],
						[2, $('<button>', { 'type': 'button', 'class': 'close', 'value': idx }).html($('<span>').html('&times;'))],
					], false);
			}
		}
	});
	shortcutsWindow.withBody('#shortcutsRows').html($('<div>', { 'class': "container-fluid", 'style': "user-select: none;cursor:move;" }).html(out));
	shortcutsWindow.withBody('.close').click(function(e){
		var actVal = shortcutsWindow.withHeader('#shortcutsSelect').val();
		(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings).splice(parseInt($(this).val()), 1);
		shortcutsRefresh();
		if(actVal != 'root') {
			shortcutsWindow.withHeader('#shortcutsSelect').val(actVal).change();
		}
	});
	shortcutsWindow.withBody('.container-fluid').sortable({
		update: function( event, ui ) {
			var prevIndex = $(ui.item).find('.close').val();
			shortcutsMoveElement((shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings), prevIndex, ui.item.index());
		}
	});
	shortcutsWindow.withBody('.folder').click(function(e){
		shortcutsWindow.withHeader("#shortcutsSelect").val(this.id).change();
	});
}

function shortcutsMoveElement(array, fromIndex, toIndex) {
  const element = array.splice(fromIndex, 1)[0];
  array = array.splice(toIndex, 0, element);
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
		if(t[n].id) {
			t[n].items.forEach(function(item){
				if(typeof item == 'object' && !Array.isArray(item))
					result = shortcutsGetActiveRecursive([item], s) || result;
			});
		}
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

function shortcutsImport()
{
	var exportSource = new SaveLoadTemplate('short', function(data) {
		var hashed = data.hash;
		delete data.hash;
		if(!data.tree || !data.content || hash(JSON.stringify(data)) != hashed) {
			alert(getText("bad_template"));
			return;
		}
		shortcutsImportProceed(data);
	});
	exportSource.load();
}

function shortcutsImportMakeSelect()
{
	var select = $('<select>', { 'class': "form-control" });
	game.zone.GetSpecialists_vector().sort(specNameSorter).forEach(function(item){
			if(!armySPECIALIST_TYPE.IsGeneralOrAdmiral(item.GetType()) || item.getPlayerID() == -1) { return; }
			select.append($('<option>', { value: item.GetUniqueID().toKeyString(), id: item.GetType() }).text(item.getName(false).replace(/(<([^>]+)>)/gi, "") + " ({0})".format(item.GetUniqueID().toKeyString())));
	});
	return select;
}

function shortcutsImportFilterSelect(select, type)
{
	var result = select.clone();
	var filter = [ type ];
	shortcutsGeneralsReplacement[type]&&(filter = filter.concat(shortcutsGeneralsReplacement[type]));
	result.find('option[id]').filterAttribute('id', filter, true).remove();
	result.prepend($('<option>', { value: 0 }).text(loca.GetText("LAB", "Select")));
	return result.find('option').length == 1 ? getText('NoData') : result.prop('outerHTML');
}

function shortcutsImportFinal()
{
	var selected = [];
	shortcutsWindow.sBody().find('select').each(function(i, item) { selected.push(item.value); });
	var check = selected.filter(function(item, index) { return selected.indexOf(item) !== index; });
	if(check.length > 0) {
		check.forEach(function(item) {
			shortcutsWindow.sBody().find('select option[value="' + item +'"]:selected').closest('div.row > div').addClass('buffNotReady');
			setTimeout(function() { shortcutsWindow.sBody().find('select option[value="' + item +'"]:selected').closest('div.row > div').removeClass('buffNotReady'); }, 2000);
		});
		return;
	}
	var newContentString = JSON.stringify(shortcutsImported.content);
	shortcutsWindow.sBody().find('select').each(function(i, item) {
		var oldId = $(item).closest('div').attr('class').split(' ').pop();
		var re = new RegExp(oldId,"gi");
		newContentString = newContentString.replace(re, item.value);
		delete shortcutsImported.generals[oldId];
	});
	var newContent = JSON.parse(newContentString);
	try
	{
		$.each(newContent, function(item) { 
			$.each(newContent[item], function(spec) { 
				if(shortcutsImported.generals[spec]) {
					delete newContent[item][spec];
					return;
				}
				var specialist = armyGetSpecialistFromID(spec);
				newContent[item][spec].name = specialist.getName(false);
				newContent[item][spec].type = specialist.GetType();
				newContent[item][spec].skills = {};
				specialist.getSkillTree().getItems_vector().forEach(function(skill, index){
					if(skill.getLevel() > 0) { newContent[item][spec].skills[index] = skill.getLevel(); }
				});
			});
			if(Object.keys(newContent[item]) == 0) {
				delete newContent[item];
				return;
			}
		});
	} catch (e) {
		alert(getText("shortImportSmthWrong"));
		return;
	}
	var file = new air.File(); 
	file.addEventListener(air.Event.SELECT, function(event){
		shortcutsImportTree(shortcutsImported.tree, newContent, file.nativePath);
		shortcutsImportData(newContent, file.nativePath, false);
		if(shortcutsImported.description != '') {
			shortcutsImportData({ 'README.txt': shortcutsImported.description.replace(/\n/g, '\r\n') }, file.nativePath, true);
		}
		(shortcutsGetActive() && shortcutsGetActive().items || shortcutsSettings).push(shortcutsImported.tree);
		$('#' + shortcutsWindow.rawsId).modal('hide');
		var actVal = shortcutsWindow.withHeader('#shortcutsSelect').val();
		shortcutsRefresh();
		if(actVal != 'root') {
			shortcutsWindow.withHeader('#shortcutsSelect').val(actVal).change();
		}
		alert(getText("shortImportDone"));
	}); 
	file.browseForDirectory("Select a destination directory"); 
}

function shortcutsImportData(data, path, raw)
{
	$.each(data, function(item) {
		var file = new air.File("file:///" + path + "\\" + item),
			fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.WRITE);
		if(!raw) {
			fileStream.writeUTFBytes(JSON.stringify(data[item], null, " "));
		} else {
			fileStream.writeUTFBytes(data[item]);
		}
		fileStream.close();
	});
}

function shortcutsImportTree(t, content, path)
{
	t.id += Math.floor(Math.random() * 1000) + 1;
	$.each(t.items, function(i) { 
		if(typeof t.items[i] == 'string') { return; }
		if(!Array.isArray(t.items[i])) { 
			shortcutsImportTree(t.items[i], content, path);
			return;
		}
		switch(shortcutsStripType(t.items[i][0])[1]) {
			case 'd ':
			case 'f ':
			case 's ':
			    return;
			default:
				if(!content[t.items[i][0].slice(0, -3)]) {
					delete t.items[i];
					return;
				}
				t.items[i][0] = "{0}\\{1}".format(path, t.items[i][0]);
		}
	});
}

function shortcutsImportProceed(data)
{
	shortcutsImported = data;
	var urlRegex = /(https?:\/\/[^\s]+)/g;
	shortcutsImported.descriptionHtml = shortcutsImported.description.replace(urlRegex, '<a href="$1">$1</a>');
	shortcutsImported.descriptionHtml = shortcutsImported.descriptionHtml.replace(/\n/g, '<br>');
	shortcutsWindow.settings(shortcutsImportFinal, 'modal-lg');
	shortcutsWindow.sDialog().css("height", "90%");
	shortcutsWindow.sTitle().html("<center>{0} {1} ({2} {3})</center>".format(getText("shortImportTitle"), data.tree.name, Object.keys(data.content).length, getText("shortImportTemplate")));
	shortcutsWindow.sFooter().find('.pull-left').addClass('btnSubmit').hide();
	shortcutsWindow.sFooter().append($('<button>').attr({ "class": "btn btn-primary pull-left toggleTransport" }).text(!shortcutsImportTransport ? getText("shortImportTransportUse") : getText("shortImportTransportIgnore")));
	shortcutsWindow.sFooter().append($('<button>').attr({ "class": "btn btn-primary pull-left toggleSkills" }).text(!shortcutsImportSkills ? getText("shortImportSkillsUse") : getText("shortImportSkillsIgnore")));
	shortcutsWindow.sFooter().find('.toggleTransport').click(function() {
		shortcutsImportTransport = !shortcutsImportTransport;
		$(this).text(!shortcutsImportTransport ? getText("shortImportTransportUse") : getText("shortImportTransportIgnore"));
		shortcutsImportGetData();
	});
	shortcutsWindow.sFooter().find('.toggleSkills').click(function() {
		shortcutsImportSkills = !shortcutsImportSkills;
		$(this).text(!shortcutsImportSkills ? getText("shortImportSkillsUse") : getText("shortImportSkillsIgnore"));
		shortcutsImportGetData();
	});
	shortcutsImportGetData();
	$('#' + shortcutsWindow.rawsId).modal({backdrop: "static"});
}

function shortcutsImportGetData()
{
	var out = '';
	var select = shortcutsImportMakeSelect();
	if(shortcutsImported.description != '') {
		out += '<h4>{0}</h4>'.format(loca.GetText("QUL", "TutDetailsTab"));
		out += $('<div>', { 'class': "container-fluid", 'style': "width:100%;height:150px;border:1px solid;border-radius:5px;" }).html(shortcutsImported.descriptionHtml).prop('outerHTML');
	}
	out += "<H4>{0}</H4>".format(getText("shortImportComparator")) + createTableRow([[5, loca.GetText("RES", "General")],[1, loca.GetText("LAB", "ProductionStatus")],[6, loca.GetText("QUL", "GuiDaiTheGoodGenerals")]], true);
	shortcutsImportTotalGens = 0;
	$.each(shortcutsImported.generals, function(item) {
		if(!shortcutsImportTransport && shortcutscSpecialist.GetSpecialistDescriptionForType(shortcutsImported.generals[item].type).isTransportGeneral()) { return; }
		var name = loca.GetText("SPE", shortcutscSpecialist.GetSpecialistDescriptionForType(shortcutsImported.generals[item].type).getName_string());
		shortcutsImportTotalGens++;
		out += createTableRow([
			[5, $('<div>', { 'style': 'line-height: 23px;' }).html(name).prop('outerHTML') + shortcutsImportShowSkills(shortcutsImported.generals[item].skills, shortcutsImported.generals[item].type)],
			[1, "", 'match'],
			[6, shortcutsImportFilterSelect(select, shortcutsImported.generals[item].type) + '<div class="skills" style="text-align: right;"/>', item]
		], false);
	});
	shortcutsWindow.sBody().html($('<div>', { 'class': "container-fluid", 'style': "user-select: none;" }).html(out));
	shortcutsWindow.sBody().find('a').click(function(e) { e.preventDefault(); navigateToURL(this.href); });
	shortcutsWindow.sBody().find('select').change(shortcutsImportMatch);
}

function shortcutsImportShowSkills(skills, type)
{
	var result = '';
	if(shortcutscSpecialist.GetSpecialistDescriptionForType(type).isTransportGeneral()) {
		$.each(shortcutsTransportSkillsVector, function(index, item) {
			if(!skills[index]) { return; }
			result += "&nbsp;&nbsp;&nbsp;&nbsp;{0}&nbsp;{1}&nbsp; >= {2}<br>".format(getImageTag(item.icon_string, '20px', '20px'), loca.GetText("LAB", item.name_string), skills[index]);
		});
	} else {
		$.each(shortcutsSkillsVector, function(index, item) {
			if(!skills[index]) { return; }
			result += "&nbsp;&nbsp;&nbsp;&nbsp;{0}&nbsp;{1}&nbsp; >= {2}<br>".format(getImageTag(item.icon_string, '20px', '20px'), loca.GetText("LAB", item.name_string), skills[index]);
		});
	}
	return result;
}

function shortcutsImportMatch()
{
	var selected = $(this).val();
	var compared = $(this).closest('div').attr('class').split(' ').pop();
	if(selected == 0) { 
		$(this).closest('div.row').find('.match').html("");
		return;
	}
	var spec = armyGetSpecialistFromID($(this).val());
	var match = true;
	var resultSkills = '';
	if(spec != null && shortcutsImportSkills) {
		var skills = spec.getSkillTree().getItems_vector();
		$.each(shortcutsImported.generals[compared].skills, function(index, item) {
			var localMatch = true;
			if(item > skills[index].getLevel()) {
				match = false;
				localMatch = false;
			}
			if(spec.GetSpecialistDescription().isTransportGeneral()) {
				resultSkills += "{0}&nbsp;<font color={3}>{2}</font>&nbsp;{1}&nbsp;&nbsp;&nbsp;&nbsp;<br>".format(skills[index].getLevel(), getImageTag(shortcutsTransportSkillsVector[index].icon_string, '20px', '20px'), loca.GetText("LAB", shortcutsTransportSkillsVector[index].name_string), localMatch ? 'green' : 'red');
			} else {
				resultSkills += "{0}&nbsp;<font color={3}>{2}</font>&nbsp;{1}&nbsp;&nbsp;&nbsp;&nbsp;<br>".format(skills[index].getLevel(), getImageTag(shortcutsSkillsVector[index].icon_string, '20px', '20px'), loca.GetText("LAB", shortcutsSkillsVector[index].name_string), localMatch ? 'green' : 'red');
			}
		});
	}
	$(this).closest('div').find('.skills').html(resultSkills);
	$(this).closest('div.row').find('.match').html(match ? 'ok' : 'fail');
	var check = shortcutsWindow.sBody().find('div.match:contains(ok)');
	if(check.length == shortcutsImportTotalGens) {
		shortcutsWindow.sFooter().find('.btnSubmit').show();
	} else {
		shortcutsWindow.sFooter().find('.btnSubmit').hide();
	}
}

function shortcutsExport()
{
	if(!shortcutsGetActive()) {
		alert("You cant export root");
		return;
	}
	var dataToexport = JSON.parse(JSON.stringify(shortcutsGetActive())),
		skippedTemplates = [],
		exportedContent = {},
		exportStatus = shortcutsExportTree(dataToexport, exportedContent, skippedTemplates);
	if(exportStatus == true) {
		shortcutsWindow.settings(function() { 
			var genData = shortcutsExportGetGens(exportedContent);
			$.each(genData, function(item) {
				delete genData[item].name;
				if(Object.keys(genData[item].skills) == 0) { return; }
				if(!shortcutscSpecialist.GetSpecialistDescriptionForType(genData[item].type).isTransportGeneral()) {
					shortcutsSkipSkills.forEach(function(idx) { delete genData[item].skills[idx]; });
				} else {
					[3,4,5].forEach(function(idx) { delete genData[item].skills[idx]; });
				}
				$('#' + shortcutsWindow.rawsId).find("div." + item.replace('.', '') + " input:not(:checked)").each(function(i, check) { 
					delete genData[item].skills[check.id];
				});
			});
			$.each(exportedContent, function(item) {
				$.each(exportedContent[item], function(spec) { 
					delete exportedContent[item][spec].skills;
					delete exportedContent[item][spec].name;
				});
			});
			shortcutsExportFinal({ 'tree': dataToexport, 'content': exportedContent, 'generals': genData, 'description': shortcutsWindow.sBody().find('#description').val() }); 
		}, '');
		shortcutsWindow.sDialog().css("height", "90%");
		shortcutsWindow.sTitle().html(getText("shortExportTitle"));
		var out = '<h4>{0}</h4>'.format(loca.GetText("QUL", "TutDetailsTab"));
		out += '<textarea maxlength=2000 id="description" style="width:100%;height:100px;background:none;"></textarea>';
		if(skippedTemplates.length > 0) {
			out += '<h4>{0}</h4>'.format(getText("shortExportSkipped"));
			out += createTableRow([[8, getText("shortcutsFilename")],[4, getText("shortExportReason")]], true);
			for(tmpl in skippedTemplates) {
				out += createTableRow([[8, '...' + skippedTemplates[tmpl][0].slice(-40)],[4, skippedTemplates[tmpl][1]]], false);
			}
		}
		
		out += out == '' ? '' : '<h4>{0}</h4>'.format(loca.GetText("LAB", "ToggleOptionsPanel"));
		var genData = shortcutsExportGetGens(exportedContent);
		out += createTableRow([[6, loca.GetText("RES", "General")],[6, getText("shortExportSkills")]], true);
		$.each(genData, function(item) {
			if(Object.keys(genData[item].skills) == 0) { return; }
			var skillTable = exportGenerateSkillsTable(genData[item].skills, genData[item].type);
			if(skillTable == '') { return; }
			out += createTableRow([[6, genData[item].name],[6, skillTable, item.replace('.', '')]], false);
		});
		shortcutsWindow.sBody().html($('<div>', { 'class': "container-fluid", 'style': "user-select: none;cursor:move;" }).html(out));
		$('#' + shortcutsWindow.rawsId).modal({backdrop: "static"});
	}
}

function exportGenerateSkillsTable(skills, type)
{
	var result = '';
	if(shortcutscSpecialist.GetSpecialistDescriptionForType(type).isTransportGeneral()) {
		$.each(shortcutsTransportSkillsVector, function(index, item) {
			if(!skills[index] || /Travel/.test(item.name_string)) { return; }
			result += $('<input>', { 'type': 'checkbox', 'checked': 'checked', 'style': 'width:20px;height:10px;', 'id': index } ).prop('outerHTML');
			result += "{0}&nbsp;{1}&nbsp;({2}/{3})<br>".format(getImageTag(item.icon_string, '20px', '20px'), loca.GetText("LAB", item.name_string), skills[index], item.level_vector.length);
		});
	} else {
		$.each(shortcutsSkillsVector, function(index, item) {
			if(!skills[index] || shortcutsMustHaveSkills.indexOf(index) != -1 || shortcutsSkipSkills.indexOf(index) != -1) { return; }
			result += $('<input>', { 'type': 'checkbox', 'checked': 'checked', 'style': 'width:20px;height:10px;', 'id': index } ).prop('outerHTML');
			result += "{0}&nbsp;{1}&nbsp;({2}/{3})<br>".format(getImageTag(item.icon_string, '20px', '20px'), loca.GetText("LAB", item.name_string), skills[index], item.level_vector.length);
		});
	}
	return result;
}

function shortcutsExportFinal(data)
{
	if($('#' + shortcutsWindow.rawsId).length > 0) {
		$('#' + shortcutsWindow.rawsId).modal('hide');
	}
	data.hash = hash(JSON.stringify(data));
	var file = air.File.documentsDirectory.resolvePath(data.tree.name + '_export.data');
	file.save(JSON.stringify(data));
}

function shortcutsExportTree(t, content, skipped)
{
	for (i in t.items) {
		if(typeof t.items[i] == 'string') { continue; }
		if(!Array.isArray(t.items[i])) { 
			if(!shortcutsExportTree(t.items[i], content, skipped))
				return false;
			continue;
		}
		switch(shortcutsStripType(t.items[i][0])[1]) {
			case 'd ':
			case 'f ':
			case 's ':
			    continue;
			default:
				var data = shortcutsExportGetTemplateData(t.items[i][0].slice(0, -3));
				if(typeof data == 'object') {
					var file = t.items[i][0].split("\\").pop();
					content[file.slice(0, -3)] = data;
					t.items[i][0] = file;
				} else {
					skipped.push([t.items[i][0].slice(0, -3), data]);
					delete t.items[i];
				}
		}
	}
	t.items = t.items.filter(function(e) { return e != null; });
	return true;
}

function shortcutsExportGetTemplateData(filepath)
{
	try {
		var file = new air.File(filepath);
		if(!file.exists) { return getText("buff_not_exist"); }
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.READ);
		var data = fileStream.readUTFBytes(file.size);
		fileStream.close();
		if (data == "") { return getText("shortExportReasonEmpty"); }
		data = JSON.parse(data);
		if(!data[Object.keys(data)[0]].skills || Array.isArray(data[Object.keys(data)[0]].skills)) { return getText("shortExportReasonBadFormat"); }
		return data;
	} catch(e) { return getText("shortExportReasonError"); }
}

function shortcutsExportGetGens(data)
{
	var result = { };
	$.each(data, function(item) { 
		$.each(data[item], function(spec) { 
			result[spec] = { 'type': data[item][spec].type, 'skills': data[item][spec].skills, 'name': data[item][spec].name };
		});
	});
	return result;
}