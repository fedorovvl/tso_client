var avatarAlertSettingsKey = "avatarMessageExclusions";
var avatarAlertTypes = "NewGeneral NewAdmiral NewExplorer NewGeologist DepositDepleted ClaimedSector GeologistStartedFindDeposit GeologistFinishedPositive GeologistFinishedPositiveSecond GeologistFinishedPositiveFailover GeologistFinishedNegative GeologistFinishedNegativeSecond GeologistFinishedNegativeNoDeposit GeologistFinishedNegativeAllAccessible GeneralDistracted GeneralDistractedViewer GeneralStartedAttack GeneralStartedAttackViewer GeneralRetreat GeneralRetreatViewer GeneralLost GeneralLostViewer GeneralWonAndContinues GeneralWonAndContinuesViewer GeneralWonAndReturns GeneralWonAndReturnsViewer GeneralWonAndBlocked GeneralWonAndBlockedViewer GeneralFinishedNegative GeneralFinishedNegativeViewer GeneralFinishedPositive GeneralFinishedPositiveViewer GeneralStartedTransfer GeneralStartedTransferViewer GeneralTravelsToZone GeneralTravelsToStarMenu CannotReachTarget GeneralDidNotFindLandinggrid AdmiralDistracted AdmiralDistractedViewer AdmiralStartedAttack AdmiralStartedAttackViewer AdmiralRetreat AdmiralRetreatViewer AdmiralLost AdmiralLostViewer AdmiralWonAndContinues AdmiralWonAndContinuesViewer AdmiralWonAndReturns AdmiralWonAndReturnsViewer AdmiralFinishedNegative AdmiralFinishedNegativeViewer AdmiralFinishedPositive AdmiralFinishedPositiveViewer AdmiralStartedTransfer AdmiralTravelsToZone AdmiralTravelsToStarMenu AdmiralCannotReachTarget AdmiralDidNotFindLandinggrid ExplorerStarted ExplorerFinishedPositive ExplorerFinishedNegative ExplorerStartedFindTreasure ExplorerFoundTreasure ExplorerDidNotFindTreasure ExplorerStartedFindEventZone ExplorerStartedFindExpeditionZone ExplorerFoundEventZone ExplorerDidNotFindEventZone ExplorerFoundExpeditionZone ExplorerDidNotFindExpeditionZone ExplorerStartedFindAdventureZone ExplorerFoundAdventureZone ExplorerDidNotFindAdventureZone ExplorerFoundMapFragment ServerCallFailed NewQuest NoTools NotEnoughBuildingMaterial NewMail RecruitmentFinished RecruitmentFinishedNewCombat ProductionFinished SkillpointPickUp PurchaseSuccessful PuchaseHardCurrencySuccessful PurchaseGiftSuccessful UsedDepositBuff UsedResourceBuff UsedPopulationResourceBuff UsedPopulationBuffLimitReached UsedHiredTroopBuff UsedHiredTroopBuffToFriend UsedResourceBuffLimitReached QuestRewardLimitReached PlacedBuff ZoneBuff ZoneBuffOnFriend FriendZoneBuff PlacedBuffOnFriend PlacedBuffOnFriendNegative PlacedBuffByFriend PlacedBuffByFriendNegative TradeAcceptedWarehouse PlacedDestroyMountainBuff DestroyMountainBuffReady TradeAccepted TradeAcceptedBuff IncreasedMaxBuildings IncreasedPermanentBuildSlots FriendRequestSent FriendRequestCooldown MailSent LastBuildingLicenseUsed TradeInitiated GuildIncreaseSize GuildIncreaseSizeMail GuildChangesSaved GuildInviteSent GuildLeft GuildDisbanded GuildMemberKicked AdventureStarted ExpeditionStarted AdventureIsFull AdventureHasPlayerAlready AdventureInvitationSent AdventurePlayerWasInvited AdventurePlayerAcceptedInvitation AdventurePlayerDeclinedInvitation AdventurePlayerLeftAdventure AdventurePlayerInvitationCancelled TempBuildSlotRemoved TradeSucess TradeFailed TradeExpired TradeLotSold TradedResourceLimitReached GeneralRecovered AdmiralRecovered FilterActive PremiumAccountActivated PremiumAccountExpired ResourceDonationSuccessful BuffDonationSuccessful ResourceDonationServerGoalReached ResourceDonationReactivated PickedUpCollectible PickedUpCollectibleBuff CollectedPickupInAdventure CollectionReadyForPickup ResourceWithdrawSuccessful BuffWithdrawSuccessful ResourceTransferSuccessful BuffTransferSuccessful GuildBankEnlargeSuccessful GuildBankBuyTabSuccessful MonsterHit MonsterHitByFriend HalloweenBrightLight BuffRedeemed RedeemLimitReached RedNoseAvatarAdd RedNoseAvatarRemove RemovedRandomBandits RemovedBanditUnit RemovedRandomBanditUnit RemovedBanditCamp HealedMayaCamp RemovedFootballCampTrait RevealCollectibles RevealFriendCollectibles AchievementCompleted MoreAchievementsCompleted AchievementResourceReceived AchievementBuffReceived AchievementFacebookSent UnlockedIslandByBuff AvatarMessageEffect AddedRecipe RemovedBuff CollectedEventPickupInAdventure BuffAdventureApplied EventStart QuestAlreadyActive TaskFinished SpecialistGroupReady GeneralReturnedToStar AdmiralReturnedToStarMenu WeeklyTaskGained ChangeSkinBuffApplied StarCoinsPickedUpFromAdventure GeneralInstantRecover GeneralInstantTravel HiredMilitaryFromSkill".split(" ");

var avatarAlertCategoryOrder = [
    "specialists", "production", "trade", "social", "guild", "adventure",
    "buffs", "resources", "collections", "achievements", "events", "system", "other"
];

var avatarAlertCategoryFallbacks = {
    specialists: "Specialists",
    production: "Production",
    trade: "Trade",
    social: "Mail and friends",
    guild: "Guild",
    adventure: "Adventures",
    buffs: "Buffs",
    resources: "Resources and buildings",
    collections: "Collectibles",
    achievements: "Achievements",
    events: "Events",
    system: "System",
    other: "Other"
};

var avatarAlertTranslations = {
    "en-uk": {
        title: "Avatar messages",
        showAll: "Show all",
        hideAll: "Hide all",
        save: "Save",
        specialists: "Specialists",
        production: "Production",
        trade: "Trade",
        social: "Mail and friends",
        guild: "Guild",
        adventure: "Adventures",
        buffs: "Buffs",
        resources: "Resources",
        collections: "Collectibles",
        achievements: "Achievements",
        events: "Events",
        system: "System",
        other: "Other",
        messages: {
            GeologistFinishedPositiveFailover: "Geologist finished searching",
            AdmiralDistractedViewer: "Another player's marshal was intercepted",
            AdmiralStartedAttackViewer: "Another player's marshal is attacking",
            AdmiralRetreatViewer: "Another player's marshal is retreating",
            AdmiralLostViewer: "Another player's marshal lost the battle",
            AdmiralWonAndContinuesViewer: "Another player's marshal won and continues attacking",
            AdmiralWonAndReturnsViewer: "Another player's marshal won and is returning",
            AdmiralFinishedNegativeViewer: "Another player's marshal was wounded",
            AdmiralFinishedPositiveViewer: "Another player's marshal is ready",
            AdmiralCannotReachTarget: "The marshal cannot reach the target",
            AdventureIsFull: "There are no free slots in the adventure",
            AdventureHasPlayerAlready: "The player is already participating in the adventure",
            AdventureInvitationSent: "Adventure invitation sent",
            GuildBankEnlargeSuccessful: "Guild bank storage expanded",
            GuildBankBuyTabSuccessful: "Guild bank tab purchased",
            AvatarMessageEffect: "Effect applied",
            EventStart: "Event started",
            SpecialistGroupReady: "Specialist group is ready",
            GeneralInstantTravel: "General travelled instantly"
        }
    },
    "ru-ru": {
        title: "Сообщения аватара",
        showAll: "Показывать все",
        hideAll: "Скрыть все",
        save: "Сохранить",
        specialists: "Специалисты",
        production: "Производство",
        trade: "Торговля",
        social: "Почта и друзья",
        guild: "Гильдия",
        adventure: "Приключения",
        buffs: "Усилители",
        resources: "Ресурсы",
        collections: "Коллекционные предметы",
        achievements: "Достижения",
        events: "События",
        system: "Системные",
        other: "Разное",
        messages: {
            GeologistFinishedPositiveFailover: "Геолог завершил поиск",
            AdmiralDistractedViewer: "Маршал другого игрока перехвачен",
            AdmiralStartedAttackViewer: "Маршал другого игрока атакует",
            AdmiralRetreatViewer: "Маршал другого игрока отступает",
            AdmiralLostViewer: "Маршал другого игрока проиграл сражение",
            AdmiralWonAndContinuesViewer: "Маршал другого игрока победил и продолжает атаку",
            AdmiralWonAndReturnsViewer: "Маршал другого игрока победил и возвращается",
            AdmiralFinishedNegativeViewer: "Маршал другого игрока ранен",
            AdmiralFinishedPositiveViewer: "Маршал другого игрока готов",
            AdmiralCannotReachTarget: "Маршал не может добраться до цели",
            AdventureIsFull: "В приключении нет свободных мест",
            AdventureHasPlayerAlready: "Игрок уже участвует в приключении",
            AdventureInvitationSent: "Приглашение в приключение отправлено",
            GuildBankEnlargeSuccessful: "Хранилище банка гильдии расширено",
            GuildBankBuyTabSuccessful: "Вкладка банка гильдии приобретена",
            AvatarMessageEffect: "Эффект применён",
            EventStart: "Событие началось",
            SpecialistGroupReady: "Группа специалистов готова",
            GeneralInstantTravel: "Генерал мгновенно перемещён"
        }
    }
};

function avatarAlertTranslation()
{
    return avatarAlertTranslations[gameLang] || avatarAlertTranslations["en-uk"];
}

var avatarAlertCategoryLoca = {
    specialists: ["LAB", "Specialists"],
    production: ["LAB", "Production"],
    trade: ["LAB", "Trade"],
    social: ["LAB", "Mail"],
    guild: ["LAB", "Guild"],
    adventure: ["LAB", "Adventures"],
    buffs: ["LAB", "Buffs"],
    resources: ["LAB", "Resources"],
    collections: ["LAB", "Collectibles"],
    achievements: ["LAB", "Achievements"],
    events: ["LAB", "Events"],
    system: ["LAB", "Messages"],
    other: ["LAB", "Misc"]
};

function avatarAlertIsMissingText(text)
{
    return !text || /undefined text|not found/i.test(text);
}

function avatarAlertLoca(group, id, fallback)
{
    var text;
    try {
        text = loca.GetText(group, id);
    } catch (e) {
        text = null;
    }
    return avatarAlertIsMissingText(text) ? fallback : text;
}

function avatarAlertCategoryName(category)
{
    var key = avatarAlertCategoryLoca[category];
    var translation = avatarAlertTranslation();
    return translation[category] || avatarAlertLoca(key[0], key[1], avatarAlertCategoryFallbacks[category]);
}

function avatarAlertMessageName(type)
{
    var headline = avatarAlertLoca("MEL", type, "");
    var body = avatarAlertLoca("MES", type, "");
    var translation = avatarAlertTranslation();
    return headline || body || translation.messages[type] || type;
}

function avatarAlertCategory(type)
{
    if (/^(NewGeneral|NewAdmiral|NewExplorer|NewGeologist|Geologist|Explorer|General|Admiral|HiredMilitary|SpecialistGroup)/.test(type)) return "specialists";
    if (/^(Recruitment|Production|Skillpoint|TaskFinished)/.test(type)) return "production";
    if (/^(Trade|Traded|Purchase)/.test(type)) return "trade";
    if (/^(NewMail|MailSent|FriendRequest)/.test(type)) return "social";
    if (/^(Guild|ResourceDonation|BuffDonation|ResourceWithdraw|BuffWithdraw|ResourceTransfer|BuffTransfer)/.test(type)) return "guild";
    if (/^(Adventure|Expedition|CollectedPickupInAdventure|CollectedEventPickupInAdventure)/.test(type)) return "adventure";
    if (/(Buff|Premium|Redeem|Recipe|ZoneBuff)/.test(type)) return "buffs";
    if (/^(Deposit|ClaimedSector|NoTools|NotEnoughBuilding|LastBuilding|Increased|TempBuild|ResourceWith|ResourceTransfer)/.test(type)) return "resources";
    if (/^(Collection|PickedUpCollectible|RevealCollectibles|RevealFriendCollectibles)/.test(type)) return "collections";
    if (/Achievement/.test(type)) return "achievements";
    if (/^(Event|Halloween|Monster|RedNose|Removed|Healed|UnlockedIsland|WeeklyTask)/.test(type) || /Football/.test(type)) return "events";
    if (/^(ServerCallFailed|NewQuest|FilterActive|AvatarMessageEffect|QuestAlreadyActive)/.test(type)) return "system";
    return "other";
}

function avatarAlertReadSettings()
{
    var value = settings.read(null, avatarAlertSettingsKey);
    return value instanceof Array ? value : [];
}

function avatarAlertApply(exclusions)
{
    var target = game.def("defines").AVATAR_MESSAGE_EXCLUSIONS;
    target.splice(0, target.length);
    $.each(exclusions || [], function(index, type) {
        if (avatarAlertTypes.indexOf(type) !== -1 && target.indexOf(type) === -1) {
            target.push(type);
        }
    });
}

function avatarAlertEscape(text)
{
    return $("<div>").text(text).html();
}

function avatarAlertShowCategory(windowObject, category)
{
    windowObject.withBody(".avatar-alert-category").hide();
    windowObject.withBody('.avatar-alert-category[data-category="' + category + '"]').show();
    windowObject.withBody(".avatar-alert-tab").removeClass("active");
    windowObject.withBody('.avatar-alert-tab[data-category="' + category + '"]').addClass("active");
}

function avatarAlertBuildBody(exclusions)
{
    var groups = {};
    var html = '<div class="container-fluid avatar-alert-settings">';
    $.each(avatarAlertCategoryOrder, function(index, category) { groups[category] = []; });
    $.each(avatarAlertTypes, function(index, type) { groups[avatarAlertCategory(type)].push(type); });

    html += '<ul class="nav nav-tabs" style="margin-bottom:12px;display:flex;flex-wrap:wrap;">';
    $.each(avatarAlertCategoryOrder, function(index, category) {
        if (!groups[category].length) return;
        html += '<li role="presentation" class="avatar-alert-tab" data-category="' + category + '">' +
            '<a href="#">' + avatarAlertEscape(avatarAlertCategoryName(category)) + '</a></li>';
    });
    html += '</ul>';

    $.each(avatarAlertCategoryOrder, function(index, category) {
        var rows = [];
        if (!groups[category].length) return;
        html += '<div class="avatar-alert-category" data-category="' + category + '">';
        html += '<h4>' + avatarAlertEscape(avatarAlertCategoryName(category)) + '</h4>';
        html += '<div style="margin-bottom:10px;">' +
            '<button type="button" class="btn btn-xs btn-default avatar-alert-select-category">' + avatarAlertEscape(avatarAlertTranslation().showAll) + '</button> ' +
            '<button type="button" class="btn btn-xs btn-default avatar-alert-clear-category">' + avatarAlertEscape(avatarAlertTranslation().hideAll) + '</button>' +
            '</div>';
        $.each(groups[category], function(typeIndex, type) {
            rows.push(
                [5, avatarAlertEscape(avatarAlertMessageName(type))],
                [1, createSwitch("avatar-alert-" + type, exclusions.indexOf(type) === -1)]
            );
            if (rows.length === 4) {
                html += utils.createTableRow(rows, false);
                rows = [];
            }
        });
        if (rows.length) {
            rows.push([5, "&nbsp;"], [1, "&nbsp;"]);
            html += utils.createTableRow(rows, false);
        }
        html += '</div>';
    });
    return html + '</div>';
}

function avatarAlertMenuHandler()
{
    var exclusions = avatarAlertReadSettings();
    var title = avatarAlertTranslation().title;
    var windowObject = new Modal("avatarAlertSettingsWindow", title);
    windowObject.create();
    windowObject.Body().html(avatarAlertBuildBody(exclusions));

    windowObject.Footer().prepend(
        $("<button>").attr({"class": "btn btn-primary"}).text(avatarAlertTranslation().save).click(function() {
            var selected = [];
            windowObject.withBody('.avatar-alert-category input[type="checkbox"]:not(:checked)').each(function() {
                selected.push(this.id.replace("avatar-alert-", ""));
            });
            settings.settings[avatarAlertSettingsKey] = [];
            settings.store(selected, avatarAlertSettingsKey);
            avatarAlertApply(selected);
            windowObject.hide();
        })
    );

    windowObject.withBody(".avatar-alert-tab a").click(function(event) {
        event.preventDefault();
        avatarAlertShowCategory(windowObject, $(this).closest(".avatar-alert-tab").attr("data-category"));
    });
    windowObject.withBody(".avatar-alert-select-category").click(function() {
        $(this).closest(".avatar-alert-category").find('input[type="checkbox"]').prop("checked", true);
    });
    windowObject.withBody(".avatar-alert-clear-category").click(function() {
        $(this).closest(".avatar-alert-category").find('input[type="checkbox"]').prop("checked", false);
    });

    avatarAlertShowCategory(windowObject, avatarAlertCategoryOrder[0]);
    windowObject.show();
}

avatarAlertApply(avatarAlertReadSettings());
addToolsMenuItem(avatarAlertTranslation().title, avatarAlertMenuHandler);

