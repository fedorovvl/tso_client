addToolsMenuItem("Hide specialists", specHideMenuHandler);
var specHideVector = {};
var specHideSelectedType = 1;
var specHideBtnToSpecType = { 'specHideExplorersBtn': 1,'specHideGeologistBtn': 2,'specHideGeneralsBtn': 3 };
var specHideSPECIALIST_TYPE = swmmo.getDefinitionByName("Enums::SPECIALIST_TYPE");
var specHideTracker = game.getTracker('specHide', specHideHandler);
game.gi.channels.ZONE.addPropertyObserver("ZONE_REFRESHED", specHideTracker);
$.extend(specHideVector, settings.read(null, "specHide"));
specHideHandler(null);

function specHideMenuHandler(event)
{
	var w = new Modal('specHideWindow', utils.getImageTag('icon_dice.png', '45px') + ' Hide specialists');
	w.create();
	specHideGetData(w);
	w.Footer().prepend([
		$("<button>").attr({'class':"btn btn-primary"}).text(loca.GetText("LAB","Save")).click(function(){
			settings.store(specHideVector, "specHide");
			specHideHandler(null);
			w.hide();
		}),
		$('<button>').attr({ "id": "specHideExplorersBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("SPE", "Explorer")),
		$('<button>').attr({ "id": "specHideGeologistBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("SPE", "Geologist")),
		$('<button>').attr({ "id": "specHideGeneralsBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("SPE", "General"))
	]);
	$('#specHideExplorersBtn, #specHideGeologistBtn, #specHideGeneralsBtn').click(function(event) {
		specHideSelectedType = specHideBtnToSpecType[this.id];
		specHideGetData(w);
	});
	w.show();
}

function specHideGetData(w)
{
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[6, loca.GetText("LAB", "Name")], [3, "UniqueID"], [3, loca.GetText("LAB", "GuildOnlineLast24")]], true);
	game.zone.GetSpecialists_vector().sort(0).forEach(function(item){
		var isValid = item.GetBaseType() == specHideSelectedType || (specHideSelectedType == 3 && specHideSPECIALIST_TYPE.IsGeneralOrAdmiral(item.GetType()));
		if(!isValid) { return; }
		html += utils.createTableRow([
			[6, getImageTag(item.getIconID(), '24px', '24px') + ' ' + item.getName(false)], 
			[3, item.GetUniqueID().toKeyString()],
			[3, createSwitch(item.GetUniqueID().toKeyString(), item.getPlayerID() > 0)]]);
		return true;
	});
	w.Body().html(html + '<div>');
	w.withBody('[type=checkbox]').change(function(e) {
		if($(e.target).is(':checked') && $(e.target).attr('id') in specHideVector) {
			delete specHideVector[$(e.target).attr('id')];
			return;
		}
		if($(e.target).not(':checked') && !($(e.target).attr('id') in specHideVector)) {
			specHideVector[$(e.target).attr('id')] = true;
		}
	});
}

function specHideHandler(event)
{
	game.zone.GetSpecialists_vector().forEach(function(item){
		if(item.GetUniqueID().toKeyString() in specHideVector && item.getPlayerID() != -1) {
			item.SetPlayerID(-1);
			return true;
		}
		if(!(item.GetUniqueID().toKeyString() in specHideVector) && item.getPlayerID() == -1) {
			item.SetPlayerID(game.player.GetPlayerId());
		}
	});
}

