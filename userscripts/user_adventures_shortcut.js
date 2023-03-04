
var _exudUserAdventureLang = {
	'en-uk': {
		'Options': 'Options',
		'Add' : 'Add',
		'Remove' : 'Remove',
		'Title' : 'Adventure Manager',
		'Filename' : 'Filename',
		'AddError' : 'Description is empty!',
		'AddItem' : 'Add Macro',
		'AutoFree': 'Always Free Units',
		'NoUnitsOnBoard' : 'Army disposed',
		'UnitReady' : 'Army ready',
		'Menuname' : 'Adventures',
		'Command' : 'Command',
		'CannotSet' : 'Something was wrong, cannot load army. Please verify in Specialists/Army (F9)'
		},
	'pt-br' : {
		'Options': 'Opções',
		'Add' : 'Adicionar',
		'Remove' : 'Remover',
		'Title' : 'Gerenciar Aventuras',
		'Filename' : 'Arquivos Macro',
		'AddError' : 'A descrição está vazia!',
		'AddItem' : 'Adicionar Macro',
		'AutoFree': 'Libera sempre as unidades',
		'NoUnitsOnBoard' : 'Unidades liberadas',
		'UnitReady' : 'Generais configurados',
		'Menuname' : 'Aventuras',
		'Command' : 'Comando',
		'CannotSet' : 'Algo deu errado, Nao foi possivel carreagar as unidades. Verificar em Especialistas/Exercito (F9)'
		},
	'ru-ru': {
		'Options': 'Настройки',
		'Add' : 'Добавить',
		'Remove' : 'Удалить',
		'Title' : 'Менеджер приключений',
		'Filename' : 'Файл',
		'AddError' : 'Пустое описание!',
		'AddItem' : 'Добавить макро',
		'AutoFree': 'Всегда выгружать войска',
		'NoUnitsOnBoard' : 'Армия распущена',
		'UnitReady' : 'Армия готова',
		'Menuname' : 'Приключения',
		'Command' : 'Команда',
		'CannotSet' : 'Не все условия выполнены для загрузки армии. Проверьте в ручную в окне армии (F9)'
		}
	};
	extendBaseLang(_exudUserAdventureLang, 'exudUserAdventureLang');

var _exudUserAdventureMainMenuName  = getText('Menuname', 'exudUserAdventureLang');
var _exudUserAdventureButtons = {
	"remove": utils.getImage(new(game.def("GUI.Assets::gAssetManager_ButtonIconThrowAway"))().bitmapData),
	"up": utils.getImage(new(game.def("GUI.Assets::gAssetManager_ArrowSmallNUp"))().bitmapData),
	"down": utils.getImage(new(game.def("GUI.Assets::gAssetManager_ArrowSmallSUp"))().bitmapData)
};
var _exudUserAdventurefileToOpen;
var _exudUserAdventureModalInitialized = false;
var _exudUserAdventureSettings = {
	'Adventures' : [],
	'AutoFree' : false
};

$.extend(_exudUserAdventureSettings, readSettings(null, 'usMKF_Adventures'));

// Creating Adventure Menu Item without function handler but with submenu
const toolsMenu = menu.nativeMenu.getItemByName("Tools");
const toolsItem = new air.NativeMenuItem(_exudUserAdventureMainMenuName);
toolsItem.name = _exudUserAdventureMainMenuName;
toolsItem.submenu = new air.NativeMenu();		
toolsMenu.submenu.addItem(toolsItem);


_exudUserAdventuresMakeMenu()

// regenerate adventures submenu and shortcuts
function _exudUserAdventuresMakeMenu()
{
	var m = [
		{ label: getText('Options', 'exudUserAdventureLang'), onSelect: _exudUserAdventureAddHandler },
		{ label: loca.GetText("LAB","UnloadUnits"), onSelect: _exudUserAdventureFreeAllUnits },
		{ type: 'separator' }
	];
	_exudUserAdventureSettings.Adventures.forEach(function(adv){
		var s = { label: adv.Description, items: [] };
		adv.Items.forEach(function(i) {
			s.items.push({ label: i.split("\\").pop().replace("_", "[UNDERSCORE]"), name: i, onSelect: _exuduserAdventureMenuSelectedHandler });
		});
		m.push(s);
	});
	toolsMenu.submenu.getItemByName(_exudUserAdventureMainMenuName).submenu = air.ui.Menu.createFromJSON(m);
}

// Execute a shortcut
function _exuduserAdventureMenuSelectedHandler(event)
{
	var Text = "";
	try {
		var file = new air.File();
		file.nativePath = event.target.name;
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.READ);
		Text = fileStream.readUTFBytes(file.size);
		fileStream.close();
		if (Text == "") { return; }
		if (_exudUserAdventureSettings.AutoFree)
			_exudUserAdventureFreeAllUnits();
		armyPacket = JSON.parse(Text);
		if(_exuduserAdventurearmyLoadData()) {
			armyLoadGenerals(true);
			game.showAlert(getText('UnitReady', 'exudUserAdventureLang'));
		}
	} catch (e) {
		alert(e);
	}
}

function _exuduserAdventurearmyLoadData()
{
	if(Object.keys(armyPacket).length == 0) {
		return false;
	}
	var canSubmit = true;
	$.each(armyPacket, function(item) { 
		var uniqueID = item.split(".")
		var uniqueIDPacket = game.def("Communication.VO::dUniqueID").Create(uniqueID[0], uniqueID[1]),
		var spec = game.zone.getSpecialist(game.player.GetPlayerId(), uniqueIDPacket);
		if(spec.GetGarrison() == null || spec.GetTask() != null) { canSubmit = false; }
	});
	if (canSubmit)
	{
		var requiredArmy = {};
		$.each(armyPacket, function(item) {
			$.each(armyPacket[item], function(res) {
				if(res == "name") { return; }
				requiredArmy[res] = requiredArmy[res] + armyPacket[item][res] || armyPacket[item][res];
			});
		});
		$.each(requiredArmy, function(item) {
			if(armyFreeInfo[item] < requiredArmy[item]) { canSubmit = false; }
		});
	}
	else
		game.showAlert(getText('CannotSet', 'exudUserAdventureLang'));
	return canSubmit;
}

function _exudUserAdventureFreeAllUnits()
{
	var queue = new TimedQueue(1000);
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
		if (game.player.GetPlayerId() == item.getPlayerID() && item.GetGarrisonGridIdx() > 0 && item.HasUnits() && !item.IsInUse() && !item.isTravellingAway())
		{
			queue.add(function(){ 
				armyMilitarySystem.SendRaiseArmyToServer(game.gi, item, null);
				game.chatMessage(item.getName(false), getText('Menuname', 'exudUserAdventureLang'));
			});
		}
	});
	if(queue.len() > 0)
	{
		queue.run();
		game.showAlert(getText('NoUnitsOnBoard', 'exudUserAdventureLang'));
	}
	
}

// Option menu. Manage adventure shortcuts
function _exudUserAdventureAddHandler(event)
{
	$("div[role='dialog']:not(#UserAdventureModal):visible").modal("hide");
	
	if(!_exudUserAdventureModalInitialized)
		$('#UserAdventureModal').remove();
	
	try{
		if($('#UserAdventureModal .modal-header .container-fluid').length == 0){
			createModalWindow('UserAdventureModal', utils.getImageTag('$ExpeditionAdventure_.png', '45px') + ' ' + getText('Title', 'exudUserAdventureLang'));	
			
			select = $('<select>', { id: 'exudUserAdventureSelect', 'class': "form-control" });
			select.append($('<option>', { value:"---" }).text("---")).prop("outerHTML");
			checkbox = createSwitch("exudUserAdventureFreeChk", _exudUserAdventureSettings.AutoFree);

			$('#UserAdventureModal .modal-header').append(
				'<div class="container-fluid">' 
				+ createTableRow([[2, loca.GetText("LAB","AdventuresHelp")],[6, select.prop("outerHTML")],
				[4, '<div style="position: absolute;left: 55px;top: 1px;">&nbsp;&nbsp;'+getText('AutoFree', 'exudUserAdventureLang')+'</div>' + checkbox]], true)
				+ createTableRow([
						[10, getText('Filename', 'exudUserAdventureLang')],
						[2, getText('Command', 'exudUserAdventureLang')]
					], true)
				+ "</div>"
			);
			$('#UserAdventureModalData').html("<div id='exudUserAdventureRows'/>");
			$('#exudUserAdventureSelect').change(_exudUserAdventureUpdateView);
			
			$('#exudUserAdventureFreeChk').click(function() {
				_exudUserAdventureSettings.AutoFree = !_exudUserAdventureSettings.AutoFree;
			});
			

			$("#UserAdventureModal .modal-footer").prepend([
				$('<button>').attr({ "id": "exudUserAdventureSave", "class": "btn btn-primary exudUserAdventureSave" }).text(loca.GetText("LAB","GuildSave")),
				$('<button>').attr({ "id": "exudUserAdventureAdd","class": "btn btn-primary pull-left"}).text(getText('Add', 'exudUserAdventureLang')),
				$('<button>').attr({ "id": "exudUserAdventureRemove","class": "btn btn-primary pull-left"}).text(getText('Remove', 'exudUserAdventureLang')),
				$('<button>').attr({ "id": "exudUserAdventureAddItem","class": "btn btn-primary pull-left"}).text(getText('AddItem', 'exudUserAdventureLang'))
			]);
			$('#UserAdventureModal .modal-footer #exudUserAdventureRemove, #exudUserAdventureAddItem').hide();
			$('#exudUserAdventureAdd').click(function() {
				var des = prompt("Adventure name", '');
				if(des == null) { return; }
				if (des == "")
				{
					alert(getText('AddError', 'exudUserAdventureLang'));
					return;
				}
				_exudUserAdventureSettings.Adventures.push({
					'UUID' : _exudUseAdventureGenerateUUID(),
					'Description' : des,
					'Items' : new Array()
				});
				_exudUserAdventureRefresh();
			});
			$('#exudUserAdventureAddItem').click(function() {
				var adv = _exudUserAdventureGetActAdv();
				if (adv != null)
				{
					var base = readLastDir('army');
					_exudUserAdventurefileToOpen = air.File.documentsDirectory; 
					if (base != '')
						_exudUserAdventurefileToOpen.nativePath = base;
					_exudUserAdventureselectTextFile(_exudUserAdventurefileToOpen); 
				}
			});
			$('#exudUserAdventureRemove').click(function() {
				var AdvToDisplay = $('#exudUserAdventureSelect option:selected').val();
				for(var i = 0 ; i < _exudUserAdventureSettings.Adventures.length; i++)
					if (_exudUserAdventureSettings.Adventures[i].UUID == AdvToDisplay)
						_exudUserAdventureSettings.Adventures.splice(i, 1);
				_exudUserAdventureRefresh();
			});
			$('#UserAdventureModal .exudUserAdventureSave').click(function(){
				storeSettings(_exudUserAdventureSettings, 'usMKF_Adventures');
				_exudUserAdventuresMakeMenu();
			});
			
			_exudUserAdventureModalInitialized = true;
		}

		_exudUserAdventureRefresh();
	}
	catch (e) {}
	
	$('#UserAdventureModal:not(:visible)').modal({ backdrop: "static" });
}

// Browse files to add a macro to the list

function _exudUserAdventureselectTextFile(root) 
{ 
    var txtFilter = new air.FileFilter("Macro", "*.*"); 
    root.browseForOpen("Open", new window.runtime.Array(txtFilter)); 
    root.addEventListener(air.Event.SELECT, function(event) {
		var filename = _exudUserAdventurefileToOpen.nativePath;
		var adv = _exudUserAdventureGetActAdv();
		if (adv != null)
		{
			adv.Items.push(filename);
			_exudUserAdventureUpdateView();
		}
	}); 
}

// Udate rows
function _exudUserAdventureUpdateView()
{
	
	$( "#_exudAdventureDescription" ).val('');
	$('#exudUserAdventureRows').html("");
	var adv = _exudUserAdventureGetActAdv();
		
	if (adv != null)
	{
		$('#UserAdventureModal .modal-footer #exudUserAdventureRemove, #exudUserAdventureAddItem').show();
		$('#UserAdventureModal .modal-footer #exudUserAdventureAdd').hide();
		$( "#_exudAdventureDescription" ).val(adv.Description);
		if (adv.Items != null && adv.Items.length > 0)
		{
			var out = "";
			adv.Items.forEach(function(i, idx) {
				out += createTableRow([
					[10, i.split("\\").pop()],
					[2, "<a href='#' id='_exudUserAdventureRemoveA_"+idx+"'>"+_exudUserAdventureButtons["remove"]+"</a>" +
						(idx > 0 ? "&nbsp;<a href='#' id='_exudUserAdventureUpA_"+idx+"'>"+_exudUserAdventureButtons["up"]+"</a>" : "") +
						(idx != adv.Items.length - 1 ? "&nbsp;<a href='#' id='_exudUserAdventureDownA_"+idx+"'>"+_exudUserAdventureButtons["down"]+"</a>" : "")
					]
				], false);
			});
			$('#exudUserAdventureRows').html('<div class="container-fluid">{0}</div>'.format(out));
			
			$('#exudUserAdventureRows a[id^="_exudUserAdventureRemoveA_"]').click(function(e){
				var idx = parseInt(e.target.parentNode.id.replace("_exudUserAdventureRemoveA_",""));
				_exudUserAdventureGetActAdv().Items.splice(idx, 1);
				_exudUserAdventureUpdateView();
			});
			$('#exudUserAdventureRows a[id^="_exudUserAdventureUpA_"]').click(function(e){
				var idx = parseInt(e.target.parentNode.id.replace("_exudUserAdventureUpA_",""));
				_exudUserAdventureGetActAdv().Items[idx] = _exudUserAdventureGetActAdv().Items.splice(idx-1, 1, _exudUserAdventureGetActAdv().Items[idx])[0];
				_exudUserAdventureUpdateView();
			});
			$('#exudUserAdventureRows a[id^="_exudUserAdventureDownA_"]').click(function(e){
				var idx = parseInt(e.target.parentNode.id.replace("_exudUserAdventureDownA_",""));
				_exudUserAdventureGetActAdv().Items[idx] = _exudUserAdventureGetActAdv().Items.splice(idx+1, 1, _exudUserAdventureGetActAdv().Items[idx])[0];
				_exudUserAdventureUpdateView();
			});
		}
	} else {
		$('#UserAdventureModal .modal-footer #exudUserAdventureRemove, #exudUserAdventureAddItem').hide();
		$('#UserAdventureModal .modal-footer #exudUserAdventureAdd').show();
	}
	
}
function _exudUserAdventureGetActAdv()
{
	var AdvToDisplay = $('#exudUserAdventureSelect option:selected').val();
	var result = _exudUserAdventureSettings.Adventures.filter(function(e) { return e.UUID == AdvToDisplay; });
	return result.length > 0 ? result[0] : null;
}

// Refresh comboBox and table
function _exudUserAdventureRefresh()
{
	$( "#_exudAdventureDescription" ).val('');
	$('#exudUserAdventureSelect').html("");
	$('#exudUserAdventureSelect').append($('<option>', { value:"---" }).text("---")).prop("outerHTML");
	_exudUserAdventureSettings.Adventures.sort(function(a, b) {
		return a.Description.toUpperCase().localeCompare(b.Description.toUpperCase());
	});

	_exudUserAdventureSettings.Adventures.forEach(function(adv) {
		$('#exudUserAdventureSelect').append($('<option>', { value: adv.UUID }).text(adv.Description)).prop("outerHTML");
	});
	_exudUserAdventureUpdateView();
}

// Generate an UUID
function _exudUseAdventureGenerateUUID() {
    var dt = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (dt + Math.random()*16)%16 | 0;
        dt = Math.floor(dt/16);
        return (c=='x' ? r :(r&0x3|0x8)).toString(16);
    });
	return uuid;
}
