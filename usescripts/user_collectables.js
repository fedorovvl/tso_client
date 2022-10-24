
addToolsMenuItem("Collectables" + " (Ctrl + F4)", _exudHLColl, 115, true);

function _exudHLColl(event) {
	try 
	{
		var offset_sec = 1000;
		var offset_func = 1000;
		var GI = swmmo.application.mGameInterface;
		var _Buildings = GI.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector();
		if (_Buildings == null || typeof _Buildings == "undefined") {
			alert("Error loading building vector !");
			return;
		}

		var nBuildings = _Buildings.length;
		var collection_manager = swmmo.getDefinitionByName("Collections::CollectionsManager").getInstance();
		var y = 0;

		for (y = 0 ; y < nBuildings ; y++) {
			var building = _Buildings[y];
			if (building != null)
			try {
				var okSelect = false;
				if (building.mIsSelectable) 
					if (collection_manager.getBuildingIsCollectible(building.GetBuildingName_string()) ||
						collection_manager.isCollectibleResource(building.GetBuildingName_string())
					) 
					{
						setTimeout(_exudSelectColl, offset_func, building);
						offset_func += offset_sec;
					}
								
			}
			catch (err1) {
			}
		}	

		try {
			if (GI.mCurrentPlayer.mIsAdventureZone) {
				var qPool = GI.mNewQuestManager.GetQuestPool();
				var ids = qPool.GetQuest_vector(); // dQuestElementVO[]

				if (!(ids == null || ids == undefined)) {
					var nIDS = 0;
					nIDS = ids.length;
					y = 0;
					for (y = 0 ; y < nIDS ; y++) {
						var qe = ids[y];
						if (!qe.isFinished() && qe.IsQuestActive()) {
							var dqdVO = qe.mQuestDefinition;
							var items = dqdVO.questTriggers_vector; // dQuestDefinitionTriggerVO[]
							if (!(items == null || items == undefined)) {
								var ni = 0;
								ni = items.length;
								var z = 0;
								for (z = 0 ; z < ni ; z++) {
									var item = items[z]; //dQuestDefinitionTriggerVO
									if (item.name_string != null && item.name_string != '')
									{
										_exudSelectBuilding(_Buildings, item.name_string, offset_func);
										offset_func += offset_sec;
									}

									
								}
							}
						}
						
					}
				}
			}
		}
		catch (error3) {
		}

		showAlert("Command Sent", false, 'success');	
	}
	catch (error) {
		alert(error.message);
	}

}

function _exudSelectColl(c)
{
	try{
	swmmo.application.mGameInterface.SelectBuilding(c);
	}
	catch (error) {
	}
}

function _exudSelectBuilding(_Buildings, name, to) {
	var nBuildings = 0;
	nBuildings = _Buildings.length;
	var nb = 0;
	var lp = 0;
	for (nb = 0 ; nb < nBuildings ; nb++) {
		var building = _Buildings[nb];
		if (building != null && building.mIsSelectable && (building.GetBuildingName_string() == name)) 
			setTimeout(_exudSelectColl, to + (lp++ * 500), building);
	}
}
