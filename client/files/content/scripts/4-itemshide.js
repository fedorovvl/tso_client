var hideItemsTracker = game.getTracker('itemsHide', hideItemsHandler);
game.gi.channels.ZONE.addPropertyObserver("ZONE_REFRESHED", hideItemsTracker);
game.gi.mCurrentPlayer.addPropertyObserver("starMenuUpdated", hideItemsTracker);
var itemsHideVector = {};
var itemsHideAllVector = {};
$.extend(itemsHideVector, settings.read(null, "itemsHide"));
const hideItemsGroup = {
    "AddResource":              "res",
    "FillDeposit":              "res",
    "PremiumAccount":           "buffs",
    "ProductivityBuff":         "buffs",
    "ProductivityAreaBuff":     "buffs",
    "SpeedUpPopulationGrowth":  "buffs",
    "RecruitingBuff":           "buffs",
    "ProvisionerBuff":          "buffs",
    "EventBuff":                "buffs",
    "HalloweenEvent":           "buffs",
    "AddRecipe":                "buffs",
    "EmptyEffectBuff":          "buffs",
    "#donate-resource#":        "buffs",
    "MultiplierBuffZone":       "buffs",
    "EffectBuff":               "buffs",
    "RemoveBuff":               "buffs",
    "BattleBuff":               "buffs",
    "BookbinderBuff":           "buffs",
    "ShuffleCollectibles":      "buffs",
    "AnimalBuff":               "buffs",
    "RevealCollectiblesBuff":   "buffs",
    "ChangeColorScheme":        "buffs",
    "ChangeSkin":               "buffs",
    "ChangeDefaultSkin":        "buffs",
    "EventMonsterBuff":         "buffs",
    "GeneralSpeed":             "buffs",
    "BuildBuilding":            "builds",
    "BuildDefenseModeBuilding": "builds",
    "Adventure":                "advs",
    "RarityArea":               "misc",
    "QuestStart":               "misc",
    "HiredMilitary":            "misc",
    "ChangeAvatar":             "misc",
    "MountainDemolition":       "misc"
};
hideItemsHandler(null);

function hideItemsHandler(event)
{
    try{
        var deleteCandidates = [];
        game.gi.mCurrentPlayer.mAvailableBuffs_vector.forEach(function(item){
            if(itemsHideVector[item.GetType()+"|"+item.GetResourceName_string()]) {
                deleteCandidates.push(item.GetUniqueId());
            }
        });
        deleteCandidates.map(function(item) { game.gi.mCurrentPlayer.removeBuffFromVector(item); });
    } catch (e) { debug(e); }
}
    
function hideItemsGetList()
{
    itemsHideAllVector = {};
    game.gi.mCurrentPlayer.mAvailableBuffs_vector.forEach(function(item){
        itemsHideAllVector[item.GetType()+"|"+item.GetResourceName_string()] = { icon: item.GetBuffIconData() };
    });
    $.extend(itemsHideAllVector, itemsHideVector);
    return itemsHideAllVector;
}

function hideItemgetGroupName(item)
{
    for(type in hideItemsGroup) {
        if(item.indexOf(type) != -1) { return hideItemsGroup[type]; }
    }
    return "misc";
}

function hideItemsGetName(type, name)
{
    if(type == "Adventure") { 
        return loca.GetText("ADN", name);
    }
    if(type == "FillDeposit" && name == "") { type += "Any"; }
    return loca.GetText("RES", type, ["", name]);
}

function hideItemsMenuHandler(event)
{
    var w = new Modal('hideItemsWindow', utils.getImageTag('icon_dice.png', '45px') + ' ' + getText('itemshide_desc'));
    w.create();
    if(w.withFooter('#hideItemsresBtn').length == 0) {
        w.Footer().prepend([
            $("<button>").attr({'class':"btn btn-primary"}).text(getText('btn_reset')).click(function(){
				itemsHideVector = {};
                settings.settings["itemsHide"] = {};
                settings.store(itemsHideVector, "itemsHide");
                menuZoneRefreshHandler(null);
                w.hide();
            }),
			$("<button>").attr({'class':"btn btn-primary"}).text(loca.GetText("LAB","Save")).click(function(){
                settings.settings["itemsHide"] = {};
                settings.store(itemsHideVector, "itemsHide");
                menuZoneRefreshHandler(null);
                w.hide();
            }),
            $('<button>').attr({ "id": "hideItemsresBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("LAB", "Resources")),
            $('<button>').attr({ "id": "hideItemsbuffsBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("LAB", "Buffs")),
            $('<button>').attr({ "id": "hideItemsbuildsBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("LAB", "Buildings")),
            $('<button>').attr({ "id": "hideItemsadvsBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("LAB", "Adventures")),
            $('<button>').attr({ "id": "hideItemsmiscBtn", "class": "btn btn-primary pull-left" }).text(loca.GetText("LAB", "Misc"))
        ]);
        
        w.withFooter('#hideItemsresBtn, #hideItemsbuffsBtn, #hideItemsbuildsBtn, #hideItemsadvsBtn, #hideItemsmiscBtn').click(function(event) {
            var type = this.id.replace("hideItems", "").replace("Btn", "");
            w.withBody('div.row').find('.type'+type).closest('div.row').show();
            w.withBody('div.row').find(':first:not(.type'+type+')').closest('div.row').hide();
        });
    }
    if(w.withHeader('.container-fluid').length == 0) {
        w.withHeader('').append('<div class="container-fluid"><br>' + utils.createTableRow([[5, loca.GetText("LAB", "Name")], [1, loca.GetText("LAB", "GuildOnlineLast24")],[5, loca.GetText("LAB", "Name")], [1, loca.GetText("LAB", "GuildOnlineLast24")]], true) + '</div>');
    }
    var html = '<div class="container-fluid" style="user-select: all;">';
    var list = hideItemsGetList();
	var rows = [];
    $.each(Object.keys(list).sort(), function(i, item) {
        var typeName = item.split("|");
		rows.push([5, getImageByModule(list[item].icon[0], list[item].icon[1], 24, 24) + "  " + hideItemsGetName(typeName[0], typeName[1]), 'type'+ hideItemgetGroupName(typeName[0])], [1, createSwitch(item, !itemsHideVector[item])]);
		if(rows.length == 4) {
			html += utils.createTableRow(rows, false);
			rows = [];
		}
    });
	if(rows.length == 2) {
		rows.push([5, '&nbsp;'], [1, '&nbsp;']);
		html += utils.createTableRow(rows, false);
	}
    w.Body().html(html + '<div>');
    w.withBody('div.row').find(':first:not(.typeres)').closest('div.row').hide();
    w.withBody('[type=checkbox]').change(function(e) {
        if($(e.target).is(':checked') && $(e.target).attr('id') in itemsHideVector) {
            delete itemsHideVector[$(e.target).attr('id')];
            return;
        }
        if($(e.target).not(':checked') && !($(e.target).attr('id') in itemsHideVector)) {
            itemsHideVector[$(e.target).attr('id')] = itemsHideAllVector[$(e.target).attr('id')];
        }
    });
    w.show();
}
