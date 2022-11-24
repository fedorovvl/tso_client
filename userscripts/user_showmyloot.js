// use addMenuItem from main script
addToolsMenuItem("Show my loot", smlMenuHandler);
var smlRewards = [];
var smlTracker = game.getTracker('sml', smlApliedHandler);
game.gi.channels.ZONE.addPropertyObserver("lootedResource", smlTracker);

function smlMenuHandler(event)
{
	var w = new Modal('smlWindow', utils.getImageTag('icon_dice.png', '45px') + ' '+loca.GetText("LAB", "Rewards"));
	w.size = '';
	w.create();
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += utils.createTableRow([[3, loca.GetText("LAB", "DateAndTime")], [6, loca.GetText("LAB", "Name")], [3, "Link"]], true);
	smlRewards.every(function(item){
		html += utils.createTableRow([
			[3, dtf.format(new window.runtime.Date(item.time))], 
			[6, loca.GetText("ADN", item.name)], 
			[3, $('<a>', { 'href': 'https://tsomaps.com/loot-table/' + item.id }).text(loca.GetText("LAB", "ShowHelp")).prop('outerHTML')]]);
		return true;
	});
	w.Body().html(html + '<div>');
	w.withBody('a').click(function(event) { 
		event.preventDefault();
		air.navigateToURL(new air.URLRequest(this)); 
	});
	w.show();
}

function smlGetSlots(items)
{
	var result = [];
	for(var slot = 0; slot < items.length; slot++){
		const className = window.runtime.flash.utils.getQualifiedClassName(items[slot]);
		if(className != 'Communication.VO::dBuffVO') continue;
		result.push({
			type: items[slot].buffName_string,
			name: items[slot].resourceName_string,
			amount: items[slot].amount,
			slot: (slot + 1)
		});
	}
	return result;
}
function smlApliedHandler(event)
{
	try
	{
		var mailVo = event.data.mailVO;
		if(mailVo.type != 19)
			return;
		var lootData = { 
			nick: game.player.GetPlayerName_string(),
			nickId: game.player.getPlayerID(),
			realm: swmmo.getDefinitionByName("global").gameworld,
			adv: {
				mId: mailVo.id,
				sId: -(mailVo.senderId),
				Tms: mailVo.timestamp / 1000,
				name: mailVo.senderName,
				isPrem: event.data.premiumItems.length > 0,
				loot: smlGetSlots(event.data.items),
				premLoot: event.data.premiumItems.length > 0 ? smlGetSlots(event.data.premiumItems) : []
			}
		};
		const result = window.btoa(unescape(encodeURIComponent(JSON.stringify(lootData))));
		smlRewards.push({name: mailVo.senderName, time: mailVo.timestamp, id: mailVo.id});
		$.post( "http://loots.tsomaps.com/loots/", { raw: result }, function( data ) {
			if(data != 'error') {
				game.chatMessage("Loot uploaded", 'sml');
			} else {
				game.chatMessage("Error uploading loot", 'sml');
			}
		});
	} catch(e) {
		game.chatMessage("Error processing loot " + e, 'sml');
	}
}

