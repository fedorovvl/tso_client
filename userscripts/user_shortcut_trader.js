var ShortcutTrader = (function () {

    var SCRIPT_CONST = {
        PREFIX:            'FT',
        NAME:              loca.GetText("QUL", "MiadTropicalSunQ2") + ', ' + loca.GetText("ACL", "SellGoods_1"),
        TRADE_TYPES:       { MARKET: 'market', FRIEND: 'friend' },
        TRADE_QUEUE_DELAY: 3000,
        BUTTON_COOLDOWN:   3000,
        SLOT_TYPE: {
            FREE_SLOT:            0,
            PAID_SLOT_WITH_GEMS:  1,
            PAID_SLOT_WITH_COINS: 2,
            FRIEND_TO_FRIEND:     4
        },
        TRADE_STATUS: {
            ACTIVE:            0,
            EXPIRED:           1,
            EXPIRED_SOLDTO:    2,
            EXPIRED_SOME_SOLD: 3,
            EXPIRED_ALL_SOLD:  4
        },
        MSG: {
            SEND_TRADE:         1049,
            REFRESH_TRADES:     1062,
            REQUEST_TRADE_DATA: 1061
        },
        MODE_ICONS: {
            MARKET: 'ButtonIconTrade',
            FRIEND: 'ButtonIconDiplomacy'
        }
    };

    var buildTemplates;

    // ─── User Trades Reader ───────────────────────────────────────────────────
    //
    // Reads placed orders from userPlaceOffersList.dataProvider.
    // rearrangeOffers() fills empty slots with blank cTradeObjects
    // (offer = new Object(), no name fields).
    //
    // isActiveOrder() mirrors exactly what getNextFreeSlotForType() counts:
    //   (status === 0) OR (coolDownTime > 0)
    // plus checks that offer has a real name field (not blank placeholder).

    var UserTradesReader = (function () {

        function getDataProvider() {
            try {
                var GuiBase = swmmo.getDefinitionByName("GUI::cGuiBaseElement");
                var tw      = GuiBase.GetPanel("GAMESTATE_ID_TRADE_WINDOW");
                if (!tw || !tw.userPlaceOffersList) return null;
                return tw.userPlaceOffersList.dataProvider;
            } catch (e) {
                return null;
            }
        }

        function isReady() {
            var dp = getDataProvider();
            return !!(dp && dp.length > 0);
        }

        function isActiveOrder(t) {
            if (!t || !t.offer) return false;
            var hasOffer = !!(t.offer.name_string || t.offer.buffName_string || t.offer.resourceName_string);
            if (!hasOffer) return false;
            return (t.status === SCRIPT_CONST.TRADE_STATUS.ACTIVE) || (t.coolDownTime > 0);
        }

        function getUserTrades() {
            var dp = getDataProvider();
            if (!dp) return [];
            var result = [];
            for (var i = 0; i < dp.length; i++) {
                var t = dp.getItemAt(i);
                if (!isActiveOrder(t)) continue;
                var offerName = t.offer.name_string || t.offer.resourceName_string || t.offer.buffName_string || '';
                var costName  = t.costs
                    ? (t.costs.name_string || t.costs.resourceName_string || t.costs.buffName_string || '')
                    : '';
                result.push({
                    tradeID:       t.tradeID,
                    slotType:      t.slotType,
                    slotPos:       t.slotPos,
                    status:        t.status,
                    coolDownTime:  t.coolDownTime,
                    runningTime:   t.runningTime || '',
                    remainingLots: t.remainingLots,
                    totalLots:     t.totalLots,
                    lots:          t.totalLots || 1,
                    offerResName:  offerName,
                    offerResAmount:t.offer ? (t.offer.amount || 0) : 0,
                    costResName:   costName,
                    costResAmount: t.costs ? (t.costs.amount  || 0) : 0
                });
            }
            return result;
        }

        // Returns the count of active market orders.
        // Primary source: DataProvider (includes LocalInjector placeholders
        // because they have offer name fields → pass isActiveOrder).
        // Fallback: mTradeData.getNextFreeSlotForType (if TradeWindow not ready yet).
        function getCountActiveTrades() {
            if (isReady()) {
                return getUserTrades().length;
            }
            // Fallback before TradeWindow is initialized
            var free  = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(SCRIPT_CONST.SLOT_TYPE.FREE_SLOT);
            var coins = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS);
            return free + coins;
        }

        return {
            isReady:              isReady,
            getUserTrades:        getUserTrades,
            getCountActiveTrades: getCountActiveTrades
        };
    })();

    // ─── Slot Capacity ────────────────────────────────────────────────────────

    var SlotCapacity = (function () {

        function getMaxCoinsSlots() {
            try { return swmmo.getDefinitionByName("global").activateSlotsWithCoins_vector.length; }
            catch (e) { return 10; }
        }

        function getUsedSlotsForType(slotType) {
            return game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(slotType);
        }

        // Total = 1 free + N coins. Remaining = total - active orders.
        function getRemainingMarketCapacity() {
            var activeCount = UserTradesReader.getCountActiveTrades();
            return Math.max(0, getMaxCoinsSlots() + 1 - activeCount);
        }

        // sessionOffset  — 0-based index within current batch
        // baseFreeUsed   — snapshot of FREE_SLOT usage taken before batch loop
        // baseCoinsUsed  — snapshot of COINS usage taken before batch loop
        //
        // Using pre-batch snapshots prevents mid-loop drift: LocalInjector
        // updates mTradeData during queue execution, but slotPos for all
        // offers in the batch is computed here before any send happens.
        function resolveSlot(sessionOffset, baseFreeUsed, baseCoinsUsed) {
            var maxCoins  = getMaxCoinsSlots();
            var freeUsed  = (baseFreeUsed  !== undefined) ? baseFreeUsed  : getUsedSlotsForType(SCRIPT_CONST.SLOT_TYPE.FREE_SLOT);
            var coinsUsed = (baseCoinsUsed !== undefined) ? baseCoinsUsed : getUsedSlotsForType(SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS);

            // First order in batch AND free slot is still available
            if (freeUsed === 0 && sessionOffset === 0) {
                return { slotType: SCRIPT_CONST.SLOT_TYPE.FREE_SLOT, slotPos: 0 };
            }

            // Subsequent orders go to coins slots.
            // If offset=0 consumed the free slot, offset=1 → coinsPos=0, etc.
            var coinsOffset = (freeUsed === 0) ? (sessionOffset - 1) : sessionOffset;
            var coinsPos    = coinsUsed + Math.max(0, coinsOffset);
            if (coinsPos >= maxCoins) return null;

            return { slotType: SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS, slotPos: coinsPos };
        }

        return {
            getRemainingMarketCapacity: getRemainingMarketCapacity,
            getUsedSlotsForType:        getUsedSlotsForType,
            getMaxCoinsSlots:           getMaxCoinsSlots,
            resolveSlot:                resolveSlot
        };
    })();

    // ─── Local Trade Injector ─────────────────────────────────────────────────
    //
    // Injects placeholder entries into mPlacedOffer_vector so that
    // getNextFreeSlotForType() returns correct values for subsequent orders
    // processed in the same game tick.
    //
    // TIMING: must be called AFTER the server has processed INITIATE_TRADE.
    // If called before (e.g. synchronously in the send callback),
    // ValidateBuyTradeOneClickShopItems() sees the slot as already occupied
    // and calls cancelTrade → "TradeFailed" popup even though the trade succeeds.
    //
    // Solution: injectMissing() is called from a trailing queue entry with a
    // setTimeout(TRADE_QUEUE_DELAY) — well after all server responses have been
    // processed. It only injects slots not yet confirmed by the server, so
    // there are no phantom double-entries.

    var LocalTradeInjector = (function () {
        var _idCounter = -1000;

        function inject(slotType, slotPos, offerName, offerAmount, costName, costAmount, lots) {
            try {
                var VOClass = game.def("Communication.VO.TradeWindow::dTradeObjectVO");
                var ACClass = swmmo.getDefinitionByName("mx.collections::ArrayCollection");

                var vo            = new VOClass();
                vo.id             = _idCounter--;   // negative → won't collide with server IDs
                vo.senderID       = game.gi.mHomePlayer.GetPlayerId();
                vo.receiverID     = 0;
                vo.type           = 0;
                vo.slotType       = slotType;
                vo.slotPos        = slotPos;
                vo.created        = new Date().getTime();
                vo.remainingTime  = 3600000 * 6;    // 6h placeholder
                vo.lotsRemaining  = lots || 1;
                vo.deleted        = 0;
                vo.coolDownTime   = 0;
                vo.isTradeCancled = false;
                vo.senderName     = '';
                vo.offer          = offerName + ',' + offerAmount + '|' + costName + ',' + costAmount + '|' + (lots || 1);

                var col = new ACClass();
                col.addItem(vo);
                game.gi.mHomePlayer.mTradeData.setUserPlacedOffers(col);
            } catch (e) {
                debug('LocalTradeInjector.inject error: ' + e);
            }
        }

        // Injects only slots from `slots` that are NOT yet in getUserTrades().
        // Called after TRADE_QUEUE_DELAY ms so server confirmations arrive first.
        function injectMissing(slots) {
            var existing    = UserTradesReader.getUserTrades();
            var existingKeys = {};
            for (var e = 0; e < existing.length; e++) {
                existingKeys[existing[e].slotType + '_' + existing[e].slotPos] = true;
            }
            for (var i = 0; i < slots.length; i++) {
                var s = slots[i];
                if (!s || !s.slot) continue;          // friend trades have slot=null
                var key = s.slot.slotType + '_' + s.slot.slotPos;
                if (existingKeys[key]) continue;      // server already confirmed it
                inject(
                    s.slot.slotType, s.slot.slotPos,
                    s.tr.offerResName, s.tr.offerResAmount,
                    s.tr.costResName,  s.tr.costResAmount,
                    s.tr.UserName
                );
            }
        }

        return { inject: inject, injectMissing: injectMissing };
    })();

    // ─── Settings ─────────────────────────────────────────────────────────────
    //
    // getState() returns a REFERENCE — mutating nested fields directly changes
    // STATE. setState() is only needed when replacing the whole object
    // (resetState, template load).

    var SettingsService = (function () {
        var STATE = initStateData();

        function initStateData() {
            return {
                tradesData: {
                    isMarketTradeMode: true,
                    zone_id:           game.gi.mCurrentViewedZoneID,
                    friendsTrades:     [],
                    marketTrades:      []
                },
                modalInitialized: false
            };
        }

        function resetState()  { STATE = initStateData(); return STATE; }
        function getState()    { return STATE; }
        function setState(s)   { STATE = s; }

        function saveSettings() {
            settings.settings[SCRIPT_CONST.PREFIX + '_SETTINGS'] = {};
            settings.store(STATE.tradesData, SCRIPT_CONST.PREFIX + '_SETTINGS');
        }

        function getCurrentTrades() {
            return STATE.tradesData.isMarketTradeMode
                ? STATE.tradesData.marketTrades
                : STATE.tradesData.friendsTrades;
        }

        function removeTrade(index) {
            if (STATE.tradesData.isMarketTradeMode) {
                STATE.tradesData.marketTrades.splice(index, 1);
            } else {
                STATE.tradesData.friendsTrades.splice(index, 1);
            }
        }

        function getTradeModeType() {
            return STATE.tradesData.isMarketTradeMode
                ? SCRIPT_CONST.TRADE_TYPES.MARKET
                : SCRIPT_CONST.TRADE_TYPES.FRIEND;
        }

        function isMarketModeON() { return STATE.tradesData.isMarketTradeMode; }

        return {
            getState: getState, setState: setState, resetState: resetState,
            saveSettings: saveSettings, removeTrade: removeTrade,
            getCurrentTrades: getCurrentTrades, getTradeModeType: getTradeModeType,
            isMarketModeON: isMarketModeON
        };
    })();

    // ─── UI Map ───────────────────────────────────────────────────────────────

    var UIMap = {
        ids: {
            modal:           SCRIPT_CONST.PREFIX + '_FriendTraderModal',
            modalData:       SCRIPT_CONST.PREFIX + '_FriendTraderModalData',
            modeMarketBtn:   SCRIPT_CONST.PREFIX + '_ModeMarket',
            modeFriendBtn:   SCRIPT_CONST.PREFIX + '_ModeFriend',
            modeFriendLbl:   SCRIPT_CONST.PREFIX + '_MainModeLabel',
            slotInfo:        SCRIPT_CONST.PREFIX + '_SlotInfo',
            selectCounter:   SCRIPT_CONST.PREFIX + '_SelectCounter',

            offerInputStr:   SCRIPT_CONST.PREFIX + '_AddOffer_',
            costInputStr:    SCRIPT_CONST.PREFIX + '_AddCost_',
            offerSelectStr:  SCRIPT_CONST.PREFIX + '_OfferList_',
            costSelectStr:   SCRIPT_CONST.PREFIX + '_CostList_',

            addOfferInput:  function (m) { return this.offerInputStr  + m; },
            addCostInput:   function (m) { return this.costInputStr   + m; },
            offerSelect:    function (m) { return this.offerSelectStr + m; },
            costSelect:     function (m) { return this.costSelectStr  + m; },
            friendSelector: function (m) { return SCRIPT_CONST.PREFIX + '_friend_selector_' + m; },
            marketSelector: function (m) { return SCRIPT_CONST.PREFIX + '_market_scroll_'   + m; }
        },
        classes: {
            modeBtn:         SCRIPT_CONST.PREFIX + '_ModeBtn',
            addRowContainer: SCRIPT_CONST.PREFIX + '_AddRowContainer',
            tradesContainer: SCRIPT_CONST.PREFIX + '_Trades',
            offerResourceImg:'offer-res-img',
            costResourceImg: 'cost-res-img',
            deleteTrade:     SCRIPT_CONST.PREFIX + '_delTrade',
            sendTrade:       SCRIPT_CONST.PREFIX + '_SendTrade',
            addTradeBtn:     SCRIPT_CONST.PREFIX + '_AddTradeBtn',
            resetBtn:        SCRIPT_CONST.PREFIX + '_reset-btn',
            sendAllBtn:      SCRIPT_CONST.PREFIX + '_send-all-btn',
            selectTrade:     SCRIPT_CONST.PREFIX + '_select-trade-chkbox',
            selectAllBtn:    SCRIPT_CONST.PREFIX + '_select-trade-btn',
            saveTemplateBtn: SCRIPT_CONST.PREFIX + '_save-temp-btn',
            loadTemplateBtn: SCRIPT_CONST.PREFIX + '_load-temp-btn'
        }
    };

    // ─── UI Renderer ──────────────────────────────────────────────────────────

    var UIRenderer = (function () {

        function renderHeader() {
            var isMarket = SettingsService.isMarketModeON();

            var marketIcon = '', friendIcon = '';
            try { marketIcon = getImageTag(SCRIPT_CONST.MODE_ICONS.MARKET, '50px'); } catch (e) {}
            try { friendIcon = getImageTag(SCRIPT_CONST.MODE_ICONS.FRIEND, '50px'); } catch (e) {}

            var btnBase   = 'cursor:pointer;border:2px solid transparent;border-radius:5px;padding:3px 0;display:inline-block;vertical-align:middle;margin-right:6px;transition:opacity 0.15s;';
            var marketBtn =
                    '<span id="' + UIMap.ids.modeMarketBtn + '" class="' + UIMap.classes.modeBtn + '" ' +
                    'data-mode="' + SCRIPT_CONST.TRADE_TYPES.MARKET + '" title="' + loca.GetText("LAB", "Marketplace") + '" ' +
                    'style="' + btnBase + 'opacity:' + (isMarket ? '1' : '0.4') + '">' + marketIcon + '</span>';
            var friendBtn =
                    '<span id="' + UIMap.ids.modeFriendBtn + '" class="' + UIMap.classes.modeBtn + '" ' +
                    'data-mode="' + SCRIPT_CONST.TRADE_TYPES.FRIEND + '" title="' + loca.GetText("LAB", "Friends") + '" ' +
                    'style="' + btnBase + 'opacity:' + (!isMarket ? '1' : '0.4') + '">' + friendIcon + '</span>';
            var modeLabel =
                    '<span id="' + UIMap.ids.modeFriendLbl + '" ' +
                    'style="vertical-align:middle;font-weight:600;font-size:13px;">' +
                    loca.GetText("LAB", isMarket ? "Marketplace" : "Friends") + '</span>';

            var modeRow = '<div style="margin-bottom:6px;">' + marketBtn + friendBtn + modeLabel + '</div>';

            var tableHeadHtml = createTableRow([
                [2, loca.GetText("LAB", "WareToDeliver")],
                [2, loca.GetText("LAB", "WareToRecieve")],
                [4, loca.GetText("LAB", "SelectTradeResources")],
                [2, '<span id="tableHeader">' + loca.GetText("LAB", isMarket ? "Lot" : "Friends") + '</span>'],
                [2, loca.GetText('LAB', 'Tasks')]
            ], true);

            var $modal = $('#' + UIMap.ids.modalData);
            $modal.append(
                '<div class="container-fluid">' +
                modeRow +
                '<div style="margin-bottom:5px;padding:4px 8px;background:rgba(0,0,0,0.08);border-radius:4px;font-size:12px;">' +
                '<span id="' + UIMap.ids.slotInfo + '"></span>' +
                '<span id="' + UIMap.ids.selectCounter + '" style="float: right"></span>' +
                '</div>' +
                tableHeadHtml +
                '</div>'
            );

            $modal.find('.container-fluid').append('<div class="' + UIMap.classes.addRowContainer + '"></div>');
            addTradeRow(SettingsService.getTradeModeType());
            $modal.find('.container-fluid').append('<div class="' + UIMap.classes.tradesContainer + '"></div>');

            renderSlotInfo();
            updateSelectCounter();
        }

        function renderBody() {
            var isMarket = SettingsService.isMarketModeON();
            var trades   = isMarket
                ? SettingsService.getState().tradesData.marketTrades
                : SettingsService.getState().tradesData.friendsTrades;

            var $container = $('#' + UIMap.ids.modal)
                .find('.container-fluid')
                .find('.' + UIMap.classes.tradesContainer)
                .empty();

            for (var i = 0; i < trades.length; i++) {
                var trade = trades[i];
                if (isMarket  && trade.userId !== 0) continue;
                if (!isMarket && trade.userId === 0) continue;
                $container.append(renderTradeRow(trade, i));
            }

            renderSlotInfo();
            updateSelectCounter();
        }

        function renderFooter() {
            var $footer = $('#' + UIMap.ids.modal).find('.modal-footer');

            // Counter label sits between the two action buttons so it's visible
            // while the user is selecting rows.
            $footer.prepend([
                createButton(UIMap.classes.resetBtn      + ' btn-warning', getText('btn_reset')),
                createButton(UIMap.classes.sendAllBtn    + ' btn-success', getText('btn_submit') + ' ' + loca.GetText("LAB", "All")),
                createButton(UIMap.classes.selectAllBtn  + ' btn-success', getText('btn_submit') + ' ' + loca.GetText("LAB", "SelectedResource")),
                createButton(UIMap.classes.saveTemplateBtn + ' btn-primary pull-left', getText('save_template')),
                createButton(UIMap.classes.loadTemplateBtn + ' btn-primary pull-left', getText('load_template'))
            ]);
        }

        function updateModeButtons() {
            var isMarket = SettingsService.isMarketModeON();
            $('#' + UIMap.ids.modeMarketBtn).css('opacity', isMarket  ? '1' : '0.4');
            $('#' + UIMap.ids.modeFriendBtn).css('opacity', !isMarket ? '1' : '0.4');
            $('#tableHeader').text(loca.GetText("LAB", isMarket ? "Lot" : "Friends"));
            $('#' + UIMap.ids.modeFriendLbl).text(loca.GetText("LAB", isMarket ? "Marketplace" : "Friends"));
        }

        function renderSlotInfo() {
            if (!SettingsService.isMarketModeON()) {
                $('#' + UIMap.ids.slotInfo).hide();
                return;
            }
            var remaining = SlotCapacity.getRemainingMarketCapacity();
            var maxCoins  = SlotCapacity.getMaxCoinsSlots();
            var total     = maxCoins + 1;
            var used      = total - remaining;
            var color     = remaining === 0 ? '#d9534f' : remaining <= 2 ? '#f0ad4e' : '#5cb85c';
            var warn      = remaining === 0
                ? ' &nbsp;<span style="color:#d9534f">&#9888; ' + (loca.GetText("LAB", "NoSlots")) + '</span>'
                : ' &nbsp;<span style="color:#888">(' + (loca.GetText("LAB", "Available")) + ' ' + remaining + ')</span>';

            $('#' + UIMap.ids.slotInfo)
                .show()
                .html('<span>' + (loca.GetText("LAB", "Slot")) + ': </span>' +
                    '<strong style="color:' + color + '">' + used + ' / ' + total + '</strong>' + warn);
        }

        function updateSelectCounter() {
            var $counter = $('#' + UIMap.ids.selectCounter);

            if (!SettingsService.isMarketModeON()) {
                $counter.text('');
                // Make sure no boxes stay disabled when switching to friend mode
                $('.' + UIMap.classes.selectTrade).prop('disabled', false);
                return;
            }

            var remaining = SlotCapacity.getRemainingMarketCapacity();
            var $boxes    = $('.' + UIMap.classes.selectTrade);
            var checked   = $boxes.filter(':checked').length;

            // Color: green while under limit, orange at limit, red if somehow over
            var color = checked === 0 ? 'wheat'
                : checked < remaining ? '#5cb85c'
                    : checked === remaining ? '#f0ad4e'
                        : '#d9534f';



            $counter.html(loca.GetText("LAB", "OrdersWaiting") + ' <span style="color: '+color+'">' + checked + ' / ' + remaining + '</span>');

            // Disable every unchecked box once the limit is reached
            $boxes.each(function () {
                if (!$(this).prop('checked')) {
                    $(this).prop('disabled', checked >= remaining);
                }
            });
        }

        function addTradeRow(mode) {
            var resources   = GameDataSource.getResourceList();
            var firstRes    = resources[0].items[0];
            var secondRes   = resources[0].items[1];
            var inputOffer  = createNumberInput(UIMap.ids.addOfferInput(mode));
            var inputCost   = createNumberInput(UIMap.ids.addCostInput(mode));
            var selectOffer = createResourceSelect(UIMap.ids.offerSelect(mode), resources);
            var selectCost  = createResourceSelect(UIMap.ids.costSelect(mode), resources);

            var targetSelect;
            if (mode === SCRIPT_CONST.TRADE_TYPES.FRIEND) {
                targetSelect = $('<select>', { id: UIMap.ids.friendSelector(mode), 'class': 'form-control' });
                var friends  = GameDataSource.getFriendsList();
                for (var f = 0; f < friends.length; f++) {
                    targetSelect.append($('<option>', { value: friends[f].id }).text(friends[f].name));
                }
            } else {
                targetSelect = $('<select>', { id: UIMap.ids.marketSelector(mode), 'class': 'form-control' });
                targetSelect.append('<optgroup label="' + loca.GetText("LAB", "Lots") + '">');
                for (var l = 1; l <= 4; l++) {
                    targetSelect.append($('<option>', { value: l }).text(formatFraction(l)));
                }
                targetSelect.append('</optgroup>');
            }

            var offerCell = $('<div>').append(
                $('<div>').addClass(UIMap.classes.offerResourceImg).css({ display: 'inline-block', verticalAlign: 'middle' }).html(getImageTag(firstRes.name, '24px')),
                $('<div>').css({ display: 'inline-block', verticalAlign: 'middle' }).append(inputOffer)
            );
            var costCell = $('<div>').append(
                $('<div>').addClass(UIMap.classes.costResourceImg).css({ display: 'inline-block', verticalAlign: 'middle' }).html(getImageTag(secondRes.name, '24px')),
                $('<div>').css({ display: 'inline-block', verticalAlign: 'middle' }).append(inputCost)
            );
            var addBtn = $('<div>', {
                'class': UIMap.classes.addTradeBtn,
                style:   'display:inline-block;cursor:pointer;background:wheat;border-radius:3px;'
            }).html(getImageTag('AvatarAdd', '24px'));

            var row = createTableRow([
                [2, offerCell], [2, costCell],
                [2, selectOffer], [2, selectCost],
                [2, targetSelect], [2, addBtn]
            ], true);

            $('#' + UIMap.ids.modalData + ' .container-fluid .' + UIMap.classes.addRowContainer).append(row);
            $('#' + UIMap.ids.costSelect(mode)).find('option').eq(1).prop('selected', true);
        }

        function renderTradeRow(item, index) {
            var delBtn = $('<div>', {
                'class': UIMap.classes.deleteTrade, 'data-index': index,
                css: { cursor: 'pointer', display: 'inline-block', marginRight: '5px' },
                html: getImageTag('Close', '24px')
            });
            var sendBtn = $('<div>', {
                'class': UIMap.classes.sendTrade, 'data-index': index,
                css: { cursor: 'pointer', display: 'inline-block', margin: '0 10px' },
                html: getImageTag('Trade', '24px')
            });
            var checkBox = $('<input>', {
                type: 'checkbox', 'class': UIMap.classes.selectTrade,
                'data-index': index, css: { cursor: 'pointer' }
            });
            var actions = $('<div>').append(sendBtn, checkBox, $('<span>').css('margin', '0 6px'), delBtn);
            return createTableRow([
                [2, getImageTag(item.offerResName, '24px') + ' ' + item.offerResAmount],
                [2, getImageTag(item.costResName,  '24px') + ' ' + item.costResAmount],
                [6, formatFraction(item.UserName)],
                [2, $('<div>').append(actions)]
            ], false);
        }

        // ── helpers ───────────────────────────────────────────────────────────

        function createNumberInput(id, value) {
            return $('<input>', {
                type: 'number', id: id, name: id,
                value: value || 1, 'class': 'form-control',
                style: 'display:inline;width:100px;'
            });
        }

        function formatFraction(input) {
            var n = parseInt(input, 10);
            return (n >= 1 && n <= 4) ? (n + '/4') : String(input);
        }

        function createButton(classes, text) {
            return $('<button>').addClass('btn ' + classes).text(text);
        }

        function getLocalizedResourceName(name) {
            var locs = ['RES', 'BUI', 'SHI', 'ADN'];
            for (var i = 0; i < locs.length; i++) {
                var t = loca.GetText(locs[i], name);
                if (t && t.indexOf('[undefined') === -1) return t;
            }
            return '[' + name + ']';
        }

        function createResourceSelect(id, resources) {
            var $select = $('<select>', { id: id, 'class': 'form-control' });
            for (var c = 0; c < resources.length; c++) {
                var cat = resources[c];
                $select.append('<optgroup label="' + loca.GetText("LAB", cat.categoryName) + '">');
                for (var r = 0; r < cat.items.length; r++) {
                    $select.append($('<option>', { value: cat.items[r].name })
                        .text(getLocalizedResourceName(cat.items[r].name)));
                }
            }
            $select.append('</optgroup>');
            return $select;
        }

        return {
            renderHeader:        renderHeader,
            renderBody:          renderBody,
            renderFooter:        renderFooter,
            addTradeRow:         addTradeRow,
            renderTradeRow:      renderTradeRow,
            renderSlotInfo:      renderSlotInfo,
            updateModeButtons:   updateModeButtons,
            updateSelectCounter: updateSelectCounter
        };
    })();

    // ─── Actions ──────────────────────────────────────────────────────────────

    var ActionsService = (function () {

        function init() {
            var $modal     = $('#' + UIMap.ids.modal);
            var $modalData = $('#' + UIMap.ids.modalData).css({ 'padding-top': 0 });

            $modalData
                .off('click',  '.' + UIMap.classes.modeBtn)
                .on( 'click',  '.' + UIMap.classes.modeBtn,     handleModeSwitch)
                .off('click',  '.' + UIMap.classes.deleteTrade)
                .on( 'click',  '.' + UIMap.classes.deleteTrade, handleDeleteTrade)
                .off('click',  '.' + UIMap.classes.sendTrade)
                .on( 'click',  '.' + UIMap.classes.sendTrade,   handleSendTrade)
                .off('click',  '.' + UIMap.classes.addTradeBtn)
                .on( 'click',  '.' + UIMap.classes.addTradeBtn, handleAddTrade)
                // Checkbox change → re-run counter logic
                .off('change', '.' + UIMap.classes.selectTrade)
                .on( 'change', '.' + UIMap.classes.selectTrade, handleCheckboxChange)
                .off('change', '[id^="' + UIMap.ids.offerSelectStr + '"]')
                .on( 'change', '[id^="' + UIMap.ids.offerSelectStr + '"]', handleOfferChange)
                .off('change', '[id^="' + UIMap.ids.costSelectStr  + '"]')
                .on( 'change', '[id^="' + UIMap.ids.costSelectStr  + '"]', handleCostChange)
                .off('input change', '[id^="' + UIMap.ids.offerInputStr + '"]')
                .on( 'input change', '[id^="' + UIMap.ids.offerInputStr + '"]', handleInputSanitize)
                .off('input change', '[id^="' + UIMap.ids.costInputStr  + '"]')
                .on( 'input change', '[id^="' + UIMap.ids.costInputStr  + '"]', handleInputSanitize);

            $modal
                .off('click', '.' + UIMap.classes.resetBtn)
                .on( 'click', '.' + UIMap.classes.resetBtn,        handleReset)
                .off('click', '.' + UIMap.classes.sendAllBtn)
                .on( 'click', '.' + UIMap.classes.sendAllBtn,       handleSubmitAll)
                .off('click', '.' + UIMap.classes.selectAllBtn)
                .on( 'click', '.' + UIMap.classes.selectAllBtn,     handleSubmitAllSelected)
                .off('click', '.' + UIMap.classes.saveTemplateBtn)
                .on( 'click', '.' + UIMap.classes.saveTemplateBtn,  handleSaveTemplate)
                .off('click', '.' + UIMap.classes.loadTemplateBtn)
                .on( 'click', '.' + UIMap.classes.loadTemplateBtn,  handleLoadTemplate);

            $('.' + UIMap.classes.tradesContainer).sortable({ items: '.row', update: handleSortTrades });
        }

        // Called on every checkbox change — updates counter + enforces limit
        function handleCheckboxChange() {
            UIRenderer.updateSelectCounter();
        }

        function handleModeSwitch() {
            var clickedMode = $(this).attr('data-mode');
            var isMarket    = SettingsService.isMarketModeON();
            var currentMode = isMarket ? SCRIPT_CONST.TRADE_TYPES.MARKET : SCRIPT_CONST.TRADE_TYPES.FRIEND;
            if (clickedMode === currentMode) return;

            SettingsService.getState().tradesData.isMarketTradeMode =
                (clickedMode === SCRIPT_CONST.TRADE_TYPES.MARKET);

            UIRenderer.updateModeButtons();
            $('.' + UIMap.classes.addRowContainer).empty();
            UIRenderer.addTradeRow(clickedMode);
            UIRenderer.renderBody();
            SettingsService.saveSettings();
        }

        function handleSendTrade() {
            if ($(this).css('pointer-events') === 'none') return;
            var index  = $(this).data('index');
            var trades = SettingsService.getCurrentTrades();
            disableSendButtons();
            TradeService.send([trades[index]]);
        }

        function handleSortTrades(event, ui) {
            var currentIndex = ui.item.find('.' + UIMap.classes.deleteTrade).data('index');
            var nextElement  = ui.item.nextAll('.row').find('.' + UIMap.classes.deleteTrade).first();
            var nextIndex    = nextElement.length ? nextElement.data('index') : null;
            var state        = SettingsService.getState();
            var trades       = SettingsService.getCurrentTrades();
            var moved        = trades[currentIndex];
            if (moved === undefined) return;
            trades.splice(currentIndex, 1);
            if (nextIndex !== null && trades[nextIndex] !== undefined) {
                trades.splice(trades.indexOf(trades[nextIndex]), 0, moved);
            } else {
                trades.push(moved);
            }
            if (SettingsService.isMarketModeON()) { state.tradesData.marketTrades  = trades; }
            else                                  { state.tradesData.friendsTrades = trades; }
            SettingsService.setState(state);
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleDeleteTrade() {
            SettingsService.removeTrade($(this).data('index'));
            UIRenderer.renderBody();
            SettingsService.saveSettings();
        }

        function handleAddTrade() {
            var mode           = SettingsService.getTradeModeType();
            var offerResName   = $('#' + UIMap.ids.offerSelect(mode)).val();
            var offerResAmount = parseInt($('#' + UIMap.ids.addOfferInput(mode)).val(), 10);
            var costResName    = $('#' + UIMap.ids.costSelect(mode)).val();
            var costResAmount  = parseInt($('#' + UIMap.ids.addCostInput(mode)).val(), 10);
            if (!offerResAmount || !costResAmount) { TradeNotify.alertCannotAfford(); return; }
            var userId = 0, userName;
            if (mode === SCRIPT_CONST.TRADE_TYPES.FRIEND) {
                var $fs = $('#' + UIMap.ids.friendSelector(mode));
                userId   = parseInt($fs.val(), 10);
                userName = $fs.find('option:selected').text();
            } else {
                userName = parseInt($('#' + UIMap.ids.marketSelector(mode)).find('option:selected').val(), 10);
            }
            SettingsService.getCurrentTrades().push({
                offerResName: offerResName, offerResAmount: offerResAmount,
                costResName: costResName, costResAmount: costResAmount,
                userId: userId, UserName: userName
            });
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleOfferChange() { $('.' + UIMap.classes.offerResourceImg).html(getImageTag(this.value, '24px')); }
        function handleCostChange()  { $('.' + UIMap.classes.costResourceImg).html(getImageTag(this.value, '24px')); }

        function handleReset() {
            SettingsService.resetState();
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleSubmitAll() {
            var trades = SettingsService.getCurrentTrades();
            if (!trades.length) return;
            $('#' + UIMap.ids.modal).modal('hide');
            TradeService.send(trades);
        }

        function handleSubmitAllSelected() {
            var current = SettingsService.getCurrentTrades();
            var trades  = [];
            $('.' + UIMap.classes.selectTrade + ':checked').each(function () {
                var idx = $(this).data('index');
                if (idx !== undefined) trades.push(current[parseInt(idx, 10)]);
            });
            if (!trades.length) return;
            $('#' + UIMap.ids.modal).modal('hide');
            TradeService.send(trades);
        }

        function handleSaveTemplate() { buildTemplates.save(SettingsService.getState().tradesData); }
        function handleLoadTemplate() { buildTemplates.load(); }

        function handleInputSanitize() {
            var v = this.value.replace(/\D/g, '');
            this.value = v || 1;
        }

        function disableSendButtons() {
            $('.' + UIMap.classes.sendTrade).css({ opacity: 0.5, 'pointer-events': 'none' });
            setTimeout(function () {
                $('.' + UIMap.classes.sendTrade).css({ opacity: 1, 'pointer-events': '' });
            }, SCRIPT_CONST.BUTTON_COOLDOWN);
        }

        return { init: init };
    })();

    // ─── Game Data ────────────────────────────────────────────────────────────

    var GameDataSource = (function () {
        var _friendsList  = null;
        var _resourceList = null;

        function getFriendsList() {
            if (!_friendsList) {
                var raw  = globalFlash.gui.mFriendsList.GetFilteredFriends('', true);
                _friendsList = [];
                for (var i = 0; i < raw.length; i++) {
                    _friendsList.push({ id: raw[i].id, name: raw[i].username });
                }
            }
            return _friendsList;
        }

        function getResourceList() {
            if (!_resourceList) {
                var byCategory = {}, catNames = [];
                try {
                    var products = swmmo.getDefinitionByName("ServerState::gEconomics").mResourceDefaultDefinition_vector;
                    for (var p = 0; p < products.length; p++) {
                        var prod = products[p];
                        if (!prod.tradable) continue;
                        var cat     = prod.group_string || prod.category_string || "WarehouseTab7";
                        var clMatch = cat.match(/^CL(\d+)$/);
                        if (clMatch) { cat = "WarehouseTab" + clMatch[1]; }
                        else if (cat === "Event") { cat = "WarehouseTab6"; }
                        if (cat === "WarehouseTab5") cat = "WarehouseTab8";
                        if (!byCategory.hasOwnProperty(cat)) { byCategory[cat] = []; catNames.push(cat); }
                        byCategory[cat].push({ name: prod.resourceName_string });
                    }
                    catNames.push('buffs'); byCategory['buffs'] = [];
                    var buffMap = swmmo.getDefinitionByName("global").map_BuffName_BuffDefinition;
                    for (var bk in buffMap) {
                        var bd = buffMap[bk];
                        if (bd.IsTradable(bd.GetName_string())) byCategory['buffs'].push({ name: bd.GetName_string() });
                    }
                    catNames.push('adventures'); byCategory['adventures'] = [];
                    var advs = swmmo.getDefinitionByName("AdventureSystem::cAdventureDefinition")
                        .map_AdventureName_AdventureDefinition.valueSet();
                    for (var ak in advs) {
                        if (advs[ak].IsTradable()) byCategory['adventures'].push({ name: advs[ak].GetName() });
                    }
                    catNames.push('buildings'); byCategory['buildings'] = [];
                    var blds = swmmo.getDefinitionByName("global").buildingGroup.mGOList_vector;
                    for (var bl in blds) {
                        if (blds[bl].isTradable()) byCategory['buildings'].push({ name: blds[bl].mGfxResourceListName_string });
                    }
                    catNames.sort();
                    _resourceList = [];
                    for (var cn = 0; cn < catNames.length; cn++) {
                        _resourceList.push({ categoryName: catNames[cn], items: byCategory[catNames[cn]] });
                    }
                } catch (e) { debug(e); _resourceList = []; }
            }
            return _resourceList;
        }

        function invalidate() { _friendsList = null; _resourceList = null; }

        return { getFriendsList: getFriendsList, getResourceList: getResourceList, invalidate: invalidate };
    })();

    // ─── Trade Service ────────────────────────────────────────────────────────

    var TradeService = (function () {

        function send(trades) {
            if (!Array.isArray(trades) || !trades.length) { TradeNotify.alertCannotAfford(); return; }

            var isMarket = SettingsService.isMarketModeON();

            var filtered = [];
            for (var t = 0; t < trades.length; t++) {
                var ok = isMarket ? (trades[t].userId === 0) : (trades[t].userId !== 0);
                if (ok) filtered.push(trades[t]);
            }
            if (!filtered.length) return;

            if (isMarket) {
                var remaining = SlotCapacity.getRemainingMarketCapacity();
                if (remaining <= 0) { TradeNotify.alertNoSlots(); return; }
                if (filtered.length > remaining) {
                    TradeNotify.alertSlotsTrimmed(filtered.length, remaining);
                    filtered = filtered.slice(0, remaining);
                }
            }

            var slots           = [];   // { slot, tr } — used by injectMissing at the end
            var queue           = new TimedQueue(SCRIPT_CONST.TRADE_QUEUE_DELAY);
            var successCount    = 0;
            var totalTrades     = filtered.length;
            var playerResources = game.gi.mCurrentPlayerZone.GetResources(game.gi.mHomePlayer);

            // Snapshot ONCE before the loop so resolveSlot doesn't drift
            var baseFreeUsed  = isMarket ? SlotCapacity.getUsedSlotsForType(SCRIPT_CONST.SLOT_TYPE.FREE_SLOT) : 0;
            var baseCoinsUsed = isMarket ? SlotCapacity.getUsedSlotsForType(SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS) : 0;
            var sessionOffset = 0;

            for (var i = 0; i < filtered.length; i++) {
                var trade = filtered[i];
                if (!TradeValidator.isTradeAllowed(trade)) { totalTrades--; continue; }

                var tradeOffer = TradeOfferFactory.create(trade, playerResources);
                if (!tradeOffer) { totalTrades--; continue; }

                var slotInfo = null;
                if (isMarket) {
                    slotInfo = SlotCapacity.resolveSlot(sessionOffset, baseFreeUsed, baseCoinsUsed);
                    if (!slotInfo) { totalTrades--; continue; }
                    TradeOfferFactory.applyMarketRecipient(tradeOffer, trade, slotInfo);
                    sessionOffset++;
                } else {
                    TradeOfferFactory.applyFriendRecipient(tradeOffer, trade);
                }

                slots.push({ slot: slotInfo, tr: trade });  // slot=null for friend trades

                (function (offer, tr) {
                    TradeQueue.enqueue(queue, offer, tr, function () {
                        successCount++;
                        TradeNotify.showSuccess(tr, successCount, totalTrades);
                        UIRenderer.renderSlotInfo();
                        UIRenderer.updateSelectCounter();
                    });
                })(tradeOffer, trade);
            }

            if (queue.len() > 0) {
                // Trailing entry: runs after the last timed send.
                // Waits another TRADE_QUEUE_DELAY so the server has responded
                // and updated mPlacedOffer_vector via TRADE_GET_USER_TRADES.
                // Then injects only slots still missing and refreshes the panel.
                (function (capturedSlots) {
                    queue.add(function () {
                        setTimeout(function () {
                            LocalTradeInjector.injectMissing(capturedSlots);
                            refreshTrades();
                        }, SCRIPT_CONST.TRADE_QUEUE_DELAY);
                    });
                })(slots);

                queue.run();
            }
        }

        function refreshTrades() {
            game.gi.mClientMessages.SendMessagetoServer(SCRIPT_CONST.MSG.REFRESH_TRADES,     game.gi.mCurrentViewedZoneID, null);
            game.gi.mClientMessages.SendMessagetoServer(SCRIPT_CONST.MSG.REQUEST_TRADE_DATA, game.gi.mCurrentViewedZoneID, null);
        }

        return { send: send, refreshTrades: refreshTrades };
    })();

    // ─── Trade Validator ──────────────────────────────────────────────────────

    var TradeValidator = (function () {
        function isTradeAllowed(trade) {
            var isMarket = SettingsService.getState().tradesData.isMarketTradeMode;
            if (!isMarket && trade.userId === 0)  return false;
            if ( isMarket && trade.userId !== 0)  return false;
            if (!isMarket) {
                var friends  = GameDataSource.getFriendsList();
                var isFriend = false;
                for (var f = 0; f < friends.length; f++) {
                    if (friends[f].id == trade.userId) { isFriend = true; break; }
                }
                if (!isFriend) { TradeNotify.alertAddFriend(); return false; }
            }
            return true;
        }
        return { isTradeAllowed: isTradeAllowed };
    })();

    // ─── Trade Offer Factory ──────────────────────────────────────────────────

    var TradeOfferFactory = (function () {
        function create(trade, playerResources) {
            var offer = new (game.def("Communication.VO::dTradeOfferVO"));
            if (!applyOffer(offer, trade, playerResources)) return null;
            applyCost(offer, trade);
            return offer;
        }
        function applyMarketRecipient(offer, trade, slotInfo) {
            offer.receipientId = 0;
            offer.lots     = trade.UserName;
            offer.slotType = slotInfo.slotType;
            offer.slotPos  = slotInfo.slotPos;
        }
        function applyFriendRecipient(offer, trade) {
            offer.receipientId = trade.userId;
            offer.slotType = SCRIPT_CONST.SLOT_TYPE.FRIEND_TO_FRIEND;
            offer.lots     = 0;
            offer.slotPos  = 0;
        }
        function applyOffer(offer, trade, playerResources) {
            return TradeResources.getResourceDef(trade.offerResName)
                ? TradeResources.applyOfferResource(offer, trade, playerResources)
                : TradeResources.applyOfferBuff(offer, trade);
        }
        function applyCost(offer, trade) {
            if (TradeResources.getResourceDef(trade.costResName)) { TradeResources.applyCostResource(offer, trade); }
            else { TradeResources.applyCostBuff(offer, trade); }
        }
        return { create: create, applyMarketRecipient: applyMarketRecipient, applyFriendRecipient: applyFriendRecipient };
    })();

    // ─── Trade Resources ──────────────────────────────────────────────────────

    var TradeResources = (function () {
        function getResourceDef(name) {
            return swmmo.getDefinitionByName("ServerState::gEconomics").GetResourcesDefaultDefinition(name);
        }
        function findTradableBuff(name) {
            var buffs = game.gi.mHomePlayer.getBuffsSortedForStarMenu();
            for (var i = 0; i < buffs.length; i++) {
                var item = buffs[i];
                if ((item.GetBuffDefinition().GetName_string() === name || item.GetResourceName_string() === name) &&
                    item.GetBuffDefinition().IsTradable(item.GetResourceName_string())) {
                    return item.CreateBuffVOFromBuff();
                }
            }
            return null;
        }
        function applyOfferResource(offer, trade, playerResources) {
            var amount = trade.offerResAmount;
            if (SettingsService.isMarketModeON()) amount *= trade.UserName;
            try {
                if (!playerResources.HasPlayerResource(trade.offerResName, amount)) { TradeNotify.alertCannotAfford(); return false; }
            } catch (e) { TradeNotify.alertCannotAfford(); return false; }
            var res = new (game.def("Communication.VO::dResourceVO"));
            res.amount = res.producedAmount = trade.offerResAmount;
            res.name_string = trade.offerResName;
            offer.offerRes = res;
            return true;
        }
        function applyOfferBuff(offer, trade) {
            var buff = findTradableBuff(trade.offerResName);
            if (!buff || buff.amount < trade.offerResAmount) { TradeNotify.alertCannotAfford(); return false; }
            buff.amount = trade.offerResAmount;
            offer.offerBuff = buff;
            return true;
        }
        function applyCostResource(offer, trade) {
            var res = new (game.def("Communication.VO::dResourceVO"));
            res.amount = res.producedAmount = trade.costResAmount;
            res.name_string = trade.costResName;
            offer.costsRes = res;
        }
        function applyCostBuff(offer, trade) {
            var buff = new (game.def("Communication.VO::dBuffVO"));
            buff.sourceZoneId = game.gi.mCurrentViewedZoneID;
            buff.amount = trade.costResAmount;
            buff.resourceName_string = trade.costResName;
            buff.buffName_string = getResourceTypeByName(trade.costResName);
            offer.costsBuff = buff;
        }
        function getResourceTypeByName(name) {
            var nr = swmmo.getDefinitionByName("global").buildingGroup.GetNrFromName(name);
            if (nr !== 195) return 'BuildBuilding';
            var adv = swmmo.getDefinitionByName("AdventureSystem::cAdventureDefinition")
                .map_AdventureName_AdventureDefinition.getItem(name);
            if (adv) return 'Adventure';
            return name;
        }
        return {
            getResourceDef: getResourceDef, applyOfferResource: applyOfferResource,
            applyOfferBuff: applyOfferBuff, applyCostResource: applyCostResource, applyCostBuff: applyCostBuff
        };
    })();

    // ─── Trade Queue ──────────────────────────────────────────────────────────

    var TradeQueue = {
        enqueue: function (queue, offer, trade, cb) {
            queue.add(function () {
                game.gi.mClientMessages.SendMessagetoServer(
                    SCRIPT_CONST.MSG.SEND_TRADE,
                    game.gi.mCurrentViewedZoneID,
                    offer
                );
                cb();
                globalFlash.gui.mAvatarMessageList.AddMessage('TradeInitiated');
            });
        }
    };

    // ─── Trade Notify ─────────────────────────────────────────────────────────

    var TradeNotify = {
        alertCannotAfford: function () { game.showAlert(loca.GetText('LAB', 'CannotAffordSendTrade')); },
        alertAddFriend:    function () { game.showAlert(loca.GetText('QUL', 'SocialMedium8') + ' ' + loca.GetText('LAB', 'AddFriend')); },
        alertNoSlots:      function () { game.showAlert(loca.GetText('LAB', 'NoSlots') || 'No free trade slots available.'); },
        alertSlotsTrimmed: function (req, allowed) {
            game.showAlert(loca.GetText('LAB', 'OrdersWaiting', [req]) + '. ' + loca.GetText('LAB', 'RemainingItemsPerPlayer', [allowed]));
        },
        showSuccess: function (trade, success, total) {
            var msg = loca.GetText('LAB', 'TradeOffer') + ' ';
            msg += trade.userId === 0
                ? loca.GetText('MES', 'TradeInitiated')
                : loca.GetText('LAB', 'User') + ': ' + trade.UserName;
            msg += ' (' + success + '/' + total + ')';
            game.showAlert(msg);
        }
    };

    // ─── Bootstrap ────────────────────────────────────────────────────────────

    function OpenShortCutTraderModal() {
        try {
            if (!game.gi.isOnHomzone()) { game.showAlert(getText('not_home')); return; }

            var state = SettingsService.getState();
            if (state.tradesData.zone_id !== game.gi.mCurrentViewedZoneID) SettingsService.resetState();

            $("div[role='dialog']:not(#" + UIMap.ids.modal + "):visible").modal('hide');
            if (!state.modalInitialized) $('#' + UIMap.ids.modal).remove();

            createModalWindow(UIMap.ids.modal, SCRIPT_CONST.NAME);

            buildTemplates = new SaveLoadTemplate('short_trade', function (data, name) {
                $("#" + UIMap.ids.modal + " .templateFile")
                    .html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
                if (SettingsService.isMarketModeON()) { data.friendsTrades = state.tradesData.friendsTrades; }
                else                                  { data.marketTrades  = state.tradesData.marketTrades; }
                data.isMarketTradeMode = state.tradesData.isMarketTradeMode;
                // Replacing whole object → setState needed here
                state.tradesData = data;
                SettingsService.setState(state);
                SettingsService.saveSettings();
                UIRenderer.renderBody();
            });

            $.extend(state.tradesData, settings.read(null, SCRIPT_CONST.PREFIX + '_SETTINGS'));
            SettingsService.setState(state);

            UIRenderer.renderHeader();
            UIRenderer.renderBody();
            UIRenderer.renderFooter();

            ActionsService.init();
            $('#' + UIMap.ids.modal + ':not(:visible)').modal({ backdrop: 'static' });
        } catch (e) {
            debug(e);
        }
    }

    function init() {
        try {
            TradeService.refreshTrades();
            window.OpenShortCutTraderModal = OpenShortCutTraderModal;
            addToolsMenuItem(SCRIPT_CONST.NAME, window.OpenShortCutTraderModal);
        } catch (e) {
            debug(e);
        }
    }

    return {
        init:      init,
        openModal: OpenShortCutTraderModal,
        getUserTrades:        function () { return UserTradesReader.getUserTrades(); },
        getCountActiveTrades: function () { return UserTradesReader.getCountActiveTrades(); },
        isTradesReady:        function () { return UserTradesReader.isReady(); }
    };
})();

ShortcutTrader.init();