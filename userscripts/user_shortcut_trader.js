//////////////////////////////////////////////////////////////////////////////////////
// Created by MadFX //////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

var ShortcutTrader = (function () {
    const NAME              = loca.GetText("QUL", "MiadTropicalSunQ2") + ', ' + loca.GetText("ACL", "SellGoods_1");

    var CONSTANTS = {
        TRADE_QUEUE_DELAY: 4000,
        BUTTON_COOLDOWN: 3000,
        MESSAGE_TYPES: {
            SEND_TRADE: 1049,
            REFRESH_TRADES: 1062,
            REQUEST_TRADE_DATA: 1061
        }
    };

    const MESSAGE_TYPES = {
        SEND_TRADE: 1049,
        REFRESH_TRADES: 1062,
        REQUEST_TRADE_DATA: 1061
    };
    var buildTemplates;

    function openModal() {
        if (!game.gi.isOnHomzone()) {
            game.showAlert(getText('not_home'));
            return;
        }

        if (SettingsService.getState().tradesData.zone_id !== game.gi.mCurrentViewedZoneID) {
            SettingsService.resetState();
        }
        $("div[role='dialog']:not(#FriendTraderModal):visible").modal("hide");
        if (!SettingsService.getState().modalInitialized) $('#FriendTraderModal').remove();
        createModalWindow('FriendTraderModal', NAME);

        buildTemplates = new SaveLoadTemplate('ml', function (data, name) {
            $("#FriendTraderModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
            if (SettingsService.getState().tradesData.isMarketTradeMode) {
                data.friendsTrades = SettingsService.getState().tradesData.friendsTrades;
            } else {
                data.marketTrades = SettingsService.getState().tradesData.marketTrades;
            }
            SettingsService.getState().tradesData = data;
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        });

        $.extend(SettingsService.getState().tradesData, settings.read(null, 'FT_SETTINGS'));
        UIRenderer.renderHeader();
        UIRenderer.renderBody();
        UIRenderer.renderFooter();

        if (SettingsService.getState().isTradeAlreadySent === false){
            SettingsService.getState().isTradeAlreadySent = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(0) !== 0;
        }

        ActionsService.init();
        $('#FriendTraderModal:not(:visible)').modal({backdrop: "static"});
    }

    function init() {
        try {
            game.gi.mClientMessages.SendMessagetoServer(MESSAGE_TYPES.REQUEST_TRADE_DATA, game.gi.mCurrentViewedZoneID, null)
            $.extend(SettingsService.getState().tradesData, settings.read(null, 'FT_SETTINGS'));
            addToolsMenuItem(NAME, openModal);
        } catch (e) {
            debug(e);
        }
    }

    var SettingsService = (function () {
        var STATE = initStateData();

        function initStateData() {
            return {
                tradesData: {
                    isMarketTradeMode: true,
                    zone_id: game.gi.mCurrentViewedZoneID,
                    friendsTrades: [],
                    marketTrades: [],
                },
                isTradeAlreadySent: false,
                modalInitialized: false
            };
        }

        function resetState(){
            STATE = initStateData();
            return STATE;
        }

        function saveSettings() {
            settings.settings['FT_SETTINGS'] = {};
            settings.store(STATE.tradesData, 'FT_SETTINGS');
        }

        function getCurrentTrades() {
            var trades = STATE.tradesData.isMarketTradeMode
                ? STATE.tradesData.marketTrades
                : STATE.tradesData.friendsTrades;

            return trades;
        }

        function removeTrade(index){
            if (STATE.tradesData.isMarketTradeMode) {
                STATE.tradesData.marketTrades.splice(index, 1);
            } else {
                STATE.tradesData.friendsTrades.splice(index, 1);
            }
        }

        function getState() { return STATE; }

        return {
            getState: getState,
            resetState: resetState,
            saveSettings: saveSettings,
            getCurrentTrades: getCurrentTrades,
            removeTrade: removeTrade
        };
    })();

    var ActionsService = (function (){
        function init(){
            var $modal = $('#FriendTraderModalData');

            $modal.off('click', '.FT_delTrade').on('click', '.FT_delTrade', handleDeleteTrade)
                .off('click', '.FT_SendTrade').on('click', '.FT_SendTrade', handleSendTrade)
                .off('change', '.FT_AddTradeBtn').on('click', '.FT_AddTradeBtn', handleAddTrade)
                .off('change', '#FT_SWITCH').on('change', '#FT_SWITCH', handleMainSwitch)
                .off('change', '[id^="FT_OfferList_"]').on('change', '[id^="FT_OfferList_"]', handleOfferChange)
                .off('change', '[id^="FT_CostList_"]').on('change', '[id^="FT_CostList_"]', handleCostChange)
                .off('input change', '[id^="FT_AddOffer_"]').on('input change', '[id^="FT_AddOffer_"]', handleInputSanitize)
                .off('input change', '[id^="FT_AddCost_"]').on('input change', '[id^="FT_AddCost_"]', handleInputSanitize);

            $('#FriendTraderModal').off('click', '.FT_reset-btn').on('click', '.FT_reset-btn', handleReset)
                .off('click', '.FT_send-all-btn').on('click', '.FT_send-all-btn', handleSubmitAll)
                .off('click', '.FT_save-temp-btn').on('click', '.FT_save-temp-btn', handleSaveTemplate)
                .off('click', '.FT_load-temp-btn').on('click', '.FT_load-temp-btn', handleLoadTemplate);

            $(".FT_trades").sortable({
                items: ".row",
                update: handleSortTrades
            });
        }

        function handleSendTrade() {
            if ($(this).css('pointer-events') === 'none') return;

            var index = $(this).data('index');
            var trades = SettingsService.getCurrentTrades();

            disableSendButtons();
            TradeService.send([trades[index]]);
        }

        function handleSortTrades(event, ui) {
            var currentIndex = ui.item.find(".FT_delTrade").data("index");

            var nextElement = ui.item.nextAll(".row").find(".FT_delTrade").first();
            var nextIndex   = nextElement.length ? nextElement.data("index") : null;

            var trades = SettingsService.getCurrentTrades().slice(0);
            var movedItem = trades[currentIndex];
            if (movedItem === undefined) {
                return;
            }

            trades.splice(currentIndex, 1);

            if (nextIndex !== null && trades[nextIndex] !== undefined) {
                var newPosition = trades.indexOf(trades[nextIndex]);
                trades.splice(newPosition, 0, movedItem);
            } else {
                trades.push(movedItem);
            }

            if (!SettingsService.getState().tradesData.isMarketTradeMode) {
                SettingsService.getState().tradesData.friendsTrades = trades;
            } else {
                SettingsService.getState().tradesData.marketTrades = trades;
            }
            UIRenderer.renderBody();
        }

        function handleDeleteTrade(){
            const index = $(this).data('index');
            SettingsService.removeTrade(index);
            UIRenderer.renderBody();
            SettingsService.saveSettings();
        }

        function handleAddTrade() {
            //todo Change mode
            var mode = $(this).data('mode');

            var offerResName   = $('#FT_OfferList_' + mode).val();
            var offerResAmount = parseInt($('#FT_AddOffer_' + mode).val(), 10);
            var costResName    = $('#FT_CostList_' + mode).val();
            var costResAmount  = parseInt($('#FT_AddCost_' + mode).val(), 10);

            if (!offerResAmount || !costResAmount) {
                game.showAlert(getText('invalid_amount'));
                return;
            }

            var userId   = 0;
            var userName = 'Market';

            if (mode === 'friend') {
                var $friendSel = $('#FT_friend_selector_' + mode);
                userId   = parseInt($friendSel.val(), 10);
                userName = $friendSel.find('option:selected').text();
            } else {
                userName = $('#market_scroll_' + mode).find('option:selected').val();
            }

            var newTrade = {
                offerResName: offerResName,
                offerResAmount: offerResAmount,
                costResName: costResName,
                costResAmount: costResAmount,
                userId: userId,
                UserName: userName
            };

            SettingsService.getCurrentTrades().push(newTrade);
            UIRenderer.renderBody();
        }

        function handleMainSwitch() {
            var mode = $(this).is(':checked') ? 'market' : 'friend';
            if (mode === 'friend') {
                $('#FT_RadioText').text(loca.GetText("LAB", "Friends"));
                SettingsService.getState().tradesData.isMarketTradeMode = false;
            } else {
                $('#FT_RadioText').text(loca.GetText("LAB", "Marketplace"));
                SettingsService.getState().tradesData.isMarketTradeMode = true;
            }
            $('.FT_AddRowContainer').empty();
            UIRenderer.addTradeRow(mode);
            UIRenderer.renderBody();
            SettingsService.saveSettings();
        }

        function handleOfferChange() {
            $('.offer-res-img').html(getImageTag(this.value, '24px'));
        }

        function handleCostChange() {
            $('.cost-res-img').html(getImageTag(this.value, '24px'));
        }

        function handleReset() {
            SettingsService.resetState();
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleSubmitAll() {
            var $modal = $('#FriendTraderModal');
            var trades = SettingsService.getCurrentTrades();

            if (!trades.length) {
                game.showAlert(getText('no_trades'));
                return;
            }

            $modal.modal('hide');
            TradeService.send(trades);
        }

        function handleSaveTemplate() {
            var state = SettingsService.getState();
            buildTemplates.save(state.tradesData);
        }

        function handleLoadTemplate() {
            buildTemplates.load();
        }

        function handleInputSanitize() {
            sanitizeInput(this);
        }

        function disableSendButtons() {
            $('.FT_SendTrade').css({ opacity: 0.5, 'pointer-events': 'none' });
            setTimeout(function() {
                $('.FT_SendTrade').css({ opacity: 1, 'pointer-events': '' });
            }, 3000);
        }

        function sanitizeInput(element) {
            var value = element.value.replace(/\D/g, '');
            element.value = value || 1;
        }

        return {
            init: init
        };
    })();

    var UIRenderer = (function () {
        function renderHeader() {
            var switchRadio   = '<div>' + createSwitch('FT_SWITCH', SettingsService.getState().tradesData.isMarketTradeMode) + '<div style="display:inline-block;vertical-align:top;margin-left: 10px;margin-bottom: 15px;" id="FT_RadioText">' + loca.GetText("LAB", "Marketplace") + '</div></div>';
            var tableHeadHtml = createTableRow([[2, loca.GetText("LAB", "WareToDeliver")], [2, loca.GetText("LAB", "WareToRecieve")], [4, loca.GetText("LAB", "SelectTradeResources")], [2, loca.GetText("LAB", "BoughtFromSoldTo")], [2, loca.GetText('LAB', 'Tasks')]], true);

            $('#FriendTraderModalData').append('<div class="container-fluid">' + switchRadio + tableHeadHtml + '</div>');
            $('#FriendTraderModalData .container-fluid').append('<div class="FT_AddRowContainer"></div>');

            UIRenderer.addTradeRow(SettingsService.getState().tradesData.isMarketTradeMode ? 'market' : 'friend');
            $('#FriendTraderModalData .container-fluid').append('<div class="FT_trades"></div>');
        }

        function renderBody() {
            var $container = $('#FriendTraderModalData .container-fluid .FT_trades').empty();
            if (!SettingsService.getState().tradesData.isMarketTradeMode) {
                SettingsService.getState().tradesData.friendsTrades.forEach(function (trade, index) {
                    if (trade.userId == 0) {
                        return;
                    }
                    $container.append(UIRenderer.renderTradeRow(trade, index));
                });
            } else {
                SettingsService.getState().tradesData.marketTrades.forEach(function (trade, index) {
                    if ((!SettingsService.getState().tradesData.isMarketTradeMode && trade.userId == 0) || (SettingsService.getState().tradesData.isMarketTradeMode && trade.userId !== 0)) {
                        return;
                    }
                    $container.append(UIRenderer.renderTradeRow(trade, index));
                });
            }
        }

        function renderFooter() {
            var $modal  = $('#FriendTraderModal');
            var $footer = $modal.find('.modal-footer');

            var buttons = [
                createButton('FT_reset-btn btn-warning', getText('btn_reset')),
                createButton('FT_send-all-btn btn-success', getText('btn_submit') + ' ' + loca.GetText("LAB", "All")),
                createButton('FT_save-temp-btn btn-primary pull-left', getText('save_template')),
                createButton('FT_load-temp-btn btn-primary pull-left', getText('load_template'))
            ];

            $footer.prepend(buttons);
        }

        function addTradeRow(mode) {
            var resources   = GameDataSource.getResourceList();
            var firstRes    = resources[0].items[0], secondRes = resources[0].items[1];
            var inputOffer  = createNumberInput('FT_AddOffer_' + mode);
            var inputCost   = createNumberInput('FT_AddCost_' + mode);
            var selectOffer = createResourceSelect('FT_OfferList_' + mode, resources);
            var selectCost  = createResourceSelect('FT_CostList_' + mode, resources);

            var targetSelect;
            if (mode === 'friend') {
                targetSelect = $('<select>', {id: 'FT_friend_selector_' + mode, 'class': 'form-control'});
                GameDataSource.getFriendsList().forEach(function (friend) {
                    targetSelect.append($('<option>', {value: friend.id}).text(friend.name));
                });
            } else {
                targetSelect = $('<select>', {id: 'market_scroll_' + mode, 'class': 'form-control'});
                targetSelect.append('<optgroup label="Ресурсы">');
                [1, 2, 3, 4].forEach(function (res) {
                    targetSelect.append($('<option>', {value: res}).text(formatToFractionOrReturn(res)));
                });
                targetSelect.append('</optgroup>');
            }

            var row = createTableRow([
                [2, $('<div>').append($('<div>').addClass('offer-res-img').css({
                    display: 'inline-block', verticalAlign: 'middle'
                }).html(getImageTag(firstRes.name, '24px')), $('<div>').css({
                    display: 'inline-block',
                    verticalAlign: 'middle'
                }).append(inputOffer))],

                [2, $('<div>').append($('<div>').addClass('cost-res-img').css({
                    display: 'inline-block', verticalAlign: 'middle'
                }).html(getImageTag(secondRes.name, '24px')), $('<div>').css({
                    display: 'inline-block',
                    verticalAlign: 'middle'
                }).append(inputCost))],

                [2, selectOffer],

                [2, selectCost],

                [2, targetSelect],

                [2, $('<div>', {
                    'class': 'FT_AddTradeBtn',
                    'data-mode': mode,
                    style: 'display:inline-block;cursor:pointer;background:wheat;border-radius:3px;'
                }).html(getImageTag('AvatarAdd', '24px'))]], true);

            $('#FriendTraderModalData .container-fluid .FT_AddRowContainer').append(row);

            $('#FT_CostList_' + mode).find('option').eq(1).prop('selected', true);
        }

        function renderTradeRow(item, index) {
            var delBtn = $('<div>', {
                'class': 'FT_delTrade',
                'data-index': index,
                css: {
                    cursor: 'pointer',
                    display: 'inline-block',
                    marginRight: '5px'
                }, // html: getImageTag('ButtonIconAbort', '24px')
                html: getImageTag('Close', '24px')
            });

            var sendBtn = $('<div>', {
                'class': 'FT_SendTrade',
                'data-index': index,
                css: {cursor: 'pointer', display: 'inline-block'},
                html: getImageTag('Trade', '24px')
            })

            return createTableRow([[2, getImageTag(item.offerResName, '24px') + ' ' + item.offerResAmount], [2, getImageTag(item.costResName, '24px') + ' ' + item.costResAmount], [6, formatToFractionOrReturn(item.UserName)], [2, $('<div>').append(delBtn, sendBtn)]], false);
        }

        function createNumberInput(id, value) {
            return $('<input>', {
                type: 'number',
                id: id,
                name: id,
                value: value || 1,
                'class': 'form-control',
                style: 'display:inline;width:100px;'
            });
        }

        function formatToFractionOrReturn(input) {
            var count = parseInt(input, 10);
            switch (count) {
                case 1:
                case 2:
                case 3:
                case 4:
                    return count + "/4";
                default:
                    return input;
            }
        }

        function createButton(classes, text) {
            return $('<button>')
                .addClass('btn ' + classes)
                .text(text)
        }

        function getName(originalName){
            locs = ['RES','BUI','SHI','ADN'];
            var name = '[undefined text]';
            for (loc in locs){
                loc = locs[loc];
                name = loca.GetText(loc, originalName);
                if (name !== '[undefined text]' && name !== '[undefined text] '){
                    return name;
                }
            }
            return name;
        }

        function createResourceSelect(id, resources) {
            var $select = $('<select>', {id: id, 'class': 'form-control'});
            resources.forEach(function (cat) {
                $select.append('<optgroup label="' + loca.GetText("LAB", cat.categoryName) + '">');
                cat.items.forEach(function (res) {
                    $select.append($('<option>', {
                        value: res.name, 'data-max': res.maxLimit
                    }).text(getName(res.name)));
                })
            });
            $select.append('</optgroup>');
            return $select;
        }

        return {
            renderHeader: renderHeader,
            renderBody: renderBody,
            renderFooter: renderFooter,
            addTradeRow: addTradeRow,
            renderTradeRow: renderTradeRow
        };
    })();

    var GameDataSource = (function () {
        var _friendsList = null;
        var _resourceList = null;

        function getFriendsList() {
            if (!_friendsList) {
                _friendsList = globalFlash.gui.mFriendsList.GetFilteredFriends("", true).map(function (f) {
                    return { id: f.id, name: f.username };
                });
            }
            return _friendsList;
        }

        function getResourceList() {
            if (!_resourceList) {
                var resourcesByCategory = {};
                var categoryNames       = [];
                try {
                    swmmo.getDefinitionByName("ServerState::gEconomics").mResourceDefaultDefinition_vector.forEach(function (product) {
                        if (product.tradable) {
                            var category = product.group_string || product.category_string || "WarehouseTab7";
                            var clMatch = category.match(/^CL(\d+)$/);
                            if (clMatch) {
                                category = "WarehouseTab" + clMatch[1];
                            } else if (category === "Event") {
                                category = "WarehouseTab6";
                            }
                            if (category === "WarehouseTab5") {
                                category = "WarehouseTab8";
                            }
                            if (!resourcesByCategory.hasOwnProperty(category)) {
                                resourcesByCategory[category] = [];
                                categoryNames.push(category);
                            }
                            resourcesByCategory[category].push({ name: product.resourceName_string });
                        }
                    });

                    // Buffs
                    categoryNames.push('buffs');
                    resourcesByCategory['buffs'] = [];
                    var items = swmmo.getDefinitionByName("global").map_BuffName_BuffDefinition;
                    for (var item in items) {
                        var definition = items[item];
                        var name = definition.GetName_string();
                        if (definition.IsTradable(name)) {
                            resourcesByCategory['buffs'].push({ name: name });
                        }
                    }

                    // Adventures
                    categoryNames.push('adventures');
                    resourcesByCategory['adventures'] = [];
                    items = swmmo.getDefinitionByName("AdventureSystem::cAdventureDefinition").map_AdventureName_AdventureDefinition.valueSet();
                    for (var item in items) {
                        var definition = items[item];
                        var name = definition.GetName();
                        if (definition.IsTradable()) {
                            resourcesByCategory['adventures'].push({ name: name });
                        }
                    }

                    // Buildings
                    categoryNames.push('buildings');
                    resourcesByCategory['buildings'] = [];
                    items = swmmo.getDefinitionByName("global").buildingGroup.mGOList_vector;
                    for (var item in items) {
                        var definition = items[item];
                        var name = definition.mGfxResourceListName_string;
                        if (definition.isTradable()) {
                            resourcesByCategory['buildings'].push({ name: name });
                        }
                    }

                    categoryNames.sort();
                    _resourceList = categoryNames.map(function (catName) {
                        return { categoryName: catName, items: resourcesByCategory[catName] };
                    });
                } catch (e) {
                    debug(e);
                    _resourceList = [];
                }
            }
            return _resourceList;
        }

        function invalidate() {
            _friendsList = null;
            _resourceList = null;
        }

        return {
            getFriendsList: getFriendsList,
            getResourceList: getResourceList,
            invalidate: invalidate
        };
    })();

    var TradeService = (function () {
        function send(trades) {
            if (!TradeValidator.isValidTradeArray(trades)) {
                TradeUI.alertCannotAfford();
                return;
            }

            var queue            = new TimedQueue(4000);
            var successCount     = 0;
            var totalTrades      = trades.length;
            var playerResources  = game.gi.mCurrentPlayerZone.GetResources(game.gi.mHomePlayer);

            trades.forEach(function (trade) {
                if (!TradeValidator.isTradeAllowed(trade)) {
                    totalTrades--;
                    return;
                }

                var tradeOffer = TradeOfferFactory.create(trade, playerResources);
                if (!tradeOffer) {
                    totalTrades--;
                    return;
                }

                TradeOfferFactory.applyRecipient(tradeOffer, trade);

                TradeQueue.enqueue(queue, tradeOffer, trade, function () {
                    successCount++;
                    SettingsService.getState().isTradeAlreadySent = true;
                    TradeUI.showSuccess(trade, successCount, totalTrades);
                });
            });

            if (queue.len() > 0) {
                queue.run();
                TradeQueue.finishBatch();
            }
        }

        return {
            send: send
        };
    })();

    var TradeValidator = (function () {
        function isValidTradeArray(trades) {
            return Array.isArray(trades) && trades.length > 0;
        }

        function isTradeAllowed(trade) {
            if (!SettingsService.getState().tradesData.isMarketTradeMode && trade.userId === 0) {
                return false;
            }
            if (SettingsService.getState().tradesData.isMarketTradeMode && trade.userId !== 0) {
                return false;
            }
            if (!SettingsService.getState().tradesData.isMarketTradeMode){
                var isFriend = GameDataSource.getFriendsList().some(function (f) {
                    return f.id == trade.userId;
                });

                if (!isFriend) {
                    TradeUI.alertAddFriend();
                    return false;
                }
            }
            return true;
        }

        return {
            isValidTradeArray: isValidTradeArray,
            isTradeAllowed: isTradeAllowed
        };
    })();

    var TradeOfferFactory = (function () {
        function create(trade, playerResources) {
            var offer = new (game.def("Communication.VO::dTradeOfferVO"));

            if (!applyOffer(offer, trade, playerResources)) {
                return null;
            }

            applyCost(offer, trade);
            return offer;
        }

        function applyRecipient(offer, trade) {
            offer.receipientId = trade.userId;
            offer.lots         = 0;
            offer.slotType     = 4;
            offer.slotPos      = 0;

            if (trade.userId !== 0) {
                return;
            }

            var freeSlots = SettingsService.getState().isTradeAlreadySent
                ? 1
                : game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(0);

            offer.lots     = trade.UserName;
            offer.slotType = freeSlots === 0 ? 0 : 2;
            offer.slotPos  = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(2);
        }

        function applyOffer(offer, trade, playerResources) {
            var def = TradeResources.getResourceDef(trade.offerResName);

            if (def) {
                return TradeResources.applyOfferResource(offer, trade, playerResources);
            }else{
                return TradeResources.applyOfferBuff(offer, trade);
            }
        }

        function applyCost(offer, trade) {
            var def = TradeResources.getResourceDef(trade.costResName);

            if (def) {
                TradeResources.applyCostResource(offer, trade);
            } else {
                TradeResources.applyCostBuff(offer, trade);
            }
        }

        return {
            create: create,
            applyRecipient: applyRecipient
        };

    })();

    var TradeResources = (function () {
        function getResourceDef(name) {
            return swmmo
                .getDefinitionByName("ServerState::gEconomics")
                .GetResourcesDefaultDefinition(name);
        }

        function findTradableBuff(name) {
            var result = null;

            game.gi.mHomePlayer.getBuffsSortedForStarMenu().some(function (item) {
                if (
                    (item.GetBuffDefinition().GetName_string() === name ||
                        item.GetResourceName_string() === name) &&
                    item.GetBuffDefinition().IsTradable(item.GetResourceName_string())
                ) {
                    result = item.CreateBuffVOFromBuff();
                    return true;
                }
                return false;
            });

            return result;
        }

        function applyOfferResource(offer, trade, playerResources) {
            var amount = trade.offerResAmount;

            if (SettingsService.getState().tradesData.isMarketTradeMode) {
                amount *= trade.UserName;
            }

            try {
                if (!playerResources.HasPlayerResource(trade.offerResName, amount)) {
                    TradeUI.alertCannotAfford();
                    return false;
                }
            } catch (e) {
                TradeUI.alertCannotAfford();
                return false;
            }

            var res = new (game.def("Communication.VO::dResourceVO"));
            res.amount = res.producedAmount = trade.offerResAmount;
            res.name_string = trade.offerResName;

            offer.offerRes = res;
            return true;
        }

        function applyOfferBuff(offer, trade) {
            var buff = findTradableBuff(trade.offerResName);

            if (!buff || buff.amount < trade.offerResAmount) {
                TradeUI.alertCannotAfford();
                return false;
            }

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
            buff.sourceZoneId        = game.gi.mCurrentViewedZoneID;
            buff.amount              = trade.costResAmount;
            buff.resourceName_string = trade.costResName;
            buff.buffName_string     = getResourceTypeByName(trade.costResName);

            offer.costsBuff = buff;
        }

        function getResourceTypeByName(name){
            var definition = swmmo.getDefinitionByName("global").buildingGroup.GetNrFromName(name)
            if (definition !== 195) return 'BuildBuilding'
            definition = swmmo.getDefinitionByName("AdventureSystem::cAdventureDefinition")
                .map_AdventureName_AdventureDefinition
                .getItem(name);
            if (definition) return 'Adventure';

            return name;
        }

        return {
            getResourceDef: getResourceDef,
            applyOfferResource: applyOfferResource,
            applyOfferBuff: applyOfferBuff,
            applyCostResource: applyCostResource,
            applyCostBuff: applyCostBuff
        };

    })();

    var TradeQueue = {
        enqueue: function (queue, offer, trade, cb) {
            queue.add(function () {
                game.gi.mClientMessages.SendMessagetoServer(
                    MESSAGE_TYPES.SEND_TRADE,
                    game.gi.mCurrentViewedZoneID,
                    offer
                );
                cb();
                globalFlash.gui.mAvatarMessageList.AddMessage('TradeInitiated');
            });
        },
        finishBatch: function () {
            game.gi.mClientMessages.SendMessagetoServer(
                MESSAGE_TYPES.REFRESH_TRADES,
                game.gi.mCurrentViewedZoneID,
                null
            );
        }
    };

    var TradeUI = {
        alertCannotAfford: function () {
            game.showAlert(loca.GetText('LAB', 'CannotAffordSendTrade'));
        },
        alertAddFriend: function () {
            game.showAlert(
                loca.GetText('QUL', 'SocialMedium8') + ' ' +
                loca.GetText('LAB', 'AddFriend')
            );
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

    return {
        init: init,
        TradeService:TradeService,
        TradeValidator:TradeValidator,
        TradeOfferFactory:TradeOfferFactory,
        TradeResources:TradeResources,
        TradeQueue:TradeQueue,
        TradeUI:TradeUI,
    };
})();

ShortcutTrader.init();