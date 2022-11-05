var aucConfig = {};
var currentAuc;
var aucShopItem = swmmo.getDefinitionByName("ShopSystem::cShopItem");
var aucResponderDef = swmmo.getDefinitionByName("ServerState::ResponderSimple");
var aucResponder = new aucResponderDef(aucResultResponseHandler, aucFailResponseHandler);
var aucUnlockResponder = new aucResponderDef(aucUnlockResultResponseHandler, aucFailResponseHandler);
var aucLoaderDef = swmmo.getDefinitionByName("nLib::TSOURLLoader");
var resources = swmmo.application.mGameInterface.mCurrentPlayerZone.GetResources(swmmo.application.mGameInterface.mCurrentPlayer);
var aucLoader = new aucLoaderDef();
var bidPacket = null;
aucLoader.addEventListener(air.Event.COMPLETE, aucCompleteURLHandler);
aucLoader.loadFile("black_market_auction_config.xml");
window.runtime.flash.net.registerClassAlias(
	"defaultGame.Communication.VO.BlackMarketAuction.dBlackMarketAuctionStateVO", 
	window.runtime.Communication.VO.BlackMarketAuction.dBlackMarketAuctionStateVO
);
window.runtime.flash.net.registerClassAlias(
	"defaultGame.Communication.VO.BlackMarketAuction.dBlackMarketAuctionBidVO", 
	window.runtime.Communication.VO.BlackMarketAuction.dBlackMarketAuctionBidVO
);
addMenuItem(loca.GetText("LAB", "BlackMarketAuction") + " (F6)", menuAuctionHandler, 117);

function aucCompleteURLHandler(event)
{
	aucConfig = xmlToJSON.parseString(event.target.data, { attrsAsObject: false, valueKey: 'v', attrKey: '', childrenAsArray: false});
	aucReloadData();
}

function menuAuctionHandler(event)
{
	$( "div[role='dialog']:not(#aucModal):visible").modal("hide");
	createModalWindow('aucModal', getImageTag('icon_logistics.png') + ' '+loca.GetText("LAB", "BlackMarketAuction"));
	if($('#aucModal .aucPlace').length == 0)
	{
		$("#aucModal .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-success aucPlace" }).text(getText('auc_do_bid')),
			$('<button>').attr({ "class": "btn btn-success aucUnlock" }).text(loca.GetText("LAB", 'QuestFinish')),
			$('<button>').attr({ "class": "btn btn-primary pull-left aucReload" }).text(getText('btn_reload'))
		]);
		$('#aucModal .aucPlace').click(auxPlaceBet);
		$('#aucModal .aucUnlock').click(aucUnlock);
		$('#aucModal .aucReload').click(aucReloadData);
	}
	$('#aucModal .aucPlace').attr('disabled', true);
	$('#aucModal .aucUnlock').hide();
	out = '<div class="container-fluid">';
	if(!swmmo.application.mGameInterface.mHomePlayer.mBlackMarketUnlocked)
	{
		out = '<p class="text-center">{0} 10000 {1}'.format(loca.GetText("LAB", 'BlackMarketAuctionUnlockCost'), getImageTag("Coin"));
		out += '<p class="text-center">' + loca.GetText("LAB", 'BlackMarketAuctionUnlock') + '</p>';
		$('#aucModal .aucUnlock').show();
		$('#aucModal .aucUnlock').attr("disabled", (resources.GetResourceAmount("Coin") < 10000));
		if(resources.GetResourceAmount("Coin") < 10000) {
			out += '<br><br><p class="text-center">' + loca.GetText("ALM", 'ItemPurchaseMissingResource') + '</p>';
		}
	} else if(currentAuc == undefined) {
		out = '<p class="text-center">' + loca.GetText("LAB", 'BlackMarketAuctionInactive') + '</p>';
	} else {
		var aucDefinition = getCurrentAuc();
		out = '<p>{0} {1}</p>'.format(getText('auc_current'), currentAuc.auctionId);
		out += '<p>'+loca.GetText("LAB", 'BlackMarketAuctionBidder')+' ' + currentAuc.playerName + '</p>';
		out += '<p>{0} {1}</p>'.format(getText('auc_bidding_count'), currentAuc.biddingCount);
		endTime = currentAuc.endTime - new Date().getTime();
		out += '<p>{0} {1}</p>'.format(getText('auc_endtime'), endTime > 0 ? loca.FormatDuration(endTime) : getText('auc_ended'));
		out += '<p><br></p>';
		var aucItem = aucShopItem.GetShopItem(aucDefinition.Content.Item.shopItemId.v);
		out += '<p>{0} {2} {1}</p>'.format(getText('auc_item'), loca.GetText("SHI", aucItem.GetName_string()), getImageTag(aucItem.GetName_string()));
		out += '<p>{0} {1}</p>'.format(getText('auc_item_desc'), loca.GetText("SD3", aucItem.GetName_string()));
		out += '<p>{0} {1} {2}</p>'.format(getText('auc_initial_cost'), aucDefinition.Costs.Cost.count.v, loca.GetText("RES", aucDefinition.Costs.Cost.name.v));
		out += '<p>{0} {1}</p>'.format(getText('auc_increment'), aucDefinition.AuctionIncrements.AuctionIncrement.count.v);
		var nextBet = (aucDefinition.AuctionIncrements.AuctionIncrement.count.v * currentAuc.biddingCount) + aucDefinition.Costs.Cost.count.v;
		out += '<p>{0} {1} {2}</p>'.format(getText('auc_bid_for'), nextBet, loca.GetText("RES", aucDefinition.Costs.Cost.name.v));
		out += '<p>{0} {1} {2}</p>'.format(getText('auc_you_have'), resources.GetResourceAmount(aucDefinition.Costs.Cost.name.v), loca.GetText("RES", aucDefinition.Costs.Cost.name.v));
		if(resources.GetResourceAmount(aucDefinition.Costs.Cost.name.v) > nextBet && !aucCheckPlayer() && endTime > 0) {
			$('#aucModal .aucPlace').attr('disabled', false);
		}
		if(aucCheckPlayer())
		{
			out += '<br><p>{0}</p>'.format(getText('auc_your_max'));
		}
	}
	out += '</div>';
	$("#aucModalData").html(out);
	$('#aucModal:not(:visible)').modal({backdrop: "static"});
}

function aucCheckPlayer()
{
	return swmmo.application.mGameInterface.mCurrentPlayer.GetPlayerName_string() == currentAuc.playerName;
}

function getCurrentAuc()
{
	for(i = 0; i < aucConfig.BlackMarketConfig.BlackMarketAuctions.BlackMarketAuction.length; i++) {
		if(aucConfig.BlackMarketConfig.BlackMarketAuctions.BlackMarketAuction[i].id.v == currentAuc.auctionId) {
			return aucConfig.BlackMarketConfig.BlackMarketAuctions.BlackMarketAuction[i];
		}
	}
	return null;
}

function aucFailResponseHandler(event, data)
{
	alert("error " + data);
	menuAuctionHandler(null);
}

function aucResultResponseHandler(event, data)
{
	currentAuc = data.data;
	if(bidPacket) {
		try
		{
			var aucDefinition = getCurrentAuc();
			var nextBet = (aucDefinition.AuctionIncrements.AuctionIncrement.count.v * bidPacket.biddingCount) + aucDefinition.Costs.Cost.count.v;
			resources.AddResource(aucDefinition.Costs.Cost.name.v, -nextBet, 14, null);
			bidPacket = null;
		} catch(e) { alert(e); }
	}
	if($('#aucModal .aucPlace').length > 0)
	{
		menuAuctionHandler(null);
	}
}
function aucUnlockResultResponseHandler(event, data)
{
	swmmo.application.mGameInterface.mHomePlayer.mBlackMarketUnlocked = true;
	resources.AddResource("Coin", -10000, 14, null);
	menuAuctionHandler(null);
}

function aucReloadData()
{
	swmmo.application.mGameInterface.SendServerActionSimple(15000, null, aucResponder);
	$('#aucModal .aucReload').attr("disabled", true);
	setTimeout(function() { $('#aucModal .aucReload').removeAttr("disabled"); }, 10000);
}

function auxPlaceBet()
{
	bidPacket = new window.runtime.Communication.VO.BlackMarketAuction.dBlackMarketAuctionBidVO()
	bidPacket.auctionId = currentAuc.auctionId;
	bidPacket.biddingCount = currentAuc.biddingCount;
	swmmo.application.mGameInterface.mClientMessages.SendMessagetoServer(15001, swmmo.application.mGameInterface.mCurrentViewedZoneID, bidPacket, aucResponder);
	$('#aucModal .aucPlace').attr("disabled", true);
	setTimeout(function() { $('#aucModal .aucPlace').removeAttr("disabled"); }, 10000);
}

function aucUnlock()
{
	swmmo.application.mGameInterface.mClientMessages.SendMessagetoServer(15002, swmmo.application.mGameInterface.mCurrentViewedZoneID, null, aucUnlockResponder);
	$('#aucModal .aucUnlock').attr("disabled", true);
}
