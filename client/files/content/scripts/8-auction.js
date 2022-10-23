var aucConfig = {};
var aucInit = true;
var currentAuc;
var aucShopItem = swmmo.getDefinitionByName("ShopSystem::cShopItem");
var aucResponderDef = swmmo.getDefinitionByName("ServerState::ResponderSimple");
var aucResponder = new aucResponderDef(aucResultResponseHandler, aucFailResponseHandler);
var aucLoaderDef = swmmo.getDefinitionByName("nLib::TSOURLLoader");
var aucLoader = new aucLoaderDef();
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
$("#aucModal").on('show.bs.modal hide.bs.modal', function(){ window.nativeWindow.stage.swapChildrenAt(0, 1); });
addMenuItem(loca.GetText("LAB", "BlackMarketAuction") + " (F6)", menuAuctionHandler, 117);

function aucCompleteURLHandler(event)
{
	aucConfig = xmlToJSON.parseString(event.target.data, { attrsAsObject: false, valueKey: 'v', attrKey: '', childrenAsArray: false});
	aucReloadData();
}

function menuAuctionHandler(event)
{
	if(aucInit) { 
		showAlert("Initializing...", false, 'warning');
		return; 
	}
	$( "div[role='dialog']:not(#aucModal):visible").modal("hide");
	$('#auxPlaceBet').hide();
	out = '<div class="container-fluid">';
	if(currentAuc == undefined) {
		out = '<p class="text-center">Please reload data</p>';
	} else {
		var aucDefinition = getCurrentAuc();
		out = '<p>Current auctionId: ' + currentAuc.auctionId + '</p>';
		out += '<p>Player with max bet: ' + currentAuc.playerName + '</p>';
		out += '<p>Bidding count: ' + currentAuc.biddingCount + '</p>';
		out += '<p>End time: ' + loca.FormatDuration(currentAuc.endTime - new Date().getTime()) + '</p>';
		out += '<p><br><br></p>';
		var aucItem = aucShopItem.GetShopItem(aucDefinition.Content.Item.shopItemId.v);
		out += '<p>Auction item: ' + loca.GetText("SHI", aucItem.GetName_string()) + '</p>';
		out += '<p>Item description: ' + loca.GetText("SD3", aucItem.GetName_string()) + '</p>';
		out += '<p>Initial cost: ' + aucDefinition.Costs.Cost.count.v + ' ' +loca.GetText("RES", aucDefinition.Costs.Cost.name.v) + '</p>';
		out += '<p>Inrement by: ' + aucDefinition.AuctionIncrements.AuctionIncrement.count.v + '</p>';
		var nextBet = (aucDefinition.AuctionIncrements.AuctionIncrement.count.v * currentAuc.biddingCount) + aucDefinition.Costs.Cost.count.v;
		out += '<p>Place bet for: ' + nextBet + ' ' + loca.GetText("RES", aucDefinition.Costs.Cost.name.v) + '</p>';
		var resources = swmmo.application.mGameInterface.mCurrentPlayerZone.GetResources(swmmo.application.mGameInterface.mCurrentPlayer);
		out += '<p>You have: ' + resources.GetResourceAmount(aucDefinition.Costs.Cost.name.v) + ' ' + loca.GetText("RES", aucDefinition.Costs.Cost.name.v) + '</p>';
		if(resources.GetResourceAmount(aucDefinition.Costs.Cost.name.v) > nextBet && !aucCheckPlayer()) {
			$('#auxPlaceBet').show();
		}
		if(aucCheckPlayer())
		{
			out += '<br><p>Your bet is max, so you cant place another bet</p>';
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
	alert("error reload data");
}

function aucResultResponseHandler(event, data)
{
	currentAuc = data.data;
	if(aucInit) { 
		aucInit = false;
		return;
	}
	menuAuctionHandler(null);
}

function aucReloadData()
{
	swmmo.application.mGameInterface.SendServerActionSimple(15000, null, aucResponder);
	$('#aucReloadData').attr("disabled", true);
	setTimeout(function() { $('#aucReloadData').removeAttr("disabled"); }, 10000);
}

function auxPlaceBet()
{
	var bidPacket = new window.runtime.Communication.VO.BlackMarketAuction.dBlackMarketAuctionBidVO()
	bidPacket.auctionId = currentAuc.auctionId;
	bidPacket.biddingCount = currentAuc.biddingCount;
	swmmo.application.mGameInterface.mClientMessages.SendMessagetoServer(15001, swmmo.application.mGameInterface.mCurrentViewedZoneID, bidPacket, aucResponder);
	$('#auxPlaceBet').attr("disabled", true);
	setTimeout(function() { $('#auxPlaceBet').removeAttr("disabled"); }, 10000);
}
