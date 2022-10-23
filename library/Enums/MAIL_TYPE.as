// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//Enums.MAIL_TYPE

package Enums
{
    public class MAIL_TYPE 
    {

        public static const MAIL:int = 0;
        public static const TRADE:int = 1;
        public static const FRIEND_REQUEST:int = 2;
        public static const GUILD_INVITE:int = 3;
        public static const TRADE_ACCEPTED:int = 4;
        public static const TRADE_DECLINED:int = 5;
        public static const TREASURE_LOOT:int = 6;
        public static const BANDITS_LOOT:int = 7;
        public static const BATTLE_REPORT:int = 8;
        public static const GIFT:int = 9;
        public static const BUFF:int = 10;
        public static const BUFFED_BUILDING:int = 11;
        public static const HARD_CURRENCY_PURCHASED:int = 12;
        public static const BUFFED_DEPOSIT:int = 13;
        public static const DEPRECATED_TRADE_MAIL:int = 14;
        public static const DEPRECATED_TRADE_MAIL_ACCEPTED:int = 15;
        public static const DEPRECATED_TRADE_MAIL_DECLINED:int = 16;
        public static const FRIEND_INVITATION_CONFIRMED:int = 17;
        public static const INVITED_FRIEND_PURCHASED:int = 18;
        public static const ADVENTURE_WON_LOOT:int = 19;
        public static const GUILD_INVITE_DECLINE:int = 20;
        public static const GUILD_INVITE_FULL:int = 21;
        public static const GUILD_KICK:int = 22;
        public static const INVITE_TO_ADVENTURE:int = 23;
        public static const ADVENTURE_LOST_LOOT:int = 24;
        public static const FIND_ADVENTURE_LOOT_POSITIVE:int = 25;
        public static const FIND_ADVENTURE_LOOT_NEGATIVE:int = 26;
        public static const FIND_ADVENTURE_LOOT_MAP_FRAGMENT:int = 27;
        public static const QUEST_LOOT:int = 28;
        public static const BATTLE_REPORT_INTERCEPTED:int = 29;
        public static const COOPERATION_REWARD:int = 30;
        public static const NPC_MAIL:int = 31;
        public static const LOCA_LOOT_MAIL:int = 32;
        public static const NPC_MAIL_LOOT:int = 33;
        public static const GUILD_SUCCESSION_REQUEST:int = 34;
        public static const GUILD_LEADER_CHANGED:int = 35;
        public static const GUILD_NEW_LEADER:int = 36;
        public static const GUILD_OLD_LEADER:int = 37;
        public static const GUILD_SUCCESSION_DECLINED:int = 38;
        public static const GUILD_SUCCESSION_EXPIRED:int = 39;
        public static const GUILD_SUCCESSION_DUE_TO_INACTIVE:int = 40;
        public static const TREASURE_LOOT_SKILLED:int = 41;
        public static const FIND_ADVENTURE_LOOT_POSITIVE_SKILLED:int = 42;
        public static const FIND_ADVENTURE_LOOT_MAP_FRAGMENT_SKILLED:int = 43;
        public static const TREASURE_LOOT_TRAVELLINGERUDITE:int = 44;
        public static const TREASURE_LOOT_BEANACOLOADA:int = 45;
        public static const COLLECTIBLE_REWARDS:int = 46;
        public static const GUILD_APPLY:int = 47;
        public static const GUILD_APPLY_ACCEPTED:int = 48;
        public static const GUILD_APPLY_DECLINED:int = 49;
        public static const EVENT_LOOT_REWARDS_CURRENT_USER:int = 50;
        public static const EVENT_LOOT_REWARDS_FRIEND_USER:int = 51;
        public static const EVENT_MONSTER_HIT_BY_FRIEND:int = 52;
        public static const FIND_EXPEDITION_LOOT_POSITIVE:int = 53;
        public static const FIND_EXPEDITION_LOOT_NEGATIVE:int = 54;
        public static const PVP_COMBAT_REPORT_ATTACKER_WON:int = 55;
        public static const PVP_COMBAT_REPORT_DEFENDER_WON:int = 56;
        public static const EXPEDITION_WON_LOOT:int = 57;
        public static const EXPEDITION_LOST_LOOT:int = 58;
        public static const PVP_COMBAT_REPORT_DEFENDER_LOST:int = 59;
        public static const PVP_COMBAT_REPORT_ATTACKER_LOST:int = 60;
        public static const ADVENTURE_LOCKED_COMPENSATION:int = 61;
        public static const EXPEDITION_LOCKED_COMPENSATION:int = 62;
        public static const ADVENTURE_FAILED_CANCELLED:int = 63;
        public static const ADVENTURE_LEAVE_NOTIFICATION:int = 64;
        public static const ADVENTURE_CANCEL_INVITATION:int = 65;
        public static const NOSQL_ERROR_NO_MAILS_COULD_BE_LOADED_FROM_ARCHIVE:int = 66;
        public static const HARD_CURRENCY_REMOVED:int = 67;
        public static const LOCA_MAIL:int = 68;
        public static const BLACKMARKET_MAIL:int = 69;


        public static function isImportant(_arg_1:int):Boolean
        {
            switch (_arg_1)
            {
                case TRADE:
                case TRADE_ACCEPTED:
                case TRADE_DECLINED:
                case GUILD_INVITE:
                case FRIEND_REQUEST:
                case INVITE_TO_ADVENTURE:
                case GUILD_APPLY:
                case GUILD_SUCCESSION_REQUEST:
                    return (true);
            };
            return (false);
        }

        public static function isDeletable(_arg_1:int):Boolean
        {
            switch (_arg_1)
            {
                case MAIL_TYPE.TRADE:
                case MAIL_TYPE.INVITE_TO_ADVENTURE:
                case MAIL_TYPE.TRADE_ACCEPTED:
                case MAIL_TYPE.TRADE_DECLINED:
                case MAIL_TYPE.COOPERATION_REWARD:
                case MAIL_TYPE.COLLECTIBLE_REWARDS:
                case MAIL_TYPE.GIFT:
                case MAIL_TYPE.BUFF:
                case MAIL_TYPE.ADVENTURE_WON_LOOT:
                case MAIL_TYPE.ADVENTURE_LOST_LOOT:
                case MAIL_TYPE.BANDITS_LOOT:
                case MAIL_TYPE.FIND_ADVENTURE_LOOT_POSITIVE:
                case MAIL_TYPE.FIND_ADVENTURE_LOOT_POSITIVE_SKILLED:
                case MAIL_TYPE.FIND_ADVENTURE_LOOT_MAP_FRAGMENT:
                case MAIL_TYPE.FIND_ADVENTURE_LOOT_MAP_FRAGMENT_SKILLED:
                case MAIL_TYPE.FIND_EXPEDITION_LOOT_POSITIVE:
                case MAIL_TYPE.LOCA_LOOT_MAIL:
                case MAIL_TYPE.NPC_MAIL_LOOT:
                case MAIL_TYPE.QUEST_LOOT:
                case MAIL_TYPE.TREASURE_LOOT:
                case MAIL_TYPE.TREASURE_LOOT_SKILLED:
                case MAIL_TYPE.TREASURE_LOOT_TRAVELLINGERUDITE:
                case MAIL_TYPE.TREASURE_LOOT_BEANACOLOADA:
                case MAIL_TYPE.EVENT_LOOT_REWARDS_CURRENT_USER:
                case MAIL_TYPE.EVENT_LOOT_REWARDS_FRIEND_USER:
                case EXPEDITION_WON_LOOT:
                case EXPEDITION_LOST_LOOT:
                case ADVENTURE_LOCKED_COMPENSATION:
                case EXPEDITION_LOCKED_COMPENSATION:
                    return (false);
            };
            return (true);
        }

        public static function toString(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case MAIL:
                    return ("Mail");
                case TRADE:
                    return ("Trade");
                case FRIEND_REQUEST:
                    return ("FriendRequest");
                case GUILD_INVITE:
                    return ("GuildInvite");
                case TRADE_ACCEPTED:
                    return ("TradeAccepted");
                case TRADE_DECLINED:
                    return ("TradeDeclined");
                case TREASURE_LOOT:
                    return ("TreasureLoot");
                case BANDITS_LOOT:
                    return ("BanditsLoot");
                case BATTLE_REPORT:
                    return ("BattleReport");
                case GIFT:
                    return ("Gift");
                case BUFF:
                    return ("Buff");
                case BUFFED_BUILDING:
                    return ("BuffedBuilding");
                case HARD_CURRENCY_PURCHASED:
                    return ("HardCurrencyPurchased");
                case BUFFED_DEPOSIT:
                    return ("BuffedDeposit");
                case DEPRECATED_TRADE_MAIL:
                    return ("Unused_1");
                case DEPRECATED_TRADE_MAIL_ACCEPTED:
                    return ("Unused_2");
                case DEPRECATED_TRADE_MAIL_DECLINED:
                    return ("Unused_3");
                case FRIEND_INVITATION_CONFIRMED:
                    return ("FriendInvitationConfirmed");
                case INVITED_FRIEND_PURCHASED:
                    return ("InvitedFriendPurchased");
                case ADVENTURE_WON_LOOT:
                    return ("AdventureWonLoot");
                case GUILD_INVITE_DECLINE:
                    return ("GuildInviteDecline");
                case GUILD_INVITE_FULL:
                    return ("GuildInviteFull");
                case GUILD_KICK:
                    return ("GuildKick");
                case INVITE_TO_ADVENTURE:
                    return ("InviteToAdventure");
                case ADVENTURE_LOST_LOOT:
                    return ("AdventureLostLoot");
                case FIND_ADVENTURE_LOOT_POSITIVE:
                    return ("FindAdventureLootPositive");
                case FIND_ADVENTURE_LOOT_NEGATIVE:
                    return ("FindAdventureLootNegative");
                case FIND_ADVENTURE_LOOT_MAP_FRAGMENT:
                    return ("FindAdventureLootMapFragment");
                case FIND_EXPEDITION_LOOT_POSITIVE:
                    return ("FindExpeditionLootPositive");
                case FIND_EXPEDITION_LOOT_NEGATIVE:
                    return ("FindExpeditionLootNegative");
                case QUEST_LOOT:
                    return ("QuestLoot");
                case BATTLE_REPORT_INTERCEPTED:
                    return ("BattleReportIntercepted");
                case COOPERATION_REWARD:
                    return ("CooperationReward");
                case NPC_MAIL:
                    return ("NPCMail");
                case NPC_MAIL_LOOT:
                    return ("NPCMailLoot");
                case LOCA_LOOT_MAIL:
                    return ("LocaLootMail");
                case GUILD_SUCCESSION_REQUEST:
                    return ("GuildSuccessionRequest");
                case GUILD_LEADER_CHANGED:
                    return ("GuildLeaderChanged");
                case GUILD_NEW_LEADER:
                    return ("GuildNewLeader");
                case GUILD_OLD_LEADER:
                    return ("GuildOldLeader");
                case GUILD_SUCCESSION_DECLINED:
                    return ("GuildSuccessionDeclined");
                case GUILD_SUCCESSION_EXPIRED:
                    return ("GuildSuccessionExpired");
                case GUILD_SUCCESSION_DUE_TO_INACTIVE:
                    return ("GuildSuccessionDueToInactive");
                case TREASURE_LOOT_SKILLED:
                    return ("TreasureLootSkilled");
                case FIND_ADVENTURE_LOOT_POSITIVE_SKILLED:
                    return ("FindAdventureLootPositiveSkilled");
                case FIND_ADVENTURE_LOOT_MAP_FRAGMENT_SKILLED:
                    return ("FindAdventureLootMapFragmentSkilled");
                case TREASURE_LOOT_TRAVELLINGERUDITE:
                    return ("TreasureLootTravellingErudite");
                case TREASURE_LOOT_BEANACOLOADA:
                    return ("TreasureLootBeanAColada");
                case COLLECTIBLE_REWARDS:
                    return ("CollectibleRewards");
                case GUILD_APPLY:
                    return ("GuildApply");
                case GUILD_APPLY_ACCEPTED:
                    return ("GuildApplyAccepted");
                case GUILD_APPLY_DECLINED:
                    return ("GuildApplyDeclined");
                case EVENT_LOOT_REWARDS_CURRENT_USER:
                    return ("EventLootRewardsCurrentUser");
                case EVENT_LOOT_REWARDS_FRIEND_USER:
                    return ("EventLootRewardsFriendUser");
                case EVENT_MONSTER_HIT_BY_FRIEND:
                    return ("EventMonsterHitByFriend");
                case PVP_COMBAT_REPORT_ATTACKER_WON:
                    return ("PvPCombatReportAttackerWon");
                case PVP_COMBAT_REPORT_ATTACKER_LOST:
                    return ("PvPCombatReportAttackerLost");
                case PVP_COMBAT_REPORT_DEFENDER_WON:
                    return ("PvPCombatReportDefenderWon");
                case PVP_COMBAT_REPORT_DEFENDER_LOST:
                    return ("PvPCombatReportDefenderLost");
                case EXPEDITION_WON_LOOT:
                    return ("ExpeditionWonLoot");
                case EXPEDITION_LOST_LOOT:
                    return ("ExpeditionLostLoot");
                case ADVENTURE_LOCKED_COMPENSATION:
                    return ("AdventureLockedCompensation");
                case EXPEDITION_LOCKED_COMPENSATION:
                    return ("ExpeditionLockedCompensation");
                case ADVENTURE_FAILED_CANCELLED:
                    return ("AdventureFailedCancelled");
                case ADVENTURE_LEAVE_NOTIFICATION:
                    return ("AdventureLeaveNotification");
                case ADVENTURE_CANCEL_INVITATION:
                    return ("AdventureCancelInvitation");
                case NOSQL_ERROR_NO_MAILS_COULD_BE_LOADED_FROM_ARCHIVE:
                    return ("NoSQLErrorNoMailsCouldBeLoaded");
                case HARD_CURRENCY_REMOVED:
                    return ("HardCurrencyRemoved");
                case LOCA_MAIL:
                    return ("LocaMail");
                case BLACKMARKET_MAIL:
                    return ("BlackMarketAuctionWon");
                default:
                    return ("Unknown: " + _arg_1);
            };
        }

        public static function parse(_arg_1:String):int
        {
            if (_arg_1 == toString(MAIL))
            {
                return (MAIL);
            };
            if (_arg_1 == toString(TRADE))
            {
                return (TRADE);
            };
            if (_arg_1 == toString(FRIEND_REQUEST))
            {
                return (FRIEND_REQUEST);
            };
            if (_arg_1 == toString(GUILD_INVITE))
            {
                return (GUILD_INVITE);
            };
            if (_arg_1 == toString(TRADE_ACCEPTED))
            {
                return (TRADE_ACCEPTED);
            };
            if (_arg_1 == toString(TRADE_DECLINED))
            {
                return (TRADE_DECLINED);
            };
            if (_arg_1 == toString(TREASURE_LOOT))
            {
                return (TREASURE_LOOT);
            };
            if (_arg_1 == toString(BANDITS_LOOT))
            {
                return (BANDITS_LOOT);
            };
            if (_arg_1 == toString(BATTLE_REPORT))
            {
                return (BATTLE_REPORT);
            };
            if (_arg_1 == toString(GIFT))
            {
                return (GIFT);
            };
            if (_arg_1 == toString(BUFF))
            {
                return (BUFF);
            };
            if (_arg_1 == toString(BUFFED_BUILDING))
            {
                return (BUFFED_BUILDING);
            };
            if (_arg_1 == toString(HARD_CURRENCY_PURCHASED))
            {
                return (HARD_CURRENCY_PURCHASED);
            };
            if (_arg_1 == toString(BUFFED_DEPOSIT))
            {
                return (BUFFED_DEPOSIT);
            };
            if (_arg_1 == toString(DEPRECATED_TRADE_MAIL))
            {
                return (DEPRECATED_TRADE_MAIL);
            };
            if (_arg_1 == toString(DEPRECATED_TRADE_MAIL_ACCEPTED))
            {
                return (DEPRECATED_TRADE_MAIL_ACCEPTED);
            };
            if (_arg_1 == toString(DEPRECATED_TRADE_MAIL_DECLINED))
            {
                return (DEPRECATED_TRADE_MAIL_DECLINED);
            };
            if (_arg_1 == toString(FRIEND_INVITATION_CONFIRMED))
            {
                return (FRIEND_INVITATION_CONFIRMED);
            };
            if (_arg_1 == toString(INVITED_FRIEND_PURCHASED))
            {
                return (INVITED_FRIEND_PURCHASED);
            };
            if (_arg_1 == toString(ADVENTURE_WON_LOOT))
            {
                return (ADVENTURE_WON_LOOT);
            };
            if (_arg_1 == toString(GUILD_INVITE_DECLINE))
            {
                return (GUILD_INVITE_DECLINE);
            };
            if (_arg_1 == toString(GUILD_INVITE_FULL))
            {
                return (GUILD_INVITE_FULL);
            };
            if (_arg_1 == toString(GUILD_KICK))
            {
                return (GUILD_KICK);
            };
            if (_arg_1 == toString(INVITE_TO_ADVENTURE))
            {
                return (INVITE_TO_ADVENTURE);
            };
            if (_arg_1 == toString(ADVENTURE_LOST_LOOT))
            {
                return (ADVENTURE_LOST_LOOT);
            };
            if (_arg_1 == toString(FIND_ADVENTURE_LOOT_POSITIVE))
            {
                return (FIND_ADVENTURE_LOOT_POSITIVE);
            };
            if (_arg_1 == toString(FIND_ADVENTURE_LOOT_NEGATIVE))
            {
                return (FIND_ADVENTURE_LOOT_NEGATIVE);
            };
            if (_arg_1 == toString(FIND_ADVENTURE_LOOT_MAP_FRAGMENT))
            {
                return (FIND_ADVENTURE_LOOT_MAP_FRAGMENT);
            };
            if (_arg_1 == toString(FIND_EXPEDITION_LOOT_POSITIVE))
            {
                return (FIND_EXPEDITION_LOOT_POSITIVE);
            };
            if (_arg_1 == toString(FIND_EXPEDITION_LOOT_NEGATIVE))
            {
                return (FIND_EXPEDITION_LOOT_NEGATIVE);
            };
            if (_arg_1 == toString(QUEST_LOOT))
            {
                return (QUEST_LOOT);
            };
            if (_arg_1 == toString(BATTLE_REPORT_INTERCEPTED))
            {
                return (BATTLE_REPORT_INTERCEPTED);
            };
            if (_arg_1 == toString(COOPERATION_REWARD))
            {
                return (COOPERATION_REWARD);
            };
            if (_arg_1 == toString(NPC_MAIL))
            {
                return (NPC_MAIL);
            };
            if (_arg_1 == toString(NPC_MAIL_LOOT))
            {
                return (NPC_MAIL_LOOT);
            };
            if (_arg_1 == toString(LOCA_LOOT_MAIL))
            {
                return (LOCA_LOOT_MAIL);
            };
            if (_arg_1 == toString(GUILD_SUCCESSION_REQUEST))
            {
                return (GUILD_SUCCESSION_REQUEST);
            };
            if (_arg_1 == toString(GUILD_LEADER_CHANGED))
            {
                return (GUILD_LEADER_CHANGED);
            };
            if (_arg_1 == toString(GUILD_NEW_LEADER))
            {
                return (GUILD_NEW_LEADER);
            };
            if (_arg_1 == toString(GUILD_OLD_LEADER))
            {
                return (GUILD_OLD_LEADER);
            };
            if (_arg_1 == toString(GUILD_SUCCESSION_DECLINED))
            {
                return (GUILD_SUCCESSION_DECLINED);
            };
            if (_arg_1 == toString(GUILD_SUCCESSION_EXPIRED))
            {
                return (GUILD_SUCCESSION_EXPIRED);
            };
            if (_arg_1 == toString(GUILD_SUCCESSION_DUE_TO_INACTIVE))
            {
                return (GUILD_SUCCESSION_DUE_TO_INACTIVE);
            };
            if (_arg_1 == toString(TREASURE_LOOT_SKILLED))
            {
                return (TREASURE_LOOT_SKILLED);
            };
            if (_arg_1 == toString(FIND_ADVENTURE_LOOT_POSITIVE_SKILLED))
            {
                return (FIND_ADVENTURE_LOOT_POSITIVE_SKILLED);
            };
            if (_arg_1 == toString(FIND_ADVENTURE_LOOT_MAP_FRAGMENT_SKILLED))
            {
                return (FIND_ADVENTURE_LOOT_MAP_FRAGMENT_SKILLED);
            };
            if (_arg_1 == toString(TREASURE_LOOT_TRAVELLINGERUDITE))
            {
                return (TREASURE_LOOT_TRAVELLINGERUDITE);
            };
            if (_arg_1 == toString(TREASURE_LOOT_BEANACOLOADA))
            {
                return (TREASURE_LOOT_BEANACOLOADA);
            };
            if (_arg_1 == toString(COLLECTIBLE_REWARDS))
            {
                return (COLLECTIBLE_REWARDS);
            };
            if (_arg_1 == toString(GUILD_APPLY))
            {
                return (GUILD_APPLY);
            };
            if (_arg_1 == toString(GUILD_APPLY_ACCEPTED))
            {
                return (GUILD_APPLY_ACCEPTED);
            };
            if (_arg_1 == toString(GUILD_APPLY_DECLINED))
            {
                return (GUILD_APPLY_DECLINED);
            };
            if (_arg_1 == toString(EVENT_LOOT_REWARDS_CURRENT_USER))
            {
                return (EVENT_LOOT_REWARDS_CURRENT_USER);
            };
            if (_arg_1 == toString(EVENT_LOOT_REWARDS_FRIEND_USER))
            {
                return (EVENT_LOOT_REWARDS_FRIEND_USER);
            };
            if (_arg_1 == toString(EVENT_MONSTER_HIT_BY_FRIEND))
            {
                return (EVENT_MONSTER_HIT_BY_FRIEND);
            };
            if (_arg_1 == toString(EVENT_LOOT_REWARDS_CURRENT_USER))
            {
                return (EVENT_LOOT_REWARDS_CURRENT_USER);
            };
            if (_arg_1 == toString(EVENT_LOOT_REWARDS_FRIEND_USER))
            {
                return (EVENT_LOOT_REWARDS_FRIEND_USER);
            };
            if (_arg_1 == toString(PVP_COMBAT_REPORT_ATTACKER_WON))
            {
                return (PVP_COMBAT_REPORT_ATTACKER_WON);
            };
            if (_arg_1 == toString(PVP_COMBAT_REPORT_ATTACKER_LOST))
            {
                return (PVP_COMBAT_REPORT_ATTACKER_LOST);
            };
            if (_arg_1 == toString(PVP_COMBAT_REPORT_DEFENDER_WON))
            {
                return (PVP_COMBAT_REPORT_DEFENDER_WON);
            };
            if (_arg_1 == toString(PVP_COMBAT_REPORT_DEFENDER_LOST))
            {
                return (PVP_COMBAT_REPORT_DEFENDER_LOST);
            };
            if (_arg_1 == toString(EXPEDITION_WON_LOOT))
            {
                return (EXPEDITION_WON_LOOT);
            };
            if (_arg_1 == toString(EXPEDITION_LOST_LOOT))
            {
                return (EXPEDITION_LOST_LOOT);
            };
            if (_arg_1 == toString(ADVENTURE_LOCKED_COMPENSATION))
            {
                return (ADVENTURE_LOCKED_COMPENSATION);
            };
            if (_arg_1 == toString(EXPEDITION_LOCKED_COMPENSATION))
            {
                return (EXPEDITION_LOCKED_COMPENSATION);
            };
            if (_arg_1 == toString(ADVENTURE_FAILED_CANCELLED))
            {
                return (ADVENTURE_FAILED_CANCELLED);
            };
            if (_arg_1 == toString(ADVENTURE_LEAVE_NOTIFICATION))
            {
                return (ADVENTURE_LEAVE_NOTIFICATION);
            };
            if (_arg_1 == toString(ADVENTURE_CANCEL_INVITATION))
            {
                return (ADVENTURE_CANCEL_INVITATION);
            };
            if (_arg_1 == toString(NOSQL_ERROR_NO_MAILS_COULD_BE_LOADED_FROM_ARCHIVE))
            {
                return (NOSQL_ERROR_NO_MAILS_COULD_BE_LOADED_FROM_ARCHIVE);
            };
            if (_arg_1 == toString(HARD_CURRENCY_REMOVED))
            {
                return (HARD_CURRENCY_REMOVED);
            };
            if (_arg_1 == toString(LOCA_MAIL))
            {
                return (LOCA_MAIL);
            };
            if (_arg_1 == toString(BLACKMARKET_MAIL))
            {
                return (BLACKMARKET_MAIL);
            };
            return (MAIL);
        }

        public static function isCollectable(_arg_1:int):Boolean
        {
            switch (_arg_1)
            {
                case BANDITS_LOOT:
                case TREASURE_LOOT:
                case TREASURE_LOOT_BEANACOLOADA:
                case TREASURE_LOOT_TRAVELLINGERUDITE:
                case TREASURE_LOOT_SKILLED:
                case GIFT:
                case BUFF:
                case FIND_ADVENTURE_LOOT_POSITIVE:
                case FIND_ADVENTURE_LOOT_POSITIVE_SKILLED:
                case FIND_ADVENTURE_LOOT_MAP_FRAGMENT:
                case FIND_ADVENTURE_LOOT_MAP_FRAGMENT_SKILLED:
                case FIND_EXPEDITION_LOOT_POSITIVE:
                case FIND_EXPEDITION_LOOT_NEGATIVE:
                case QUEST_LOOT:
                case COOPERATION_REWARD:
                case LOCA_LOOT_MAIL:
                case NPC_MAIL_LOOT:
                case COLLECTIBLE_REWARDS:
                case ADVENTURE_LOCKED_COMPENSATION:
                case EXPEDITION_LOCKED_COMPENSATION:
                case EVENT_LOOT_REWARDS_CURRENT_USER:
                case EVENT_LOOT_REWARDS_FRIEND_USER:
                case ADVENTURE_LOST_LOOT:
                case ADVENTURE_WON_LOOT:
                case EXPEDITION_LOST_LOOT:
                case EXPEDITION_WON_LOOT:
                    return (true);
            };
            return (false);
        }


    }
}//package Enums

