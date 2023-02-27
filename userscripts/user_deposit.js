// ========== GUILD COMMAND
var _exudDepositVieweLang = {
	'en-uk': {
		'TimeDepEnd': 'Time Dep/Cycle',
		'BuffEnd': 'Buff End',
		'Buff': 'Buff',
		"Note": "*The exhaustion time is indicative, and may vary depending on the current cycle status and any buildings that can be added after having exhausted neighboring deposits.Sometimes the data may not be up to date. Run the refresh command first. (F2)"
		},
	"pt-br" : {
		'TimeDepEnd': 'Esgota em/Ciclo',
		'BuffEnd': 'Fim Cat.',
		'Buff': 'Catalizador',
		"Note" :  "*O tempo de esgotamento é indicativo, pode variar dependendo do estado do ciclo atual e de eventuais predios que podem intervir apos ter esgotado os depositos vizinhos.As vezes os dados podem nao estar atualizados. Execute o comando de atualizar antes. (F2)"
		},
	'fr-fr': {
		'TimeDepEnd': 'Temps Dép/Cycle',
		'BuffEnd': 'Fortifiant Terminé',
		'Buff': 'Fortifiant',
		"Note": "*La date de fin est indicative, et peut varier en fonction du cycle actuel et des buildings qui peuvent être rajoutés après avoir épuisé le(s) dépots voisins. Parfois les informations ne sont pas à jour. Faites une Mise à Jour (F2)."
		},
	'de-de': {
		'TimeDepEnd': 'Zyklus',
		'BuffEnd': 'Buff Ende',
		"Note": "*Die Zeiten bis zum Abbau der Vorkommen sind Schätzwerte und können, je nachdem wie weit die Entfernung zum Lager ist, variieren. Bitte zuerst F2 drücken!"
		},
	'es-es': {
		'TimeDepEnd': 'Agotación/Ciclo',
		'BuffEnd': 'Fin del Pote.',
		'Buff': 'Potenciador',
		"Note": "*La hora de agotación es aproximada, variará dependiendo del estado del ciclo en curso y/o cualquier otro edificio que intervenga en el mismo depósito una vez haya agotado el más cercano. Los datos pueden estar desactualizados. Refresca con (F2)."
	},
	"pl-pl": {
		"TimeDepEnd": "Czas produkcji/Cykl",
		"BuffEnd": "Koniec premii",
		"Buff": "Premia",
		"Note": "*Czas wyczerpania jest orientacyjny i zależy od aktualnego cyklu i budynków będących w otoczeniu złoża. Czasami dane nie są aktualne, należy wówczas odświeżyć dane (F2)"
	}
};

const _exudDepositViewerAssetsNames = [ "Corn", "Fish", "IronOre", "Coal", "Stone", "Marble", "Granite",
					"Meat", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter", "Water" ,
					"HalloweenResource", "ValentinesFlower"
					];

extendBaseLang(_exudDepositVieweLang, 'exudDepositVieweLang');
addToolsMenuItem(loca.GetText("LAB", "Trait_LovelyGeologist"), _exudDepositViewerMenuHandler);
var _exudDepositViewerModalInitialized = false;

function _exudDepositViewerMenuHandler(event) {
	$("div[role='dialog']:not(#DepositViewerModal):visible").modal("hide");
	if(!_exudDepositViewerModalInitialized)
		$('#DepositViewerModal').remove();
try{
	if($('#DepositViewerModal .modal-header .container-fluid').length == 0){
		$('#udDepositViewerStyle').remove();
	
		if($('#udDepositViewerStyle').length == 0)
		{
			$("head").append($("<style>", { 'id': 'udDepositViewerStyle' }).text('div .row:hover {background-color: #A65329;}'));
		}
		
		
		const selectOptions = [ "---", "DepositDepleted"]; // remove All because too heavy

		createModalWindow('DepositViewerModal', 'Deposit Viewer');
		select = $('<select>', { id: 'udDepositViewerType' });	

		_exudDepositViewerAssetsNames.forEach(function(item) {
			select.append($('<option>', { value: item }).text(loca.GetText("RES", item))).prop("outerHTML");
		});
		$('#DepositViewerModal .modal-header').html('<div class="container-fluid"><div><span>'
			+ getImageTag('buff_transmutation_reagent.png', '45px')+' '
			+select.prop("outerHTML")
			+ '</span>  <span>'+loca.GetText("SHG", "Deposits")
			+' : <span id="dvDepositViewerTotal"></span></span></div><br/>' 
			+createTableRow([
				[4, loca.GetText("LAB", "Name")],
				[2, getText('TimeDepEnd', 'exudDepositVieweLang')],
				[2, getText('BuffEnd', 'exudDepositVieweLang') ],
				[3, loca.GetText("LAB", "amount") + "/" + getText('Buff', 'exudDepositVieweLang')],
				[1, loca.GetText("LAB", "Visit")]
			], true) 
			+ '<span style="font-size:12px">'  + getText('Note', 'exudDepositVieweLang') + '</span>'
			+ '</div>'
			);	
				

		$('#DepositViewerModalData').html('<div class="container-fluid">{0}</div>'.format(_exudDepositViewerMakeModal()));
		var my_options = $("#udDepositViewerType option");
		my_options.sort(function(a,b) {
				if (a.text > b.text) return 1;
				if (a.text < b.text) return -1;
				return 0;
				});
		$("#udDepositViewerType").empty();
		
		selectOptions.forEach(function(item) {
			$("#udDepositViewerType").append($('<option>', { value: item }).text((item == "---" ? "---" : (item == "All" ? loca.GetText("LAB", "All") : loca.GetText("MEL", item)))).prop("outerHTML"));
		});	
		$("#udDepositViewerType").append( my_options );
		$("#udDepositViewerType").prop("selectedIndex", 0);
		$('#udDepositViewerType').change(function() {_exudDepositViewerGetData();});	
		_exudDepositViewerModalInitialized = true;
	}
	else
		_exudDepositViewerGetData();
}
catch (edep) {}
	
	$('#DepositViewerModal:not(:visible)').modal({ backdrop: "static" });
}

function _exudDepositViewerMakeModal() {
	var out = '';	
	out += '<div id="dvDepositViewerResult"></div>';
	return out;
}

var _exudDepositViewerGetingData = false;
function _exudDepositViewerGetData() {

	var OptionSelected = $('#udDepositViewerType option:selected').val();
	if (_exudDepositViewerGetingData) return;

try{
	var gEconomics = swmmo.getDefinitionByName("ServerState::gEconomics");

	_exudDepositViewerGetingData = true;
	$('#dvDepositViewerResult').html("");
	if (OptionSelected == "---") 
	{
		_exudDepositViewerGetingData = false;
		return;
	}
	
	var out = '';		
	var tot = 0;
	
	var Deposits = swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mDepositContainer;
	if (OptionSelected == "All")
	{
		var sDep = new Array();
		Deposits.forEach(function(item) { sDep.push(item);});
		
		Deposits = sDep;
		Deposits.sort(function(a,b) {
			return loca.GetText("RES", a.GetName_string()).localeCompare(loca.GetText("RES", b.GetName_string()));
			});
	}

	var DepositsData = new Array();
	if (OptionSelected != "DepositDepleted")
	{
		Deposits.forEach(function(item) {
			try {			
				var BuildingsData = new Array();
				if (item == null ||  (OptionSelected != "All" && item.GetName_string() != OptionSelected)) { return; }
				var gid1 = item.GetGrid();
				var IconMapDep = getImageTag("accuracy.png", '24px', '24px').replace('<img','<img id="exudDVPOS_'+ gid1+'"').replace('style="', 'style="cursor: pointer;')
				var TotRes = item.GetAmount();
				
				var BldDep = _exudDepositViewerFindMyBuildings(gid1);
				var ResourcesRemovedEverySecond = 0;
				BldDep.forEach(function (bld) {
					try {
						var IconMapBld = "";
						var bldGid = bld.GetGrid();
						if (bldGid > 0 && bldGid != gid1)
							IconMapBld = getImageTag("accuracy.png", '24px', '24px').replace('<img','<img id="exudDVPOS_'+ bldGid+'"').replace('style="', 'style="cursor: pointer;')
						timeEnd = 0;
						timeStr = "";
						buffName = "";
						buff = bld.productionBuff;
						isWorking = bld.IsProductionActive();
						if (buff != null)
						{
							app = buff.GetApplicanceMode();	
							if (buff.IsActive(swmmo.application.mGameInterface.GetClientTime()))
							{									
								timeEnd =  new window.runtime.Date(Date.now() + (buff.GetStartTime() + buff.GetBuffDefinition().getDuration(app)) - swmmo.application.mGameInterface.GetClientTime());
								buffName = loca.GetText("RES", buff.GetBuffDefinition().GetName_string());
							}							
						}
						
						if (timeEnd > 0)
						{
							var dtfex = new window.runtime.flash.globalization.DateTimeFormatter("en-US"); 
							if (gameLang.indexOf("en-") > 0)
								dtfex.setDateTimePattern("MM-dd-yyyy HH:mm"); 
							else
								dtfex.setDateTimePattern("dd-MM HH:mm"); 
							
							timeStr = dtfex.format(new window.runtime.Date(timeEnd)); // time ticks of game is different
							
						}
						var rcd = gEconomics.GetResourcesCreationDefinitionForBuilding(bld.GetBuildingName_string());

						var rcd_pck = 0; // infinite mines remove 0
						if (rcd != null)
							rcd_pck = rcd.amountRemoved; // resources removed base value
						var Seconds = bld.CalculateWays()/1000;
						var TotRemoved = bld.GetResourceInputFactor() * rcd_pck; // resources removed base * level * buffs
						
						if (isWorking)
							ResourcesRemovedEverySecond += (TotRemoved == 0 ? 0 : TotRemoved / Seconds);
						BuildingsData.push({
								"Name" : loca.GetText("BUI", bld.GetBuildingName_string()),
								"Buffed" : (bld.mBuffs_vector.length > 0),
								"BuffTime": timeStr,
								"BuffName": buffName,
								"OverallTime" : Seconds, // total seconds
								"IconMap":  IconMapBld,
								"Working": isWorking,
								"GridPos" : bldGid,
								"AmountRemoved" : TotRemoved 
						});

					}
					catch (ex) {
						//alert(ex.message);
					}
				});
				BuildingsData.sort(_exudDepositViewerBuildingsDataSort);
				DepositsData.push({
					"Name" : loca.GetText("RES", item.GetName_string()),
					"TotRes" : TotRes,
					"IconMap" : IconMapDep,
					"GridPos" : gid1,
					"BData" : BuildingsData,
					"SecondsToDeplete" : (ResourcesRemovedEverySecond > 0 && TotRes > 0 ? (TotRes / ResourcesRemovedEverySecond) : 0)
				});

				++tot;
			}
			catch (e) {
		}			
		});		
		
		DepositsData.sort(_exudDepositViewerDepositDataSort);
		// End data get start rendering
		DepositsData.forEach(function(item) {
			try{
			
				$('#dvDepositViewerResult').append('<div style="color: yellow;">' +
					createTableRow([
						[4, item.Name],
						[4, _exudDepositViewerSetTimeStr(item.SecondsToDeplete, 2)],
						[3, item.TotRes],
						[1, item.IconMap]
					], false) 
					+'</div>'
				);		
				if (item.IconMap != "")			
					document.getElementById("exudDVPOS_" + item.GridPos).addEventListener("click",function() {_exudDepositViewerGoTo(item.GridPos);});

				item.BData.forEach(function(bld) {
					$('#dvDepositViewerResult').append(
						createTableRow([
							[4, $('<span>', {'style' : 'white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' + (bld.Working?'':'color: red;')}).html('&nbsp;&rarr;' + bld.Name).prop('outerHTML')],
							[2, _exudDepositViewerSetTimeStr(bld.OverallTime, 1) + " (" + bld.AmountRemoved + ")"],
							[2, bld.BuffTime],
							[3, $('<span>', {'style' : 'white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'}).html(bld.BuffName).prop('outerHTML')],
							[1, bld.IconMap]
						], false) 
						
					);
					if (bld.IconMap != "")
						document.getElementById("exudDVPOS_" + bld.GridPos).addEventListener("click",function() {_exudDepositViewerGoTo(bld.GridPos);});
				}); // end buildingdata foreach
			}
			catch (eren) {
			//	alert("eren: " + eren.message);
			}
		}); // end depositdata foreach		
	}
	
	var Depleted = new Array();
	swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function(item) {
		try {			
			if (swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.IsADepletedDeposit(item)) {
				if(item == null ||   ((OptionSelected != "DepositDepleted") && (OptionSelected != "All") && (item.GetBuildingName_string().indexOf(OptionSelected))) < 0) { return; }
				Depleted.push( { "Item" : item , "Resource" : _exudDepositViewerFindOriginalResource(item.GetBuildingName_string()) } );	
			}
		} catch (edep) {}
		});

	Depleted.sort(function(a,b) {
		return a.Resource.localeCompare(b.Resource);
		});
		
	Depleted.forEach(function(i) {
		try {
			var gid1 = i.Item.GetGrid();
			var IconMap = "";
			if (gid1 > 0)
				IconMap = getImageTag("accuracy.png", '24px', '24px').replace('<img','<img id="exudDVPOS_'+ gid1+'"').replace('style="', 'style="cursor: pointer;')
			$('#dvDepositViewerResult').append(
				createTableRow([
						[11,  loca.GetText("BUI", i.Item.GetBuildingName_string()) + (i.Resource == "" ? "" : " (" + i.Resource + ")" )],
						[1, IconMap]
					], false) 
			);
			if (IconMap != "")
				document.getElementById("exudDVPOS_" + gid1).addEventListener("click",function() {_exudDepositViewerGoTo(gid1);});
			++tot;
		}
		catch (e) {
			
		}			
	});

	
	$('#dvDepositViewerTotal').text(tot);	
}
catch (egd) {
}
_exudDepositViewerGetingData = false;	
}
function _exudDepositViewerDepositDataSort(a, b)
{
	try{
		if (a.SecondsToDeplete < b.SecondsToDeplete) return -1;
		if (a.SecondsToDeplete > b.SecondsToDeplete) return 1;
	}
	catch (e) {
	}
	return 0;
}
function _exudDepositViewerBuildingsDataSort(a, b)
{
	try{
		if (a.OverallTime < b.OverallTime) return -1;
		if (a.OverallTime > b.OverallTime) return 1;
	}
	catch (e) {
	}
	return 0;
}
// type : 1 = 00:00:00   2 = MM-dd-yyyy 00:00:00
function _exudDepositViewerSetTimeStr(seconds, type) 
{
	try {
		if (seconds < 1) return "";
		switch(type)
		{
			case 1:
				return result = new Date(seconds * 1000).toISOString().slice(11, 19);
			case 2:
				var d =  result = new Date(new Date(Date.now()).getTime() + seconds*1000);
				var _m = ("00" + (d.getMonth()+1).toString()).slice(-2);
				var _d = ("00" + d.getDate().toString()).slice(-2);
				if (gameLang.indexOf("en-") > 0)
					return _m + "-" + _d + " " + d.toLocaleTimeString();
				else
					return _d + "-" +_m + " " + d.toLocaleTimeString();
		}
	}
	catch(e){
	}
	return "";
}


function _exudDepositViewerFindMyBuildings(gidPos)
{
	var BuildingsDep = new Array();
	swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function(item) {
		try {
			if (item.GetResourceCreation().GetDepositBuildingGridPos() > 0)
				if (item.GetResourceCreation().GetDepositBuildingGridPos() == gidPos)
				{
					BuildingsDep.push(item);
				}
		}
		catch (eee) {}
	});	
	
	return BuildingsDep;
}

function _exudDepositViewerFindOriginalResource(building_name)
{
	var res = "";
	try{
	_exudDepositViewerAssetsNames.forEach(function(item) {
			if (building_name.indexOf(item) >= 0)
				res = item;
	});
	if (res != "") res = loca.GetText("RES", res);
	}
	catch (e) {
	}
	return res;
}

function _exudDepositViewerGoTo(g)
{
	try{
		$('#DepositViewerModal').modal('hide');
		swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(g);
	}
	catch (e) {
	}
}
