var specHideVector = {};
var hideSpecSelectedType = 1;
var hideSpecTracker = game.getTracker('specHide', hideSpecHandler);
game.gi.channels.ZONE.addPropertyObserver("ZONE_REFRESHED", hideSpecTracker);
$.extend(specHideVector, settings.read(null, "specHide"));
hideSpecHandler(null);

function hideSpecMenuHandler(event)
{
	if(game.gi.isOnHomzone() == false) {
		game.showAlert(getText('not_home'));
		return;
	}
	var w = new Modal('hideSpecWindow', utils.getImageTag('PropagationBuff_AdventureZoneTravelBoost_BlackTree', '45px') + ' ' + getText('specHideTitle'));
	w.create();
	if(w.withFooter('#dutyExplorersBtn').length == 0) {
		w.Footer().prepend([
			$("<button>").attr({'class':"btn btn-primary"}).text(loca.GetText("LAB","Save")).click(function(){
				settings.settings["specHide"] = {};
				settings.store(specHideVector, "specHide");
				hideSpecHandler(null);
				w.hide();
			}),
			$('<button>').attr({ "id": "dutyExplorersBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("SPE", "Explorer")),
			$('<button>').attr({ "id": "dutyGeologistBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("SPE", "Geologist")),
			$('<button>').attr({ "id": "dutyGeneralsBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("SPE", "General"))
		]);
		
		w.withFooter('#dutyExplorersBtn, #dutyGeologistBtn, #dutyGeneralsBtn').click(function(event) {
			hideSpecSelectedType = dutySpecTypes[this.id];
			w.Title().find("img").prop('src', dutyTitleIconByType[this.id]);
			w.withBody('div.row').find('.type'+hideSpecSelectedType).closest('div.row').show();
			w.withBody('div.row').find(':first:not(.type'+hideSpecSelectedType+')').closest('div.row').hide();
		});
	}
	if(w.withHeader('.container-fluid').length == 0) {
		w.withHeader('').append('<div class="container-fluid"><br>' + utils.createTableRow([[6, loca.GetText("LAB", "Name")], [3, "UniqueID"], [3, loca.GetText("LAB", "GuildOnlineLast24")]], true) + '</div>');
	}
	var html = '<div class="container-fluid" style="user-select: all;">';
	game.gi.mCurrentPlayerZone.GetSpecialists_vector().sort(specNameSorter).forEach(function(item){
		var type = [1,2].indexOf(item.GetBaseType()) != -1 ? item.GetBaseType() : 3;
		html += utils.createTableRow([
			[6, getImageTag(item.getIconID(), '24px', '24px') + ' ' + item.getName(false), 'type'+type], 
			[3, item.GetUniqueID().toKeyString()],
			[3, createSwitch(item.GetUniqueID().toKeyString(), item.getPlayerID() > 0)]]);
		return true;
	});
	w.Body().html(html + '<div>');
	w.withBody('div.row').find(':first:not(.type'+hideSpecSelectedType+')').closest('div.row').hide();
	w.withBody('[type=checkbox]').change(function(e) {
		if($(e.target).is(':checked') && $(e.target).attr('id') in specHideVector) {
			delete specHideVector[$(e.target).attr('id')];
			return;
		}
		if($(e.target).not(':checked') && !($(e.target).attr('id') in specHideVector)) {
			specHideVector[$(e.target).attr('id')] = true;
		}
	});
	w.show();
}

function hideSpecHandler(event)
{
	if(expZone != null) {
		game.gi.mRequirements.miscRequirements_vector["GarrisonSwitchButton"].requirements[0].fulfilled = true;
	}
	try{
		game.gi.mCurrentPlayerZone.GetSpecialists_vector().forEach(function(item){
			if(item.GetUniqueID().toKeyString() in specHideVector && item.getPlayerID() != -1) {
				item.SetPlayerID(-1);
				return true;
			}
			if(!(item.GetUniqueID().toKeyString() in specHideVector) && item.getPlayerID() == -1) {
				item.SetPlayerID(game.player.GetPlayerId());
			}
		});
		game.gi.isOnHomzone()&&setFilterHandler(mainSettings.defFilter);
	} catch (e) {}
}

