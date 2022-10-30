addMenuItem(loca.GetText("LAB", "Update") + " (F2)", menuZoneRefreshHandler, 113);

function menuZoneRefreshHandler(event)
{
	swmmo.application.mGameInterface.mClientMessages.SendMessagetoServer(1037, swmmo.application.mGameInterface.mCurrentViewedZoneID, null);
	showGameAlert("Refresh zone packet sent. Wait for refresh...");
}