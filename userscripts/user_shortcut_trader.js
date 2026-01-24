//////////////////////////////////////////////////////////////////////////////////////
// Created by MadFX //////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

var ShortcutTrader = (function () {
    const SCRIPT_CONST = {
        PREFIX: 'FT',
        NAME: loca.GetText("QUL", "MiadTropicalSunQ2") + ', ' + loca.GetText("ACL", "SellGoods_1"),
        TRADE_TYPES: {MARKET: 'market', FRIEND: 'friend'},
        TRADE_QUEUE_DELAY: 4000,
        BUTTON_COOLDOWN: 3000,
        MESSAGE_TYPES: {
            SEND_TRADE: 1049, REFRESH_TRADES: 1062, REQUEST_TRADE_DATA: 1061
        }
    };
    var buildTemplates;

    function openModal() {
        try {
            if (!game.gi.isOnHomzone()) {
                game.showAlert(getText('not_home'));
                return;
            }

            var state = SettingsService.getState();
            if (state.tradesData.zone_id !== game.gi.mCurrentViewedZoneID) {
                SettingsService.resetState();
            }
            $("div[role='dialog']:not(#" + UIMap.ids.modal + "):visible").modal("hide");
            if (!state.modalInitialized) $('#' + UIMap.ids.modal).remove();
            createModalWindow(UIMap.ids.modal, SCRIPT_CONST.NAME);

            buildTemplates = new SaveLoadTemplate('ml', function (data, name) {
                $("#" + UIMap.ids.modal + " .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
                if (SettingsService.isMarketModeON()) {
                    data.friendsTrades = state.tradesData.friendsTrades;
                } else {
                    data.marketTrades = state.tradesData.marketTrades;
                }
                data.isMarketTradeMode = state.tradesData.isMarketTradeMode
                state.tradesData       = data;
                SettingsService.setState(state);
                SettingsService.saveSettings();
                UIRenderer.renderBody();
            });
            $.extend(state.tradesData, settings.read(null, SCRIPT_CONST.PREFIX + '_SETTINGS'));
            SettingsService.setState(state);

            UIRenderer.renderHeader();
            UIRenderer.renderBody();
            UIRenderer.renderFooter();

            if (state.isTradeAlreadySent === false) {
                state.isTradeAlreadySent = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(0) !== 0;
            }

            ActionsService.init();
            $('#' + UIMap.ids.modal + ':not(:visible)').modal({backdrop: "static"});
        } catch (e) {
            debug(e);
        }
    }

    function init() {
        try {
            game.gi.mClientMessages.SendMessagetoServer(SCRIPT_CONST.MESSAGE_TYPES.REQUEST_TRADE_DATA, game.gi.mCurrentViewedZoneID, null)
            $.extend(SettingsService.getState().tradesData, settings.read(null, SCRIPT_CONST.PREFIX + '_SETTINGS'));
            addToolsMenuItem(SCRIPT_CONST.NAME, openModal);
        } catch (e) {
            debug(e);
        }
    }

    var SettingsService = (function () {
        var STATE = initStateData();

        function initStateData() {
            return {
                tradesData: {
                    isMarketTradeMode: true, zone_id: game.gi.mCurrentViewedZoneID, friendsTrades: [], marketTrades: [],
                }, isTradeAlreadySent: false, modalInitialized: false
            };
        }

        function resetState() {
            STATE = initStateData();
            return STATE;
        }

        function saveSettings() {
            settings.settings[SCRIPT_CONST.PREFIX + '_SETTINGS'] = {};
            settings.store(STATE.tradesData, SCRIPT_CONST.PREFIX + '_SETTINGS');
        }

        function getCurrentTrades() {
            return STATE.tradesData.isMarketTradeMode ? STATE.tradesData.marketTrades : STATE.tradesData.friendsTrades;
        }

        function removeTrade(index) {
            if (STATE.tradesData.isMarketTradeMode) {
                STATE.tradesData.marketTrades.splice(index, 1);
            } else {
                STATE.tradesData.friendsTrades.splice(index, 1);
            }
        }

        function getState() {
            return STATE;
        }

        function setState(state) {
            STATE = state;
        }

        function getTradeModeType() {
            return STATE.tradesData.isMarketTradeMode ? SCRIPT_CONST.TRADE_TYPES.MARKET : SCRIPT_CONST.TRADE_TYPES.FRIEND
        }

        function getIsMarketMode() {
            return STATE.tradesData.isMarketTradeMode;
        }

        return {
            getState: getState,
            setState: setState,
            resetState: resetState,
            saveSettings: saveSettings,
            removeTrade: removeTrade,
            getCurrentTrades: getCurrentTrades,
            getTradeModeType: getTradeModeType,
            isMarketModeON: getIsMarketMode,
        };
    })();

    var ActionsService = (function () {
        function init() {
            var $modal = $('#' + UIMap.ids.modalData);

            $modal.off('click', '.' + UIMap.classes.deleteTrade).on('click', '.' + UIMap.classes.deleteTrade, handleDeleteTrade)
                .off('click', '.' + UIMap.classes.sendTrade).on('click', '.' + UIMap.classes.sendTrade, handleSendTrade)
                .off('change', '.' + UIMap.classes.addTradeBtn).on('click', '.' + UIMap.classes.addTradeBtn, handleAddTrade)
                .off('change', '#' + UIMap.ids.mainSwitch).on('change', '#' + UIMap.ids.mainSwitch, handleMainSwitch)
                .off('change', '[id^="' + UIMap.ids.offerSelectStr + '"]').on('change', '[id^="' + UIMap.ids.offerSelectStr + '"]', handleOfferChange)
                .off('change', '[id^="' + UIMap.ids.costSelectStr + '"]').on('change', '[id^="' + UIMap.ids.costSelectStr + '"]', handleCostChange)
                .off('input change', '[id^="' + UIMap.ids.offerInputStr + '"]').on('input change', '[id^="' + UIMap.ids.offerInputStr + '"]', handleInputSanitize)
                .off('input change', '[id^="' + UIMap.ids.costInputStr + '"]').on('input change', '[id^="' + UIMap.ids.costInputStr + '"]', handleInputSanitize);

            $('#' + UIMap.ids.modal).off('click', '.' + UIMap.classes.resetBtn).on('click', '.' + UIMap.classes.resetBtn, handleReset)
                .off('click', '.' + UIMap.classes.sendAllBtn).on('click', '.' + UIMap.classes.sendAllBtn, handleSubmitAll)
                .off('click', '.' + UIMap.classes.saveTemplateBtn).on('click', '.' + UIMap.classes.saveTemplateBtn, handleSaveTemplate)
                .off('click', '.' + UIMap.classes.loadTemplateBtn).on('click', '.' + UIMap.classes.loadTemplateBtn, handleLoadTemplate);

            $("." + UIMap.classes.tradesContainer).sortable({
                items: ".row", update: handleSortTrades
            });
        }

        function handleSendTrade() {
            if ($(this).css('pointer-events') === 'none') return;

            var index  = $(this).data('index');
            var trades = SettingsService.getCurrentTrades();

            disableSendButtons();
            TradeService.send([trades[index]]);
        }

        function handleSortTrades(event, ui) {
            var currentIndex = ui.item.find("." + UIMap.classes.deleteTrade).data("index");

            var nextElement = ui.item.nextAll(".row").find("." + UIMap.classes.deleteTrade).first();
            var nextIndex   = nextElement.length ? nextElement.data("index") : null;

            var state     = SettingsService.getState();
            var trades    = SettingsService.getCurrentTrades();
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

            if (SettingsService.isMarketModeON()) {
                state.tradesData.marketTrades = trades;
            } else {
                state.tradesData.friendsTrades = trades;
            }
            SettingsService.setState(state);
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleDeleteTrade() {
            const index = $(this).data('index');
            SettingsService.removeTrade(index);
            UIRenderer.renderBody();
            SettingsService.saveSettings();
        }

        function handleAddTrade() {
            var mode = SettingsService.getTradeModeType();

            var offerResName   = $('#' + UIMap.ids.offerSelect(mode)).val();
            var offerResAmount = parseInt($('#' + UIMap.ids.addOfferInput(mode)).val(), 10);
            var costResName    = $('#' + UIMap.ids.costSelect(mode)).val();
            var costResAmount  = parseInt($('#' + UIMap.ids.addCostInput(mode)).val(), 10);

            if (!offerResAmount || !costResAmount) {
                TradeUI.alertCannotAfford();
                return;
            }

            var userId = 0;
            var userName;

            if (mode === SCRIPT_CONST.TRADE_TYPES.FRIEND) {
                var $friendSel = $('#' + UIMap.ids.friendSelector(mode));
                userId         = parseInt($friendSel.val(), 10);
                userName       = $friendSel.find('option:selected').text();
            } else {
                userName = $('#' + UIMap.ids.marketSelector(mode)).find('option:selected').val();
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
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleMainSwitch() {
            var state = SettingsService.getState().tradesData;
            state.isMarketTradeMode = !state.isMarketTradeMode;

            var mode = state.isMarketTradeMode
                ? SCRIPT_CONST.TRADE_TYPES.MARKET
                : SCRIPT_CONST.TRADE_TYPES.FRIEND;

            $('#' + UIMap.ids.mainSwitchRadio).text(
                loca.GetText("LAB", state.isMarketTradeMode ? "Marketplace" : "Friends")
            );

            $('.' + UIMap.classes.addRowContainer).empty();
            UIRenderer.addTradeRow(mode);
            UIRenderer.renderBody();

            SettingsService.saveSettings();
        }

        function handleOfferChange() {
            $('.' + UIMap.classes.offerResourceImg).html(getImageTag(this.value, '24px'));
        }

        function handleCostChange() {
            $('.' + UIMap.classes.costResourceImg).html(getImageTag(this.value, '24px'));
        }

        function handleReset() {
            SettingsService.resetState();
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleSubmitAll() {
            var $modal = $('#' + UIMap.ids.modal);
            var trades = SettingsService.getCurrentTrades();

            if (!trades.length) {
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
            $('.' + UIMap.classes.sendTrade).css({opacity: 0.5, 'pointer-events': 'none'});
            setTimeout(function () {
                $('.' + UIMap.classes.sendTrade).css({opacity: 1, 'pointer-events': ''});
            }, SCRIPT_CONST.BUTTON_COOLDOWN);
        }

        function sanitizeInput(element) {
            var value     = element.value.replace(/\D/g, '');
            element.value = value || 1;
        }

        return {
            init: init
        };
    })();

    var UIMap = {
        ids: {
            modal: SCRIPT_CONST.PREFIX + '_FriendTraderModal',
            modalData: SCRIPT_CONST.PREFIX + '_FriendTraderModalData',
            mainSwitch: SCRIPT_CONST.PREFIX + '_SWITCH',
            mainSwitchRadio: SCRIPT_CONST.PREFIX + '_RadioText',

            offerInputStr: SCRIPT_CONST.PREFIX + '_AddOffer_',
            costInputStr: SCRIPT_CONST.PREFIX + '_AddCost_',
            offerSelectStr: SCRIPT_CONST.PREFIX + '_OfferList_',
            costSelectStr: SCRIPT_CONST.PREFIX + '_CostList_',

            addOfferInput: function (mode) {
                return this.offerInputStr + mode;
            },
            addCostInput: function (mode) {
                return this.costInputStr + mode;
            },
            offerSelect: function (mode) {
                return this.offerSelectStr + mode;
            },
            costSelect: function (mode) {
                return this.costSelectStr + mode;
            },
            friendSelector: function (mode) {
                return SCRIPT_CONST.PREFIX + '_friend_selector_' + mode;
            },
            marketSelector: function (mode) {
                return SCRIPT_CONST.PREFIX + '_market_scroll_' + mode;
            }
        },

        classes: {
            addRowContainer: SCRIPT_CONST.PREFIX + '_AddRowContainer',
            tradesContainer: SCRIPT_CONST.PREFIX + '_Trades',

            offerResourceImg: 'offer-res-img',
            costResourceImg: 'cost-res-img',
            deleteTrade: SCRIPT_CONST.PREFIX + '_delTrade',
            sendTrade: SCRIPT_CONST.PREFIX + '_SendTrade',
            addTradeBtn: SCRIPT_CONST.PREFIX + '_AddTradeBtn',

            resetBtn: SCRIPT_CONST.PREFIX + '_reset-btn',
            sendAllBtn: SCRIPT_CONST.PREFIX + '_send-all-btn',
            saveTemplateBtn: SCRIPT_CONST.PREFIX + '_save-temp-btn',
            loadTemplateBtn: SCRIPT_CONST.PREFIX + '_load-temp-btn'
        }
    };

    var UIRenderer = (function () {

        function renderHeader() {
            var switchRadio   = '<div>' + createSwitch(UIMap.ids.mainSwitch, SettingsService.isMarketModeON()) + '<div style="display:inline-block;vertical-align:top;margin-left: 10px;margin-bottom: 15px;" id="' + UIMap.ids.mainSwitchRadio + '">' + loca.GetText("LAB", SettingsService.isMarketModeON() ? "Marketplace" : "Friends") + '</div></div>';
            var tableHeadHtml = createTableRow([[2, loca.GetText("LAB", "WareToDeliver")], [2, loca.GetText("LAB", "WareToRecieve")], [4, loca.GetText("LAB", "SelectTradeResources")], [2, loca.GetText("LAB", "BoughtFromSoldTo")], [2, loca.GetText('LAB', 'Tasks')]], true);

            var $modal = $('#' + UIMap.ids.modalData);
            $modal.append('<div class="container-fluid">' + switchRadio + tableHeadHtml + '</div>');
            $modal.find('.container-fluid').append('<div class="' + UIMap.classes.addRowContainer + '"></div>');
            UIRenderer.addTradeRow(SettingsService.getTradeModeType());
            $modal.find('.container-fluid').append('<div class="' + UIMap.classes.tradesContainer + '"></div>');
        }

        function renderBody() {
            function shouldRenderTrade(trade, isMarket) {
                if (!isMarket) {
                    return trade.userId !== 0;
                }
                return trade.userId === 0;
            }

            var state    = SettingsService.getState();
            var isMarket = SettingsService.isMarketModeON();
            var trades   = isMarket ? state.tradesData.marketTrades : state.tradesData.friendsTrades;

            var $container = $('#' + UIMap.ids.modal)
                .find('.container-fluid')
                .find('.' + UIMap.classes.tradesContainer)
                .empty();

            trades.forEach(function (trade, index) {
                if (!shouldRenderTrade(trade, isMarket)) {
                    return;
                }
                $container.append(UIRenderer.renderTradeRow(trade, index));
            });
        }


        function renderFooter() {
            var $modal  = $('#' + UIMap.ids.modal);
            var $footer = $modal.find('.modal-footer');

            var buttons = [createButton(UIMap.classes.resetBtn + ' btn-warning', getText('btn_reset')), createButton(UIMap.classes.sendAllBtn + ' btn-success', getText('btn_submit') + ' ' + loca.GetText("LAB", "All")), createButton(UIMap.classes.saveTemplateBtn + ' btn-primary pull-left', getText('save_template')), createButton(UIMap.classes.loadTemplateBtn + ' btn-primary pull-left', getText('load_template'))];

            $footer.prepend(buttons);
        }

        function addTradeRow(mode) {
            var resources   = GameDataSource.getResourceList();
            var firstRes    = resources[0].items[0], secondRes = resources[0].items[1];
            var inputOffer  = createNumberInput(UIMap.ids.addOfferInput(mode));
            var inputCost   = createNumberInput(UIMap.ids.addCostInput(mode));
            var selectOffer = createResourceSelect(UIMap.ids.offerSelect(mode), resources);
            var selectCost  = createResourceSelect(UIMap.ids.costSelect(mode), resources);

            var targetSelect;
            if (mode === SCRIPT_CONST.TRADE_TYPES.FRIEND) {
                targetSelect = $('<select>', {id: UIMap.ids.friendSelector(mode), 'class': 'form-control'});
                GameDataSource.getFriendsList().forEach(function (friend) {
                    targetSelect.append($('<option>', {value: friend.id}).text(friend.name));
                });
            } else {
                targetSelect = $('<select>', {id: UIMap.ids.marketSelector(mode), 'class': 'form-control'});
                targetSelect.append('<optgroup label="Ресурсы">');
                [1, 2, 3, 4].forEach(function (res) {
                    targetSelect.append($('<option>', {value: res}).text(formatToFractionOrReturn(res)));
                });
                targetSelect.append('</optgroup>');
            }

            var row = createTableRow([[2, $('<div>').append($('<div>').addClass(UIMap.classes.offerResourceImg).css({
                display: 'inline-block', verticalAlign: 'middle'
            }).html(getImageTag(firstRes.name, '24px')), $('<div>').css({
                display: 'inline-block', verticalAlign: 'middle'
            }).append(inputOffer))],

                [2, $('<div>').append($('<div>').addClass(UIMap.classes.costResourceImg).css({
                    display: 'inline-block', verticalAlign: 'middle'
                }).html(getImageTag(secondRes.name, '24px')), $('<div>').css({
                    display: 'inline-block', verticalAlign: 'middle'
                }).append(inputCost))],

                [2, selectOffer],

                [2, selectCost],

                [2, targetSelect],

                [2, $('<div>', {
                    'class': UIMap.classes.addTradeBtn,
                    // 'data-mode': mode,
                    style: 'display:inline-block;cursor:pointer;background:wheat;border-radius:3px;'
                }).html(getImageTag('AvatarAdd', '24px'))]], true);

            $('#' + UIMap.ids.modalData + ' .container-fluid .' + UIMap.classes.addRowContainer).append(row);

            $('#' + UIMap.ids.costSelect(mode)).find('option').eq(1).prop('selected', true);
        }

        function renderTradeRow(item, index) {
            var delBtn = $('<div>', {
                'class': UIMap.classes.deleteTrade, 'data-index': index, css: {
                    cursor: 'pointer', display: 'inline-block', marginRight: '5px'
                }, // html: getImageTag('ButtonIconAbort', '24px')
                html: getImageTag('Close', '24px')
            });

            var sendBtn = $('<div>', {
                'class': UIMap.classes.sendTrade,
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

        function getName(originalName) {
            locs     = ['RES', 'BUI', 'SHI', 'ADN'];
            var name = '[undefined text]';
            for (loc in locs) {
                loc  = locs[loc];
                name = loca.GetText(loc, originalName);
                if (name !== '[undefined text]' && name !== '[undefined text] ') {
                    return name;
                }
            }
            return name;
        }

        function createResourceSelect(id, resources) {
            var $select = $('<select>', {id: id, 'class': 'form-control'});
            resources.forEach(function (cat) {
                //sort by local name (slowdown script)
                // var items = cat.items.slice();
                // items.sort(function (a, b) {
                //     return getName(a.name).localeCompare(getName(b.name));
                // });

                $select.append('<optgroup label="' + loca.GetText("LAB", cat.categoryName) + '">');
                cat.items.forEach(function (res) {
                    $select.append($('<option>', {
                        value: res.name
                    }).text(getName(res.name)));
                });
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
        var _friendsList  = null;
        var _resourceList = null;

        function getFriendsList() {
            if (!_friendsList) {
                _friendsList = globalFlash.gui.mFriendsList.GetFilteredFriends("", true).map(function (f) {
                    return {id: f.id, name: f.username};
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
                            var clMatch  = category.match(/^CL(\d+)$/);
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
                            resourcesByCategory[category].push({name: product.resourceName_string});
                        }
                    });

                    // Buffs
                    categoryNames.push('buffs');
                    resourcesByCategory['buffs'] = [];
                    var items                    = swmmo.getDefinitionByName("global").map_BuffName_BuffDefinition;
                    for (var item in items) {
                        var definition = items[item];
                        var name       = definition.GetName_string();
                        if (definition.IsTradable(name)) {
                            resourcesByCategory['buffs'].push({name: name});
                        }
                    }

                    // Adventures
                    categoryNames.push('adventures');
                    resourcesByCategory['adventures'] = [];
                    items                             = swmmo.getDefinitionByName("AdventureSystem::cAdventureDefinition").map_AdventureName_AdventureDefinition.valueSet();
                    for (var item in items) {
                        var definition = items[item];
                        var name       = definition.GetName();
                        if (definition.IsTradable()) {
                            resourcesByCategory['adventures'].push({name: name});
                        }
                    }

                    // Buildings
                    categoryNames.push('buildings');
                    resourcesByCategory['buildings'] = [];
                    items                            = swmmo.getDefinitionByName("global").buildingGroup.mGOList_vector;
                    for (var item in items) {
                        var definition = items[item];
                        var name       = definition.mGfxResourceListName_string;
                        if (definition.isTradable()) {
                            resourcesByCategory['buildings'].push({name: name});
                        }
                    }

                    categoryNames.sort();
                    _resourceList = categoryNames.map(function (catName) {
                        return {categoryName: catName, items: resourcesByCategory[catName]};
                    });
                } catch (e) {
                    debug(e);
                    _resourceList = [];
                }
            }
            return _resourceList;
        }

        function invalidate() {
            _friendsList  = null;
            _resourceList = null;
        }

        return {
            getFriendsList: getFriendsList, getResourceList: getResourceList, invalidate: invalidate
        };
    })();

    var TradeService = (function () {
        function send(trades) {
            if (!TradeValidator.isValidTradeArray(trades)) {
                TradeUI.alertCannotAfford();
                return;
            }

            var queue           = new TimedQueue(SCRIPT_CONST.TRADE_QUEUE_DELAY);
            var successCount    = 0;
            var totalTrades     = trades.length;
            var playerResources = game.gi.mCurrentPlayerZone.GetResources(game.gi.mHomePlayer);

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
            if (!SettingsService.getState().tradesData.isMarketTradeMode) {
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
            isValidTradeArray: isValidTradeArray, isTradeAllowed: isTradeAllowed
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

            var freeSlots = SettingsService.getState().isTradeAlreadySent ? 1 : game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(0);

            offer.lots     = trade.UserName;
            offer.slotType = freeSlots === 0 ? 0 : 2;
            offer.slotPos  = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(2);
        }

        function applyOffer(offer, trade, playerResources) {
            var def = TradeResources.getResourceDef(trade.offerResName);

            if (def) {
                return TradeResources.applyOfferResource(offer, trade, playerResources);
            } else {
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
            create: create, applyRecipient: applyRecipient
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
                if ((item.GetBuffDefinition().GetName_string() === name || item.GetResourceName_string() === name) && item.GetBuffDefinition().IsTradable(item.GetResourceName_string())) {
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

            var res         = new (game.def("Communication.VO::dResourceVO"));
            res.amount      = res.producedAmount = trade.offerResAmount;
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

            buff.amount     = trade.offerResAmount;
            offer.offerBuff = buff;
            return true;
        }

        function applyCostResource(offer, trade) {
            var res         = new (game.def("Communication.VO::dResourceVO"));
            res.amount      = res.producedAmount = trade.costResAmount;
            res.name_string = trade.costResName;

            offer.costsRes = res;
        }

        function applyCostBuff(offer, trade) {
            var buff                 = new (game.def("Communication.VO::dBuffVO"));
            buff.sourceZoneId        = game.gi.mCurrentViewedZoneID;
            buff.amount              = trade.costResAmount;
            buff.resourceName_string = trade.costResName;
            buff.buffName_string     = getResourceTypeByName(trade.costResName);

            offer.costsBuff = buff;
        }

        function getResourceTypeByName(name) {
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
                game.gi.mClientMessages.SendMessagetoServer(SCRIPT_CONST.MESSAGE_TYPES.SEND_TRADE, game.gi.mCurrentViewedZoneID, offer);
                cb();
                globalFlash.gui.mAvatarMessageList.AddMessage('TradeInitiated');
            });
        }, finishBatch: function () {
            game.gi.mClientMessages.SendMessagetoServer(SCRIPT_CONST.MESSAGE_TYPES.REFRESH_TRADES, game.gi.mCurrentViewedZoneID, null);
        }
    };

    var TradeUI = {
        alertCannotAfford: function () {
            game.showAlert(loca.GetText('LAB', 'CannotAffordSendTrade'));
        }, alertAddFriend: function () {
            game.showAlert(loca.GetText('QUL', 'SocialMedium8') + ' ' + loca.GetText('LAB', 'AddFriend'));
        }, showSuccess: function (trade, success, total) {
            var msg = loca.GetText('LAB', 'TradeOffer') + ' ';
            msg += trade.userId === 0 ? loca.GetText('MES', 'TradeInitiated') : loca.GetText('LAB', 'User') + ': ' + trade.UserName;
            msg += ' (' + success + '/' + total + ')';

            game.showAlert(msg);
        }
    };

    return {
        init: init,
        TradeService: TradeService,
        TradeValidator: TradeValidator,
        TradeOfferFactory: TradeOfferFactory,
        TradeResources: TradeResources,
        TradeQueue: TradeQueue,
        TradeUI: TradeUI,
    };
})();

ShortcutTrader.init();