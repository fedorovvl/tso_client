// ========== GUILD COMMAND

addToolsMenuItem("Deposit Viewer", _exudDepositViewerMenuHandler);


function _exudDepositViewerMenuHandler(event) {

	$("div[role='dialog']:not(#DepositViewerModal):visible").modal("hide");

	const selectOptions = [ "---", "All", "DepositDepleted"];
	const assetsNames = [ "Corn", "Wood", "RealWood", "Fish",	"IronOre",	"Coal",	"Stone",
							"Marble", "Granite", "ExoticWood", "Meat", "BronzeOre", "GoldOre", "TitaniumOre", "Salpeter", "Water" ,
							"HalloweenResource"
						];

	createModalWindow('DepositViewerModal', 'Deposit Viewer');
	select = $('<select>', { id: 'udDepositViewerType' });	

	assetsNames.forEach(function(item) {
			select.append($('<option>', { value: item }).text(loca.GetText("RES", item))).prop("outerHTML");
	});
	
	$('#DepositViewerModal .modal-header').html('<div class="container-fluid"><div><span>'+select.prop("outerHTML")+ '</span>  <span>'+loca.GetText("SHG", "Deposits")+' : <span id="dvDepositViewerTotal"></span></span></div><br/>' +
				createTableRow([
				[4, loca.GetText("LAB", "Name")],
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
	
	$('#udDepositViewerType').change(function() {_exudDepositViewerGetData();	});	
	$('#DepositViewerModal:not(:visible)').modal({ backdrop: "static" });

}

function _exudDepositViewerMakeModal() {

	var out = '';
	
	out += '<div id="dvDepositViewerResult"></div>';
	
	return out;
}

	
function _exudDepositViewerGetData() {

var OptionSelected = $('#udDepositViewerType option:selected').val();

	$('#dvDepositViewerResult').html("");
	if (OptionSelected == "---") return;
	
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
						[4, loca.GetText("RES", item.GetName_string())],
						[2, item.GetAmount()],
						[2, IconMap]
					], false) 
				);
				document.getElementById("exudDVPOS_" + gid1).addEventListener("click",function() {swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(gid1);});
				++tot;
		}
		catch (e) {
			alert(e.message);
		}			
	});	
	
		swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.mBuildingContainer.forEach(function(item) {
		try {			
				if (swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.IsADepletedDeposit(item)) {
				if(item == null ||   ((OptionSelected != "DepositDepleted") && OptionSelected != "All" && item.GetBuildingName_string().indexOf(OptionSelected)) < 0) { return; }
				var gid1 = item.GetGrid();
				IconMap = getImageTag("accuracy.png", '18px', '18px').replace('<img','<img id="exudDVPOS_'+ gid1+'"').replace('style="', 'style="cursor: pointer;')
				$('#dvDepositViewerResult').append(
					createTableRow([
							[4,  loca.GetText("BUI", item.GetBuildingName_string())],
							[2, ""],
							[2, IconMap]
						], false) 
			);
				document.getElementById("exudDVPOS_" + gid1).addEventListener("click",function() {swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(gid1);});
				++tot;
			}
		}
		catch (e) {
			
		}			
	});	

	$('#dvDepositViewerTotal').text(tot);		
	//$('#dvDepositViewerResult').html(out);

}
