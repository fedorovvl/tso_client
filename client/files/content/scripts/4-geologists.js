addMenuItem(loca.GetText("SPE", "Geologist") + " (F4)", menuGeologistsHandler, 115);

function menuGeologistsHandler(event)
{
	$( "div[role='dialog']:not(#specModal):visible").modal("hide");
	if(swmmo.application.mGameInterface.isOnHomzone() == false) {
		showAlert("It's not your home zone", false, 'danger');
		return;
	}
	playerLevel = swmmo.application.mGameInterface.mHomePlayer.GetPlayerLevel();
    out = '<div class="container-fluid">';
	isThereAnySpec = false;
	swmmo.application.mGameInterface.mCurrentPlayerZone.GetSpecialists_vector().sort(0).forEach(function(item){
	  if(item.GetBaseType() == 2) {
		  if (item.GetTask() != null) { return; }
		  isThereAnySpec = true;
		  out = out + '<div class="row"><div class="col-xs-4 col-sm-4 col-lg-4 name">' + item.getName(false) + '</div><div class="col-xs-3 col-sm-3 col-lg-3">&nbsp;</div><div class="col-xs-5 col-sm-5 col-lg-5">' + createGeologistDropdown(item.GetUniqueID(), playerLevel, false) + '</div></div>';
	  }
	});
	out = out + '</div>';
	if(!isThereAnySpec){
		showAlert("You don't have free geologists", false, 'warning');
		return;
	}
	$("#specModal .massSend").html(createGeologistDropdown(1, 1, true));
	$("#specModalData").html(out);
	$( "#expl-mass" ).change(massChangeSpecDropdown);
	$('#specModalData .container-fluid').selectable({
		filter: ".name",
		selecting: function(e, ui) {
			var curr = $(ui.selecting.tagName, e.target).index(ui.selecting);
			if(e.shiftKey && prev > -1) {
				$(ui.selecting.tagName, e.target).slice(Math.min(prev, curr), 1 + Math.max(prev, curr)).filter(".name").addClass('ui-selected');
				prev = -1;
			} else {
				prev = curr;
			}
		}
	});
	$('#specModalData select[id!="expl-mass"]').change(multiSelectSpec);
	$('#specModal:not(:visible)').modal({backdrop: "static"});
}

function createGeologistDropdown(id, level, mass)
{
	if(mass) { id = 'mass';	} else { id = id.uniqueID1 + '_' + id.uniqueID2; }	
	select = $('<select>', { id: 'expl-'+id });
	select.append($('<option>', { value: '0' }).text(loca.GetText("LAB", "Cancel")).prop("outerHTML"));
	select.append($('<option>', { value: '0,0' }).text(loca.GetText("TOT", "FindDepositStone")).prop("outerHTML"));
	if(level >= 9 || mass) { select.append($('<option>', { value: '0,1' }).text(loca.GetText("TOT", "FindDepositBronzeOre")).prop("outerHTML")); }
	if(level >= 17 || mass) { select.append($('<option>', { value: '0,2' }).text(loca.GetText("TOT", "FindDepositMarble")).prop("outerHTML")); }
	if(level >= 18 || mass) { select.append($('<option>', { value: '0,3' }).text(loca.GetText("TOT", "FindDepositIronOre")).prop("outerHTML")); }
	if(level >= 23 || mass) { select.append($('<option>', { value: '0,4' }).text(loca.GetText("TOT", "FindDepositGoldOre")).prop("outerHTML")); }
	if(level >= 24 || mass) { select.append($('<option>', { value: '0,5' }).text(loca.GetText("TOT", "FindDepositCoal")).prop("outerHTML")); }
	if(level >= 60 || mass) { select.append($('<option>', { value: '0,6' }).text(loca.GetText("TOT", "FindDepositGranite")).prop("outerHTML")); }
	if(level >= 61 || mass) { select.append($('<option>', { value: '0,7' }).text(loca.GetText("TOT", "FindDepositAlloyOre")).prop("outerHTML")); }
	if(level >= 62 || mass) { select.append($('<option>', { value: '0,8' }).text(loca.GetText("TOT", "FindDepositSalpeter")).prop("outerHTML")); }
	return select.prop("outerHTML");
}