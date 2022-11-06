addToolsMenuItem(loca.GetText("LAB", "WarehouseTab7") + " (Ctrl + F4)", _exudHLColl, 115, true);

function _exudHLColl(event) {
    var collectionsManager = swmmo.getDefinitionByName("Collections::CollectionsManager").getInstance(),
        queue = new TimedQueue(1000),
        questTriggersMap = {},
        mGameInterface = swmmo.application.mGameInterface,
        questVector, questVectors, questTriggerNameString, questTriggers, itemBuildingName, itemGOContainer;
    if (mGameInterface.mCurrentPlayer.mIsAdventureZone) {
        questVectors = mGameInterface.mNewQuestManager.GetQuestPool().GetQuest_vector();
        for (var questVectorName in questVectors){
            questVector = questVectors[questVectorName];
            if (!(questVector.isFinished() || !questVector.IsQuestActive())) {
                questTriggers = questVector.mQuestDefinition.questTriggers_vector;
                for (var questTriggerName in questTriggers) {
                    questTriggerNameString = questTriggers[questTriggerName].name_string;
                    if (questTriggerNameString != null && questTriggerNameString !== '') {
                        questTriggersMap[questTriggerNameString] = true;
                    }
                }
            }
        }
    }

    mGameInterface.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector().forEach(function(item){
        if (item === null) {
            return;
        }
        itemBuildingName = item.GetBuildingName_string();
        itemGOContainer = item.GetGOContainer();
        if (
            collectionsManager.getBuildingIsNormalCollectible(itemBuildingName) ||
            collectionsManager.getBuildingIsEventCollectible(itemBuildingName) ||
            (
                questTriggersMap[itemBuildingName] &&
                item.mIsSelectable &&
                itemGOContainer.mIsAttackable &&
                !itemGOContainer.mIsLeaderCamp &&
                itemGOContainer.ui !== "enemy" &&
                (item.GetArmy() == null || !item.GetArmy().HasUnits())
            )
        ) {
            queue.add(function(){
                mGameInterface.SelectBuilding(item);
            });
        }
    });

    if (queue.len() === 0) {
        showGameAlert("No collectibles found");
        return;
    }
    showGameAlert(getText('command_sent'));
    queue.run();
}
