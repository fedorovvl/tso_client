
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
		'ToStar' : 'Return all generals to star',
		'CannotSet' : 'Something was wrong, cannot load army. Please verify in Specialists/Army (F9)',
		'Saved' : 'Saved !'
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
		'CannotSet' : 'Algo deu errado, Nao foi possivel carreagar as unidades. Verificar em Especialistas/Exercito (F9)',
		'Saved' : 'Salvado !'
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
		'ToStar' : 'Вернуть всех генералов в звезду',
		'Menuname' : 'Приключения',
		'Command' : 'Команда',
		'CannotSet' : 'Не все условия выполнены для загрузки армии. Проверьте вручную в окне армии (F9)',
		'Saved' : 'Сохранено !'
		},
	'es-es' : {
		'Options': 'Macros',
		'Add' : 'Nueva aventura',
		'Remove' : 'Eliminar',
		'Title' : 'Ajustes de los Macros de Aventuras',
		'Filename' : 'Nombre del Macro',
		'AddError' : '¡Lo has dejado en blanco!',
		'AddItem' : 'Agregar Macro',
		'AutoFree': 'Descargar unidades siempre',
		'NoUnitsOnBoard' : 'Descargando unidades',
		'UnitReady' : 'Cargando unidades',
		'Menuname' : 'Aventuras',
		'Command' : 'Comando',
		'CannotSet' : "Algo salió mal, no fue posible cargar las unidades. Verifica en Especialistas -> Ejército / (F9)",
		'Saved' : 'Salvado !'
		},
	'fr-fr': {
		'Options': 'Options',
		'Add' : 'Ajouter',
		'Remove' : 'Enlever',
		'Title' : 'Aventure manager ',
		'Filename' : 'nom de fichier',
		'AddError' : 'la description est vide!',
		'AddItem' : 'Ajouter une macro',
		'AutoFree': 'Toujours les unités libres',
		'NoUnitsOnBoard' : 'Armées vidées',
		'UnitReady' : 'Armées prêtes',
		'Menuname' : 'Aventures',
		'Command' : 'Commande',
		'CannotSet' : "Il y a eu un problème, impossible de charger l'armée. Veuillez vérifier dans Spécialistes/Armée (F9)",
		'Saved' : 'Enregistré !'
  		},
	'pl-pl': {
		'Options': 'Opcje',
		'Add': 'Dodaj',
		'Remove': 'Usuń',
		'Title': 'Menedżer przygód',
		'Filename': 'Nazwa pliku',
		'AddError': 'Opis jest pusty!',
		'AddItem': 'Dodaj Makro',
		'AutoFree': 'Zawsze zwalniaj jednostki',
		'NoUnitsOnBoard': 'Armia rozładowana',
		'UnitReady': 'Armia gotowa',
		'Menuname': 'Przygody',
		'Command': 'Komenda',
		'CannotSet': 'Coś nie tak, nie udało się załadować armii. Sprawdź w Specjaliści/Armia (F9)',
		'Saved' : 'Zapisane !'
		},
	'de-de': {
		'Options': 'Optionen',
		'Add' : 'Hinzufügen',
		'Remove' : 'Entfernen',
		'Title' : 'Abenteuer Manager',
		'Filename' : 'Dateiname',
		'AddError' : 'Beschreibung ist leer!',
		'AddItem' : 'Makro hinzufügen',
		'AutoFree': 'Immer Truppen freilassen',
		'NoUnitsOnBoard' : 'Truppen entfernt',
		'UnitReady' : 'Truppen bereit',
		'Menuname' : 'Abenteuer',
		'Command' : 'Befehl',
		'CannotSet' : 'Irgendwas stimmt nicht, konnte Truppe nicht laden. Bitte überprüfe die Truppen unter Spezialisten/Armnee (F9)',
		'Saved' : 'Gerettet !'
		}
	};
	extendBaseLang(_exudUserAdventureLang, 'exudUserAdventureLang');

var _exudUserAdventureMainMenuName  = getText('Menuname', 'exudUserAdventureLang');
var _exudUserAdventureTypes = { '[b]': 'x ', '[a]': '^ ', '[m]': '> ' };
var _exudUserAdventureTypesLang = {'x ': loca.GetText("ACL", "PvPAttacker"), '^ ' : loca.GetText("LAB","Army"), '> ': loca.GetText("LAB", "Move")};
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
var _exudUserAdventuresSPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");


_exudUserAdventuresMakeMenu()

// regenerate adventures submenu and shortcuts
function _exudUserAdventuresMakeMenu()
{
	var m = [
		{ label: getText('Options', 'exudUserAdventureLang'), onSelect: _exudUserAdventureAddHandler },
		{ label: loca.GetText("LAB","UnloadUnits"), onSelect: _exudUserAdventureFreeAllUnits },
		{ label: getText('ToStar', 'exudUserAdventureLang'), onSelect: _exudUserAdventureReturnAll },
		{ type: 'separator' }
	];
	_exudAdventureGenMenuRecursive(_exudUserAdventureSettings.Adventures, m);
	toolsMenu.submenu.getItemByName(_exudUserAdventureMainMenuName).submenu = air.ui.Menu.createFromJSON(m);
}

function _exudAdventureGenMenuRecursive(item, m)
{
	item.forEach(function(adv){
		var s = { label: adv.Description, items: [] };
		adv.Items.forEach(function(i) {
			if(typeof i == 'object') {
				return _exudAdventureGenMenuRecursive([i], s.items);
			}
			if(i == '--sep--') {
				s.items.push({ type: 'separator' });
			} else {
				s.items.push({ label: _exudAdventureStripType(i)[1] + _exudAdventureStripType(i)[0].split("\\").pop().replace(/_/g, "[UNDERSCORE]"), name: i, onSelect: _exuduserAdventureMenuSelectedHandler });
			}
		});
		m.push(s);
	});
}

function _exudAdventureStripType(value)
{
	var possibleType = value.slice(-3);
	if(_exudUserAdventureTypes[possibleType] == null)
		return [value, '^ '];
	return [value.slice(0, -3), _exudUserAdventureTypes[possibleType]]; 
}

// Execute a shortcut
function _exuduserAdventureMenuSelectedHandler(event)
{
	try {
		var filetype = _exudAdventureStripType(event.target.name);
		var file = new air.File();
		file.nativePath = filetype[0];
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.READ);
		var Text = fileStream.readUTFBytes(file.size);
		fileStream.close();
		if (Text == "") { return; }
		_exudUserAdventureProceedFile(JSON.parse(Text), filetype[1]);
	} catch (e) {
		alert(e);
	}
}

function _exudUserAdventureProceedFile(data, type)
{
	switch(type) {
		case '^ ':
			updateFreeArmyInfo(true);
			var checkedPacket = armyLoadDataCheck(data);
			if(checkedPacket.canSubmit = false) {
				game.showAlert(getText('CannotSet', 'exudUserAdventureLang'));
				return;
			}
			armyPacket = data;
			armyLoadGenerals(true);
		break;
		case '> ':
			battlePacket = battleLoadDataCheck(data);
			var canSubmitMove = true;
			$.each(battlePacket, function(item) { 
				if(!battlePacket[item].canSubmitMove) { canSubmitMove = false; }
			});
			if(!canSubmitMove) {
				game.showAlert(getText('CannotSet', 'exudUserAdventureLang'));
				return;
			}
			battleMove(true);
		break;
		case 'x ':
			battlePacket = battleLoadDataCheck(data);
			var canSubmitAttack = true;
			$.each(battlePacket, function(item) { 
				if(!battlePacket[item].canSubmitAttack) { canSubmitAttack = false; }
			});
			if(!canSubmitAttack) {
				game.showAlert(getText('CannotSet', 'exudUserAdventureLang'));
				return;
			}
			battleAttack(true);
		break;
	}
	showGameAlert(getText('command_sent'));
}

function _exudUserAdventureReturnAll()
{
	var queue = new TimedQueue(1000);
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
		if (game.player.GetPlayerId() == item.getPlayerID() && 
		    _exudUserAdventuresSPECIALIST_TYPE.IsGeneral(item.GetType()) && 
			item.GetGarrisonGridIdx() > 0  && !item.IsInUse() && !item.isTravellingAway())
		{
			queue.add(function(){ armySendGeneralToStar(item); });
		}
	});
	if(queue.len() > 0)
	{
		queue.run();
		game.showAlert(getText('NoUnitsOnBoard', 'exudUserAdventureLang'));
	}
}
function _exudUserAdventureFreeAllUnits()
{
	var queue = new TimedQueue(1000);
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
		if (game.player.GetPlayerId() == item.getPlayerID() && 
		    _exudUserAdventuresSPECIALIST_TYPE.IsGeneral(item.GetType()) && 
			item.GetGarrisonGridIdx() > 0  && item.HasUnits() && !item.IsInUse() && !item.isTravellingAway())
		{
			queue.add(function(){ armyMilitarySystem.SendRaiseArmyToServer(game.gi, item, null); });
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
				[4, '']], true)
				+ createTableRow([
						[3, loca.GetText("LAB", "Type")],
						[7, getText('Filename', 'exudUserAdventureLang')],
						[2, getText('Command', 'exudUserAdventureLang')]
					], true)
				+ "</div>"
			);
			$('#UserAdventureModalData').html("<div id='exudUserAdventureRows'/>");
			$('#exudUserAdventureSelect').change(_exudUserAdventureUpdateView);
			
			$('#exudUserAdventureFreeChk').click(function() {
				_exudUserAdventureSettings.AutoFree = !_exudUserAdventureSettings.AutoFree;
			});
			
			var groupSelect = $('<div>', { 'class': 'btn-group' }).append([
				$('<button>').attr({ 
					"id": "exudUserAdventureAddItem",
					"class": "btn btn-success exudUserAdventureAddItem dropdown-toggle",
					'aria-haspopup': 'true',
					'style': 'margin-left: 4px;',
					'aria-expanded': 'false',
					'data-toggle': "dropdown"
				}).text(getText('AddItem', 'exudUserAdventureLang')), 
				$('<div>', {
					'x-placement': 'bottom-start',
					'style': 'position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;',
					'class': 'dropdown-menu'
				}).append([
					$('<li>').html($('<a>', {'href': '#', 'name': 'army'}).text(loca.GetText("LAB","Army"))),
					$('<li>').html($('<a>', {'href': '#', 'name': 'move'}).text(loca.GetText("LAB", "Move"))),
					$('<li>').html($('<a>', {'href': '#', 'name': 'battle'}).text(loca.GetText("ACL", "PvPAttacker"))),
					$('<li>').html($('<a>', {'href': '#', 'name': 'sep'}).text("Separator"))
				])
			]);
			$("#UserAdventureModal .modal-footer").prepend([
				$('<button>').attr({ "id": "exudUserAdventureSave", "class": "btn btn-primary exudUserAdventureSave" }).text(loca.GetText("LAB","GuildSave")),
				$('<button>').attr({ "id": "exudUserAdventureAdd","class": "btn btn-primary pull-left"}).text(getText('Add', 'exudUserAdventureLang')),
				$('<button>').attr({ "id": "exudUserAdventureRemove","class": "btn btn-primary pull-left"}).text(getText('Remove', 'exudUserAdventureLang')),
				groupSelect
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
				var newUUID = _exudUseAdventureGenerateUUID();
				(_exudUserAdventureGetActAdv() && _exudUserAdventureGetActAdv().Items || _exudUserAdventureSettings.Adventures).push({
					'UUID' : newUUID,
					'Description' : des,
					'Items' : new Array()
				});
				_exudUserAdventureRefresh();
				$("#exudUserAdventureSelect").val(newUUID).change();
			});
			$('#UserAdventureModal .modal-footer .dropdown-menu a').click(function() {
				var adv = _exudUserAdventureGetActAdv();
				if (adv != null)
				{
					if(this.name == 'sep') {
						adv.Items.push('--sep--');
						_exudUserAdventureUpdateView();
						return;
					}
					var base = readLastDir(this.name == 'army' ? this.name : 'battle');
					_exudUserAdventurefileToOpen = air.File.documentsDirectory; 
					if (base != '')
						_exudUserAdventurefileToOpen.nativePath = base;
					_exudUserAdventureselectTextFile(_exudUserAdventurefileToOpen, this.name); 
				}
			});
			$('#exudUserAdventureRemove').click(function() {
				var AdvToDisplay = $('#exudUserAdventureSelect option:selected').val();
				for(var i = 0 ; i < _exudUserAdventureSettings.Adventures.length; i++) {
					if (_exudUserAdventureSettings.Adventures[i].UUID == AdvToDisplay) {
						_exudUserAdventureSettings.Adventures.splice(i, 1);
						break;
					}
					_exudUserAdventureRemoveRecursive(_exudUserAdventureSettings.Adventures[i].Items, AdvToDisplay);
				}
				_exudUserAdventureRefresh();
			});
			$('#UserAdventureModal .exudUserAdventureSave').click(function(){
				storeSettings(_exudUserAdventureSettings, 'usMKF_Adventures');
				_exudUserAdventuresMakeMenu();
				game.showAlert(getText('Saved', 'exudUserAdventureLang'));	
			});
			
			_exudUserAdventureModalInitialized = true;
		}

		_exudUserAdventureRefresh();
	}
	catch (e) {}
	
	$('#UserAdventureModal:not(:visible)').modal({ backdrop: "static" });
}

function _exudUserAdventureRemoveRecursive(t, idToRemove) {
	for (i in t) {
		if(typeof t[i] == 'object') {
			if(t[i].UUID == idToRemove) {
				t.splice(i, 1);
				continue;
			}
			_exudUserAdventureRemoveRecursive(t[i].Items, idToRemove);
		}
	}
}
// Browse files to add a macro to the list

function _exudUserAdventureselectTextFile(root, type) 
{ 
    var txtFilter = new air.FileFilter("Macro", "*.*");
    root.browseForOpenMultiple("Open", new window.runtime.Array(txtFilter)); 
    root.addEventListener(window.runtime.flash.events.FileListEvent.SELECT_MULTIPLE, function(event) {
		var adv = _exudUserAdventureGetActAdv();
		if (adv == null) { return; }
		event.files.forEach(function(item) {
			adv.Items.push(item.nativePath + "[{0}]".format(type.charAt(0)));
		});
		_exudUserAdventureUpdateView();
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
		$( "#_exudAdventureDescription" ).val(adv.Description);
		if (adv.Items != null && adv.Items.length > 0)
		{
			var out = "";
			adv.Items.forEach(function(i, idx) {
				if(typeof i == 'object') { 
					out += createTableRow([
						[3, 'Folder'],
						[7, i.Description],
						[2, '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8239;&#8239;' + 
							(idx > 0 ? "&nbsp;<a href='#' id='_exudUserAdventureUpA_"+idx+"'>"+_exudUserAdventureButtons["up"]+"</a>" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8239;&#8239;") +
							(idx != adv.Items.length - 1 ? "&nbsp;<a href='#' id='_exudUserAdventureDownA_"+idx+"'>"+_exudUserAdventureButtons["down"]+"</a>" : "")
						]
					], false);
				} else if(i == '--sep--') {
					out += createTableRow([
						[10, '<hr style="margin: 10px 0;">'],
						[2, "<a href='#' id='_exudUserAdventureRemoveA_"+idx+"'>"+_exudUserAdventureButtons["remove"]+"</a>" +
							(idx > 0 ? "&nbsp;<a href='#' id='_exudUserAdventureUpA_"+idx+"'>"+_exudUserAdventureButtons["up"]+"</a>" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8239;&#8239;") +
							(idx != adv.Items.length - 1 ? "&nbsp;<a href='#' id='_exudUserAdventureDownA_"+idx+"'>"+_exudUserAdventureButtons["down"]+"</a>" : "")
						]
					], false);
				} else {
					var typename = _exudAdventureStripType(i.split("\\").pop());
					out += createTableRow([
						[3, _exudUserAdventureTypesLang[typename[1]]],
						[7, typename[0]],
						[2, "<a href='#' id='_exudUserAdventureRemoveA_"+idx+"'>"+_exudUserAdventureButtons["remove"]+"</a>" +
							(idx > 0 ? "&nbsp;<a href='#' id='_exudUserAdventureUpA_"+idx+"'>"+_exudUserAdventureButtons["up"]+"</a>" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8239;&#8239;") +
							(idx != adv.Items.length - 1 ? "&nbsp;<a href='#' id='_exudUserAdventureDownA_"+idx+"'>"+_exudUserAdventureButtons["down"]+"</a>" : "")
						]
					], false);
				}
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
	}
	
}
function _exudUserAdventureGetActAdv()
{
	var AdvToDisplay = $('#exudUserAdventureSelect option:selected').val();
	var result = _exudUserAdventureGetActAdvRecursive(_exudUserAdventureSettings.Adventures, AdvToDisplay);
	return result;
}

function _exudUserAdventureGetActAdvRecursive(t, s)
{
	var result = null;
	for(n in t) {
		if (t[n].UUID == s) return t[n];
		t[n].Items.forEach(function(item){
			if(typeof item == 'object')
				result = _exudUserAdventureGetActAdvRecursive([item], s) || result;
		});
	};
	return result;
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
	_exudUserAdventureSettings.Adventures.forEach(function(adv){
		$('#exudUserAdventureSelect').append($('<option>', { value: adv.UUID }).text(adv.Description)).prop("outerHTML");
		var dim = [adv.Description];
		var depth = 0;
		for (i in adv.Items) {
			if(typeof adv.Items[i] == 'object') {
				depth = 1;
				_exudUserAdventureRefreshRecursive(adv.Items[i], dim, depth);
			}
		}
	});
	_exudUserAdventureUpdateView();
}

function _exudUserAdventureRefreshRecursive(t, dim, depth)
{
	dim = dim.slice(0, depth);
	dim.push(t.Description);
	$('#exudUserAdventureSelect').append($('<option>', { value: t.UUID }).text(dim.join(" -> "))).prop("outerHTML");
	for (i in t.Items) {
		if(typeof t.Items[i] == 'object') {
			depth++;
			_exudUserAdventureRefreshRecursive(t.Items[i], dim, depth);
		}
	}
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
