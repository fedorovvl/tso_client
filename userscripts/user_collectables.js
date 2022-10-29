addToolsMenuItem(loca.GetText("LAB", "WarehouseTab7") + " (Ctrl + F4)", _exudHLColl, 115, true);
						
function _exudHLColl(event) {
	var x = new TimedQueue(1000);
	var col = swmmo.getDefinitionByName("Collections::CollectionsManager").getInstance();
	var extra = {}
	if (swmmo.application.mGameInterface.mCurrentPlayer.mIsAdventureZone) {
		var Quest_vector = swmmo.application.mGameInterface.mNewQuestManager.GetQuestPool().GetQuest_vector();
		for(qKey in Quest_vector){
			if (Quest_vector[qKey].isFinished() || !Quest_vector[qKey].IsQuestActive()) { continue; }
			var questTriggers = Quest_vector[qKey].mQuestDefinition.questTriggers_vector;
			for(tKey in questTriggers) {
				if (questTriggers[tKey].name_string != null && questTriggers[tKey].name_string != '') {
					extra[questTriggers[tKey].name_string] = true;
				}
			};
		};
	}
	
	
	swmmo.application.mGameInterface.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector().forEach(function(item){
		if(item == null) { return; }
		if(
			col.getBuildingIsNormalCollectible(item.GetBuildingName_string()) || col.getBuildingIsEventCollectible(item.GetBuildingName_string()) 
			|| (
					extra[item.GetBuildingName_string()] && item.mIsSelectable && item.GetGOContainer().mIsAttackable  && !item.GetGOContainer().mIsLeaderCamp
					&& item.GetGOContainer().ui != "enemy" && (item.GetArmy() == null || !item.GetArmy().HasUnits())				
				)
		  ) {
				x.add(function(){ swmmo.application.mGameInterface.SelectBuilding(item); });
			}
		});	
	
	if(x.len() == 0) {
		showAlert("No collectibles found", false, 'warning');
		return;
	}
	showAlert("Command Sent", false, 'success');	
	x.run();
}

