var ChestOpener = (function () {
    var SCRIPT_CONST = {
        PREFIX: 'CO',
        OPEN_DELAY: 1500,
        LOOTTABLE_PREFIX: 'Loottable'
    };

    // ─── Settings ─────────────────────────────────────────────────────────────

    var SettingsService = (function () {
        var STATE = initState();

        function initState() {
            return {
                chestAmounts: {}   // { defName: requestedAmount }
            };
        }

        function getState()   { return STATE; }
        function setState(s)  { STATE = s; }
        function resetState() { STATE = initState(); return STATE; }

        function saveSettings() {
            settings.settings[SCRIPT_CONST.PREFIX + '_SETTINGS'] = {};
            settings.store(STATE, SCRIPT_CONST.PREFIX + '_SETTINGS');
        }

        function loadSettings() {
            $.extend(STATE, settings.read(null, SCRIPT_CONST.PREFIX + '_SETTINGS'));
        }

        return {
            getState:     getState,
            setState:     setState,
            resetState:   resetState,
            saveSettings: saveSettings,
            loadSettings: loadSettings
        };
    })();

    // ─── Game Data ────────────────────────────────────────────────────────────

    var GameDataSource = (function () {

        /**
         * Returns array of chest objects:
         * {
         *   defName:     String,   — buff definition name, e.g. "LoottableGrandmasDinner"
         *   displayName: String,   — localized name
         *   icon:        String,   — same as defName, used for getImageTag()
         *   totalCount:  Number,   — buff.GetAmount()
         *   buff:        cBuff     — single instance; call buff.GetUniqueId() each open
         * }
         */
        function getChestGroups() {
            var buffs  = game.gi.mHomePlayer.getBuffsSortedForStarMenu();
            var groups = {};

            for (var i = 0; i < buffs.length; i++) {
                var buff    = buffs[i];
                var defName = buff.GetBuffDefinition().GetName_string();

                if (defName.indexOf(SCRIPT_CONST.LOOTTABLE_PREFIX) !== 0) continue;

                if (!groups[defName]) {
                    groups[defName] = {
                        defName:     defName,
                        displayName: getLocalizedName(defName),
                        icon:        defName,
                        totalCount:  0,
                        buffs:       [] // лучше хранить все, а не один
                    };
                }
                groups[defName].totalCount += buff.GetAmount();
                groups[defName].buffs.push(buff);
            }

            var result = [];
            var keys   = Object.keys(groups);
            for (var k = 0; k < keys.length; k++) {
                result.push(groups[keys[k]]);
            }
            return result;
        }

        function getLocalizedName(defName) {
            var locs = ['RES', 'BUI', 'SHI', 'ADN', 'LAB', 'DES'];
            for (var i = 0; i < locs.length; i++) {
                var t = loca.GetText(locs[i], defName);
                if (t && t.indexOf('[undefined') === -1) return t;
            }
            return defName.replace('Loottable', '').replace(/([A-Z])/g, ' $1').trim();
        }

        return {
            getChestGroups: getChestGroups
        };
    })();

    // ─── Opener Service ───────────────────────────────────────────────────────

    var OpenerService = (function () {

        /**
         * Opens `count` chests.
         * Re-reads buff.GetUniqueId() on every tick — the game updates it
         * server-side as the stack decreases.
         */
        function openChests(group, count, onDone) {
            var queue  = new TimedQueue(SCRIPT_CONST.OPEN_DELAY);
            var opened = 0;
            var grid   = game.zone.mStreetDataMap.GetMayorHouse().GetGrid();

            var remaining = count;

            for (var i = 0; i < group.buffs.length; i++) {
                var buff   = group.buffs[i];
                var amount = buff.GetAmount();

                for (var j = 0; j < amount && remaining > 0; j++) {
                    (function (buffRef) {
                        queue.add(function () {
                            try {
                                game.gi.SendServerAction(61, 0, grid, 0, buffRef.GetUniqueId());
                                globalFlash.gui.mMysteryBoxPanel.SetData(buffRef);
                            } catch (e) {
                                debug(e);
                            } finally {
                                opened++;
                                if (typeof onDone === 'function') {
                                    onDone(opened, count);
                                }
                            }
                        });
                    })(buff);

                    remaining--;
                }

                if (remaining <= 0) break;
            }

            if (queue.len() > 0) queue.run();
        }

        return {
            openChests: openChests
        };
    })();

    // ─── UI Map ───────────────────────────────────────────────────────────────

    var UIMap = {
        ids: {
            modal:      SCRIPT_CONST.PREFIX + '_ChestOpenerModal',
            modalData:  SCRIPT_CONST.PREFIX + '_ChestOpenerModalData',
            listWrap:   SCRIPT_CONST.PREFIX + '_ChestList',
            openAllBtn: SCRIPT_CONST.PREFIX + '_OpenAllBtn',
            resetBtn:   SCRIPT_CONST.PREFIX + '_ResetBtn'
        },
        classes: {
            chestRow:    SCRIPT_CONST.PREFIX + '_chestRow',
            amountInput: SCRIPT_CONST.PREFIX + '_amountInput',
            openOneBtn:  SCRIPT_CONST.PREFIX + '_openOneBtn',
            progressBar: SCRIPT_CONST.PREFIX + '_progress'
        }
    };

    // ─── UI Renderer ──────────────────────────────────────────────────────────

    var UIRenderer = (function () {

        function renderModal() {
            $('#' + UIMap.ids.modal).find('.modal-body').html(
                '<div id="' + UIMap.ids.modalData + '">' +
                '<div id="' + UIMap.ids.listWrap + '"></div>' +
                '</div>'
            );
            renderList();
        }

        function renderList() {
            var groups = GameDataSource.getChestGroups();
            var $list  = $('#' + UIMap.ids.listWrap).empty();
            var state  = SettingsService.getState();

            if (!groups.length) {
                $list.html(
                    '<p style="text-align:center;padding:30px;color:#b8860b;font-size:15px;">' +
                    'No lootable chests found in Star Menu</p>'
                );
                return;
            }

            var $table = $('<table>').css({
                width:           '100%',
                borderCollapse:  'separate',
                borderSpacing:   '0 6px'
            });

            for (var i = 0; i < groups.length; i++) {
                var group   = groups[i];
                var saved   = state.chestAmounts[group.defName];
                var initVal = Math.min(saved !== undefined ? saved : 1, group.totalCount);

                var iconHtml = '';
                try { iconHtml = getImageTag(group.icon, '28px'); } catch (e) {}

                var $input = $('<input>', {
                    type:           'number',
                    'class':        UIMap.classes.amountInput,
                    'data-defname': group.defName,
                    'data-max':     group.totalCount,
                    value:          initVal,
                    min:            0,
                    max:            group.totalCount
                }).css({
                    width:        '80px',
                    background:   'rgba(30,20,10,0.8)',
                    border:       '1px solid #7a5c00',
                    color:        '#ffe082',
                    borderRadius: '5px',
                    padding:      '3px 6px',
                    fontSize:     '13px',
                    textAlign:    'center'
                });

                var $openBtn = $('<div>', {
                    'class':        'btn ' + UIMap.classes.openOneBtn,
                    'data-defname': group.defName,
                    css: {cursor: 'pointer', display: 'inline-block',margin: '0 10px'},
                    html: getImageTag('AchievementTriggerCheckboxCheckedIcon', '25px')
                })

                var $row = $('<tr>')
                    .addClass(UIMap.classes.chestRow)
                    .attr('data-defname', group.defName)
                    .css({ background: 'rgba(255,215,0,0.06)' });

                $row.append(
                    $('<td>').css({ padding: '8px 6px 8px 10px', width: '36px' }).html(iconHtml),
                    $('<td>').css({ padding: '8px 4px', fontWeight: '600', color: '#ffe082', fontSize: '13px' })
                        .text(group.displayName),
                    $('<td>').css({ padding: '8px 4px', color: '#aaa', fontSize: '12px', whiteSpace: 'nowrap' })
                        .html('<span style="background:rgba(255,215,0,0.18);padding:2px 8px;border-radius:10px;color:#ffc107;">&times;' + group.totalCount + '</span>'),
                    $('<td>').css({ padding: '8px 4px', width: '95px' }).append($input),
                    $('<td>').css({ padding: '8px 10px 8px 4px', textAlign: 'right' }).append($openBtn)
                );

                // Progress row — hidden until opening starts
                var $progInner = $('<div>')
                    .addClass(UIMap.classes.progressBar)
                    .attr('data-defname', group.defName)
                    .css({
                        height:       '100%',
                        width:        '0%',
                        background:   'gold',
                        borderRadius: '4px',
                        transition:   'width 0.3s ease'
                    });

                var $progRow = $('<tr>').hide()
                    .addClass(UIMap.classes.progressBar + '_row')
                    .attr('data-defname', group.defName);

                $progRow.append(
                    $('<td>', { colspan: 5 }).css({ padding: '0 10px 8px' }).append(
                        $('<div>').css({
                            background:   'rgba(0,0,0,0.3)',
                            borderRadius: '4px',
                            overflow:     'hidden',
                            height:       '6px'
                        }).append($progInner)
                    )
                );

                $table.append($row);
                $table.append($progRow);
            }

            $list.append($table);
        }

        function showProgress(defName, current, total) {
            var pct = Math.round((current / total) * 100);
            $('.' + UIMap.classes.progressBar + '_row[data-defname="' + defName + '"]').show();
            $('.' + UIMap.classes.progressBar + '[data-defname="' + defName + '"]').css('width', pct + '%');
            if (current >= total) {
                setTimeout(function () {
                    $('.' + UIMap.classes.progressBar + '_row[data-defname="' + defName + '"]').hide();
                    renderList();
                }, SCRIPT_CONST.OPEN_DELAY + 5000);
            }
        }

        return {
            renderModal:  renderModal,
            renderList:   renderList,
            showProgress: showProgress
        };
    })();

    // ─── Actions ──────────────────────────────────────────────────────────────

    var ActionsService = (function () {

        function init() {
            var $modal = $('#' + UIMap.ids.modal);

            $modal
                .off('input change', '.' + UIMap.classes.amountInput)
                .on('input change',  '.' + UIMap.classes.amountInput, handleInputChange)
                .off('click', '.' + UIMap.classes.openOneBtn)
                .on('click',  '.' + UIMap.classes.openOneBtn, handleOpenOne)
                .off('click', '#' + UIMap.ids.openAllBtn)
                .on('click',  '#' + UIMap.ids.openAllBtn, handleOpenAll)
                .off('click', '#' + UIMap.ids.resetBtn)
                .on('click',  '#' + UIMap.ids.resetBtn, handleReset);
        }

        function handleInputChange() {
            var $inp    = $(this);
            var defName = $inp.attr('data-defname');
            var max     = parseInt($inp.attr('data-max'), 10);
            var val     = parseInt($inp.val(), 10) || 0;

            if (val < 0)   val = 0;
            if (val > max) { val = max; $inp.val(max); }

            var state = SettingsService.getState();
            state.chestAmounts[defName] = val;
            SettingsService.setState(state);
            SettingsService.saveSettings();
        }

        function handleOpenOne() {
            var defName = $(this).attr('data-defname');
            var $inp    = $('.' + UIMap.classes.amountInput + '[data-defname="' + defName + '"]');
            var count   = parseInt($inp.val(), 10) || 0;

            if (count <= 0) {
                game.showAlert('Set amount > 0 to open chests.');
                return;
            }

            var groups = GameDataSource.getChestGroups();
            var group  = null;
            for (var i = 0; i < groups.length; i++) {
                if (groups[i].defName === defName) { group = groups[i]; break; }
            }
            if (!group) return;

            disableOpenButtons();
            globalFlash.gui.mMysteryBoxPanel.Show();
            OpenerService.openChests(group, count, function (opened, total) {
                UIRenderer.showProgress(defName, opened, total);
            });
        }

        function handleOpenAll() {
            var groups = GameDataSource.getChestGroups();
            var state  = SettingsService.getState();
            var any    = false;

            for (var i = 0; i < groups.length; i++) {
                var group = groups[i];
                var count = parseInt(state.chestAmounts[group.defName], 10) || 0;
                if (count <= 0) continue;
                any = true;
                disableOpenButtons();
                (function (g, c) {
                    OpenerService.openChests(g, c, function (opened, total) {
                        UIRenderer.showProgress(g.defName, opened, total);
                    });
                })(group, count);
            }

            if (!any) game.showAlert('Set at least one chest amount > 0.');
        }

        function handleReset() {
            SettingsService.resetState();
            SettingsService.saveSettings();
            UIRenderer.renderList();
        }

        function disableOpenButtons() {
            var selector = '.' + UIMap.classes.openOneBtn + ', #' + UIMap.ids.openAllBtn;
            $(selector).prop('disabled', true).css('opacity', 0.5);
        }

        function enableOpenButtons() {
            var selector = '.' + UIMap.classes.openOneBtn + ', #' + UIMap.ids.openAllBtn;
            $(selector).prop('disabled', false).css('opacity', 1);
        }

        return {
            init: init
        };
    })();

    // ─── Bootstrap ────────────────────────────────────────────────────────────

    function buildModalFooter($modal) {
        $modal.find('.modal-footer').prepend([
            $('<button>', { id: UIMap.ids.resetBtn })
                .addClass('btn btn-warning')
                .text(getText('btn_reset'))
                .css({ fontWeight: '600' }),
            // $('<button>', { id: UIMap.ids.openAllBtn })
            //     .addClass('btn btn-success')
            //     .text('Open All')
            //     .css({ fontWeight: '700', background: 'linear-gradient(135deg,#2e7d32,#66bb6a)', border: 'none' })
        ]);
    }

    function OpenChestOpenerModal() {
        try {
            if (!game.gi.isOnHomzone()) {
                game.showAlert('You must be on your home zone to open chests.');
                return;
            }

            SettingsService.loadSettings();

            $("div[role='dialog']:not(#" + UIMap.ids.modal + "):visible").modal('hide');
            $('#' + UIMap.ids.modal).remove();

            createModalWindow(UIMap.ids.modal, loca.GetText('SHI','AnniversaryBundle2024_Large'));

            var $modal = $('#' + UIMap.ids.modal);
            $modal.find('.modal-dialog').css('max-width', '620px');
            $modal.find('.modal-content').css({
                background:   'linear-gradient(160deg, #1a1200 0%, #2c1e00 60%, #1a1200 100%)',
                borderRadius: '10px',
                boxShadow:    '0 0 40px rgba(218,165,32,0.15)',
                color:        '#ffe082'
            });
            $modal.find('.modal-header').css({
                borderBottom: '1px solid rgba(218,165,32,0.2)',
                padding:      '14px 20px'
            });
            $modal.find('.modal-title').css({
                fontSize:      '16px',
                fontWeight:    '700',
                letterSpacing: '1px',
                color:         '#ffe082'
            });

            UIRenderer.renderModal();
            buildModalFooter($modal);
            ActionsService.init();

            $modal.not(':visible').modal({ backdrop: 'static' });
        } catch (e) {
            debug(e);
        }
    }

    function init() {
        try {
            window.OpenChestOpenerModal = OpenChestOpenerModal;
            addToolsMenuItem(loca.GetText('SHI','AnniversaryBundle2024_Large'), window.OpenChestOpenerModal);
        } catch (e) {
            debug(e);
        }
    }

    return {
        init:      init,
        openModal: OpenChestOpenerModal
    };
})();

ChestOpener.init();