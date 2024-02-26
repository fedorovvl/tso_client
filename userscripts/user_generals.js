
// ========== Generals COMMAND
const _exudGeneralsLang = {
	"en-uk": {
		"ByName": "Sort by Name",
		"ByType": "Sort by Type",
		"ShowGuest": "Show Guests",
		"HideGuest": "Hide Guests",
		"ShowUnselected": "Show Unselected",
		"HideUnselected": "Hide Unselected",
		"SelectAll": "Select All",
		"Load": "Load",
		"CommandSent": "Command sent",
		"ColumnOwner": "Owner",
		"ColumnTimeToZone": "To Zone",
		"IsGuest": " (* guest) ",
		"SelectedFirst": "Selected First",
		"ExcludeStarMenu": "Exclude Star Menu",
		"SkillTip": "Click on general icon to open the Skill Tree."
	},
	"pt-br": {
		"ByName": "Classificar por nome",
		"ByType": "Classificar por tipo",
		"ShowGuest": "Todos",
		"HideGuest": "Excluir outros jogadores",
		"ShowUnselected": "Todos",
		"HideUnselected": "Somente selecionados",
		"SelectAll": "Selecionar todos",
		"Load": "Carregar",
		"ColumnOwner": "Proprietario",
		"IsGuest": " (* = convidado) ",
		"SelectedFirst": "Selecionado primeiro",
		"ExcludeStarMenu": "Excluir Menu Estrela",
		"SkillTip" : "Clicar no icone do general para abrir a arvore das abilidades"
	},
	"pl-pl": {
		"ByName": "Sortuj po nazwie",
		"ByType": "Sortuj po typie",
		"ShowGuest": "Pokaż gości",
		"HideGuest": "Ukryj gości",
		"ShowUnselected": "Pokaż niezaznaczonych",
		"HideUnselected": "Ukryj niezaznaczonych",
		"SelectAll": "Zaznacz wszystkich",
		"Load": "Załaduj",
		"CommandSent": "Generał wysłany",
		"ColumnOwner": "Właściciel",
		"IsGuest": " (* = gość) ",
		"SelectedFirst": "Zaznaczeni na górze",
		"ExcludeStarMenu": "Nie pokazuj tych z gwiazdy",
		"SkillTip": "Kliknij na ikonie generała, aby zobaczyć drzewo umiejętności."
	},
	"ru-ru": {
		"ByName": "Сортировать по имени",
		"ByType": "Сортировать по типу",
		"ShowGuest": "Показать генералов гостя",
		"HideGuest": "Спрятать генералов гостя",
		"ShowUnselected": "Показать всех",
		"HideUnselected": "Показать отмеченных",
		"SelectAll": "Выбрать всех",
		"Load": "Загрузить",
		"CommandSent": "Отправить",
		"ColumnOwner": "Владелец",
		"IsGuest": " (* = гостевой) ",
		"SkillTip": "Нажмите на иконку генерала чтобы открыть его дерево навыков",
		"SelectedFirst": "Выбранные в начале",
		"ExcludeStarMenu": "Без звездного меню",
    },
	"fr-fr": {
		"ByName": "Trier par Nom",
		"ByType": "Trier par Type",
		"ShowGuest": "Afficher Invité",
		"HideGuest": "Masquer Invité",
		"ShowUnselected": "Afficher Tout",
		"HideUnselected": "Afficher Sélection",
		"SelectAll": "Sélectionner Tout",
		"Load": "Charger",
		"CommandSent": "Envoyer",
		"ColumnOwner": "Propriétaire",
		"IsGuest": " (* Invité) ",
		"SelectedFirst": "Sélection en Premier",
		 "ExcludeStarMenu": "Masquer les Généraux en Etoile",
		 "SkillTip" : "Cliquer sur Général pour voir ses compétences."
	},
	"it-it": {
		"ByName": "Ordina per nome",
		"ByType": "Ordina per tipo",
		"ShowGuest": "Di tutti",
		"HideGuest": "Escludi altri giocatori",
		"ShowUnselected": "Tutti",
		"HideUnselected": "Solo selezionati",
		"SelectAll": "Seleciona tutto",
		"Load": "Apri",
		"ColumnOwner": "Proprietario",
		"IsGuest": " (* = invitato) "
	},
	"es-es": {
		"ByName": "Ordenar por nombre",
		"ByType": "Ordenar por tipo",
		"ShowGuest": "Ver generales de amigos",
		"HideGuest": "Esconder generales de amigos",
		"ShowUnselected": "Mostrar no seleccionados",
		"HideUnselected": "Esconder no seleccionados",
		"SelectAll": "Seleccionar todos",
		"Load": "Cargar",
		"CommandSent": "Comando enviado",
		"ColumnOwner": "Propietario",
		"IsGuest": " (* = invitado) ",
		"SelectedFirst": "Mostrar seleccionados primero",
		"ExcludeStarMenu": "No mostrar generales en estrella",
		"SkillTip" : "Haz click en el icono del general para ver su árbol de habilidades."
	},
	"es-mx": {
		"ByName": "Ordenar: Nombre",
		"ByType": "Ordenar: Tipo",
		"ShowGuest": "Ver generales de amigos",
		"HideGuest": "Ver solo los míos",
		"ShowUnselected": "Todos",
		"HideUnselected": "Seleccionados",
		"SelectAll": "Seleccionar todos",
		"Load": "Cargar",
		"CommandSent": "Comando enviado",
		"ColumnOwner": "Propietario",
		"IsGuest": " (* = invitado) "
    },
	"de-de": {
		"ByName": "Name sortieren",
		"ByType": "Type sortieren",
		"ShowGuest": "Gäste zeigen",
		"HideGuest": "Gäste verbergen",
		"ShowUnselected": "Unmarkierte zeigen",
		"HideUnselected": "Unmarkierte verbergen",
		"SelectAll": "Alles auswählen",
		"Load": "Laden",
		"CommandSent": "Befehl gesendet",
		"ColumnOwner": "Besitzer",
		"IsGuest": " (* Gast) ",
		"SelectedFirst": "erst auswählen",
		"ExcludeStarMenu": "Sternemenü verbergen",
		"SkillTip": "Klicke auf den General um den Skill zu sehen."
	}
};
var _exudGeneralsButtons = {
	"...": utils.getImage(new(game.def("GUI.Assets::gAssetManager_ButtonContextMenuHighlight"))().bitmapData)
};
var _exudGeneralsTemplates;
var _exudGeneralsOpening = false;
var _exudGeneralsSortField = { 'key': 0, 'order': false }
var _exudGeneralsModalInitialized = false;
var _exudGeneralsModalInitializingWithTemplate = false;
const playerId = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
var _exudGeneralsSortingFromTemplate = null;

// inital settings
var _exudGeneralsSettings = {
	'_exudGeneralsSortType' : 1,
	'_exudGeneralsHideUnselected' : false,
	'_exudGeneralsHideGuest' : true,
	'_exudGeneralsSelectedFirst' : false,
	'_exudGeneralsExcludeStarMenu' : false,
	'_exudGeneralsArmySorted' : false,
	'_exudGeneralsShortcuts' : false,
	'_exudGeneralsShortcutsRoot' : ''
}
$.extend(_exudGeneralsSettings, readSettings(null, 'usMKF_Generals'));
_exudGeneralsMakeMenu();


function _exudGeneralsMakeMenu()
{
	try{
		var toolsMenu = menu.nativeMenu.getItemByName("Tools");
		var toolsItem = new air.NativeMenuItem(loca.GetText("ACL", "MilitarySpecialists"));
		toolsItem.name = loca.GetText("ACL", "MilitarySpecialists");
		
		if (!_exudGeneralsSettings._exudGeneralsShortcuts) {
			toolsItem.data = { 'item': { 'onSelect': _exudGeneralsMenuHandler } };
			toolsItem.addEventListener(air.Event.SELECT, _exudGeneralsMenuHandler);
		}

		toolsMenu.submenu.addItem(toolsItem);
		
		if (_exudGeneralsSettings._exudGeneralsShortcuts)
			_exudGeneralsMakeSubMenu();
	}
	catch (e)
	{
	}
}
function _exudGeneralsRemakeMenuHandler(event){
	_exudGeneralsRemakeMenu();
}

function _exudGeneralsRemakeMenu()
{
	try{
		if (_exudGeneralsSettings._exudGeneralsShortcuts)
			_exudGeneralsMakeSubMenu();
		else
		{
			var toolsMenu = menu.nativeMenu.getItemByName("Tools");
			var myMenuItem = toolsMenu.submenu.getItemByName(loca.GetText("ACL", "MilitarySpecialists"));
			var Idx = toolsMenu.submenu.getItemIndex(myMenuItem);
			toolsMenu.submenu.removeItem(myMenuItem);
			
			myMenuItem = new air.NativeMenuItem(loca.GetText("ACL", "MilitarySpecialists"));
			myMenuItem.name = loca.GetText("ACL", "MilitarySpecialists");
			myMenuItem.addEventListener(air.Event.SELECT, _exudGeneralsMenuHandler);
			myMenuItem.data = { 'item': { 'onSelect': _exudGeneralsMenuHandler } };
			toolsMenu.submenu.addItem(myMenuItem);
			toolsMenu.submenu.setItemIndex(myMenuItem, Idx);
		}
	}
	catch (e) {
		alert(e);
	}
}

function _exudGeneralsMakeSubMenu()
{
	try{
		var homeDir = _exudGeneralsSettings._exudGeneralsShortcutsRoot;
		var toolsMenu = menu.nativeMenu.getItemByName("Tools");
		
		var m = [
			{ label: loca.GetText("ACL", "MilitarySpecialists"), onSelect: _exudGeneralsMenuHandler },
			//{ label: loca.GetText("LAB", "Update"), onSelect: _exudGeneralsRemakeMenuHandler },
			{ type: 'separator' }
		];
		if (homeDir != "")
		{
			_exudGeneralsMakeSubMenuRecursive(homeDir, m);
		}

		toolsMenu.submenu.getItemByName(loca.GetText("ACL", "MilitarySpecialists")).submenu = air.ui.Menu.createFromJSON(m);
	}
	catch (e)
	{
		alert(e);
	}

}
function _exudGeneralsMakeSubMenuRecursive(dir, m)
{
	air.File.applicationDirectory.resolvePath(dir).getDirectoryListing().forEach(function(i){ 
		if (i.isDirectory)
		{
			var s = { label: i.name, items: [] };
			_exudGeneralsMakeSubMenuRecursive(dir + "/" + i.name, s.items);	
			m.push(s);			
		}
		else
			m.push({ label: i.name.split("\\").pop().replace("_", "[UNDERSCORE]").replace(".txt",""), name: dir + "/" + i.name, onSelect: _exudGeneralsMenuSelectedHandler });
	});
}
function _exudGeneralsMenuSelectedHandler(event)
{
	
	var Text =  event.target.name;
	
	try {
		var file = new air.File();
		file.nativePath = event.target.name;
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.READ);
		Text = fileStream.readUTFBytes(file.size);
		fileStream.close();
		if (Text == "") { return; }
		
		tdata = JSON.parse(Text);
		
		//$( "#udGeneralsModal").modal("show");
		_exudGeneralsModalInitializingWithTemplate = true;
		_exudGeneralsMenuHandler(null);
		_exudGetGeneralsData(tdata);
		_exudGeneralsModalInitializingWithTemplate = false;
		/*
		if(!_exudGeneralsModalInitialized)			
		{
			_exudGeneralsModalInitializingWithTemplate = true;
			_exudGeneralsMenuHandlerFunc();
			_exudGetGeneralsData(tdata);
			_exudGeneralsModalInitializingWithTemplate = false;
		}
		else
			_exudMakeGeneralsTable(tdata);
		*/
		_exudGeneralsSetSendTypes();
		
	} catch (e) {
	}
	
}
function _exudGeneralsMenuHandler(event)
{
	_exudGeneralsMenuHandlerFunc();
}
function _exudGeneralsMenuHandlerFunc()
{
	$( "div[role='dialog']:not(#udGeneralsModal):visible").modal("hide");
	_exudGeneralsOpening = true;	

try {
	if(!_exudGeneralsModalInitialized || $('#udGeneralsModal .modal-header .container-fluid').length > 0 )
	{
		$('#udGeneralsStyle').remove();
		$('#udGeneralsModal').remove();

		createModalWindow('udGeneralsModal', loca.GetText("ACL", "MilitarySpecialists"));
		
		_exudGeneralsTemplates = new SaveLoadTemplate('genspec', function(data) {_exudMakeGeneralsTable(data);	},	_exudGeneralsRemakeMenu	);
		if($('#udGeneralsStyle').length == 0)
		{
			$("head").append($("<style>", { 'id': 'udGeneralsStyle' }).text('.dropdown-toggle::after {display: inline-block;width: 0;height: 0;margin-left: .255em;vertical-align: .255em;content: ""; border-top: .3em solid;border-right: .3em solid transparent;  border-bottom: 0; border-left: .3em solid transparent;}#udGeneralsModal .modal-content{height: 90%;}.CellWithComment{position:relative;}#_exudGeneralsSkillTree{position:absolute; top: 1; left: 1; color: black; background: #B2A589; font-weight: bold; display:none; border : thick solid #000000 ; border-width: 2px; width:210px;} div .row:hover {background-color: #A65329;}'));
		}
		
		var groupSend = $('<div>', { 'class': 'btn-group' }).append([
			$('<button>').attr({ 
				"id": "_exudGeneralsSendGeneralsBtn",
				"class": "btn btn-success _exudGeneralsSendGeneralsBtn dropdown-toggle",
				'aria-haspopup': 'true',
				'aria-expanded': 'false',
				'data-toggle': "dropdown"
			}).text(loca.GetText("LAB", "Send")), 
			$('<div>', {
				'x-placement': 'bottom-start',
				'style': 'position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;',
				'class': 'dropdown-menu'
			})
		]);
		$("#udGeneralsModal .modal-footer").prepend([
			$('<button>').attr({ "id": "_exudGeneralsSaveTemplateBtn", "class": "btn btn-primary pull-left _exudGeneralsSaveTemplateBtn" }).text(getText('save_template')),
			$('<button>').attr({ "id": "_exudGeneralsLoadTemplateBtn", "class": "btn btn-primary pull-left _exudGeneralsLoadTemplateBtn" }).text(getText('load_template')),
			$('<button>').attr({ "id": "_exudGeneralRefreshBtn", "class": "btn btn-primary pull-left _exudGeneralRefreshBtn" }).text(loca.GetText("LAB", "Update")),
			$('<span>').text(_exudGeneralsGetLabel("IsGuest")),
			groupSend
		]);

		$("#udGeneralsModal .modal-footer").append('<p align="left" style="font-size: 10px">* {0}</p>'.format(_exudGeneralsGetLabel("SkillTip")));

		$('#udGeneralsModal ._exudGeneralsLoadTemplateBtn').click(function() { _exudGeneralsTemplates.load(); });

		$('#udGeneralsModal ._exudGeneralsSaveTemplateBtn').click(function(){
			var dataToSave = [];
			$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) {
				if(item.checked) {
					dataToSave.push(item.id);
				}
			});
			
			if (dataToSave.length > 0)
				_exudGeneralsTemplates.save(dataToSave);
		});

		_exudGetGeneralsTitle(0);

		var out = '<div class="container-fluid">';

		_exudGeneralsSetSendTypes();

		out += '<div id="topRowWithIcons" class="text-center" style="display: none;"></div>';

		var massCheckbox = $('<input>', { 'type': 'checkbox', 'class': '_exudSelectAllGeneralsBtn', 'data-toggle': 'tooltip', 'data-placement': 'top', 'title': _exudGeneralsGetLabel('SelectAll') }).prop('outerHTML') + '&nbsp;&nbsp;';
		if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone) {
		    out += createTableRow([
			[7, _exudGeneralsCreateSortingField("&#8597;&nbsp;" + massCheckbox) + _exudGeneralsCreateSortingField(loca.GetText("LAB","Name"))],
			[2, _exudGeneralsCreateSortingField(loca.GetText("LAB", "StarMenu"))],
			[1, _exudGeneralsCreateSortingField(loca.GetText("LAB", "Army"))],
			[1, _exudGeneralsGetLabel("ColumnOwner")],
			[1, _exudGeneralsGetLabel("ColumnTimeToZone")]
		    ], true) ;
		} else {
		    out += createTableRow([
			[9, _exudGeneralsCreateSortingField("&#8597;&nbsp;" + massCheckbox) + _exudGeneralsCreateSortingField(loca.GetText("LAB","Name"))],
			[2, _exudGeneralsCreateSortingField(loca.GetText("LAB", "StarMenu"))],
			[1, _exudGeneralsCreateSortingField(loca.GetText("LAB", "Army"))]
		    ], true) ;
		}
		out += '</div>';
		
		$('#udGeneralsModal .modal-header').append(out);
	
		$('#udGeneralsModal .modal-header .row a').click(_exudGeneralsChangeSortingField);		
		
		$('[data-toggle="tooltip"]').tooltip({container: 'body'});
		$('#udGeneralsModal ._exudSelectAllGeneralsBtn').change(function() {
			_exudGeneralsSettings._exudGeneralsToggleselected = !_exudGeneralsSettings._exudGeneralsToggleselected;
			$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) {
				item.checked = _exudGeneralsSettings._exudGeneralsToggleselected;
			});
		});
		$('#udGeneralsModal ._exudGeneralRefreshBtn').click(function(){
			_exudMakeGeneralsTable();
			showGameAlert(getText('command_sent'));
		});

		$('#topRowWithIcons').on('click', '.selectSpecificGeneralType', function(event) {
		    var iconId = $(event.target).parent().attr('icon-id'),
			generals = $('#udGeneralsModalData input[type="checkbox"][icon-id="' + iconId +'"]');
		    if (generals.length > 0) {
			var isSelected = generals.filter(':checked').length !== generals.length;
			generals.each(function(i, item) {
			    item.checked = isSelected;
			});
		    }
		});
		if (!_exudGeneralsModalInitializingWithTemplate)
			_exudGetGeneralsData();
		_exudGeneralsModalInitialized = true;
	}
	else
		_exudMakeGeneralsTable();
}
catch (egen) {}	
	$('#udGeneralsModal:not(:visible)').modal({backdrop: "static"});	
	_exudGeneralsOpening = false;
}

function _exudGeneralsSetSendTypes()
{
	try
	{
		var AdvManager = swmmo.getDefinitionByName("com.bluebyte.tso.adventure.logic::AdventureManager").getInstance(),
			currentViewedZoneId = swmmo.application.mGameInterface.mCurrentViewedZoneID;
		$("#udGeneralsModal .dropdown-menu").html($('<li>').html($('<a>', {'href': '#', 'value': '98'}).text(loca.GetText("LAB", "StarMenu"))));

		if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone){
			$("#udGeneralsModal .dropdown-menu").append($('<li>').html($('<a>', {'href': '#', 'value': swmmo.application.mGameInterface.mCurrentPlayer.GetHomeZoneId()}).text(loca.GetText("LAB", "ReturnHome"))));
		}

		AdvManager.getAdventures().forEach(function(item){
			if (item.zoneID !== currentViewedZoneId) {
				$("#udGeneralsModal .dropdown-menu").append($('<li>').html($('<a>', {'href': '#', 'value': item.zoneID}).text((item.ownerPlayerID !== playerId ? '*' : '') + loca.GetText("ADN", item.adventureName))));
			}
		});
		
		$('#udGeneralsModal .dropdown-menu a').click(_exudGeneralsSend);
	} catch (error) {
		alert("Err (retry): " + error.message);
	}
}

function _exudGeneralsGetLabel(id)
{
	if(!_exudGeneralsLang[gameLang] && !_exudGeneralsLang["en-uk"][id]) { return "RES not found : " + id; }
	txt = _exudGeneralsLang[gameLang] && _exudGeneralsLang[gameLang][id] ? _exudGeneralsLang[gameLang][id] : _exudGeneralsLang["en-uk"][id];
	return txt == undefined ? id : txt;
}

function _createTopRowWithIcons(generalsIconsList) {
    var output = '';
    generalsIconsList.forEach(function(iconID){
        output += '<a href="#" class="selectSpecificGeneralType" icon-id="{0}">{1}</a>'.format(iconID, getImageTag(iconID, '24px', '24px'));
    });
    return output;
}

function _exudGeneralsCreateSortingField(name)
{
	var field = $('<a>', { 'style': 'cursor: pointer;text-decoration:none;color:#000;' }).html(name).prop('outerHTML');
	return field ;
}
function _exudGeneralsChangeSortingField(e)
{
	var selfIndex = $(this).parent().index();
	var selfSubIndex = $(this).index();
	switch(selfIndex)	{
		case 0 :
			switch (selfSubIndex)
			{
				case 0:
					_exudGeneralsSettings._exudGeneralsSelectedFirst = !_exudGeneralsSettings._exudGeneralsSelectedFirst;
					break;
				case 1 :
					if (++_exudGeneralsSettings._exudGeneralsSortType == 2)
						_exudGeneralsSettings._exudGeneralsSortType = 0;
					break;	
			}
			break;
		case 1 :
			_exudGeneralsSettings._exudGeneralsExcludeStarMenu = !_exudGeneralsSettings._exudGeneralsExcludeStarMenu;
			break;	
		case 2 :
			_exudGeneralsSettings._exudGeneralsArmySorted = !_exudGeneralsSettings._exudGeneralsArmySorted;
			break;	
	}

	_exudGeneralsSortField['key'] = selfIndex;
	_exudMakeGeneralsTable();

}
function _exudGetGeneralsTitle(generalCount)
{
	var pname = "";
	if (!swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone &&
		!swmmo.application.mGameInterface.isOnHomzone())
	{
		try{
			pname = swmmo.application.mGameInterface.mHomePlayer.GetPlayerName_string() + " - " + swmmo.application.mGameInterface.mHomePlayer.GetPlayerLevel();
		}
		catch(e) {}
	}
	$('#udGeneralsModal .modal-title').html( getImageTag('icon_general.png') + loca.GetText("ACL", "MilitarySpecialists") + (generalCount>0 ? " ("+generalCount+")" : "") + (pname != "" ? " (" + pname + ")" : ""));
	$("#udGeneralsModal .modal-title").append($('<button>').attr({ "class": "btn btn-settings pull-right" }).text(loca.GetText("LAB", "ToggleOptionsPanel")));
	$('#udGeneralsModal .btn-settings').click(_exudGeneralsOptions);
}

function _exudGeneralsSaveSettings()
{
	try
	{
		storeSettings(_exudGeneralsSettings, 'usMKF_Generals');
		$('#udGeneralsModalsettings').modal("hide");
		_exudGeneralsRemakeMenu();
	} catch (e) {
		alert(e.message);
	}
}
var ShortcutDirSelected = null;

function _exudGeneralsOptions()
{
	createSettingsWindow('udGeneralsModal', _exudGeneralsSaveSettings,  'modal-sm');
	$('#udGeneralsModalsettingsData').html(_exudGeneralsOptionsCreateSettings());
	$('#udGeneralsModalsettingsData').css("height", "300px");
	$('#udGeneralsModalsettings').css("height", "900px");
	$('#udGeneralsModalsettings:not(:visible)').modal({backdrop: "static"});

	$('#_exudChangeGeneralSortFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		if (++_exudGeneralsSettings._exudGeneralsSortType == 2)	_exudGeneralsSettings._exudGeneralsSortType = 0;
		_exudMakeGeneralsTable();
	});
	$('#_exudHideUnselectedGeneralsFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsSettings._exudGeneralsHideUnselected = !_exudGeneralsSettings._exudGeneralsHideUnselected;
		_exudMakeGeneralsTable();
	});
	$('#_exudHideGuestGeneralsFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsSettings._exudGeneralsHideGuest = !_exudGeneralsSettings._exudGeneralsHideGuest;
		_exudMakeGeneralsTable();
	});
	$('#_exudGeneralsExcludeStarMenuFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsSettings._exudGeneralsExcludeStarMenu = !_exudGeneralsSettings._exudGeneralsExcludeStarMenu;
		_exudMakeGeneralsTable();
	});
	$('#_exudGeneralsSelectedFirstBtn').click(function() {
		_exudGeneralsSettings._exudGeneralsSelectedFirst = !_exudGeneralsSettings._exudGeneralsSelectedFirst;
		_exudMakeGeneralsTable();
	});
	$('#_exudGeneralsShortcutsBtn').click(function() {
		_exudGeneralsSettings._exudGeneralsShortcuts = !_exudGeneralsSettings._exudGeneralsShortcuts;
		_exudGeneralsRemakeMenu();
	});
	$('#_exudGeneralsShortcutsDirBtn').click(function() {
		try{
			ShortcutDirSelected = air.File.applicationDirectory; 
			if (_exudGeneralsSettings._exudGeneralsShortcutsRoot != "")
				ShortcutDirSelected = ShortcutDirSelected.resolvePath(_exudGeneralsSettings._exudGeneralsShortcutsRoot);
			ShortcutDirSelected.addEventListener(air.Event.SELECT, _exudGeneralsOptionsdirSelected); 
			ShortcutDirSelected.browseForDirectory("Select a directory"); 
		}
		catch (e) {
		}	
	});
}

function _exudGeneralsOptionsdirSelected(event) 
{ 
    _exudGeneralsSettings._exudGeneralsShortcutsRoot = ShortcutDirSelected.nativePath; 
}
function _getSettingsRow(switchName, switchValue, labelId, btnText, btnId) {
	return [
		'<div style="float: clear">',
		'<div style="float: left;">' + createSwitch(switchName, switchValue) + '</div>',
		'<div>&nbsp;&nbsp;' + _exudGeneralsGetLabel(labelId) + 
		(btnText ? "&nbsp;&nbsp;<a href='#' id='"+btnId+"'>"+_exudGeneralsButtons[btnText]+"</a>" : "") + '</div>',
		'</div><br/>'
	].join('');
}

function _exudGeneralsOptionsCreateSettings() {
	var out = '';
	try {
		out += _getSettingsRow('_exudChangeGeneralSortFloatBtn', _exudGeneralsSettings._exudGeneralsSortType === 1, "ByName");
		out += _getSettingsRow('_exudHideGuestGeneralsFloatBtn', _exudGeneralsSettings._exudGeneralsHideGuest, "HideGuest");
		out += _getSettingsRow('_exudHideUnselectedGeneralsFloatBtn', _exudGeneralsSettings._exudGeneralsHideUnselected, "HideUnselected");
		out += _getSettingsRow('_exudGeneralsExcludeStarMenuFloatBtn', _exudGeneralsSettings._exudGeneralsExcludeStarMenu, "ExcludeStarMenu");
		out += _getSettingsRow('_exudGeneralsSelectedFirstBtn', _exudGeneralsSettings._exudGeneralsSelectedFirst, "SelectedFirst");
		out += _getSettingsRow('_exudGeneralsShortcutsBtn', _exudGeneralsSettings._exudGeneralsShortcuts, loca.GetText("HIL", "Help_window_shortcuts_0"), '...','_exudGeneralsShortcutsDirBtn');
	} catch (e) { alert(e.message); }
	return out;
}

function _exudGetGeneralsData(templateData)
{
	var out = $('<div>', { 'class': 'container-fluid', 'id': 'exGeneralsMainDiv' }).append([
		$('<div>', { 'id': '_exudGeneralsDivTable' }),
		$('<div>', { 'class': 'modal-dialog _exudGeneralsSkillTree', 'id': '_exudGeneralsSkillTree' })
	]);
	$('#udGeneralsModalData').html(out.prop('outerHTML'));

	_exudMakeGeneralsTable(templateData);
}

function _exudMakeGeneralsTable(templateData)
{
	var out = "";

	try {
		var selectedGenerals = !templateData ? _exudGeneralsGetChecked() : templateData,
		    myGens = 0,
		    uniqueIconIDs = [],
		    checkbox;
		if (templateData && _exudGeneralsSettings._exudGeneralsSelectedFirst)
			_exudGeneralsSortingFromTemplate = templateData;

		_exudGetSpecialists().forEach(function(item){
			try {
				var isSelected = selectedGenerals.indexOf(item.UID) >= 0;
				if (
				    (_exudGeneralsSettings._exudGeneralsHideGuest && !item.Owner) ||
				    (_exudGeneralsSettings._exudGeneralsExcludeStarMenu && (item.GridPosition < 1) && !isSelected) ||
				    (_exudGeneralsSettings._exudGeneralsHideUnselected && !isSelected)
				) {
				    return;
				}
				if (item.Owner) {
				    ++myGens;
				}
				if (uniqueIconIDs.indexOf(item.IconID) < 0) {
				    uniqueIconIDs.push(item.IconID);
				}
				var tooltip = loca.GetText("HIL", "Help_window_skilltrees_0");

				var Icon =  item.Icon.replace('<img','<img id="exudSTIMG'+item.UID+'"').replace('style="', 'style="cursor:pointer;');
				var IconMap = "";
				if (item.GridPosition > 0)
					IconMap = getImageTag("accuracy.png", '24px', '24px').replace('<img','<img id="exudSTGENPOS'+item.UID+'"').replace('style="', 'style="cursor: pointer;')
					checkbox = '<input type="checkbox" id="{0}" icon-id="{1}"{2}/> {3}'.format(
						item.UID,
						item.IconID,
						isSelected ? ' checked' : '',
						Icon + item.Name
					);

				if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone)
				{
					out += createTableRow([
						[7, !_exudGeneralsIsSelectable(item) ? '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + Icon + item.Name  + (item.PlayerName != null ? ' (' + item.PlayerName + ')' : '' ): checkbox],
						[2, (item.GridPosition <= 0 ? loca.GetText("LAB", "YES"): '')],
						[1, (item.TotalArmy>0?item.TotalArmy:'')],
						[1, (item.Owner ? loca.GetText("LAB", "YES"): IconMap)],
						[1, GetTravelTime(item)]
					]);
				}
				else{
						out += createTableRow([
						[9, !_exudGeneralsIsSelectable(item) ? '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + Icon + item.Name : checkbox],
						[2, (item.GridPosition <= 0 ? loca.GetText("LAB", "YES"): IconMap)],
						[1, (item.TotalArmy>0?item.TotalArmy:'')]
					]);
				}
			}
			catch (e) {
				//alert("MGT: " + e.message);
			}
		});

		_exudGetGeneralsTitle(myGens);
	}
	catch (e) {
		alert(e.message);
	}
	_exudGeneralsSortingFromTemplate = null;
	$('#_exudGeneralsDivTable').html(out);
	$('#topRowWithIcons').html('').hide();
	if (uniqueIconIDs.length > 0) {
        $('#topRowWithIcons').html(_createTopRowWithIcons(uniqueIconIDs)).show();
    }
	$('#_exudGeneralsDivTable img[id^="exudSTIMG"]').click(_exudGeneralsOpenSkillTree);
	$('#_exudGeneralsDivTable img[id^="exudSTGENPOS"]').click(_exudGeneralsGoToMap);
}
function _exudGeneralsGoToMap(e)
{
	try {
		var Spec = _exudGeneralsFindByID(e.target.id.replace("exudSTGENPOS",""));
		if (Spec != null)
			swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(Spec.GetGarrisonGridIdx());
	} catch (e) {}
}

function _exudGeneralsOpenSkillTree(e)
{
	try {
		var Spec = _exudGeneralsFindByID(e.target.id.replace("exudSTIMG",""));
		if (Spec != null)
		{
			var General = _exudGeneralsGetGeneralStruct(Spec, playerId);
			if (General == null) return;
			$("#_exudGeneralsSkillTree").css({left : 250 ,  top : 10, position:'absolute'});
			$("#_exudGeneralsSkillTree").show()
			var out = '';
			out += '<table width="200px" border="0" style="margin-left: 10px;margin-top: 5px;padding:5px; margin-right: 5px"';
			out += '<tr><td data-toggle="tooltip" data-placement="top" title="'+General.UID+'" style="white-space: nowrap; text-overflow:ellipsis; overflow: hidden; min-width:100px;max-width: 100px;">'+General.Icon + ' ' + General.Name+'</td>';
			out += '<td><button style="cursor: pointer;background: none;border: none;" class="pull-right" id="_exudGeneralsSkillTreeCloseBtn">'+getImageTag("attackweakesttarget_negative.png", '15px')+'</button></td></tr>';
			out += '</table>';

			out += '<table border="1" width="100%">';
			for(var y = 0; y < 5; y++)
			{
				out += "<tr>";
				for(var x = 0; x < 4; x++)
					out += _exudGeneralsSkillTreeAddCell(General, x, y);
				out += "</tr>";
			}

			out += "</table>";
			out += '</div>';
			$("#_exudGeneralsSkillTree").html(out);
			$('[data-toggle="tooltip"]').tooltip({container: 'body'});

			$('#_exudGeneralsSkillTreeCloseBtn').click(function(){
				$('#_exudGeneralsSkillTree').hide();
			});
		}
	} catch (e) {}
}

function _exudGeneralsSkillTreeAddCell(General, x, y)
{
	var out = '';
	if (General.Skills == null || General.Skills.length == 0) { return ''; }
	General.Skills.forEach(function(item) {
		if (item[0].PositionX == x && item[0].PositionY == y)
		{
			var inum =  item[0].Level + "/" + item[0].MaxLevel;
			if (item[0].Level > 0)
				inum = "<b>" + inum + "</b>";
			out = "<td data-toggle='tooltip' data-placement='top' title='"+item[0].Description+"' class='CellWithComment' align='center' width='40px' height='50px' style='background: "+(item[0].Level > 0 ? "#B2A500" : "#B2A589")+"'>";
			out += getImageTag(item[0].IconString, '24px', '24px') + "<br/>" + inum ;
			out + "</td>";
		}
	});
	return out;
}

function _exudGeneralsIsSelectable(S)
{
	return (S.Owner && !S.InUse && !S.Travelling)
}

function _exudGeneralsGetChecked()
{
	var GensUID = [];
	$('#udGeneralsModalData input[type="checkbox"]:checked').each(function(i, item) {
		GensUID.push(item.id);
	});
	return GensUID;
}

function _exudGeneralsIsCheked(uid)
{
	if (_exudGeneralsSortingFromTemplate == null)
		return $('input:checkbox[id^="'+uid+'"]:checked').length>0;
	else	// From template and selectdFirst flag true
		return (_exudGeneralsSortingFromTemplate.indexOf(uid) >= 0);
}

function _exudGeneralsSend(e)
{
	try
	{
		var OptionSelected = $(e.target).attr('value');
		if (OptionSelected == -1) return;
		var Specialists = swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector(); // Vector.<cSpecialist>
		var Services = swmmo.getDefinitionByName("com.bluebyte.tso.service::ServiceManager").getInstance();
		_exudGeneralsGetChecked().forEach(function(item){
			var S = _exudGetSpecialistbyUID(Specialists,item);
			if (S == null) { return; }
			if (OptionSelected == '98' && S.GetGarrisonGridIdx() > 0) {
				_exudSendGeneralToStar(S);
			}
			if (OptionSelected != '98') {
				Services.specialist.sendToZone(S, OptionSelected);
			}
		});
		$('#udGeneralsModal').modal('hide');
		showGameAlert(getText('command_sent'));

	 }
	 catch (error) {
		 alert("send error : " + error.message);
	 }
}

function _exudGeneralsFindByID(id)
{
	try{
		var Specialists = swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector(); // Vector.<cSpecialist>
		return _exudGetSpecialistbyUID(Specialists,id);
	} catch (e)	{ }
	return null;
}

function _exudSendGeneralToStar(S)
{
	try
	{
		swmmo.application.mGameInterface.mCurrentCursor.mCurrentSpecialist = S;
		specTaskDef = swmmo.getDefinitionByName("Communication.VO::dStartSpecialistTaskVO");
		stask = new specTaskDef();
		stask.uniqueID = S.GetUniqueID();
		stask.subTaskID = 0;

		swmmo.application.mGameInterface.SendServerAction(95,12,S.GetGarrisonGridIdx(),0,stask);
		wfcDef = swmmo.getDefinitionByName("Specialists::cSpecialistTask_TravelToStarMenu");
		wfc = new wfcDef(swmmo.application.mGameInterface,S,0,12);
		S.SetTask(wfc);
	}
	catch (error) {
		alert("Send to star error : " + error.message);
	}
}

function _exudGetSpecialistbyUID(specs, uid)
{
	for(y = 0 ; y < specs.length ; y++) {
		if (specs[y].GetUniqueID().toKeyString() == uid)
			return specs[y];
	}
	return null;
}

function _exudGetSpecialists()
{
	var listS = [];
	try
	{
		var SPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
		swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
			if (!SPECIALIST_TYPE.IsGeneral(item.GetType()))
				return;
			var General = _exudGeneralsGetGeneralStruct(item, playerId);
			if (General != null)
				listS.push(General);
		});
		if (listS.length > 1)
			listS.sort(_exudCompareGenerals);
		}
	catch (e) {	}
	return listS;
}

function _exudGeneralsGetGeneralStruct(item, playerID) {
	try {
		const itemPlayerId = item.getPlayerID(),
			isOwner = playerID === itemPlayerId,
			iconId = item.getIconID(),
			army = item.GetArmy();
		return {
			"BaseType": item.GetBaseType(),
			"GridPosition": item.GetGarrisonGridIdx(),
			"HasElites": army.HasEliteUnits(),
			"HasUnits": item.HasUnits(),
			"Icon": getImageTag(iconId, '24px', '24px'),
			"IconID": iconId,
			"InUse": item.IsInUse(),
			"IsGeneral": true,
			"Name": item.getName(false).replace('<b>', '').replace('</b>',''),
			"Owner": isOwner,
			"PlayerID": itemPlayerId,
			"PlayerName": (itemPlayerId > 0 && !isOwner ? swmmo.application.mGameInterface.GetPlayerName_string(itemPlayerId) : null),
			"Skills": _exudGeneralsGetSkills(item),
			"Travelling": item.isTravellingAway(),
			"Type": item.GetType(),
			"TotalArmy": army.GetUnitsCount(),
			"UID": item.GetUniqueID().toKeyString(),
			"XP": item.GetXP()
		};
	} catch (e){}
	return null;
}

function _exudGeneralsGetSkills(itemS)
{
	var SKILLS = [];
	try
	{
		if (itemS.getSkillTree() == null) return null;
		itemS.getSkillTree().getItems_vector().forEach(function(item){
			SKILLS.push([{
				"Name" : item.getName(),
				"Description" : loca.GetText("LAB", item.getName()).replace("'", " ").replace('"', ' '),
				"ID" : item.getId(),
				"UnappliedPoints" : item.getUnappliedPoints(),
				"PositionX" : item.getPosition().x,
				"PositionY" : item.getPosition().y,
				"Level" : item.getLevel(),
				"MaxLevel" : item.getMaxLevel(),
				"SkillPointType" : item.getSkillPointType_string(),
				"IconString" : item.getDefinition().icon_string
			}]);
		});
	} catch (e) {}
	return SKILLS;
}

function _exudCompareGenerals( a, b ) {
	try{
		if (_exudGeneralsSettings._exudGeneralsSelectedFirst)
		{
			var a_chkd = _exudGeneralsIsCheked(a.UID);
			var b_chkd = _exudGeneralsIsCheked(b.UID);
			
			if (a_chkd != b_chkd)
				return (a_chkd ? -1 : 1);
		}
		if (!b.Owner && a.Owner) return -1;
		if (!a.Owner && b.Owner) return 1;
		if (_exudGeneralsSettings._exudGeneralsArmySorted)
		{
			if (a.TotalArmy > b.TotalArmy)	return -1;
			if (a.TotalArmy < b.TotalArmy)	return 1;
		}
		switch(_exudGeneralsSettings._exudGeneralsSortType)
		{
			case 1:
				var tp = a.Name.toLowerCase().localeCompare(b.Name.toLowerCase());
				if (tp != 0) return tp;
				if (a.Type < b.Type) return -1;
				if (a.Type > b.Type) return 1;
			break;
			default:
				if (a.Type < b.Type) return -1;
				if (a.Type > b.Type) return 1;
				return a.Name.toLowerCase().localeCompare(b.Name.toLowerCase());
			break;
		}
	}
	catch (error) {
		//alert("compare error : " + error.message);
	}
	return 0;
}

function GetTravelTime(spec)
{
	var specialists = swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector();
	var time = "00:00";
	specialists.forEach(function(item){
		if (item.GetUniqueID().toKeyString() == spec['UID'])
		{
			if(item.GetTask() == null ) { return; }

			if(item.GetTask().GetType() == 7) // travel to zone id
			{
				time = GetFormatedTime(item.GetTask().GetRemainingTime());
			}
		}
	});
	return time;
}

function GetFormatedTime(time){
	return GetMinutes(time) + ":" + GetSeconds(time);
}

function GetMinutes(time){
	if(time <= 0) { return "00"; }
	return (Math.floor(time / 1000 / 60) < 10 ? "0" : "") + Math.floor(time / 1000 / 60);
}

function GetSeconds(time){
	if(time <= 0) { return "00"; }
	return (Math.floor((time / 1000) % 60) < 10 ? "0" : "") + Math.floor((time / 1000) % 60);
}