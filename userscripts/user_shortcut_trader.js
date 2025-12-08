//////////////////////////////////////////////////////////////////////////////////////
// Created by MadFX //////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

var ShortcutTrader = (function () {
    var NAME              = loca.GetText("QUL", "MiadTropicalSunQ2") + ', ' + loca.GetText("ACL", "SellGoods_1");
    var tradesData        = {};
    var isMarketTradeMode = true;
    let isTradeAlreadySent = false;
    var buildTemplates;
    var modalInitialized  = false;

    function openModal() {
        if (!game.gi.isOnHomzone()) {
            game.showAlert(getText('not_home'));
            return;
        }

        if (tradesData.zone_id !== game.gi.mCurrentViewedZoneID) {
            tradesData = initTradesData();
        }
        $("div[role='dialog']:not(#FriendTraderModal):visible").modal("hide");
        if (!modalInitialized) $('#FriendTraderModal').remove();
        createModalWindow('FriendTraderModal', NAME);

        buildTemplates = new SaveLoadTemplate('ml', function (data, name) {
            $("#FriendTraderModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
            if (isMarketTradeMode) {
                data.friendsTrades = tradesData.friendsTrades;
            } else {
                data.marketTrades = tradesData.marketTrades;
            }
            tradesData = data;
            saveSettings();

            renderBody();
        });

        $.extend(tradesData, settings.read(null, 'FT_SETTINGS'));
        renderHeader();
        renderBody();
        renderFooter();

        if (isTradeAlreadySent === false){
            isTradeAlreadySent = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(0) !== 0;
        }

        $('#FriendTraderModal:not(:visible)').modal({backdrop: "static"});
    }

    function init() {
        try {
            tradesData = initTradesData();
            $.extend(tradesData, settings.read(null, 'FT_SETTINGS'));
            isMarketTradeMode = tradesData.isMarketTradeMode;
            addToolsMenuItem(NAME, openModal);
        } catch (e) {
            debug(e);
        }
    }

    function initTradesData() {
        return {
            zone_id: game.gi.mCurrentViewedZoneID,
            friendsTrades: [],
            marketTrades: [],
            isMarketTradeMode: isMarketTradeMode
        };
    }

    function saveSettings() {
        settings.settings['FT_SETTINGS'] = {};
        settings.store(tradesData, 'FT_SETTINGS');
    }

    function renderHeader() {
        var switchRadio   = '<div>' + createSwitch('FT_SWITCH', isMarketTradeMode) + '<div style="display:inline-block;vertical-align:top;margin-left: 10px;margin-bottom: 15px;" id="FT_RadioText">' + loca.GetText("LAB", "Marketplace") + '</div></div>';
        var tableHeadHtml = createTableRow([[2, loca.GetText("LAB", "WareToDeliver")], [2, loca.GetText("LAB", "WareToRecieve")], [4, loca.GetText("LAB", "SelectTradeResources")], [2, loca.GetText("LAB", "BoughtFromSoldTo")], [2, loca.GetText('LAB', 'Tasks')]], true);

        $('#FriendTraderModalData').append('<div class="container-fluid">' + switchRadio + tableHeadHtml + '</div>');
        $('#FriendTraderModalData .container-fluid').append('<div class="FT_AddRowContainer"></div>');

        $('#FriendTraderModalData').off('change', '#FT_SWITCH').on('change', '#FT_SWITCH', function () {
            var mode = $(this).is(':checked') ? 'market' : 'friend';
            if (mode === 'friend') {
                $('#FT_RadioText').text(loca.GetText("LAB", "Friends"));
                isMarketTradeMode = false;
            } else {
                $('#FT_RadioText').text(loca.GetText("LAB", "Marketplace"));
                isMarketTradeMode = true;
            }
            $('.FT_AddRowContainer').empty();
            addTradeRow(mode);

            renderBody();
        });

        addTradeRow(isMarketTradeMode ? 'market' : 'friend');
        $('#FriendTraderModalData .container-fluid').append('<div class="FT_trades"></div>');
    }

    function renderBody() {
        var $container = $('#FriendTraderModalData .container-fluid .FT_trades').empty();
        if (!isMarketTradeMode) {
            tradesData.friendsTrades.forEach(function (trade, index) {
                if (trade.userId == 0) {
                    return;
                }
                $container.append(renderTradeRow(trade, index));
            });
        } else {
            tradesData.marketTrades.forEach(function (trade, index) {
                if ((!isMarketTradeMode && trade.userId == 0) || (isMarketTradeMode && trade.userId !== 0)) {
                    return;
                }
                $container.append(renderTradeRow(trade, index));
            });
        }
    }

    function renderFooter() {
        var $modal  = $('#FriendTraderModal');
        var $footer = $modal.find('.modal-footer');

        $(".FT_trades").sortable({
            items: ".row", update: function (event, ui) {
                var currentIndex = ui.item.find(".FT_delTrade").data("index");

                var nextElement = ui.item.nextAll(".row").find(".FT_delTrade").first();
                var nextIndex   = nextElement.length ? nextElement.data("index") : null;

                if (!isMarketTradeMode) {
                    var trades = tradesData.friendsTrades.slice(0);
                } else {
                    var trades = tradesData.marketTrades.slice(0);
                }
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

                if (!isMarketTradeMode) {
                    tradesData.friendsTrades = trades;
                } else {
                    tradesData.marketTrades = trades;
                }
                renderBody();
            }
        });

        $footer.prepend([$('<button>').addClass('btn btn-warning').text(getText('btn_reset')).click(function () {
            tradesData = initTradesData();
            saveSettings();
            renderBody();
        }), $('<button>').addClass('btn btn-success').text(getText('btn_submit') + ' ' + loca.GetText("LAB", "All")).click(function () {
            $modal.modal('hide');
            var trades = [];
            if (isMarketTradeMode) {
                if (!tradesData.marketTrades.length) return;
                trades = tradesData.marketTrades
            } else {
                if (!tradesData.friendsTrades.length) return;
                trades = tradesData.friendsTrades
            }
            sendTrades(trades);
        }), $('<button>').addClass('btn btn-primary pull-left').text(getText('save_template')).click(function () {
            buildTemplates.save(tradesData);
            saveSettings();
        }), $('<button>').addClass('btn btn-primary pull-left').text(getText('load_template')).click(function () {
            buildTemplates.load();
            saveSettings();
        })]);
    }

    function addTradeRow(mode) {
        var resources   = getResourceList();
        var firstRes    = resources[0].items[0], secondRes = resources[0].items[1];
        var inputOffer  = createNumberInput('FT_AddOffer_' + mode, 1, 1);
        var inputCost   = createNumberInput('FT_AddCost_' + mode, 1, 1);
        var selectOffer = createResourceSelect('FT_OfferList_' + mode, resources);
        var selectCost  = createResourceSelect('FT_CostList_' + mode, resources);

        var targetSelect;
        if (mode === 'friend') {
            targetSelect = $('<select>', {id: 'FT_friend_selector_' + mode, 'class': 'form-control'});
            getFriendsList().forEach(function (friend) {
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

        $('#FriendTraderModalData').off('change', '#FT_OfferList_' + mode).on('change', '#FT_OfferList_' + mode, function () {
            $('.offer-res-img').html(getImageTag(this.value, '24px'));
        });

        $('#FriendTraderModalData').off('change', '#FT_CostList_' + mode).on('change', '#FT_CostList_' + mode, function () {
            $('.cost-res-img').html(getImageTag(this.value, '24px'));
        });

        $('#FriendTraderModalData').off('input change', '#FT_AddOffer_' + mode).on('input change', '#FT_AddOffer_' + mode, function () {
            sanitizeInput(this);
        });

        $('#FriendTraderModalData').off('input change', '#FT_AddCost_' + mode).on('input change', '#FT_AddCost_' + mode, function () {
            sanitizeInput(this);
        });


        $('#FriendTraderModalData').off('click', '.FT_AddTradeBtn').on('click', '.FT_AddTradeBtn', function () {
            var mode = $(this).data('mode');

            var offerResName   = $('select[id="FT_OfferList_' + mode + '"]').val();
            var offerResAmount = parseInt($('input[id="FT_AddOffer_' + mode + '"]').val(), 10);
            var costResName    = $('select[id^="FT_CostList_' + mode + '"]').val();
            var costResAmount  = parseInt($('input[id^="FT_AddCost_' + mode + '"]').val(), 10);

            var userId   = 0;
            var userName = 'Market';
            if (mode === 'friend') {
                var $friendSel = $('select[id^="FT_friend_selector"]');
                userId         = $friendSel.val();
                userName       = $friendSel.find('option:selected').text();
            } else {
                var qty  = $('select[id^="market_scroll_' + mode + '"]');
                userName = qty.find('option:selected').val();
            }

            var trades = [];
            if (isMarketTradeMode) {
                trades = tradesData.marketTrades;
            } else {
                trades = tradesData.friendsTrades;
            }
            trades.push({
                offerResName: offerResName,
                offerResAmount: offerResAmount,
                costResName: costResName,
                costResAmount: costResAmount,
                userId: userId,
                UserName: userName
            });

            renderBody();
            saveSettings();
        });

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

        $('#FriendTraderModalData').off('click', '.FT_delTrade').on('click', '.FT_delTrade', function () {
            var i = $(this).data('index');
            if (isMarketTradeMode) {
                tradesData.marketTrades.splice(i, 1);
            } else {
                tradesData.friendsTrades.splice(i, 1);
            }
            renderBody();
            saveSettings();
        });

        $('#FriendTraderModalData').off('click', '.FT_SendTrade').on('click', '.FT_SendTrade', function () {
            if ($(this).css('pointer-events') === 'none') return;
            var i = $(this).data('index');


            $('.FT_SendTrade').css({ opacity: 0.5, 'pointer-events': 'none' });
            setTimeout(function (){
                $('.FT_SendTrade').css({ opacity: 1, 'pointer-events': '' });
            }, 3000);

            if (isMarketTradeMode) {
                sendTrades([tradesData.marketTrades[i]]);
            } else {
                sendTrades([tradesData.friendsTrades[i]]);
            }
        });

        return createTableRow([[2, getImageTag(item.offerResName, '24px') + ' ' + item.offerResAmount], [2, getImageTag(item.costResName, '24px') + ' ' + item.costResAmount], [6, formatToFractionOrReturn(item.UserName)], [2, $('<div>').append(delBtn, sendBtn)]], false);
    }

    function getResourceList() {
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

                    resourcesByCategory[category].push({
                        name: product.resourceName_string,
                    });
                }
            });
        } catch (e) {
            return [];
        }

        categoryNames.sort();

        var sortedGroupedList = [];
        for (var i = 0; i < categoryNames.length; i++) {
            var categoryName        = categoryNames[i];
            var resourcesInCategory = resourcesByCategory[categoryName];

            sortedGroupedList.push({
                categoryName: categoryName, items: resourcesInCategory
            });
        }

        return sortedGroupedList;
    }

    function getFriendsList() {
        return globalFlash.gui.mFriendsList.GetFilteredFriends("", true).map(function (f) {
            return {id: f.id, name: f.username};
        });
    }

    function createResourceSelect(id, resources) {
        var $select = $('<select>', {id: id, 'class': 'form-control'});
        resources.forEach(function (cat) {
            $select.append('<optgroup label="' + loca.GetText("LAB", cat.categoryName) + '">');
            cat.items.forEach(function (res) {
                $select.append($('<option>', {
                    value: res.name, 'data-max': res.maxLimit
                }).text(loca.GetText("RES", res.name)));
            })
        });
        $select.append('</optgroup>');
        return $select;
    }

    function createNumberInput(id, min, max, value) {
        return $('<input>', {
            type: 'number',
            id: id,
            name: id,
            min: min || 1,
            max: max || 1,
            value: value || 1,
            'class': 'form-control',
            style: 'display:inline;width:100px;'
        });
    }

    function sendTrades(tradeArray) {
        if (!Array.isArray(tradeArray) || tradeArray.length === 0) {
            game.showAlert(loca.GetText('LAB', 'CannotAffordSendTrade'));
            return;
        }

        var queue        = new TimedQueue(3000);
        var successCount = 0;
        var totalTrades  = tradeArray.length;

        var myResources = game.gi.mCurrentPlayerZone.GetResources(game.gi.mHomePlayer);
        for (var i = 0; i < tradeArray.length; i++) {
            var trade = tradeArray[i];

            if (!isMarketTradeMode && trade.userId === 0) {
                totalTrades--;
                continue;
            }
            if (isMarketTradeMode && trade.userId !== 0) {
                totalTrades--;
                continue;
            }
            if (!isMarketTradeMode) {
                var friends  = getFriendsList();
                var isFriend = friends.some(function (f) {
                    return f.id == trade.userId;
                });
                if (!isFriend) {
                    game.showAlert(loca.GetText('QUL', 'SocialMedium8') + ' ' + loca.GetText('LAB', 'AddFriend'));
                    continue;
                }
            }

            var hasEnoughResource = true;

            try {
                var amount = trade.offerResAmount;
                if (isMarketTradeMode){
                    amount = amount * trade.UserName;
                }
                if (myResources.HasPlayerResource(trade.offerResName, amount)) {
                    hasEnoughResource = true;
                } else {
                    hasEnoughResource = false;
                }
            } catch (checkError) {
                hasEnoughResource = false;
            }

            if (!hasEnoughResource) {
                totalTrades--;
                game.showAlert(loca.GetText('LAB', 'CannotAffordSendTrade'));
                continue;
            }

            var offerRes         = new (game.def("Communication.VO::dResourceVO"));
            offerRes.amount      = offerRes.producedAmount = trade.offerResAmount;
            offerRes.name_string = trade.offerResName;

            var costRes         = new (game.def("Communication.VO::dResourceVO"));
            costRes.amount      = costRes.producedAmount = trade.costResAmount;
            costRes.name_string = trade.costResName;

            var tradeOffer          = new (game.def("Communication.VO::dTradeOfferVO"));
            tradeOffer.offerRes     = offerRes;
            tradeOffer.costsRes     = costRes;
            tradeOffer.receipientId = trade.userId;
            tradeOffer.lots         = 0;
            tradeOffer.slotType     = 4;
            tradeOffer.slotPos      = 0;

            if (trade.userId === 0) {
                let freeSlots, slotPos;
                if (isTradeAlreadySent) {
                    freeSlots = 1;
                } else {
                    freeSlots = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(0);
                }
                slotPos   = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(2);

                tradeOffer.lots     = trade.UserName;
                tradeOffer.slotType = freeSlots === 0 ? 0 : 2;
                tradeOffer.slotPos  = slotPos
            }

            (function (currentTradeOffer, currentTrade) {
                queue.add(function () {
                    game.gi.mClientMessages.SendMessagetoServer(1049, game.gi.mCurrentViewedZoneID, currentTradeOffer);
                    isTradeAlreadySent = true;
                    successCount++;
                    if (currentTrade.userId === 0) {
                        game.showAlert(loca.GetText('LAB', 'TradeOffer') + ' ' + loca.GetText('MES', 'TradeInitiated') + ' (' + successCount + '/' + totalTrades + ')');
                    } else {
                        game.showAlert(loca.GetText('LAB', 'TradeOffer') + ' ' + loca.GetText('LAB', 'User') + ': ' + currentTrade.UserName + ' (' + successCount + '/' + totalTrades + ')');
                    }
                });
            })(tradeOffer, trade);
        }

        if (queue.len() > 0) {
            queue.run();
        }
    }

    function sanitizeInput(element) {
        element.value = element.value.replace(/\D/g, '') || 1;
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

    return {init: init};
})();

ShortcutTrader.init();