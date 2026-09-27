// =====================================
// Show My Loot PRO
// PRO version author: T_O_M_A_S_Z (in-game nickname: Osadnik)
// Version: 2.9.4
//
// Based on the original Show My Loot script by SirriS.
// Significantly expanded and modified by T_O_M_A_S_Z.
// Prepared with support from ChatGPT.
//
// Community maintenance notice:
// The author no longer maintains or develops this script.
// The community is welcome to continue improving, fixing,
// modifying and redistributing it, while preserving credits
// to SirriS and T_O_M_A_S_Z in the source code.
//
// Provided as-is, without warranty.
// =====================================

(function () {

    var SML_PRO = {
        STORAGE_KEY: 'SML_PRO294_SETTINGS',
        MENU_HISTORY: 'Show my loot PRO',
        MENU_SUMMARY: 'Loot summary PRO',
        CHAT_TAG: 'smlpro',
        STYLE_ID: 'smlpro_style_block'
    };

    var I18N = {
        pl: {
            historyTitle: 'Loot history PRO',
            summaryTitle: 'Loot summary PRO',
            summary: 'Podsumowanie',
            history: 'Historia',
            exportJson: 'Eksport JSON',
            resetData: 'Reset danych',
            totalEntries: 'Łącznie przechwyconych wpisów:',
            lastUpdate: 'Ostatnia aktualizacja:',
            normalLoot: 'Normalny loot',
            premiumLoot: 'Premium loot',
            noData: 'Brak danych.',
            noSavedLoots: 'Brak zapisanych lootów.',
            dateTime: 'Data i czas',
            sender: 'Nadawca',
            type: 'Typ',
            source: 'Źródło',
            category: 'Kategoria',
            rewards: 'Nagrody',
            name: 'Nazwa',
            sum: 'Suma',
            occurrences: 'Wystąpienia',
            confirmReset: 'Na pewno wyczyścić całą historię lootów?',
            resetDone: 'Wyczyszczono historię lootów.',
            exportDone: 'Wygenerowano eksport JSON.',
            exportError: 'Błąd eksportu JSON: ',
            initDone: 'Show my loot PRO aktywny.',
            initError: 'Błąd inicjalizacji: ',
            processError: 'Błąd przetwarzania lootu: ',
            unknownReward: '[nieznana nagroda]',
            unknown: '[nieznane]',
            unknownSender: '(brak nadawcy)',
            unknownCategory: 'Inne',
            adventureSearch: 'Poszukiwanie przygód',
            treasureSearch: 'Poszukiwanie skarbów',
            artifactSearch: 'Poszukiwanie artefaktów',
            rareItemSearch: 'Poszukiwanie rzadkich przedmiotów',
            adventureLoot: 'Łupy z przygód',
            geologistSmuggler: 'Geolog / Przemytnik',
            adventureFinds: 'Znajdki z przygód',
            sortBy: 'Sortuj:',
            sortSource: 'Źródło',
            sortItemCategory: 'Kategoria',
            sortName: 'Nazwa',
            catResources: 'Surowce',
            catBuffs: 'Premie',
            catAdventures: 'Przygody',
            catBuildings: 'Budynki',
            catEvents: 'Wydarzenie',
            catCollections: 'Kolekcje',
            catOther: 'Pozostałe',
            other: 'Inne',
            searchName: 'Szukaj:',
            lang: 'Język',
            polish: 'Polski',
            english: 'English'
        },
        en: {
            historyTitle: 'Loot history PRO',
            summaryTitle: 'Loot summary PRO',
            summary: 'Summary',
            history: 'History',
            exportJson: 'Export JSON',
            resetData: 'Reset data',
            totalEntries: 'Total captured entries:',
            lastUpdate: 'Last update:',
            normalLoot: 'Normal loot',
            premiumLoot: 'Premium loot',
            noData: 'No data.',
            noSavedLoots: 'No saved loot entries.',
            dateTime: 'Date and time',
            sender: 'Sender',
            type: 'Type',
            source: 'Source',
            category: 'Category',
            rewards: 'Rewards',
            name: 'Name',
            sum: 'Total',
            occurrences: 'Occurrences',
            confirmReset: 'Are you sure you want to clear the full loot history?',
            resetDone: 'Loot history has been cleared.',
            exportDone: 'JSON export generated.',
            exportError: 'JSON export error: ',
            initDone: 'Show my loot PRO is active.',
            initError: 'Initialization error: ',
            processError: 'Loot processing error: ',
            unknownReward: '[unknown reward]',
            unknown: '[unknown]',
            unknownSender: '(no sender)',
            unknownCategory: 'Other',
            adventureSearch: 'Adventure search',
            treasureSearch: 'Treasure search',
            artifactSearch: 'Artifact search',
            rareItemSearch: 'Rare treasure search',
            adventureLoot: 'Adventure loot',
            geologistSmuggler: 'Geologist / Smuggler',
            adventureFinds: 'Adventure finds',
            sortBy: 'Sort by:',
            sortSource: 'Source',
            sortItemCategory: 'Category',
            sortName: 'Name',
            catResources: 'Resources',
            catBuffs: 'Buffs',
            catAdventures: 'Adventures',
            catBuildings: 'Buildings',
            catEvents: 'Event',
            catCollections: 'Collections',
            catOther: 'Other',
            other: 'Other',
            searchName: 'Search:',
            lang: 'Language',
            polish: 'Polski',
            english: 'English'
        }
    };

    var CUSTOM_MAP_PL = {
        TheDarkBrotherhood: 'Mroczne Bractwo',
        TheDarkPriests: 'Mroczni Kapłani',
        SurpriseAttack: 'Atak z Zaskoczenia',
        TheNords: 'Wikingowie',
        RoaringBull: 'Ryczący Byk',
        SonsOfTheVeld: 'Synowie stepów',
        MadHenry: 'Szalony Henryk',
        VictorTheVicious: 'Wiktor Podstępny',
        Outlaws: 'Banici',
        TheSiege: 'Oblężenie',
        RaidingTheRaiders: 'Atak na Łupieżców',
        RidingTheRaiders: 'Najazd Wikingów',
        SplitCityFall: 'Podzielone Miasto Jesienią',
        SecludedExperiments: 'Zakazane Eksperymenty',
        BonabertiBusiness: 'Interesy Bonabertich',
        TheBlackKnights: 'Czarni Rycerze',
        LakesideTreasure: 'Skarb przy jeziorze',
        MiadSleepyReef: 'Uśpiona Rafa',
        MiadSleepingVolcano: 'Uśpiony Wulkan',
        WitchCovenGrimoirePage18: 'Wiedźmi grymuar, strona XVIII',
        WitchCovenGrimoirePage20: 'Wiedźmi grymuar, strona XX',
        BuffAdventures_heartOfTheWood_medium: 'Serce Kniei',
        Whirlwind: 'Wir',

        Fragment: 'Fragment mapy',
        MapPart: 'Fragment mapy',
        night: 'Proch Piaskuna',

        ProductivityBuff1: 'Półmisek ryb',
        ProductivityBuffLvl1: 'Półmisek ryb',
        ProductivityBuffLvl2: 'Pożywna kanapka',
        ProductivityBuffLvl3: 'Koszyk cioci Irmy',
        ProductivityBuffLvl4: 'Kosz egzotycznych owoców',
        ProductivityBuffLvl5: 'Latający Osadnik',
        ProductivityBuffLvl6: 'Królicza łapka',
        ProductivityBuffLvl7: 'Zombie',
        ProductivityBuffLvl8: 'Ciastka',
        ProductivityBuffLvl9: 'Akcelerator fermentacji',
        ProductivityBuffLvl10: 'Stadionowe przekąski',
        ProductivityBuffLvl12: 'Torba tęczowego śniegu',
        ProductivityBuffLvl13: 'Pieczona kaczka',
        ProductivityBuffLvl14: 'Misa makaronu Piero',
        ProductivityBuffLvl15: 'Pomocny strach na wróble',
        ProductivityBuffLvl16: 'Rytuał Drzewa-Matki',
        ProductivityBuffLvl17: 'Gorączka złota',
        ProductivityBuffLvl18: 'Młot damasceński',
        ProductivityBuffLvl19: 'Gorąca herbata cytrynowa',
        ProductivityBuffLvl25: 'Pan Croix Sant',
        ProductivityBuffLvl100: 'Rytuał żniwny',
        ProductivityBuffLvl101: 'Kije i marchewki',
        ProductivityBuffLvl103: 'Odznaka pracownika miesiąca',
        ProductivityBuffFEW1: 'Zupa z magicznej fasoli',

        tropical: 'Amulet dobrej pogody',

        SpeedUpPopulationGrowth2: 'Kanapka z serem',
        RecruitingBuffLvl1: 'Ulepszony zaciąg',
        RecruitingBuffLvl2: 'Pan Myers',
        RecruitingBuffLvl5: 'iGor',

        Token: 'Żetony',
        TombRaiders: 'Łupieżcy Grobowców',
        '1001NightsFirstThief': 'Ali Baba i pierwszy złodziej',
        '1001NightsSecondThief': 'Ali Baba i drugi złodziej',
        AdventureTale: 'Opowieść przygodowa',

        PlatinumOre: 'Ruda platyny',
        Platinum: 'Platyna',
        Gold: 'Złoto',
        GoldOre: 'Ruda złota',
        Coin: 'Monety',
        Granite: 'Granit',
        MagicBean: 'Magiczna fasola',
        MahoganyWood: 'Mahoniowe drewno',
        ExoticWood: 'Egzotyczne drewno',
        Oilseed: 'Nasiono oleiste',
        Grout: 'Zaprawa',
        Salpeter: 'Saletra',
        Gunpowder: 'Proch',
        TitaniumOre: 'Ruda tytanu',
        Titanium: 'Tytan',
        FillDeposit: 'Dodaj do złoża',
        Codex: 'Kodeks',

        ProvisionerBuffLvl3: 'Ciasto sezamowe',
        ChangeSkin_mediterranean_mayorhouse_red_long: 'Skórka 15-dniowa: Dom władcy (wytworny, czerwony)',

        BuffAdventures_blackenedTitanium: 'Pociemniała podkowa z tytanu',
        GeneralSpeedBuff_Blackened_Titanium: 'Pociemniała podkowa z tytanu',
        BattleBuffBomb_random_units_limited: 'Grad strzał',
        EffectBuff_BuffX_Fireworks: 'Festiwalowe fajerwerki'
    };

    var CUSTOM_MAP_EN = {
        TheDarkBrotherhood: 'Dark Brotherhood',
        TheDarkPriests: 'Dark Priests',
        SurpriseAttack: 'Surprise Attack',
        TheNords: 'The Nords',
        RoaringBull: 'Roaring Bull',
        SonsOfTheVeld: 'Sons of the Veld',
        MadHenry: 'Mad Henry',
        VictorTheVicious: 'Victor the Vicious',
        Outlaws: 'Outlaws',
        TheSiege: 'The Siege',
        RaidingTheRaiders: 'Raiding the Raiders',
        RidingTheRaiders: 'Riding the Raiders',
        SplitCityFall: 'Split City Fall',
        SecludedExperiments: 'More Secluded Experiments',
        BonabertiBusiness: 'Bonaberti Business',
        TheBlackKnights: 'The Black Knights',
        LakesideTreasure: 'Lakeside Treasure',
        MiadSleepyReef: 'Sleepy Reef',
        MiadSleepingVolcano: 'Sleeping Volcano',
        WitchCovenGrimoirePage18: 'Witch Coven Grimoire Page XVIII',
        WitchCovenGrimoirePage20: 'Witch Coven Grimoire Page XX',
        BuffAdventures_heartOfTheWood_medium: 'Heart of the Wood',
        Whirlwind: 'Whirlwind',

        Fragment: 'Map Fragment',
        MapPart: 'Map Fragment',
        night: 'Sandman’s Powder',

        ProductivityBuff1: 'Fish Platter',
        ProductivityBuffLvl1: 'Fish Platter',
        ProductivityBuffLvl2: 'Hearty Sandwich',
        ProductivityBuffLvl3: 'Aunt Irma Basket',
        ProductivityBuffLvl4: 'Basket of Exotic Fruits',
        ProductivityBuffLvl5: 'Flying Settler',
        ProductivityBuffLvl6: 'Rabbit Foot',
        ProductivityBuffLvl7: 'Zombie',
        ProductivityBuffLvl8: 'Cookies',
        ProductivityBuffLvl9: 'Fermentation Accelerator',
        ProductivityBuffLvl10: 'Stadium Snacks',
        ProductivityBuffLvl12: 'Rainbow Snow Bag',
        ProductivityBuffLvl13: 'Roasted Duck',
        ProductivityBuffLvl14: 'Piero Pasta Bowl',
        ProductivityBuffLvl15: 'Helpful Scarecrow',
        ProductivityBuffLvl16: 'Mother Tree Ritual',
        ProductivityBuffLvl17: 'Gold Fever',
        ProductivityBuffLvl18: 'Damascene Hammer',
        ProductivityBuffLvl19: 'Hot Lemon Tea',
        ProductivityBuffLvl25: 'Pan Croix Sant',
        ProductivityBuffLvl100: 'Harvest Ritual',
        ProductivityBuffLvl101: 'Sticks and Carrots',
        ProductivityBuffLvl103: 'Employee of the Month Badge',
        ProductivityBuffFEW1: 'Magic Bean Soup',

        tropical: 'Good Weather Charm',

        SpeedUpPopulationGrowth2: 'Cheese Sandwich',
        RecruitingBuffLvl1: 'Improved Recruitment',
        RecruitingBuffLvl2: 'Mr. Myers',
        RecruitingBuffLvl5: 'iGor',

        Token: 'Tokens',
        TombRaiders: 'Tomb Raiders',
        '1001NightsFirstThief': 'Ali Baba and the First Thief',
        '1001NightsSecondThief': 'Ali Baba and the Second Thief',
        AdventureTale: 'Adventure Tale',

        PlatinumOre: 'Platinum Ore',
        Platinum: 'Platinum',
        Gold: 'Gold',
        GoldOre: 'Gold Ore',
        Coin: 'Coins',
        Granite: 'Granite',
        MagicBean: 'Magic Bean',
        MahoganyWood: 'Mahogany Wood',
        ExoticWood: 'Exotic Wood',
        Oilseed: 'Oilseed',
        Grout: 'Grout',
        Salpeter: 'Saltpeter',
        Gunpowder: 'Gunpowder',
        TitaniumOre: 'Titanium Ore',
        Titanium: 'Titanium',
        FillDeposit: 'Refill Deposit',
        Codex: 'Codex',

        ProvisionerBuffLvl3: 'Sesame Cake',
        ChangeSkin_mediterranean_mayorhouse_red_long: '15-day Skin: Mayor House (refined, red)',

        BuffAdventures_blackenedTitanium: 'Blackened Titanium Horseshoe',
        GeneralSpeedBuff_Blackened_Titanium: 'Blackened Titanium Horseshoe',
        BattleBuffBomb_random_units_limited: 'Hail of Arrows',
        EffectBuff_BuffX_Fireworks: 'Festival Fireworks'
    };

    var state = loadState();

    function t(key) {
        var lang = state && state.meta && state.meta.lang ? state.meta.lang : 'pl';
        if (!I18N[lang]) lang = 'pl';
        return I18N[lang][key] || key;
    }

    function chat(msg) {
        try {
            game.chatMessage(msg, SML_PRO.CHAT_TAG);
        } catch (e) { }
    }

    function reportMissingTranslation(rawName) {
        if (!rawName) return;
        if (!state.meta) state.meta = {};
        if (!state.meta.missingNames) state.meta.missingNames = {};

        if (state.meta.missingNames[rawName]) return;

        state.meta.missingNames[rawName] = true;
        saveState();

        chat('Brak tłumaczenia rawName: ' + rawName);
    }

    function initDefaultState() {
        return {
            rewards: [],
            meta: {
                trackedCount: 0,
                lastUpdate: 0,
                lang: 'pl',
                sortMode: 'source',
                missingNames: {}
            }
        };
    }

    function loadState() {
        var s = initDefaultState();
        try {
            $.extend(true, s, settings.read(null, SML_PRO.STORAGE_KEY));
        } catch (e) { }
        if (!s.meta) s.meta = {};
        if (!s.meta.lang) s.meta.lang = 'pl';
        if (!s.meta.sortMode || s.meta.sortMode === 'category') s.meta.sortMode = 'source';
        if (!s.meta.missingNames) s.meta.missingNames = {};
        if (!s.rewards) s.rewards = [];
        return s;
    }

    function saveState() {
        try {
            settings.settings[SML_PRO.STORAGE_KEY] = {};
            settings.store(state, SML_PRO.STORAGE_KEY);
        } catch (e) { }
    }

    function resetState() {
        var currentLang = state && state.meta ? state.meta.lang : 'pl';
        state = initDefaultState();
        state.meta.lang = currentLang;
        saveState();
    }

    function setLang(lang) {
        state.meta.lang = lang === 'en' ? 'en' : 'pl';
        saveState();
    }

    function getSortMode() {
        return state && state.meta && state.meta.sortMode ? state.meta.sortMode : 'source';
    }

    function setSortMode(mode) {
        if (!state.meta) state.meta = {};
        var validModes = ['name', 'source', 'itemCategory'];
        state.meta.sortMode = validModes.indexOf(mode) !== -1 ? mode : 'source';
        saveState();
    }

    function renderSortSwitcher(prefix) {
        var currentMode = getSortMode();
        var html = '';
        html += '<div style="display:inline-block;margin-left:10px;">';
        html += '<label style="margin-right:6px;"><b>' + t('sortBy') + '</b></label>';
        html += '<select id="' + prefix + '_sortMode" style="padding:3px 6px;">';
        html += '<option value="source"' + (currentMode === 'source' ? ' selected="selected"' : '') + '>' + t('sortSource') + '</option>';
        html += '<option value="itemCategory"' + (currentMode === 'itemCategory' ? ' selected="selected"' : '') + '>' + t('sortItemCategory') + '</option>';
        html += '<option value="name"' + (currentMode === 'name' ? ' selected="selected"' : '') + '>' + t('sortName') + '</option>';
        html += '</select>';
        html += '</div>';
        return html;
    }

    function ensureStyles() {
        if ($('#' + SML_PRO.STYLE_ID).length) return;

        var css = ''
            + '#smlProSummaryWindow .modal-body, #smlProHistoryWindow .modal-body{'
            + 'overflow:hidden !important;'
            + 'padding-bottom:50px !important;'
            + '}'

            + '#smlProSummaryWindow .modal-footer, #smlProHistoryWindow .modal-footer{'
            + 'position:absolute !important;'
            + 'right:12px !important;'
            + 'bottom:10px !important;'
            + 'width:auto !important;'
            + 'min-width:0 !important;'
            + 'min-height:0 !important;'
            + 'height:auto !important;'
            + 'margin:0 !important;'
            + 'padding:0 !important;'
            + 'border:0 !important;'
            + 'background:transparent !important;'
            + 'box-shadow:none !important;'
            + 'outline:none !important;'
            + 'display:block !important;'
            + 'flex:none !important;'
            + 'z-index:5 !important;'
            + '}'

            + '#smlProSummaryWindow .modal-footer:before, #smlProSummaryWindow .modal-footer:after,'
            + '#smlProHistoryWindow .modal-footer:before, #smlProHistoryWindow .modal-footer:after{'
            + 'display:none !important;'
            + 'content:none !important;'
            + '}'

            + '#smlProSummaryWindow .modal-footer .btn, #smlProHistoryWindow .modal-footer .btn{'
            + 'margin:0 !important;'
            + '}'

            + '.smlpro-scroll{'
            + 'max-height:55vh;'
            + 'overflow-y:auto;'
            + 'overflow-x:hidden;'
            + 'padding-right:6px;'
            + 'box-sizing:border-box;'
            + 'border:0 !important;'
            + 'outline:none !important;'
            + 'box-shadow:none !important;'
            + 'background:transparent;'
            + '}'

            + '.smlpro-scroll, .smlpro-scroll *{'
            + 'outline:none !important;'
            + 'box-shadow:none !important;'
            + '}'

            + '.smlpro-scroll .row{'
            + 'margin-left:0 !important;'
            + 'margin-right:0 !important;'
            + '}'

            + '.smlpro-scroll [class*="col-"]{'
            + 'padding-left:6px;'
            + 'padding-right:6px;'
            + 'box-sizing:border-box;'
            + '}'

            + '.smlpro-scroll::-webkit-scrollbar{width:8px;height:8px;}'
            + '.smlpro-scroll::-webkit-scrollbar-track{background:rgba(0,0,0,0.15);border-radius:10px;}'
            + '.smlpro-scroll::-webkit-scrollbar-thumb{background:linear-gradient(180deg,#c8a96a,#8b6f3d);border-radius:10px;}'
            + '.smlpro-scroll::-webkit-scrollbar-thumb:hover{background:linear-gradient(180deg,#e0c07a,#a8864a);}'
            + '.smlpro-scroll{scrollbar-width:thin;scrollbar-color:#a8864a rgba(0,0,0,0.15);}'

            + '.smlpro-sticky-head{'
            + 'position:sticky;'
            + 'top:0;'
            + 'z-index:10;'
            + 'background:linear-gradient(180deg, #4d3615 0%, #30220d 100%);'
            + 'border-bottom:1px solid #c8a96a;'
            + 'margin-bottom:2px;'
            + 'box-shadow:0 2px 4px rgba(0,0,0,0.3);'
            + 'color:#ffe082;'
            + 'font-weight:bold;'
            + 'text-shadow:1px 1px 1px rgba(0,0,0,0.5);'
            + '}'

            + '.smlpro-sticky-head .row > [class*="col-"]{'
            + 'padding-top:4px;'
            + 'padding-bottom:4px;'
            + '}'

            + '.smlpro-card{'
            + 'border:1px solid rgba(218,165,32,0.20);'
            + 'border-radius:8px;'
            + 'margin-bottom:10px;'
            + 'overflow:hidden;'
            + '}'

            + '.smlpro-card-head{'
            + 'padding:8px 12px;'
            + 'background:rgba(218,165,32,0.06);'
            + '}'

            + '.smlpro-card-body{'
            + 'padding:10px 12px;'
            + '}';

        $('head').append('<style id="' + SML_PRO.STYLE_ID + '">' + css + '</style>');
    }

    function safeText(group, key, fallback) {
        try {
            var txt = loca.GetText(group, key);
            if (txt && txt.indexOf('[undefined') === -1 && txt.indexOf('[missing') === -1) {
                return txt;
            }
        } catch (e) { }
        return fallback || null;
    }

    function prettify(name) {
        if (!name) return t('unknown');
        return String(name)
            .replace(/^Buff_/i, '')
            .replace(/^BattleBuff/i, '')
            .replace(/^AdventureBuff/i, '')
            .replace(/^QuestBuff/i, '')
            .replace(/^DepositBuff/i, '')
            .replace(/^TimedBuff/i, '')
            .replace(/^MailBuff/i, '')
            .replace(/^SearchBuff/i, '')
            .replace(/^LootBuff/i, '')
            .replace(/_/g, ' ')
            .replace(/([a-ząćęłńóśźż])([A-ZĄĆĘŁŃÓŚŹŻ])/g, '$1 $2')
            .trim();
    }

    function getLocalizedRewardName(rawName) {
        var lang, groups, i, txt;

        if (!rawName) return t('unknownReward');

        lang = state.meta.lang === 'en' ? 'en' : 'pl';

        if (lang === 'en' && CUSTOM_MAP_EN[rawName]) return CUSTOM_MAP_EN[rawName];
        if (lang === 'pl' && CUSTOM_MAP_PL[rawName]) return CUSTOM_MAP_PL[rawName];

        if (lang === 'pl') {
            groups = ['RES', 'BUI', 'SHI', 'ADN', 'LAB', 'DES'];
            for (i = 0; i < groups.length; i++) {
                txt = safeText(groups[i], rawName, null);
                if (txt) return txt;
            }
        }
        if (lang === 'pl' && !CUSTOM_MAP_PL[rawName]) {
            reportMissingTranslation(rawName);
        }
        if (lang === 'en' && !CUSTOM_MAP_EN[rawName]) {
            reportMissingTranslation(rawName);
        }

        return prettify(rawName);
    }

    function getLocalizedMailName(name) {
        if (!name) return t('unknownSender');
        if (state.meta.lang === 'pl') {
            return safeText('ADN', name, name) || name;
        }
        return name;
    }

    function containsAny(text, needles) {
        var i;
        if (!text) return false;
        text = String(text).toLowerCase();
        for (i = 0; i < needles.length; i++) {
            if (text.indexOf(needles[i]) !== -1) return true;
        }
        return false;
    }

    function classifyEntry(entry) {
        var i, rawName, allItems;
        var sender = String(entry.senderName || '').toLowerCase();
        var subject = String(entry.subject || '').toLowerCase();

        var hasAdventureSearchMarker = false;
        var hasTreasureSearchMarker = false;
        var hasAdventureLootMarker = false;

        if (entry.mailType === 19) return t('adventureLoot');
        if (entry.mailType === 32) return t('geologistSmuggler');
        if (entry.mailType === 41) return t('treasureSearch');
        if (entry.mailType === 42) return t('adventureSearch');
        if (entry.mailType === 44) return t('artifactSearch');
        if (entry.mailType === 45) return t('rareItemSearch');
        if (entry.mailType === 46) return t('adventureFinds');

        allItems = [];
        if (entry.loot) {
            for (i = 0; i < entry.loot.length; i++) allItems.push(entry.loot[i]);
        }
        if (entry.premLoot) {
            for (i = 0; i < entry.premLoot.length; i++) allItems.push(entry.premLoot[i]);
        }

        for (i = 0; i < allItems.length; i++) {
            rawName = String(allItems[i].rawName || '').toLowerCase();

            var advSearchMarkers = [
                'surpriseattack', 'tombraiders', 'darkbrotherhood', 'darkpriests', 'thenords',
                'roaringbull', '1001night', 'fragment', 'mappart', 'ridingtheraiders',
                'sonsoftheveld', 'bonabertibusiness', 'theblackknights', 'madhenry',
                'splitcityfall', 'secludedexperiments', 'victorthevicious', 'outlaws',
                'thesiege', 'miadsleepyreef', 'miadsleepingvolcano', 'lakesidetreasure',
                'witchcovengrimoirepage', 'heartofthewood', 'whirlwind', 'bountyhunter',
                'theshaman', 'endoftheworld', 'tropicalsun', 'pirateisland', 'lostskull',
                'traitors', 'banditnest', 'mary', 'stolensleigh', 'oldfriends', 'prisonisland',
                'piratelife', 'arcticexplosion', 'stealingfromtherich', 'motherlylove',
                'valuableintel', 'chupacabra', 'lostcity', 'onestepahead', 'evilqueen',
                'hansel', 'piedpiper', 'redridinghood', 'snowwhite', 'footofthemountain',
                'mountainlabyrinth', 'mountainpeople', 'giantbattle', 'sindbad', 'aladdin',
                'buccaneer', 'grainconflict', 'stormrecovery', 'winterwonderland'
            ];

            var treasureMarkers = [
                'productivitybuff', 'speeduppopulationgrowth', 'night', 'recruitingbuff',
                'filldeposit', 'codex', 'effectbuff_buffx_fireworks', 'battlebuffbomb_random_units_limited'
            ];

            var advLootMarkers = [
                'platinumore', 'platinum', 'goldore', 'gold', 'coin', 'granite',
                'magicbean', 'mahoganywood', 'exoticwood', 'oilseed', 'grout',
                'titaniumore', 'titanium', 'adventuretale', 'token', 'salpeter',
                'gunpowder', 'blackened_titanium'
            ];

            if (containsAny(rawName, advSearchMarkers)) {
                hasAdventureSearchMarker = true;
            }

            if (containsAny(rawName, treasureMarkers)) {
                hasTreasureSearchMarker = true;
            }

            if (containsAny(rawName, advLootMarkers)) {
                hasAdventureLootMarker = true;
            }
        }

        if (hasAdventureSearchMarker) return t('adventureSearch');
        if (hasTreasureSearchMarker) return t('treasureSearch');

        if (containsAny(sender, ['ali baba', 'adventure']) || containsAny(subject, ['przygoda', 'adventure'])) {
            return t('adventureLoot');
        }

        if (hasAdventureLootMarker) return t('adventureLoot');

        return t('other');
    }

    function getItemImage(name) {
        try {
            return utils.getImageTag(name, '24px');
        } catch (e) {
            try {
                return getImageTag(name, '24px');
            } catch (e2) {
                return '';
            }
        }
    }

    function formatDate(ts) {
        try {
            return dtf.format(new window.runtime.Date(ts));
        } catch (e) {
            try {
                return new Date(ts).toLocaleString();
            } catch (e2) {
                return String(ts);
            }
        }
    }

    function getBestRawName(item) {
        try {
            if (item.resourceName_string && item.resourceName_string !== 'null') return item.resourceName_string;
        } catch (e) { }

        try {
            if (item.buffName_string && item.buffName_string !== 'null') return item.buffName_string;
        } catch (e) { }

        try {
            if (item.name_string && item.name_string !== 'null') return item.name_string;
        } catch (e) { }

        try {
            if (item.GetBuffDefinition) {
                var def = item.GetBuffDefinition();
                if (def && def.GetName_string) {
                    var defName = def.GetName_string();
                    if (defName && defName !== 'null') return defName;
                }
            }
        } catch (e) { }

        try {
            if (item.mBuffName_string && item.mBuffName_string !== 'null') return item.mBuffName_string;
        } catch (e) { }

        return null;
    }

    function getSlots(items) {
        var result = [];
        var i, item, className, rawName, amount;

        if (!items || !items.length) return result;

        for (i = 0; i < items.length; i++) {
            try {
                item = items[i];
                className = window.runtime.flash.utils.getQualifiedClassName(item);
                if (className !== 'Communication.VO::dBuffVO') continue;

                rawName = getBestRawName(item);
                amount = 1;

                try {
                    amount = item.amount || 1;
                } catch (e) { }

                result.push({
                    rawName: rawName || '[identifier null]',
                    amount: amount
                });
            } catch (e) { }
        }

        return result;
    }

    function buildLootEntry(event, sourceName) {
        var mailVo = event && event.data ? event.data.mailVO : null;
        var normalLoot = getSlots(event && event.data ? (event.data.items || []) : []);
        var premiumLoot = getSlots(event && event.data ? (event.data.premiumItems || []) : []);

        return {
            source: sourceName || 'lootedResource',
            mailId: mailVo ? mailVo.id : 0,
            senderId: mailVo ? -(mailVo.senderId) : 0,
            senderName: mailVo ? mailVo.senderName : t('unknownSender'),
            mailType: mailVo && mailVo.type !== undefined ? mailVo.type : null,
            timestamp: mailVo ? mailVo.timestamp : new Date().getTime(),
            subject: mailVo && mailVo.subject_string ? mailVo.subject_string : '',
            loot: normalLoot,
            premLoot: premiumLoot
        };
    }

    function registerLoot(entry) {
        state.rewards.push(entry);

        // Ograniczenie wielkości tablicy żeby nie puchła w nieskończoność
        if (state.rewards.length > 5000) {
            state.rewards.shift();
        }

        state.meta.trackedCount += 1;
        state.meta.lastUpdate = entry.timestamp;
        saveState();
    }

    function getItemCategory(rawName, localizedName) {
        if (!rawName && !localizedName) return t('catOther');
        var name = String(rawName || '').toLowerCase();
        var loc = String(localizedName || '').toLowerCase();

        function matches(engArr, plArr) {
            var i;
            for (i = 0; engArr && i < engArr.length; i++) {
                if (name.indexOf(engArr[i]) !== -1) return true;
            }
            for (i = 0; plArr && i < plArr.length; i++) {
                if (loc.indexOf(plArr[i]) !== -1) return true;
            }
            return false;
        }

        var explicitAdventuresEng = ['stormrecovery', 'heartofthewood'];
        var explicitAdventuresPl = ['odbudowa', 'serce kniei'];
        if (matches(explicitAdventuresEng, explicitAdventuresPl)) return t('catAdventures');

        var explicitResourcesEng = ['tale', 'token', 'grimoire', 'page'];
        var explicitResourcesPl = ['opowieść', 'żeton', 'grymuar', 'grimuar', 'strona '];
        if (matches(explicitResourcesEng, explicitResourcesPl)) return t('catResources');

        var eventsEng = ['easteregg', 'stripy', 'pumpkin', 'present', 'football', 'balloon', 'valentineflower', 'party'];
        var eventsPl = ['pisank', 'dyni', 'prezent', 'futbolówk', 'balon', 'kwiaty'];
        if (matches(eventsEng, eventsPl)) return t('catEvents');

        var collectionsEng = ['herb', 'foodcart', 'cart', 'kettle', 'teapot', 'banner', 'flag', 'cauldron', 'barrel', 'sack', 'grain', 'leather', 'hide', 'adamantium', 'adamantine', 'adamant'];
        var collectionsPl = ['zioła', 'wózek', 'czajnik', 'chorągiew', 'kocioł', 'beczka', 'worki', 'skóra', 'adamantu'];
        if (matches(collectionsEng, collectionsPl)) return t('catCollections');

        var buildingsEng = ['building', 'mayorhouse', 'changeskin', 'residence', 'storehouse', 'manor', 'mine', 'industrial', 'stump', 'beanstalk', 'box', 'crate', 'chest'];
        var buildingsPl = ['kopalni', 'kopalnia', 'pieniek', 'pień', 'skrzyni', 'ozdob', 'monument', 'statue', 'pomnik', 'budynek', 'rezydencja', 'magazyn'];
        if (matches(buildingsEng, buildingsPl)) return t('catBuildings');

        var buffsEng = ['buff', 'productivity', 'speedup', 'night', 'recruiting', 'codex', 'manuscript', 'tome', 'effect', 'battle', 'tropical', 'filldeposit', 'recruit', 'weaponproduction', 'potion', 'stadiumsnack', 'glue', 'scarecrow'];
        var buffsPl = ['premia', 'doładowanie', 'kanapka', 'półmisek', 'koszyk', 'torba', 'rytuał', 'zupa', 'misa', 'herbata', 'przekąski', 'łapka', 'amulet', 'szybsze', 'steki', 'pieczona kaczka', 'zombie', 'mr myers', 'myers', 'pan myers', 'piaskuna', 'igor', 'odznaka', 'ciasteczka', 'napój', 'klej', 'strach na wróble'];
        if (matches(buffsEng, buffsPl)) return t('catBuffs');

        var adventuresEng = ['adventure', 'tombraiders', 'darkbrotherhood', 'darkpriests', 'thenords', 'roaringbull', '1001night', 'ridingtheraiders', 'sonsoftheveld', 'bonabertibusiness', 'theblackknights', 'madhenry', 'splitcityfall', 'secludedexperiments', 'victorthevicious', 'outlaws', 'thesiege', 'miadsleepyreef', 'miadsleepingvolcano', 'lakesidetreasure', 'heartofthewood', 'whirlwind', 'surpriseattack', 'scenario', 'tailor', 'invitation', 'wedding', 'bounty hunter', 'bountyhunter', 'shaman', 'endoftheworld', 'horseback', 'banditnest', 'bandit nest', 'tropicalsun', 'oldruins', 'garrun', 'christmasfeast', 'pirateisland', 'piratelife', 'lostskull', 'traitors', 'mary', 'stolensleigh', 'oldfriends', 'tikki', 'prisonisland', 'arcticexplosion', 'stealingfromtherich', 'motherlylove', 'valuableintel', 'songs', 'curses', 'chupacabra', 'lostcity', 'onestepahead', 'evilqueen', 'hansel', 'gretel', 'piedpiper', 'redridinghood', 'snowwhite', 'footofthemountain', 'unknownregions', 'mountainlabyrinth', 'mountainpeople', 'giantbattle', 'sindbad', 'aladdin', 'buccaneer', 'grainconflict', 'twins', 'mountainwealth', 'stormrecovery', 'mist', 'danger', 'darkgate', 'picasso', 'sabotage', 'cousin', 'east eggs', 'winterwonderland', 'festivecheer', 'match', 'cup', 'quarter final', 'semi final', 'final', 'herowanted', 'nothingunusual', 'newexperience', 'retrostyle', 'jester', 'blackknights'];
        var adventuresPl = ['przygoda', 'zaproszenie', 'krawiec', 'bractwo', 'kapłani', 'wikingowie', 'byk', 'synowie stepów', 'henryk', 'wiktor', 'banici', 'oblężenie', 'łupieżców', 'podzielone miasto', 'eksperymenty', 'czarni rycerze', 'skarb przy jeziorze', 'rafa', 'wulkan', 'serce kniei', 'wir', 'atak z zaskoczenia', 'ali baba', 'złodziej', 'łowca nagród', 'wiedźm', 'koniec świata', 'tort', 'końsk', 'azyl', 'tropików', 'ruiny', 'szaman', 'traper', 'uczt', 'pirat', 'czaszka', 'zdrajcy', 'maryna', 'sanie', 'przyjaciele', 'tikki', 'więzienn', 'eksplozja', 'bonaberti', 'okradać', 'sawanny', 'matczyna', 'cenne dane', 'pieśni i klątwy', 'czatownia', 'chupacabra', 'zaginione miasto', 'krok naprzód', 'królowej', 'jaś i małgosia', 'flecista', 'kapturek', 'śnieżka', 'u stóp góry', 'nieznane tereny', 'labirynt', 'lud gór', 'wielka bitwa', 'sindbad', 'aladyn', 'bukanier', 'ziarno', 'bliźnięta', 'jajka', 'bogactwa', 'odbudowa', 'potwory z mgły', 'niebezpieczeństwo', 'mroczna brama', 'picasso', 'sabotaż', 'kuzyn', 'pisank', 'kraina czarow', 'nastroju', 'mecz', 'puchar', 'ćwierćfinał', 'półfinał', 'finał', 'bohater', 'nic szczególnego', 'nowe doświadczenie', 'styl retro', 'trefnisi'];
        if (matches(adventuresEng, adventuresPl)) return t('catAdventures');

        var resourcesEng = ['platinumore', 'platinum', 'goldore', 'gold', 'coin', 'guildcoin', 'granite', 'magicbean', 'bean', 'mahoganywood', 'mahogany', 'exoticwood', 'exotic', 'oilseed', 'grout', 'salpeter', 'gunpowder', 'titaniumore', 'titanium', 'obsidian', 'wood', 'pinewood', 'pine', 'hardwood', 'oak', 'plank', 'board', 'log', 'fir', 'firwood', 'stone', 'marble', 'tools', 'water', 'coal', 'ironore', 'iron', 'steel', 'bronze', 'copper', 'copperore', 'horses', 'horse', 'sausages', 'sausage', 'bread', 'brew', 'beer', 'flour', 'wheat', 'meat', 'fish', 'fragment', 'mappart', 'settler', 'population', 'sword', 'bow', 'crossbow', 'cannon', 'arquebus', 'harquebus', 'mortar', 'gun'];
        var resourcesPl = ['ruda', 'monety', 'granit', 'fasola', 'drewno', 'nasiono', 'zaprawa', 'saletra', 'proch', 'tytan', 'deski', 'bale', 'kamień', 'marmur', 'narzędzia', 'woda', 'węgiel', 'żelazo', 'stal', 'brąz', 'miedź', 'konie', 'wędliny', 'chleb', 'napitek', 'mąka', 'zboże', 'mięso', 'ryby', 'fragment', 'osadnicy', 'miecz', 'łuk', 'kusze', 'armat', 'arkebuz', 'moździerz'];
        if (matches(resourcesEng, resourcesPl)) return t('catResources');

        return t('catOther');
    }

    function getComputedItem(rawItem, entrySource) {
        var locName = getLocalizedRewardName(rawItem.rawName);
        return {
            rawName: rawItem.rawName || '[identifier null]',
            amount: rawItem.amount || 1,
            name: locName,
            source: entrySource || t('other'),
            itemCategory: getItemCategory(rawItem.rawName, locName)
        };
    }

    function buildTotals(itemsList, entrySources) {
        var totals = {};
        var i, j, rawItem, item, key, sourceStr;

        for (i = 0; i < itemsList.length; i++) {
            sourceStr = entrySources[i] || t('other');

            for (j = 0; j < itemsList[i].length; j++) {
                rawItem = itemsList[i][j];
                item = getComputedItem(rawItem, sourceStr);
                key = (item.rawName || item.name || t('unknown')) + '||' + item.source + '||' + item.itemCategory;

                if (!totals[key]) {
                    totals[key] = {
                        name: item.name,
                        rawName: item.rawName,
                        amount: 0,
                        hits: 0,
                        source: item.source,
                        itemCategory: item.itemCategory
                    };
                }

                totals[key].amount += item.amount;
                totals[key].hits += 1;
            }
        }

        return totals;
    }

    function sortTotalsObject(obj) {
        var arr = [];
        var key;
        var mode = getSortMode();

        function sourceOrder(src) {
            if (src === t('treasureSearch')) return 1;
            if (src === t('artifactSearch')) return 2;
            if (src === t('adventureSearch')) return 3;
            if (src === t('adventureLoot')) return 4;
            if (src === t('adventureFinds')) return 5;
            if (src === t('geologistSmuggler')) return 6;
            if (src === t('other')) return 99;
            return 50;
        }

        for (key in obj) {
            if (obj.hasOwnProperty(key)) arr.push(obj[key]);
        }

        arr.sort(function (a, b) {
            if (mode === 'name') {
                return String(a.name).localeCompare(String(b.name), undefined, { sensitivity: 'base' });
            }

            if (mode === 'itemCategory') {
                var catDiff = String(a.itemCategory).localeCompare(String(b.itemCategory), undefined, { sensitivity: 'base' });
                if (catDiff !== 0) return catDiff;

                var srcDiff = sourceOrder(a.source) - sourceOrder(b.source);
                if (srcDiff !== 0) return srcDiff;
            } else {
                // By default mode === 'source'
                var srcDiff = sourceOrder(a.source) - sourceOrder(b.source);
                if (srcDiff !== 0) return srcDiff;

                var catDiff = String(a.itemCategory).localeCompare(String(b.itemCategory), undefined, { sensitivity: 'base' });
                if (catDiff !== 0) return catDiff;
            }

            if (b.amount !== a.amount) return b.amount - a.amount;

            return String(a.name).localeCompare(String(b.name), undefined, { sensitivity: 'base' });
        });

        return arr;
    }

    function createBaseModal(id, title) {
        $('#' + id).remove();

        var w = new Modal(id, title);
        w.size = 'large';
        w.create();

        setTimeout(function () {
            var $root = $('#' + id);
            var $dialog = $root.find('.modal-dialog');
            var $content = $root.find('.modal-content');
            var $body = $root.find('.modal-body');
            var $footer = $root.find('.modal-footer');

            $root.css({ minWidth: '1200px' });

            $dialog.css({
                width: '1200px',
                maxWidth: '98%',
                marginLeft: 'auto',
                marginRight: 'auto'
            });

            $content.css({
                width: '100%',
                position: 'relative'
            });

            var $header = $root.find('.modal-header');
            if ($header.length) {
                $header.css({
                    borderBottom: '0',
                    padding: '14px 20px'
                });
            }

            var $title = $root.find('.modal-title');
            if ($title.length) {
                $title.css({
                    fontSize: '16px',
                    fontWeight: '700',
                    letterSpacing: '1px',
                    color: '#ffe082'
                });
            }

            $body.css({
                paddingBottom: '50px',
                background: 'linear-gradient(180deg, #7a5c30 0%, #5a3e18 100%)',
                color: '#fff8e8'
            });

            $footer.css({
                position: 'absolute',
                right: '12px',
                bottom: '10px',
                width: 'auto',
                minWidth: '0',
                minHeight: '0',
                height: 'auto',
                margin: '0',
                padding: '0',
                border: '0',
                background: 'transparent',
                boxShadow: 'none',
                outline: 'none',
                display: 'block',
                flex: 'none',
                zIndex: '5'
            });

            $footer.find('.btn').css({
                margin: '0'
            });
        }, 20);

        return w;
    }

    function renderLangSwitcher(prefix) {
        var currentLang = state.meta.lang === 'en' ? 'en' : 'pl';
        var html = '';
        html += '<div style="display:inline-block;margin-left:10px;">';
        html += '<label style="margin-right:6px;"><b>' + t('lang') + ':</b></label>';
        html += '<select id="' + prefix + '_langSelect" style="padding:3px 6px;">';
        html += '<option value="pl"' + (currentLang === 'pl' ? ' selected="selected"' : '') + '>' + t('polish') + '</option>';
        html += '<option value="en"' + (currentLang === 'en' ? ' selected="selected"' : '') + '>' + t('english') + '</option>';
        html += '</select>';
        html += '</div>';
        return html;
    }

    function createTableRow(cells, header) {
        if (typeof utils !== 'undefined' && utils.createTableRow) {
            return utils.createTableRow(cells, header);
        }

        var html = '<div class="row" style="margin:0;">';
        var i;
        for (i = 0; i < cells.length; i++) {
            html += '<div class="col-md-' + cells[i][0] + '">' + cells[i][1] + '</div>';
        }
        html += '</div>';
        return html;
    }

    function exportData() {
        try {
            var exportObj = {
                meta: state.meta,
                rewards: state.rewards
            };
            var jsonStr = JSON.stringify(exportObj, null, 2);
            var file = air.File.documentsDirectory.resolvePath('ShowMyLoot_Export.json');
            file.addEventListener(air.Event.COMPLETE, function () {
                chat(t('exportDone'));
            });
            file.save(jsonStr);
        } catch (e) {
            chat(t('exportError') + e);
        }
    }

    function renderHistoryModal() {
        var titleIcon = '';
        var w, html, rewards, i, entry, itemsHtml, j, item, pitem, category;

        try { titleIcon = utils.getImageTag('icon_dice.png', '45px') + ' '; } catch (e) { }

        w = createBaseModal('smlProHistoryWindow', titleIcon + t('historyTitle'));

        html = '<div class="container-fluid" style="user-select:text;">';

        html += '<div style="margin-bottom:12px;">';
        html += '<button id="smlProOpenSummary" class="btn btn-success" style="margin-right:8px;">' + t('summary') + '</button>';
        html += '<button id="smlProReset" class="btn btn-warning" style="margin-right:8px;">' + t('resetData') + '</button>';
        html += '<button id="smlProExport" class="btn btn-info" style="margin-right:8px;">' + t('exportJson') + '</button>';
        html += renderLangSwitcher('smlProHistory');
        html += '<div style="display:inline-block;margin-left:15px;"><label style="margin-right:6px;"><b>' + t('searchName') + '</b></label><input type="text" id="smlProHistory_nameFilter" placeholder="..." style="padding:2px 6px;width:150px;background:rgba(0,0,0,0.1);border:1px solid #a8864a;color:#fff;border-radius:4px;"></div>';
        html += '</div>';

        html += '<div class="smlpro-scroll">';
        rewards = state.rewards.slice(0).reverse();

        if (!rewards.length) {
            html += '<div style="padding:20px;text-align:center;">' + t('noSavedLoots') + '</div>';
        } else {
            for (i = 0; i < rewards.length; i++) {
                entry = rewards[i];
                itemsHtml = [];
                category = classifyEntry(entry);

                for (j = 0; j < entry.loot.length; j++) {
                    item = getComputedItem(entry.loot[j], category);
                    itemsHtml.push(
                        '<div style="display:inline-block;margin:4px 10px 4px 0;" title="' + item.itemCategory + '">' +
                        getItemImage(item.rawName || item.name) + ' ' +
                        item.name + ' <b>x' + item.amount + '</b> <span style="font-size:0.85em;color:rgba(255,255,255,0.6);">(' + item.itemCategory + ')</span>' +
                        '</div>'
                    );
                }

                for (j = 0; j < entry.premLoot.length; j++) {
                    pitem = getComputedItem(entry.premLoot[j], category);
                    itemsHtml.push(
                        '<div style="display:inline-block;margin:4px 10px 4px 0;color:#ffd54f;" title="' + pitem.itemCategory + '">' +
                        getItemImage(pitem.rawName || pitem.name) + ' [PREM] ' +
                        pitem.name + ' <b>x' + pitem.amount + '</b> <span style="font-size:0.85em;color:rgba(255,213,79,0.7);">(' + pitem.itemCategory + ')</span>' +
                        '</div>'
                    );
                }

                html += '<div class="smlpro-card">';
                html += '<div class="smlpro-card-head">';
                html += '<div style="display:inline-block; width:220px;"><b>' + t('dateTime') + ':</b> ' + formatDate(entry.timestamp) + '</div>';
                html += '<div style="display:inline-block; width:220px;"><b>' + t('sender') + ':</b> ' + getLocalizedMailName(entry.senderName) + '</div>';
                html += '<div style="display:inline-block; width:90px;"><b>' + t('type') + ':</b> ' + (entry.mailType === null ? '-' : entry.mailType) + '</div>';
                html += '<div style="display:inline-block; min-width:260px;"><b>' + t('source') + ':</b> ' + category + '</div>';
                html += '</div>';

                html += '<div class="smlpro-card-body">';
                html += '<div style="margin-bottom:6px;"><b>' + t('rewards') + ':</b></div>';
                html += '<div style="white-space:normal; word-break:break-word; line-height:1.6;">' + itemsHtml.join('') + '</div>';
                html += '</div>';
                html += '</div>';
            }
        }

        html += '</div>';
        html += '</div>';

        w.Body().html(html);
        w.show();

        $('#smlProOpenSummary').off('click').on('click', function () {
            renderSummaryModal();
        });

        $('#smlProReset').off('click').on('click', function () {
            var ok = confirm(t('confirmReset'));
            if (!ok) return;
            resetState();
            renderHistoryModal();
            chat(t('resetDone'));
        });

        $('#smlProHistory_langSelect').off('change').on('change', function () {
            setLang($(this).val());
            renderHistoryModal();
        });

        $('#smlProHistory_nameFilter').off('input').on('input', function () {
            var val = $(this).val().toLowerCase();
            $('.smlpro-card').each(function () {
                var cardText = $(this).text().toLowerCase();
                if (cardText.indexOf(val) !== -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });

        $('#smlProExport').off('click').on('click', exportData);
    }

    function renderSummarySection(title, arr, accent) {
        var html = '';
        var i, item;

        html += '<div style="margin-top:15px;">';
        html += '<h4 style="margin:8px 0;color:' + accent + ';">' + title + '</h4>';

        if (!arr.length) {
            html += '<div>' + t('noData') + '</div>';
        } else {
            html += '<div class="smlpro-scroll">';
            html += '<div class="smlpro-sticky-head">';
            html += createTableRow([
                [1, ''],
                [4, t('name')],
                [1, '<div style="text-align:center;">' + t('sum') + '</div>'],
                [1, '<div style="text-align:center;">' + t('occurrences') + '</div>'],
                [3, t('source')],
                [2, t('category')]
            ], true);
            html += '</div>';

            for (i = 0; i < arr.length; i++) {
                item = arr[i];
                html += createTableRow([
                    [1, getItemImage(item.rawName || item.name)],
                    [4, '<div style="white-space:normal;word-break:break-word;">' + item.name + '</div>'],
                    [1, '<div style="text-align:center;"><b>' + item.amount + '</b></div>'],
                    [1, '<div style="text-align:center;">' + item.hits + '</div>'],
                    [3, '<div style="white-space:normal;word-break:break-word;">' + (item.source || '-') + '</div>'],
                    [2, '<div style="white-space:normal;word-break:break-word;">' + (item.itemCategory || '-') + '</div>']
                ], false);
            }

            html += '</div>';
        }

        html += '</div>';
        return html;
    }

    function renderSummaryModal() {
        var titleIcon = '';
        var w, normalItemsList, premiumItemsList, categoriesNormal, categoriesPremium;
        var normalTotals, premiumTotals, normalArr, premiumArr, html;
        var i, category;

        try { titleIcon = utils.getImageTag('icon_dice.png', '45px') + ' '; } catch (e) { }

        w = createBaseModal('smlProSummaryWindow', titleIcon + t('summaryTitle'));

        html = '<div class="container-fluid" style="user-select:text;">';

        html += '<div style="margin-bottom:12px;">';
        html += '<button id="smlProOpenHistory" class="btn btn-primary" style="margin-right:8px;">' + t('history') + '</button>';
        html += '<button id="smlProReset2" class="btn btn-warning" style="margin-right:8px;">' + t('resetData') + '</button>';
        html += '<button id="smlProExport2" class="btn btn-info" style="margin-right:8px;">' + t('exportJson') + '</button>';
        html += renderLangSwitcher('smlProSummary');
        html += renderSortSwitcher('smlProSummary');
        html += '<div style="display:inline-block;margin-left:15px;"><label style="margin-right:6px;"><b>' + t('searchName') + '</b></label><input type="text" id="smlProSummary_nameFilter" placeholder="..." style="padding:2px 6px;width:150px;background:rgba(0,0,0,0.1);border:1px solid #a8864a;color:#fff;border-radius:4px;"></div>';
        html += '</div>';

        html += '<div style="padding:10px 0;">';
        html += '<div><b>' + t('totalEntries') + '</b> ' + state.meta.trackedCount + '</div>';
        html += '<div><b>' + t('lastUpdate') + '</b> ' + (state.meta.lastUpdate ? formatDate(state.meta.lastUpdate) : t('noData')) + '</div>';
        html += '</div>';

        normalItemsList = [];
        premiumItemsList = [];
        categoriesNormal = [];
        categoriesPremium = [];

        for (i = 0; i < state.rewards.length; i++) {
            category = classifyEntry(state.rewards[i]);
            normalItemsList.push(state.rewards[i].loot || []);
            premiumItemsList.push(state.rewards[i].premLoot || []);
            categoriesNormal.push(category);
            categoriesPremium.push(category);
        }

        normalTotals = buildTotals(normalItemsList, categoriesNormal);
        premiumTotals = buildTotals(premiumItemsList, categoriesPremium);

        normalArr = sortTotalsObject(normalTotals);
        premiumArr = sortTotalsObject(premiumTotals);

        html += renderSummarySection(t('normalLoot'), normalArr, '#ffe082');
        html += renderSummarySection(t('premiumLoot'), premiumArr, '#ffd54f');

        html += '</div>';

        w.Body().html(html);
        w.show();

        $('#smlProOpenHistory').off('click').on('click', function () {
            renderHistoryModal();
        });

        $('#smlProReset2').off('click').on('click', function () {
            var ok = confirm(t('confirmReset'));
            if (!ok) return;
            resetState();
            renderSummaryModal();
            chat(t('resetDone'));
        });

        $('#smlProSummary_langSelect').off('change').on('change', function () {
            setLang($(this).val());
            renderSummaryModal();
        });

        $('#smlProSummary_sortMode').off('change').on('change', function () {
            setSortMode($(this).val());
            renderSummaryModal();
        });

        $('#smlProSummary_nameFilter').off('input').on('input', function () {
            var val = $(this).val().toLowerCase();
            $('.smlpro-scroll .row').each(function () {
                var isHeader = $(this).find('.smlpro-sticky-head').length > 0;
                if (isHeader) return;
                var rowText = $(this).text().toLowerCase();
                if (rowText.indexOf(val) !== -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });

        $('#smlProExport2').off('click').on('click', exportData);
    }

    function processLootEvent(event, sourceName) {
        try {
            var mailVo = event && event.data ? event.data.mailVO : null;
            if (!mailVo) return;

            var entry = buildLootEntry(event, sourceName);

            if ((entry.loot && entry.loot.length) || (entry.premLoot && entry.premLoot.length)) {
                registerLoot(entry);
            }
        } catch (e) {
            chat(t('processError') + e);
        }
    }

    function init() {
        try {
            ensureStyles();

            addToolsMenuItem(SML_PRO.MENU_HISTORY, renderHistoryModal);
            addToolsMenuItem(SML_PRO.MENU_SUMMARY, renderSummaryModal);

            var tracker = game.getTracker('sml_pro294', function (event) {
                processLootEvent(event, 'lootedResource');
            });

            game.gi.channels.ZONE.addPropertyObserver('lootedResource', tracker);

            chat(t('initDone'));
        } catch (e) {
            chat(t('initError') + e);
        }
    }

    init();

})();