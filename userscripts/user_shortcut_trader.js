//////////////////////////////////////////////////////////////////////////////////////
// Created by MadFX //////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

var ShortcutTrader = (function () {
    var NAME = loca.GetText("QUL", "MiadTropicalSunQ2") + ', ' + loca.GetText("ACL", "SellGoods_1");
    var tradesData = {};
    var buildTemplates;
    var modalInitialized = false;

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
            if (data.zone_id !== game.gi.mCurrentViewedZoneID) {
                game.showAlert(loca.GetText('ALT', 'IOError') + ' ' + getText('not_home'));
                return;
            }
            tradesData = data;
            renderBody();
        });

        renderHeader();
        renderBody();
        renderFooter();

        $('#FriendTraderModal:not(:visible)').modal({backdrop: "static"});
    }

    function init() {
        try {
            tradesData = initTradesData();
            $.extend(tradesData, settings.read(null, 'FT_SETTINGS'));
            addToolsMenuItem(NAME, openModal);
        } catch (e) {
            debug(e);
        }
    }

    function initTradesData() {
        return {zone_id: game.gi.mCurrentViewedZoneID, trades: []};
    }

    function saveSettings() {
        settings.settings['FT_SETTINGS'] = {};
        settings.store(tradesData, 'FT_SETTINGS');
    }

    function renderHeader() {
        var switchRadio = '<div>' + createSwitch('FT_SWITCH', true) + '<div style="display:inline-block;vertical-align:top;margin-left: 10px;margin-bottom: 15px;" id="FT_RadioText">' + loca.GetText("LAB", "Marketplace") + '</div></div>';
        var tableHeadHtml = createTableRow([
            [2, loca.GetText("LAB", "WareToDeliver")],
            [2, loca.GetText("LAB", "WareToRecieve")],
            [4, loca.GetText("LAB", "SelectTradeResources")],
            [2, loca.GetText("LAB", "BoughtFromSoldTo")],
            [2, loca.GetText('LAB', 'Tasks')]
        ], true);

        $('#FriendTraderModalData').append('<div class="container-fluid">' + switchRadio + tableHeadHtml + '</div>');
        $('#FriendTraderModalData .container-fluid').append('<div class="FT_AddRowContainer"></div>');

        $('#FriendTraderModalData').off('change', '#FT_SWITCH').on('change', '#FT_SWITCH', function () {
            var mode = $(this).is(':checked') ? 'market' : 'friend';
            if (mode === 'friend') {
                $('#FT_RadioText').text(loca.GetText("LAB", "Friends"));
            } else {
                $('#FT_RadioText').text(loca.GetText("LAB", "Marketplace"));
            }
            $('.FT_AddRowContainer').empty();
            addTradeRow(mode);

            renderBody();
        });

        addTradeRow('market');
        $('#FriendTraderModalData .container-fluid').append('<div class="FT_trades"></div>');
    }

    function renderBody() {
        var $container = $('#FriendTraderModalData .container-fluid .FT_trades').empty();
        var mode = $('#FT_SWITCH').is(':checked') ? 'market' : 'friend';
        tradesData.trades.forEach(function (trade, index) {
            if ((mode === 'friend' && trade.userId == 0) || (mode === 'market' && trade.userId !== 0)) {
                return;
            }
            $container.append(renderTradeRow(trade, index));
        });
    }

    function renderFooter() {
        var $modal = $('#FriendTraderModal');
        var $footer = $modal.find('.modal-footer');

        $footer.prepend([
            $('<button>').addClass('btn btn-warning').text(getText('btn_reset')).click(function () {
                tradesData = initTradesData();
                saveSettings();
                renderBody();
            }),
            $('<button>').addClass('btn btn-success').text(getText('btn_submit') + ' ' + loca.GetText("LAB", "All")).click(function () {
                if (!tradesData.trades.length) return;
                $modal.modal('hide');
                sendTrades(tradesData.trades);
            }),
            $('<button>').addClass('btn btn-primary pull-left').text(getText('save_template')).click(function () {
                buildTemplates.save(tradesData);
                saveSettings();
            }),
            $('<button>').addClass('btn btn-primary pull-left').text(getText('load_template')).click(function () {
                buildTemplates.load();
                saveSettings();
            })
        ]);
    }

    function addTradeRow(mode) {
        var resources = getResourceList();
        var firstRes = resources[0].items[0], secondRes = resources[0].items[1];
        var inputOffer = createNumberInput('FT_AddOffer_' + mode, 1, 1);
        var inputCost = createNumberInput('FT_AddCost_' + mode, 1, 1);
        var selectOffer = createResourceSelect('FT_OfferList_' + mode, resources);
        var selectCost = createResourceSelect('FT_CostList_' + mode, resources);

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
            [2, $('<div>').append(
                $('<div>').addClass('offer-res-img').css({
                    display: 'inline-block',
                    verticalAlign: 'middle'
                }).html(getImageTag(firstRes.name, '24px')),
                $('<div>').css({display: 'inline-block', verticalAlign: 'middle'}).append(inputOffer)
            )],
            [2, $('<div>').append(
                $('<div>').addClass('cost-res-img').css({
                    display: 'inline-block',
                    verticalAlign: 'middle'
                }).html(getImageTag(secondRes.name, '24px')),
                $('<div>').css({display: 'inline-block', verticalAlign: 'middle'}).append(inputCost)
            )],
            [2, selectOffer],
            [2, selectCost],
            [2, targetSelect],
            [2, $('<div>', {
                'class': 'FT_AddTradeBtn',
                'data-mode': mode,
                style: 'display:inline-block;cursor:pointer;background:wheat;border-radius:3px;'
            }).html(getImageTag('ButtonIconOK', '24px'))]
        ], true);

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

            var offerResName = $('select[id="FT_OfferList_' + mode + '"]').val();
            var offerResAmount = parseInt($('input[id="FT_AddOffer_' + mode + '"]').val(), 10);
            var costResName = $('select[id^="FT_CostList_' + mode + '"]').val();
            var costResAmount = parseInt($('input[id^="FT_AddCost_' + mode + '"]').val(), 10);

            var userId = 0;
            var userName = 'Market';
            if (mode === 'friend') {
                var $friendSel = $('select[id^="FT_friend_selector"]');
                userId = $friendSel.val();
                userName = $friendSel.find('option:selected').text();
            } else {
                var qty = $('select[id^="market_scroll_' + mode + '"]');
                userName = qty.find('option:selected').val();
            }

            tradesData.trades.push({
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
            css: {cursor: 'pointer', display: 'inline-block', marginRight: '5px'},
            html: getImageTag('ButtonIconAbort', '24px')
        });

        var sendBtn = $('<div>', {
            'class': 'FT_SendTrade',
            'data-index': index,
            css: {cursor: 'pointer', display: 'inline-block'},
            html: getImageTag('Trade', '24px')
        })

        $('#FriendTraderModalData').off('click', '.FT_delTrade').on('click', '.FT_delTrade', function () {
            var i = $(this).data('index');
            tradesData.trades.splice(i, 1);
            renderBody();
            saveSettings();
        });

        $('#FriendTraderModalData').off('click', '.FT_SendTrade').on('click', '.FT_SendTrade', function () {
            var i = $(this).data('index');
            sendTrades([tradesData.trades[i]]);
            renderBody();
        });

        return createTableRow([
            [2, getImageTag(item.offerResName, '24px') + ' ' + item.offerResAmount],
            [2, getImageTag(item.costResName, '24px') + ' ' + item.costResAmount],
            [6, formatToFractionOrReturn(item.UserName)],
            [2, $('<div>').append(delBtn, sendBtn)]
        ], false);
    }

    function getResourceList() {
        var resourcesByCategory = {};
        var categoryNames = [];

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
            var categoryName = categoryNames[i];
            var resourcesInCategory = resourcesByCategory[categoryName];

            sortedGroupedList.push({
                categoryName: categoryName,
                items: resourcesInCategory
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
                    value: res.name,
                    'data-max': res.maxLimit
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

        var queue = new TimedQueue(1000);
        var successCount = 0;
        var totalTrades = tradeArray.length;

        var myResources = game.gi.mCurrentPlayerZone.GetResources(game.gi.mHomePlayer);
        var mode = $('#FT_SWITCH').is(':checked') ? 'market' : 'friend';
        for (var i = 0; i < tradeArray.length; i++) {
            var trade = tradeArray[i];

            if (mode === 'friend' && trade.userId === 0) {
                totalTrades--;
                continue;
            }
            if (mode === 'market' && trade.userId !== 0) {
                totalTrades--;
                continue;
            }

            var hasEnoughResource = true;

            try {
                if (myResources.HasPlayerResource(trade.offerResName, trade.offerResAmount)) {
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

            var offerRes = new (game.def("Communication.VO::dResourceVO"));
            offerRes.amount = offerRes.producedAmount = trade.offerResAmount;
            offerRes.name_string = trade.offerResName;

            var costRes = new (game.def("Communication.VO::dResourceVO"));
            costRes.amount = costRes.producedAmount = trade.costResAmount;
            costRes.name_string = trade.costResName;

            var tradeOffer = new (game.def("Communication.VO::dTradeOfferVO"));
            tradeOffer.offerRes = offerRes;
            tradeOffer.costsRes = costRes;
            tradeOffer.receipientId = trade.userId;
            tradeOffer.lots = 0;
            tradeOffer.slotType = 4;
            tradeOffer.slotPos = 0;

            if (trade.userId === 0) {
                var freeSlots = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(0);
                var slotPos = game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(2);

                tradeOffer.lots = trade.UserName;
                tradeOffer.slotType = freeSlots === 0 ? 0 : 2;
                tradeOffer.slotPos = slotPos
            }

            (function (currentTradeOffer, currentTrade) {
                queue.add(function () {
                    game.gi.mClientMessages.SendMessagetoServer(1049, game.gi.mCurrentViewedZoneID, currentTradeOffer);
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