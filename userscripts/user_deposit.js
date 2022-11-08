// ========== GUILD COMMAND

addToolsMenuItem("Deposit Viewer", _exudDepositViewerMenuHandler);

const _exudDepositViewerAssetsNames = [ "Corn",  "Fish",	"IronOre",	"Coal",	"Stone",
					"Marble", "Granite", "Meat", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter", "Water" ,
					"HalloweenResource"
					];

var _exudDepositViewerModalInitialized = false;

function _exudDepositViewerMenuHandler(event) {
	//_debugClassesDebugMessage("_exudDepositViewerMenuHandler");
	//_debugClassesDebugMessage("_exudDepositViewerModalVersion : " + _exudDepositViewerModalVersion);
	//_debugClassesDebugMessage("_exudDepositViewerModalInitialized : " + _exudDepositViewerModalInitialized);
	$("div[role='dialog']:not(#DepositViewerModal):visible").modal("hide");
	if(!_exudDepositViewerModalInitialized)
		$('#DepositViewerModal').remove();
try{
	if($('#DepositViewerModal .modal-header .container-fluid').length == 0){
		const selectOptions = [ "---", "DepositDepleted"]; // remove All because too heavy
		//_debugClassesDebugMessage("_exudDepositViewerMenuHandler creating");

		createModalWindow('DepositViewerModal', 'Deposit Viewer');
		select = $('<select>', { id: 'udDepositViewerType' });	

		_exudDepositViewerAssetsNames.forEach(function(item) {
			select.append($('<option>', { value: item }).text(loca.GetText("RES", item))).prop("outerHTML");
		});
		
		$('#DepositViewerModal .modal-header').html('<div class="container-fluid"><div><span>'
			+select.prop("outerHTML")
			+ '</span>  <span>'+loca.GetText("SHG", "Deposits")
			+' : <span id="dvDepositViewerTotal"></span></span></div><br/>' 
			+createTableRow([
				[8, loca.GetText("LAB", "Name")],
				[2, loca.GetText("LAB", "amount")],
				[2, loca.GetText("LAB", "Visit")]
			], true) 
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
		//_debugClassesDebugMessage("_exudDepositViewerMenuHandler exiting");

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
	//_debugClassesDebugMessage("_exudDepositViewer get data");

var OptionSelected = $('#udDepositViewerType option:selected').val();
	if (_exudDepositViewerGetingData) return;

try{
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

	if (OptionSelected != "DepositDepleted")
		Deposits.forEach(function(item) {
			try {			
				if(item == null ||  (OptionSelected != "All" && item.GetName_string() != OptionSelected)) { return; }
				var gid1 = item.GetGrid();
				IconMap = getImageTag("accuracy.png", '18px', '18px').replace('<img','<img id="exudDVPOS_'+ gid1+'"').replace('style="', 'style="cursor: pointer;')
				
				$('#dvDepositViewerResult').append(
					createTableRow([
						[8, loca.GetText("RES", item.GetName_string())],
						[2, item.GetAmount()],
						[2, IconMap]
					], false) 
				);				
				document.getElementById("exudDVPOS_" + gid1).addEventListener("click",function() {_exudDepositViewerGoTo(gid1);});
				var BldDep = _exudDepositViewerFindMyBuildings(gid1);
				//_debugClassesDebugMessage("Pushed : " + BldDep.length);
				BldDep.forEach(function (bld) {
					try {
						var bldGid = bld.GetGrid();
						IconMap = "";
						if (bldGid > 0 && bldGid != gid1)
							IconMap = getImageTag("accuracy.png", '18px', '18px').replace('<img','<img id="exudDVPOS_'+ bldGid+'"').replace('style="', 'style="cursor: pointer;')
						timeEnd = 0;
						timeStr = "";
						buffName = "";
						buff = bld.productionBuff;
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
							dtfex.setDateTimePattern("MM-dd-yyyy HH:mm"); 
							timeStr = dtfex.format(new window.runtime.Date(timeEnd));
							
						}
						
						$('#dvDepositViewerResult').append(
							createTableRow([
								[1, ""],
								[3, loca.GetText("BUI", bld.GetBuildingName_string())],
								[1, (bld.mBuffs_vector.length > 0 ? "Buffed" : "") ],
								[2, timeStr],
								[3, buffName],
								[2, IconMap]
							], false) 
						);
						//_debugClassesDebugMessage(loca.GetText("BUI", bld.GetBuildingName_string()) + ": bldGid=" + bldGid);
						document.getElementById("exudDVPOS_" + bldGid).addEventListener("click",function() {_exudDepositViewerGoTo(bldGid);});
					}
					catch (ex) {}
				});

				++tot;
			}
			catch (e) {
			}			
		});	
		
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
			IconMap = "";
			if (gid1 > 0)
				IconMap = getImageTag("accuracy.png", '18px', '18px').replace('<img','<img id="exudDVPOS_'+ gid1+'"').replace('style="', 'style="cursor: pointer;')
			$('#dvDepositViewerResult').append(
				createTableRow([
						[8,  loca.GetText("BUI", i.Item.GetBuildingName_string()) + (i.Resource == "" ? "" : " (" + i.Resource + ")" )],
						[2, ""],
						[2, IconMap]
					], false) 
			);
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

function _exudDepositViewerFindMyBuildings(gidPos)
{
	var BuildingsDep = new Array();
	swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function(item) {
		try {
			if (item.GetResourceCreation().GetDepositBuildingGridPos() > 0)
				if (item.GetResourceCreation().GetDepositBuildingGridPos() == gidPos)
				{
					//_debugClassesDebugMessage("Push : " + item.GetBuildingName_string() + " = " + gidPos);
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
	//$('#DepositViewerModal').modal('hide');
	swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(g);
	//_debugClassesDebugMessage("_exudDepositViewer go and hide");

	}
	catch (e) {
		alert(e.message);
	}
}
