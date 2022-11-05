
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
		"IsGuest": " (*convidado) ",
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
        "SelectedFirst": "Selected First",
        "ExcludeStarMenu": "Exclude Star Menu",
        "SkillTip": "Click on general icon to open the Skill Tree."
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
		"SkillTip": "Нажмите на иконку генерала чтобы открыть его дерево навыков"
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
    }
};
var _exudGeneralsTemplates;
addToolsMenuItem(loca.GetText("ACL", "MilitarySpecialists"), _exudGeneralsMenuHandler);

var _exudGeneralsSortType = 1; // 0 = type/name  1 = name/type
var _exudGeneralsHideGuest = true;
var _exudGeneralsHideUnselected = false;
var _exudGeneralsToggleselected = false;
var idL = loca.getSelectedLanguage();
var _exudGeneralsSelectedFirst = false;
var _exudGeneralsExcludeStarMenu = false;

function _exudGeneralsGetLabel(id)
{
	if(!_exudGeneralsLang[idL] && !_exudGeneralsLang["en-uk"][id]) { return "RES not found : " + id; }
	return _exudGeneralsLang[idL] && _exudGeneralsLang[idL][id] ? _exudGeneralsLang[idL][id] : _exudGeneralsLang["en-uk"][id];
}
function _createTopRowWithIcons(generalsIconsList) {
    var output = '';
    generalsIconsList.forEach(function(iconID){
        output += '<a href="#" class="selectSpecificGeneralType" icon-id="{0}">{1}</a>'.format(iconID, getImageTag(iconID, '24px', '24px'));
    });
    return output;
}

var _exudGeneralsOpening = false;

function _exudGeneralsMenuHandler(event)
{
	_exudGeneralsTemplates = new SaveLoadTemplate('genspec', function(data) {
		_exudMakeGeneralsTable(data);
		if (_exudGeneralsSelectedFirst)
			_exudMakeGeneralsTable();
	});

	//showGameAlert(_exudGeneralsGetLabel("SkillTip"));

	var myStyle = document.getElementById('_exudGeneralsSyle');
	if (myStyle != null && myStyle != undefined)
		myStyle.parentNode.removeChild(myStyle);

	myStyle = ".CellWithComment{  position:relative; } ";
	myStyle += ".CellComment{  display:none;  position:absolute;   z-index:100;  border:1px;  background-color:#B2A589;  border-style:solid;  border-width:1px;  border-color:black;  padding:3px;  color:black;   top:350px;   left:0px; width: 250px} ";
	myStyle += ".CellWithComment:hover span.CellComment{  display:block;}";

	var sheet = document.createElement('style')
	sheet.innerHTML = myStyle;
	document.body.appendChild(sheet);

	_exudGeneralsOpening = true;
	$('#udGeneralsModal').remove();

	try{
		_exudGeneralsSortType = readSettings('_exudGeneralsSortType',  'usMKF_Generals');
		_exudGeneralsHideUnselected = readSettings('_exudGeneralsHideUnselected', 'usMKF_Generals');
		_exudGeneralsHideGuest = readSettings('_exudGeneralsHideGuest',  'usMKF_Generals');
		_exudGeneralsSelectedFirst = readSettings('_exudGeneralsSelectedFirst',  'usMKF_Generals');
		_exudGeneralsExcludeStarMenu = readSettings('_exudGeneralsExcludeStarMenu',  'usMKF_Generals');
	}
	catch (e) {}


	// close all modals
	$( "div[role='dialog']:not(#udGeneralsModal):visible").modal("hide");
	// create modal
	createModalWindow('udGeneralsModal', loca.GetText("ACL", "MilitarySpecialists"));
	if($('#udGeneralsModal .modal-footer ._exudGeneralsLoadTemplateBtn').length == 0)
	{
		$("#udGeneralsModal .modal-footer").prepend([
			$('<button>').attr({ "id": "_exudGeneralsSaveTemplateBtn", "class": "btn btn-primary pull-left _exudGeneralsSaveTemplateBtn" }).text(getText('save_template')),
			$('<button>').attr({ "id": "_exudGeneralsLoadTemplateBtn", "class": "btn btn-primary pull-left _exudGeneralsLoadTemplateBtn" }).text(getText('load_template'))
		]);

		$("#udGeneralsModal .modal-footer").append(['<p align="left" style="font-size: 10px">* {0}</p>'.format(_exudGeneralsGetLabel("SkillTip"))]);

		$('#udGeneralsModal ._exudGeneralsLoadTemplateBtn').click(function() { _exudGeneralsTemplates.load(); });

		$('#udGeneralsModal ._exudGeneralsSaveTemplateBtn').click(function(){
			var dataToSave = new Array();
			$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) {
				if(item.checked) {
					dataToSave.push(item.id);
				}
			});
			if (dataToSave.length > 0)
				_exudGeneralsTemplates.save(dataToSave);
		});



		$('#udGeneralsModal ._exudGeneralsSendGeneralsBtn').click(_exudGeneralsSend);

		_exudGetGeneralsTitle(0);

		var out = '<div class="container-fluid">';
		try
		{
			var AdvManager = swmmo.getDefinitionByName("com.bluebyte.tso.adventure.logic::AdventureManager").getInstance();
			var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
			
			select = $('<select>', { id: 'udcboSendZones' });
			select.append($('<option>', { value: '-1' }).text('-----').prop("outerHTML"));
			select.append($('<option>', { value: '98' }).text(loca.GetText("LAB", "StarMenu")).prop("outerHTML"));

			if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone)
				select.append($('<option>', { value: swmmo.application.mGameInterface.mCurrentPlayer.GetHomeZoneId() }).text(loca.GetText("LAB", "ReturnHome")).prop("outerHTML"));

			AdvManager.getAdventures().forEach(function(item){
				if (item.zoneID != swmmo.application.mGameInterface.mCurrentViewedZoneID) {
					select.append($('<option>', { value: item.zoneID }).text((item.ownerPlayerID != PlayerID ? '*' : '') + loca.GetText("ADN", item.adventureName)).prop("outerHTML"));
				}
			});

			//out += select.prop("outerHTML") + _exudGeneralsGetLabel("IsGuest");
			out += select.prop("outerHTML")+ ' ';
			
			out += $('<button>').attr({ "class": "btn btn-sm _exudGeneralsSendGeneralsBtn" }).text(
				loca.GetText("LAB", "Send")
			).prop("outerHTML") + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			
			out += $('<button>').attr({ "class": "btn btn-sm _exudSelectAllGeneralsBtn" }).text(
				_exudGeneralsGetLabel("SelectAll")
			).prop("outerHTML") + '&nbsp;&nbsp;&nbsp;';

			out += $('<button>').attr({ "class": "btn btn-sm _exudGeneralsSelectedFirstBtn" }).text(
				_exudGeneralsGetLabel("SelectedFirst")
			).prop("outerHTML") + '&nbsp;&nbsp;&nbsp;';


			out += $('<button>').attr({ "class": "btn btn-sm _exudGeneralRefreshBtn" }).text(
				loca.GetText("LAB", "Update")
			).prop("outerHTML") + ' ';
			out += '<p align="left" style="font-size: 10px">{0}</p>'.format(_exudGeneralsGetLabel("IsGuest")) + '</span>';

		} catch (error) {
			alert("Err (retry): " + error.message);
		}
		out += '<div id="topRowWithIcons" style="margin: 10px 0 0 0; display: none;"></div>';
        if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone) {
            out += '<br/>' + createTableRow([
                [7, loca.GetText("LAB","Name")],
                [2, loca.GetText("LAB", "StarMenu")],
                [1, loca.GetText("LAB", "Army")],
                [2, _exudGeneralsGetLabel("ColumnOwner")]
            ], true) ;
        } else {
            out += '<br/>' + createTableRow([
                [9, loca.GetText("LAB","Name")],
                [2, loca.GetText("LAB", "StarMenu")],
                [1, loca.GetText("LAB", "Army")]
            ], true) ;
        }
		out += '</div>';

		$('#udGeneralsModal .modal-header').append(out);

		$('#udGeneralsModal ._exudSelectAllGeneralsBtn').click(function() {
			_exudGeneralsToggleselected = !_exudGeneralsToggleselected;
			$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) {
				item.checked = _exudGeneralsToggleselected;
				});
		});
		$('#udGeneralsModal ._exudGeneralRefreshBtn').click(function(){
			_exudMakeGeneralsTable();
			showGameAlert(getText('command_sent'));
		});

		$('#udGeneralsModal ._exudGeneralsSelectedFirstBtn').click(function() {
			_exudGeneralsSelectedFirst = !_exudGeneralsSelectedFirst;
			_exudMakeGeneralsTable();
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
	}

	_exudGetGeneralsData();

	$("#udGeneralsModal .modal-footer .btn-danger").html(loca.GetText("LAB", "Close"));
	$('#udGeneralsModal:not(:visible)').modal({backdrop: "static"});
	_exudGeneralsOpening = false;
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

	try{
	var s = {
		'_exudGeneralsSortType' : _exudGeneralsSortType,
		'_exudGeneralsHideUnselected' : _exudGeneralsHideUnselected,
		'_exudGeneralsHideGuest' : _exudGeneralsHideGuest,
		'_exudGeneralsSelectedFirst' : _exudGeneralsSelectedFirst,
		'_exudGeneralsExcludeStarMenu' : _exudGeneralsExcludeStarMenu
	}

	storeSettings(s, 'usMKF_Generals');
	//alert("Saved");
	$('#udGeneralsModalsettings').modal("hide");
	}
	catch
	(e) {
		alert(e.message);
	}
}

function _exudGeneralsOptions()
{
	createSettingsWindow('udGeneralsModal', function(){_exudGeneralsSaveSettings();},  'modal-sm');
	$('#udGeneralsModalsettingsData').html(_exudGeneralsOptionsCreateSettings());
	$('#udGeneralsModalsettings:not(:visible)').modal({backdrop: "static"});

	$('#_exudChangeGeneralSortFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		if (++_exudGeneralsSortType == 2)	_exudGeneralsSortType = 0;
		_exudMakeGeneralsTable();
	});
	$('#_exudHideUnselectedGeneralsFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsHideUnselected = !_exudGeneralsHideUnselected;
		_exudMakeGeneralsTable();
	});
	$('#_exudHideGuestGeneralsFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsHideGuest = !_exudGeneralsHideGuest;
		_exudMakeGeneralsTable();
	});
	$('#_exudGeneralsExcludeStarMenuFloatBtn').change(function(){
		if (_exudGeneralsOpening) return;
		_exudGeneralsExcludeStarMenu = !_exudGeneralsExcludeStarMenu;
		_exudMakeGeneralsTable();
	});
}

function _exudGeneralsOptionsCreateSettings()
{
		var out = '';

		try{

		out += '<div style="float: clear"><div style="float: left;">';
		out += createSwitch("_exudChangeGeneralSortFloatBtn", (_exudGeneralsSortType==1));
		out += '</div>';
		out += '<div>&nbsp;&nbsp;'+_exudGeneralsGetLabel("ByName") +'</div>';
		out += '</div><br/>';

		out += '<div style="float: clear"><div style="float: left">';
		out += createSwitch("_exudHideGuestGeneralsFloatBtn", _exudGeneralsHideGuest);
		out += '</div>';
		out += '<div >&nbsp;&nbsp;'+_exudGeneralsGetLabel("HideGuest") +'</div>';
		out += '</div><br/>';

		out += '<div style="float: clear"><div style="float: left;">';
		out += createSwitch("_exudHideUnselectedGeneralsFloatBtn", (_exudGeneralsHideUnselected));
		out += '</div>';
		out += '<div >&nbsp;&nbsp;'+_exudGeneralsGetLabel("HideUnselected") +'</div>';
		out += '</div><br/>';

		out += '<div style="float: clear"><div style="float: left ">';
		out += createSwitch("_exudGeneralsExcludeStarMenuFloatBtn", (_exudGeneralsExcludeStarMenu));
		out += '</div>';
		out += '<div>&nbsp;&nbsp;'+_exudGeneralsGetLabel("ExcludeStarMenu") +'</div>';
		out += '</div><br/>';

		}
		catch (e) { alert(e.message); }

		return out;

}

function _exudGetGeneralsData()
{
	var out = '<div class="container-fluid" id="exGeneralsMainDiv">';
		out += '<div id="_exudGeneralsDivTable"></div>';
		out += '<div class="modal-dialog" id="_exudGeneralsSkillTree" style="position:absolute; top: 1; left: 1; color: black; background: #B2A589; font-weight: bold; visibility:hidden; border : thick solid #000000 ; border-width: 2px; width:250px ; height:350px;"></div>';
		out += '</div>';

	$('#udGeneralsModalData').html(out);

	_exudMakeGeneralsTable();
}

function _exudMakeGeneralsTable(templateData)
{
	var out = "";

	try {
		var selectedGenerals = !templateData ? _exudGeneralsGetChecked() : templateData,
            myGens = 0,
            uniqueIconIDs = [],
            checkbox;

		_exudGetSpecialists().forEach(function(item){
			try {
				var isSelected = selectedGenerals.indexOf(item.UID) >= 0;
				if (
                    (_exudGeneralsHideGuest && !item.Owner) ||
                    (_exudGeneralsExcludeStarMenu && (item.GridPosition < 1) && !isSelected) ||
                    (_exudGeneralsHideUnselected && !isSelected)
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
				var Icon =  item.Icon.replace('<img','<img id="exudSTIMG'+item.UID+'"').replace('style="', 'style="cursor: pointer;');
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
						[2, (item.Owner ? loca.GetText("LAB", "YES"): IconMap)]
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
	$('#_exudGeneralsDivTable').html(out);
	if (uniqueIconIDs.length > 0) {
        $('#topRowWithIcons').html(_createTopRowWithIcons(uniqueIconIDs)).show();
    } else {
	    $('#topRowWithIcons').html('').hide();
    }
	$('#_exudGeneralsExcludeStarMenuFloatBtn').change(function(){
		_exudGeneralsExcludeStarMenu = !_exudGeneralsExcludeStarMenu;
		_exudMakeGeneralsTable();
	});
	var imgs = document.getElementById('_exudGeneralsDivTable').getElementsByTagName('img');
	var x = 0;
	for(x = 0; x < imgs.length ; x++)
	{
		var idimg = imgs[x].id;

		if (idimg.indexOf("exudSTIMG") >= 0)
		{
			imgs[x].addEventListener("click", function(e) {
					_exudGeneralsOpenSkillTree(e);
			});
		}
		else
			{
				if (idimg.indexOf("exudSTGENPOS") >= 0)
				{
					imgs[x].addEventListener("click", function(e) {
							_exudGeneralsGoToMap(e);
					});
				}
			}

	}

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
		var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
		var Spec = _exudGeneralsFindByID(e.target.id.replace("exudSTIMG",""));
		if (Spec != null)
		{
		var General = _exudGeneralsGetGeneralStruct(Spec, PlayerID);
		if (General == null) return;
		document.getElementById('_exudGeneralsSkillTree').style.visibility = "visible";
//		$("#_exudGeneralsSkillTree").css({left : e.target.parentElement.offsetLeft + 200 ,  top : e.target.parentElement.offsetTop, position:'absolute'});
		$("#_exudGeneralsSkillTree").css({left : 250 ,  top : 10, position:'absolute'});

		var out = '';
		out += '<table width="200px" border="0" style="margin-left: 10px;margin-top: 5px;padding:5px; margin-right: 30px"';
		out += '<tr><td style="white-space: nowrap; text-overflow:ellipsis; overflow: hidden; max-width:1px;">'+General.Icon + ' ' + General.Name+'</td></tr>';
		out += '</table>';

		out += '<table border="1" style="margin-left: 10px;margin-top: 5px;padding:5px; margin-right: 30px"';
		var y = 0;
		var x = 0;
		var rows = "";
		for(y = 0; y < 5; y++)
		{
			rows += "<tr>";
			for(x = 0; x < 4; x++)
				rows += _exudGeneralsSkillTreeAddCell(General, x, y);
			rows += "</tr>";
		}

		out += rows;
		out += "</table>";
		out += '<div style="position: absolute;left: 220px;top: 1px;"><button" style="cursor: pointer;" id="_exudGeneralsSkillTreeCloseBtn">'+getImageTag("attackweakesttarget_negative.png")+'</button></div>';
		out += '</div>';
		$("#_exudGeneralsSkillTree").html(out);


		$('#_exudGeneralsSkillTreeCloseBtn').click(function(){
			document.getElementById('_exudGeneralsSkillTree').style.visibility = "hidden";
		});

		}
	} catch (e) {}
}

function _exudGeneralsSkillTreeAddCell(General, x, y)
{
	var out = '';
	if (General.Skills != null && General.Skills.length > 0)
		General.Skills.forEach(function(item) {
				if (item[0].PositionX == x && item[0].PositionY == y)
				{
					var inum =  item[0].Level + "/" + item[0].MaxLevel;
					if (item[0].Level > 0)
						inum = "<b>" + inum + "</b>";
					out = "<td class='CellWithComment' align='center' width='50px' height='60px' style='background: "+(item[0].Level > 0 ? "#B2A500" : "#B2A589")+"'>";
					out += getImageTag(item[0].IconString, '24px', '24px') + "<br/>" + inum ;
					out += "<span class='CellComment'>"+item[0].Description+"</span>";
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
	var GensUID = new Array();
	try{
	$('#udGeneralsModalData input[type="checkbox"]').each(function(i, item) {
		if(item.checked) {
			GensUID.push(item.id);
		}
	});
	}
	catch (e) {
		//alert("GGC:" + e.message);
		}
	return GensUID;
}

function _exudGeneralsIsCheked(uid)
{
	try{
return 	$('input:checkbox[id^="'+uid+'"]:checked').length>0;
	} catch (e) {}
	return false;
}

function _exudGeneralsSend()
{
	try
	{
		var OptionSelected = $('#udcboSendZones option:selected').val();
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
	}
	catch (e)
	{
	}
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

		swmmo.application.mGameInterface.SendServerAction(95,12,swmmo.application.mGameInterface.mCurrentCursor.GetGridPosition(),0,stask);
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
	var SPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
	var PlayerID = swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerId();
	var listS = new Array();
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
		try{
			if (!SPECIALIST_TYPE.IsGeneral(item.GetType()))
				return;
			var General = _exudGeneralsGetGeneralStruct(item, PlayerID);
			if (General != null)
				listS.push(General);
		}
		catch (e) {
		}
	});

	try{
	if (listS.length > 1)
		listS.sort(_exudCompareGenerals);
	}
	catch (e) {
	}

	return listS;
}

function _exudGeneralsGetGeneralStruct(item, PlayerID)
{

		try{
			i_pid = -1;
			i_pid = item.getPlayerID();

			var s = {
				"UID" : item.GetUniqueID().toKeyString(),
				"BaseType" : item.GetBaseType(),
				"HasElites" : item.GetArmy().HasEliteUnits(),
				"HasUnits" : item.HasUnits(),
				"Name" : item.getName(false).replace('<b>', '').replace('</b>',''),
				"PlayerID" : i_pid,
				"Type" : item.GetType(),
				"XP" : item.GetXP(),
				"Travelling" : item.isTravellingAway(),
				"InUse": item.IsInUse(),
				"Owner" : (PlayerID == i_pid),
				"IsGeneral" : true,
				"TotalArmy" : item.GetArmy().GetUnitsCount(),
				"Icon" : getImageTag(item.getIconID(), '24px', '24px'),
				"IconID": item.getIconID(),
				"PlayerName" : (i_pid > 0 && i_pid != PlayerID ? swmmo.application.mGameInterface.GetPlayerName_string(i_pid) : null),
				"GridPosition" : item.GetGarrisonGridIdx() ,
				"Skills" : _exudGeneralsGetSkills(item)
				};
			return s;
		}
		catch (e){}
	return null;
}
//this.skillIcon.source = gAssetManager.GetBitmap((_arg_1 as cSkill).getDefinition().icon_string);

function _exudGeneralsGetSkills(itemS)
{
		var SKILLS = new  Array();

	try{
		var ss = itemS.getSkillTree();
		if (ss == null) return null;
		// Vector.<cSkill>
		var id = 0;
		var sss = ss.getItems_vector();

		sss.forEach(function(item){
			var SKILL_DATA = new Array();
			SKILL_DATA.push({
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
							});

			SKILLS.push(SKILL_DATA);
		});
	}
	catch (e)
	{
	}
		return SKILLS;
}

function _exudCompareGenerals( a, b ) {
	try{
		if (_exudGeneralsSelectedFirst)
		{
			var a_chkd = _exudGeneralsIsCheked(a.UID);
			var b_chkd = _exudGeneralsIsCheked(b.UID);
			if (a_chkd != b_chkd)
				return (a_chkd ? -1 : 1);
		}
		if (!b.Owner && a.Owner) return -1;
		if (!a.Owner && b.Owner) return 1;
		switch(_exudGeneralsSortType)
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