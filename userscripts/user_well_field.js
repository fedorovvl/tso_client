////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////// Wells & Fields Rebuilder /////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(function () {
    'use strict';

    /**
     * Wells & Fields Rebuilder
     * Senior-level modular architecture for The Settlers Online Client.
     * Uses strictly native game localization (loca.GetText) and standard client helpers.
     */

    // --- Module: Constants & Config Definitions ---
    var SETTINGS_KEY = 'WF_SETTINGS';

    // Enums.COMMAND.SET_BUILDING_IN_GAME (client_scripts.txt: "public static const SET_BUILDING_IN_GAME:int = 50;")
    var CMD_SET_BUILDING_IN_GAME = 50;

    var BUILDING_DEFINITIONS = {
        wells: [
            { id: 72, name: 'Well' },
            // { id: 175, name: 'Well_02' },
            { id: 176, name: 'Well_03' },
            { id: 246, name: 'Well_04' }
        ],
        fields: [
            { id: 43, name: 'Farmfield' },
            // { id: 177, name: 'Farmfield_02' },
            { id: 247, name: 'Farmfield_03' },
            { id: 248, name: 'Farmfield_04' }
        ]
    };

    var DEPLETED_NAMES = {
        WATER: 'MineDepletedDepositWater',
        CORN: 'MineDepletedDepositCorn'
    };

    // --- Module: Localization Helper ---
    // Pure native game strings without custom dictionaries
    var Loca = {
        title: function () {
            return loca.GetText("BUI", "Well") + " & " + loca.GetText("BUI", "Farmfield");
        },
        well: function () {
            return loca.GetText("BUI", "Well");
        },
        field: function () {
            return loca.GetText("BUI", "Farmfield");
        },
        buildingName: function (name) {
            return loca.GetText("BUI", name);
        },
        filter: function () {
            return loca.GetText("LAB", "Filter");
        },
        type: function () {
            return loca.GetText("LAB", "Type");
        },
        all: function () {
            return loca.GetText("LAB", "All");
        },
        wellsOnly: function () {
            return loca.GetText("BUI", "Well");
        },
        fieldsOnly: function () {
            return loca.GetText("BUI", "Farmfield");
        },
        massConstruction: function () {
            return loca.GetText("ACL", "BuildQueueSlotTemp");
        },
        amount: function () {
            return loca.GetText("LAB", "Amount");
        },
        selectAll: function () {
            return loca.GetText("LAB", "Select") + " " + loca.GetText("LAB", "All");
        },
        fillQueue: function () {
            return loca.GetText("LAB", "Slot");
        },
        depletedFound: function () {
            return loca.GetText("MEL", "DepositDepleted");
        },
        queueSlotsFree: function () {
            return loca.GetText("LAB", "Slot") + " (" + loca.GetText("LAB", "Free") + ")";
        },
        colName: function () {
            return loca.GetText("LAB", "Name");
        },
        colRebuild: function () {
            return loca.GetText("LAB", "RebuildLevelOneGroup");
        },
        colVisit: function () {
            return loca.GetText("LAB", "Visit");
        },
        noSelection: function () {
            return loca.GetText("LAB", "PleaseSelect");
        },
        commandQueued: function (bldName, grid) {
            return (bldName + " @" + grid);
        },
        autoFinished: function () {
            return loca.GetText("LAB", "GuildQuestCompleted");
        }
    };

    // --- Module: State & Preferences ---
    var State = {
        config: {
            selectedWellType: 72,
            selectedFieldType: 43,
            filterMode: 'all',
            autoMode: false
        },
        depletedList: [],
        selectedGrids: [],
        autoTimerId: null,
        templateHandler: null,

        loadSettings: function () {
            $.extend(this.config, readSettings(null, SETTINGS_KEY));
        },

        saveSettings: function () {
            settings.settings[SETTINGS_KEY] = {};
            settings.store(this.config, SETTINGS_KEY);
        },

        clearTimer: function () {
            if (this.autoTimerId) {
                clearTimeout(this.autoTimerId);
                this.autoTimerId = null;
            }
        }
    };

    State.loadSettings();

    // --- Module: Game Scanner & Queue Manager ---
    var Core = {
        getFreeQueueSlots: function () {
            try {
                var buildQueue = swmmo.application.mGameInterface.mHomePlayer.mBuildQueue;
                var total = buildQueue.GetTotalAvailableSlots();
                var used = buildQueue.GetQueue_vector().length;
                return Math.max(0, total - used);
            } catch (e) {
                return 0;
            }
        },

        scanDepletedDeposits: function () {
            var result = [];
            try {
                var zone = swmmo.application.mGameInterface.mCurrentPlayerZone;
                var streetDataMap = zone.mStreetDataMap;
                var container = streetDataMap.mBuildingContainer.mContainer;

                for (var i = 0, len = container.length; i < len; i++) {
                    var item = container[i];
                    if (!item || !streetDataMap.IsADepletedDeposit(item)) continue;

                    var bName = '';
                    try {
                        bName = item.GetBuildingName_string();
                    } catch (e) {
                        continue;
                    }

                    if (bName === DEPLETED_NAMES.WATER) {
                        result.push({
                            grid: item.GetGrid(),
                            type: 'water',
                            name: bName,
                            locName: Loca.well(),
                            icon: 'Water'
                        });
                    } else if (bName === DEPLETED_NAMES.CORN) {
                        result.push({
                            grid: item.GetGrid(),
                            type: 'corn',
                            name: bName,
                            locName: Loca.field(),
                            icon: 'Corn'
                        });
                    }
                }

                result.sort(function (a, b) {
                    if (a.type !== b.type) return a.type.localeCompare(b.type);
                    return a.grid - b.grid;
                });
            } catch (e) {
                debug(e);
            }
            return result;
        },

        getBuildingTypeId: function (depletedType) {
            if (depletedType === 'water') {
                return parseInt(State.config.selectedWellType, 10) || 72;
            }
            if (depletedType === 'corn') {
                return parseInt(State.config.selectedFieldType, 10) || 43;
            }
            return 72;
        },

        getBuildingInternalName: function (typeId) {
            typeId = parseInt(typeId, 10);
            for (var i = 0; i < BUILDING_DEFINITIONS.wells.length; i++) {
                if (BUILDING_DEFINITIONS.wells[i].id === typeId) return BUILDING_DEFINITIONS.wells[i].name;
            }
            for (var j = 0; j < BUILDING_DEFINITIONS.fields.length; j++) {
                if (BUILDING_DEFINITIONS.fields[j].id === typeId) return BUILDING_DEFINITIONS.fields[j].name;
            }
            return 'Well';
        },

        executeBatchBuild: function (gridsToBuild) {
            var queue = new TimedQueue(1000);
            var freeSlots = this.getFreeQueueSlots();
            var remainingGrids = gridsToBuild.slice();

            for (var i = remainingGrids.length - 1; i >= 0; i--) {
                if (freeSlots < 1) break;

                var grid = remainingGrids[i];
                var depletedItem = null;
                for (var d = 0; d < State.depletedList.length; d++) {
                    if (State.depletedList[d].grid === grid) {
                        depletedItem = State.depletedList[d];
                        break;
                    }
                }

                if (!depletedItem) {
                    remainingGrids.splice(i, 1);
                    continue;
                }

                var bldType = this.getBuildingTypeId(depletedItem.type);
                var bldName = this.getBuildingInternalName(bldType);

                freeSlots--;

                (function (targetGrid, targetType, targetName) {
                    queue.add(function () {
                        try {
                            var gi = game.gi;
                            var player = gi.mHomePlayer || gi.mCurrentPlayer;
                            var streetDataMap = gi.mCurrentPlayerZone.mStreetDataMap;

                            // Resolve the building number the same way the client does
                            // (cCursorAction -> global.buildingGroup.GetNrFromName).
                            var typeNr = targetType;
                            try {
                                var resolvedNr = global.buildingGroup.GetNrFromName(targetName);
                                if (resolvedNr > 0) typeNr = resolvedNr;
                            } catch (eNr) { }

                            if (player.mBuildQueue.IsFull()) return;

                            // 1) Tell the server (COMMAND.SET_BUILDING_IN_GAME).
                            gi.SendServerAction(CMD_SET_BUILDING_IN_GAME, typeNr, targetGrid, 0, null);

                            // 2) Place the building locally, exactly like the original client does.
                            //    SetPrePlaceBuildingGridPos() itself calls
                            //    RemoveDepletedDepositBuildingIfOneIsThere() and creates the
                            //    pre-placed building. Without that pre-placement the incoming
                            //    game tick (HandleSetBuilding) is dropped, so the build queue
                            //    only shows the order after reloading the client.
                            var placed = streetDataMap.SetPrePlaceBuildingGridPos(player, targetName, targetGrid, 0);
                            if (!placed) {
                                debug('WF: could not pre-place ' + targetName + ' at grid ' + targetGrid);
                            }

                            // 3) Refresh the game UI the same way the client does after placing.
                            try { globalFlash.gui.mToolboxPanel.Refresh(); } catch (eGui) { }
                            if (typeof cSoundManager !== 'undefined') {
                                try { cSoundManager.getInstance().playEffect('BuildingPlace'); } catch (eSnd) { }
                            }

                            game.showAlert(Loca.commandQueued(Loca.buildingName(targetName), targetGrid));
                        } catch (e) {
                            debug(e);
                        }
                    });
                })(grid, bldType, bldName);

                remainingGrids.splice(i, 1);
            }

            // Refresh our own list and the game panels once the batch has been sent.
            queue.add(function () {
                try {
                    if (typeof UI !== 'undefined' && UI.refreshData) {
                        UI.refreshData();
                        UI.bindGridEvents();
                    }
                    try { globalFlash.gui.mToolboxPanel.Refresh(); } catch (eGui) { }
                } catch (e) {
                    debug(e);
                }
            });

            queue.run();
            return remainingGrids;
        },

        startAutoQueue: function (targetGrids) {
            if (!game.gi.isOnHomzone()) {
                game.showAlert(getText('not_home'));
                return;
            }

            State.clearTimer();
            game.showAlert(Loca.massConstruction() + ': ' + targetGrids.length);
            this.autoLoop(targetGrids);
        },

        autoLoop: function (targetGrids) {
            var self = this;
            if (!game.gi.isOnHomzone()) {
                State.autoTimerId = setTimeout(function () {
                    self.autoLoop(targetGrids);
                }, 15000);
                return;
            }

            var remaining = targetGrids.filter(function (grid) {
                var b = game.zone.GetBuildingFromGridPosition(grid);
                if (!b) return true;
                return game.zone.mStreetDataMap.IsADepletedDeposit(b);
            });

            if (remaining.length === 0) {
                game.showAlert(Loca.autoFinished());
                State.clearTimer();
                return;
            }

            var freeSlots = self.getFreeQueueSlots();
            if (freeSlots > 0) {
                remaining = self.executeBatchBuild(remaining);
            }

            if (remaining.length === 0) {
                game.showAlert(Loca.autoFinished());
                State.clearTimer();
                return;
            }

            var nextDelay = 10000;
            try {
                var q = game.gi.mHomePlayer.mBuildQueue;
                var qVec = q.GetQueue_vector ? q.GetQueue_vector() : [];
                if (qVec.length > 0 && qVec[0]) {
                    var dur = qVec[0].GetRemainingConstructionDuration();
                    if (dur > 0) {
                        nextDelay = Math.max(dur + 2000, 5000);
                    }
                }
            } catch (e) {
                nextDelay = 10000;
            }

            State.autoTimerId = setTimeout(function () {
                self.autoLoop(remaining);
            }, nextDelay);
        }
    };

    // --- Module: Game-styled dropdown (replaces the native <select>) ---
    // The native select/option popup is drawn by the OS and cannot be themed,
    // so it is rebuilt from plain DOM nodes styled exactly like WF_inputCount.
    var Dropdown = {
        render: function (id, items, selectedValue) {
            var label = '';
            var options = '';

            for (var i = 0; i < items.length; i++) {
                var isSelected = String(items[i].value) === String(selectedValue);
                if (isSelected) label = items[i].text;
                options += '<div class="WF_selectOption' + (isSelected ? ' selected' : '') + '" data-value="' + items[i].value + '">' +
                    items[i].text + '</div>';
            }

            if (!label && items.length > 0) label = items[0].text;

            return '<div class="WF_select" id="' + id + '" data-value="' + selectedValue + '">' +
                '<span class="WF_selectLabel">' + label + '</span>' +
                '<span class="WF_caret"></span>' +
                '<div class="WF_selectMenu">' + options + '</div>' +
                '</div>';
        },

        value: function (id) {
            return $('#' + id).attr('data-value');
        },

        bind: function (id, onChange) {
            var $root = $('#' + id);
            if (!$root.length) return;

            // The client theme sets ".row div { overflow: hidden }", which would clip
            // the popup. Open up only the parents up to the modal header.
            $root.parents().each(function () {
                var $parent = $(this);
                $parent.addClass('nohide').css('overflow', 'visible');
                if ($parent.hasClass('modal-header')) return false;
            });

            $root.off('click.wfdd').on('click.wfdd', function (e) {
                e.stopPropagation();
                var wasOpen = $root.hasClass('open');
                $('#WellFieldModal .WF_select').removeClass('open');
                if (!wasOpen) $root.addClass('open');
            });

            $root.find('.WF_selectOption').off('click.wfdd').on('click.wfdd', function (e) {
                e.stopPropagation();

                var value = $(this).attr('data-value');
                $root.attr('data-value', value);
                $root.find('.WF_selectLabel').html($(this).html());
                $root.find('.WF_selectOption').removeClass('selected');
                $(this).addClass('selected');
                $root.removeClass('open');

                if (onChange) onChange(value);
            });

            $(document).off('click.wfdd_' + id).on('click.wfdd_' + id, function () {
                $root.removeClass('open');
            });
        }
    };

    // --- Module: UI View & Controllers ---
    var UI = {
        getVisibleItems: function () {
            return State.depletedList.filter(function (item) {
                if (State.config.filterMode === 'wells') return item.type === 'water';
                if (State.config.filterMode === 'fields') return item.type === 'corn';
                return true;
            });
        },

        renderHeader: function () {
            // Inject scoped styles for TSO client theme controls & clean modal scrolling
            $('#WF_CustomStyles').remove();
            $('head').append(
                '<style id="WF_CustomStyles">' +
                '#WellFieldModal { overflow: hidden !important; color-scheme: dark !important; }' +
                '#WellFieldModal .modal-dialog { width: 92% !important; max-width: 680px !important; margin: 12px auto !important; display: flex !important; flex-direction: column !important; }' +
                '#WellFieldModal .modal-content { display: flex !important; flex-direction: column !important; height: auto !important; max-height: 100% !important; overflow: hidden !important; }' +
                '#WellFieldModal .modal-header { flex: 0 0 auto !important; }' +
                '#WellFieldModal .modal-footer { flex: 0 0 auto !important; }' +
                '#WellFieldModal .modal-body { flex: 0 1 auto !important; min-height: 180px !important; height: auto !important; overflow-y: auto !important; overflow-x: hidden !important; padding: 4px 15px !important; }' +
                '#WellFieldModal .modal-body > .container-fluid { padding-bottom: 2px !important; }' +
                '#WellFieldModal .WF_autoModeBox { white-space: normal !important; overflow: visible !important; text-overflow: clip !important; line-height: 1.15 !important; }' +
                '#WellFieldModal .WF_autoModeBox > * { vertical-align: middle !important; }' +
                '#WellFieldModal .WF_autoModeLabel {' +
                '  display: inline-block !important;' +
                '  vertical-align: middle !important;' +
                '  margin-left: 6px !important;' +
                '  max-width: calc(100% - 56px) !important;' +
                '  white-space: normal !important;' +
                '  overflow: visible !important;' +
                '  text-overflow: clip !important;' +
                '  font-weight: bold !important;' +
                '  font-size: 11px !important;' +
                '  line-height: 1.15 !important;' +
                '}' +
                '#WellFieldModal select, #WellFieldModal select.form-control,' +
                '#WellFieldModal input[type="number"], #WellFieldModal input[type="number"].form-control,' +
                '#WellFieldModal input[type="text"], #WellFieldModal input[type="text"].form-control {' +
                '  color-scheme: dark !important;' +
                '  background-color: #24180d !important;' +
                '  background-image: linear-gradient(to bottom, #2e2012 0%, #1c130a 100%) !important;' +
                '  color: #f7e2be !important;' +
                '  text-shadow: none !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  box-shadow: inset 0 1px 3px rgba(0,0,0,0.7) !important;' +
                '  border-radius: 4px !important;' +
                '}' +
                '#WellFieldModal select:focus, #WellFieldModal select.form-control:focus,' +
                '#WellFieldModal input[type="number"]:focus, #WellFieldModal input[type="number"].form-control:focus,' +
                '#WellFieldModal input[type="text"]:focus, #WellFieldModal input[type="text"].form-control:focus {' +
                '  border-color: #d4a34b !important;' +
                '  box-shadow: 0 0 6px rgba(212,163,75,0.7), inset 0 1px 3px rgba(0,0,0,0.8) !important;' +
                '  outline: none !important;' +
                '}' +
                '#WellFieldModal .WF_select {' +
                '  position: relative !important;' +
                '  display: block !important;' +
                '  width: 100% !important;' +
                '  height: 28px !important;' +
                '  line-height: 22px !important;' +
                '  padding: 2px 22px 2px 6px !important;' +
                '  font-size: 12px !important;' +
                '  cursor: pointer !important;' +
                '  background-color: #24180d !important;' +
                '  background-image: linear-gradient(to bottom, #2e2012 0%, #1c130a 100%) !important;' +
                '  color: #f7e2be !important;' +
                '  text-shadow: none !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  box-shadow: inset 0 1px 3px rgba(0,0,0,0.7) !important;' +
                '  border-radius: 4px !important;' +
                '  -webkit-user-select: none !important;' +
                '  user-select: none !important;' +
                '}' +
                '#WellFieldModal .WF_select:hover, #WellFieldModal .WF_select.open {' +
                '  border-color: #d4a34b !important;' +
                '  box-shadow: 0 0 6px rgba(212,163,75,0.6), inset 0 1px 3px rgba(0,0,0,0.8) !important;' +
                '}' +
                '#WellFieldModal .WF_selectLabel {' +
                '  display: block !important;' +
                '  overflow: hidden !important;' +
                '  white-space: nowrap !important;' +
                '  text-overflow: ellipsis !important;' +
                '  color: #f7e2be !important;' +
                '}' +
                '#WellFieldModal .WF_caret {' +
                '  position: absolute !important;' +
                '  top: 50% !important;' +
                '  right: 7px !important;' +
                '  margin-top: -2px !important;' +
                '  width: 0 !important;' +
                '  height: 0 !important;' +
                '  border-left: 4px solid transparent !important;' +
                '  border-right: 4px solid transparent !important;' +
                '  border-top: 5px solid #d9b477 !important;' +
                '}' +
                '#WellFieldModal .WF_selectMenu {' +
                '  display: none !important;' +
                '  position: absolute !important;' +
                '  z-index: 2050 !important;' +
                '  top: 100% !important;' +
                '  left: -1px !important;' +
                '  right: -1px !important;' +
                '  margin-top: 2px !important;' +
                '  max-height: 168px !important;' +
                '  overflow-y: auto !important;' +
                '  overflow-x: hidden !important;' +
                '  background-color: #24180d !important;' +
                '  background-image: linear-gradient(to bottom, #2e2012 0%, #1c130a 100%) !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  border-radius: 4px !important;' +
                '  box-shadow: 0 4px 10px rgba(0,0,0,0.75) !important;' +
                '}' +
                '#WellFieldModal .WF_select.open .WF_selectMenu { display: block !important; }' +
                '#WellFieldModal .WF_selectOption {' +
                '  padding: 3px 8px !important;' +
                '  background: transparent !important;' +
                '  color: #f7e2be !important;' +
                '  white-space: nowrap !important;' +
                '  overflow: hidden !important;' +
                '  text-overflow: ellipsis !important;' +
                '}' +
                '#WellFieldModal .WF_selectOption:hover { background: #7c5828 !important; color: #fff3d8 !important; }' +
                '#WellFieldModal .WF_selectOption.selected { background: rgba(124,88,40,0.55) !important; color: #fff3d8 !important; }' +
                '#WellFieldModal .WF_headerContent b, #WellFieldModal #WF_statusInfo { color: #f7e2be !important; }' +
                '</style>'
            );

            var wellItems = BUILDING_DEFINITIONS.wells.map(function (w) {
                return { value: w.id, text: Loca.buildingName(w.name) };
            });

            var fieldItems = BUILDING_DEFINITIONS.fields.map(function (f) {
                return { value: f.id, text: Loca.buildingName(f.name) };
            });

            var filterItems = [
                { value: 'all', text: Loca.all() },
                { value: 'wells', text: Loca.wellsOnly() },
                { value: 'fields', text: Loca.fieldsOnly() }
            ];

            var rowControls = createTableRow([
                [4, '<div style="margin-bottom:3px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + getImageTag('Water', '18px', '18px') + ' <b>' + Loca.type() + '</b></div>' +
                    Dropdown.render('WF_selectWellType', wellItems, parseInt(State.config.selectedWellType, 10))],
                [4, '<div style="margin-bottom:3px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + getImageTag('Corn', '18px', '18px') + ' <b>' + Loca.type() + '</b></div>' +
                    Dropdown.render('WF_selectFieldType', fieldItems, parseInt(State.config.selectedFieldType, 10))],
                [4, '<div style="margin-bottom:3px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><b>' + Loca.filter() + '</b></div>' +
                    Dropdown.render('WF_selectFilter', filterItems, State.config.filterMode)]
            ], false);

            var autoModeSwitch = '<div class="WF_autoModeBox" style="margin-top:5px;">' +
                createSwitch('WF_AutoModeSwitch', State.config.autoMode) +
                '<span class="WF_autoModeLabel" title="' + Loca.massConstruction() + '">' + Loca.massConstruction() + '</span></div>';

            // var countInput = '<div style="margin-top:7px;white-space:nowrap;"><b>' + Loca.amount() + '</b> ' +
            //     '<input type="number" id="WF_inputCount" class="form-control" style="display:inline-block;width:55px;height:26px;padding:2px 4px;" min="0" value="0"></div>';

            var rowActions = createTableRow([
                // [2, countInput],
                [3, '<button class="btn btn-sm btn-info btn-block" id="WF_btnSelectQueue" style="margin-top:4px;padding:4px 4px;font-size:11px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + Loca.fillQueue() + '</button>'],
                [3, '<button class="btn btn-sm btn-primary btn-block" id="WF_btnSelectAll" style="margin-top:4px;padding:4px 4px;font-size:11px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + Loca.selectAll() + '</button>'],
                [4, autoModeSwitch]
            ], false);

            var rowStatus = createTableRow([
                [12, '<div id="WF_statusInfo" style="padding:2px 0;font-size:12px;color:#eee;"></div>']
            ], false);

            var rowHeader = createTableRow([
                [4, '<div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + Loca.colName() + '</div>'],
                [2, 'Grid'],
                [4, '<div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="' + Loca.colRebuild() + '">' + Loca.colRebuild() + '</div>'],
                [2, '<div style="text-align:right;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="' + Loca.colVisit() + '">' + Loca.colVisit() + '</div>']
            ], true);

            $('#WellFieldModal .modal-header .WF_headerContent').remove();
            $('#WellFieldModal .modal-header').append(
                '<div class="container-fluid WF_headerContent" style="margin-top:10px;">' +
                rowControls +
                '<div style="margin-top:6px;"></div>' +
                rowActions +
                '<div style="margin-top:4px;"></div>' +
                rowStatus +
                '<div style="margin-top:6px;"></div>' +
                rowHeader +
                '</div>'
            );
        },

        renderFooter: function () {
            var footer = $('#WellFieldModal .modal-footer');
            footer.find('.WF_btn').remove();

            footer.prepend([
                $('<button>').attr({ 'class': 'btn btn-primary pull-left WF_btn WF_saveTemplate' }).text(getText('save_template')),
                $('<button>').attr({ 'class': 'btn btn-primary pull-left WF_btn WF_loadTemplate' }).text(getText('load_template')),
                $('<button>').attr({ 'class': 'btn btn-warning WF_btn WF_btnReset' }).text(getText('btn_reset')),
                $('<button>').attr({ 'class': 'btn btn-success WF_btn WF_btnSubmit' }).text(getText('btn_submit'))
            ]);
        },

        refreshData: function () {
            State.depletedList = Core.scanDepletedDeposits();
            var visible = this.getVisibleItems();

            var html = '<div class="container-fluid" style="overflow-x:hidden;padding-right:15px;padding-left:15px;height: auto">';
 
            if (visible.length === 0) {
                html += '<div style="text-align:center;color:#999;padding:65px 0;font-size:13px;">' +
                    getText('NoData') + '</div>';
            } else {
                visible.forEach(function (item) {
                    var iconImg = getImageTag(item.icon, '20px', '20px');
                    var isChecked = State.selectedGrids.indexOf(item.grid) !== -1 ? ' checked' : '';
                    var checkbox = '<input type="checkbox" class="WF_gridCheckbox" id="WF_cb_' + item.grid + '" data-grid="' + item.grid + '"' + isChecked + ' />';
                    var gotoBtn = getImageTag('accuracy.png', '20px', '20px')
                        .replace('<img', '<img class="WF_gotoGrid" data-grid="' + item.grid + '"')
                        .replace('style="', 'style="cursor: pointer;');

                    html += createTableRow([
                        [4, '<div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + iconImg + ' ' + item.locName + '</div>'],
                        [2, item.grid],
                        [4, checkbox],
                        [2, '<div style="text-align: right;">' + gotoBtn + '</div>']
                    ], false);
                });
            }

            html += '</div>';
            $('#WellFieldModalData').html(html);

            var freeSlots = Core.getFreeQueueSlots();
            $('#WF_inputCount').attr('max', visible.length);
            $('#WF_inputCount').val(State.selectedGrids.length);
            $('#WF_statusInfo').html(
                Loca.depletedFound() + ': <b>' + visible.length + '</b> &nbsp;|&nbsp; ' +
                Loca.queueSlotsFree() + ': <b>' + freeSlots + '</b>'
            );

            // Re-fit the modal to the new content height (e.g. after filtering).
            if (typeof Layout !== 'undefined' && Layout && Layout.apply) {
                Layout.apply();
            }
        },

        updateSelectionUI: function () {
            $('.WF_gridCheckbox').each(function () {
                var grid = parseInt($(this).attr('data-grid'), 10);
                $(this).prop('checked', State.selectedGrids.indexOf(grid) !== -1);
            });
            $('#WF_inputCount').val(State.selectedGrids.length);
        },

        bindEvents: function () {
            var self = this;

            Dropdown.bind('WF_selectWellType', function (value) {
                State.config.selectedWellType = parseInt(value, 10);
                State.saveSettings();
            });

            Dropdown.bind('WF_selectFieldType', function (value) {
                State.config.selectedFieldType = parseInt(value, 10);
                State.saveSettings();
            });

            Dropdown.bind('WF_selectFilter', function (value) {
                State.config.filterMode = value;
                State.saveSettings();
                self.refreshData();
                self.bindGridEvents();
            });

            $('#WF_AutoModeSwitch').off('change').on('change', function () {
                State.config.autoMode = $(this).is(':checked');
                State.saveSettings();
            });

            $('#WF_btnSelectAll').off('click').on('click', function () {
                var visible = self.getVisibleItems();
                State.selectedGrids = visible.map(function (item) { return item.grid; });
                self.updateSelectionUI();
            });

            $('#WF_btnSelectQueue').off('click').on('click', function () {
                var free = Core.getFreeQueueSlots();
                var visible = self.getVisibleItems();
                State.selectedGrids = [];
                for (var i = 0; i < visible.length && i < free; i++) {
                    State.selectedGrids.push(visible[i].grid);
                }
                self.updateSelectionUI();
            });

            $('#WF_inputCount').off('input change').on('input change', function () {
                var count = parseInt($(this).val(), 10) || 0;
                var visible = self.getVisibleItems();
                if (count > visible.length) count = visible.length;
                if (count < 0) count = 0;
                State.selectedGrids = [];
                for (var i = 0; i < count; i++) {
                    State.selectedGrids.push(visible[i].grid);
                }
                self.updateSelectionUI();
            });

            $('#WellFieldModal .WF_btnReset').off('click').on('click', function () {
                State.selectedGrids = [];
                self.updateSelectionUI();
            });

            $('#WellFieldModal .WF_saveTemplate').off('click').on('click', function () {
                if (State.templateHandler) {
                    State.templateHandler.save(State.selectedGrids);
                }
            });

            $('#WellFieldModal .WF_loadTemplate').off('click').on('click', function () {
                if (State.templateHandler) {
                    State.templateHandler.load();
                }
            });

            $('#WellFieldModal .WF_btnSubmit').off('click').on('click', function () {
                $('#WellFieldModal').modal('hide');
                if (State.selectedGrids.length === 0) {
                    game.showAlert(Loca.noSelection());
                    return;
                }

                if (State.config.autoMode) {
                    Core.startAutoQueue(State.selectedGrids.slice());
                } else {
                    Core.executeBatchBuild(State.selectedGrids.slice());
                }
            });

            self.bindGridEvents();
        },

        bindGridEvents: function () {
            $('.WF_gridCheckbox').off('click').on('click', function () {
                var grid = parseInt($(this).attr('data-grid'), 10);
                var checked = $(this).prop('checked');
                var idx = State.selectedGrids.indexOf(grid);
                if (checked && idx === -1) {
                    State.selectedGrids.push(grid);
                } else if (!checked && idx !== -1) {
                    State.selectedGrids.splice(idx, 1);
                }
                $('#WF_inputCount').val(State.selectedGrids.length);
            });

            $('.WF_gotoGrid').off('click').on('click', function () {
                var grid = parseInt($(this).attr('data-grid'), 10);
                try {
                    $('#WellFieldModal').modal('hide');
                    swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(grid);
                } catch (e) {
                    debug(e);
                }
            });
        }
    };

    // --- Module: Adaptive Layout ---
    // Keeps the modal height driven by its own content, but never taller than the game area.
    var Layout = {
        resizeTimer: null,

        getStageHeight: function () {
            var selectors = ['#globalContainer', '#gameContainer', '#swmmoContainer', '#swmmo', '#game', 'canvas'];
            var best = 0;
            for (var i = 0; i < selectors.length; i++) {
                var $el = $(selectors[i]).first();
                if ($el.length) {
                    var h = $el.outerHeight() || 0;
                    if (h > best) best = h;
                }
            }

            var winH = $(window).height() || 0;
            var docH = (document.documentElement && document.documentElement.clientHeight) || 0;
            var viewport = 0;
            if (winH > 0 && docH > 0) viewport = Math.min(winH, docH);
            else viewport = Math.max(winH, docH);

            if (best <= 0 || (viewport > 0 && best > viewport)) best = viewport;
            return best > 0 ? best : 600;
        },

        apply: function () {
            var $modal = $('#WellFieldModal');
            if (!$modal.length) return;

            var stage = this.getStageHeight();
            var available = Math.max(240, stage - 24);
            var $dialog = $modal.find('.modal-dialog');
            var $content = $modal.find('.modal-content');
            var $body = $modal.find('.modal-body');

            $dialog.css({ 'max-height': available + 'px' });
            $content.css({ 'height': 'auto', 'max-height': available + 'px','min-height': 100 + 'px' });

            // Measure the natural content height first, then cap it.
            $body.css({ 'height': 'auto', 'max-height': 'none' });

            var header = $modal.find('.modal-header').outerHeight(true) || 0;
            var footer = $modal.find('.modal-footer').outerHeight(true) || 0;
            var bodyMin = Math.min(180, Math.max(60, available - header - footer - 12));
            var bodyMax = Math.max(bodyMin, available - header - footer - 12);
            var natural = ($body.length && $body[0]) ? $body[0].scrollHeight : 0;

            if ($body.length && $body[0]) {
                $body[0].style.setProperty('min-height', bodyMin + 'px', 'important');
            }

            $body.css({
                'max-height': bodyMax + 'px',
                'height': (natural > 0 && natural <= bodyMax) ? 'auto' : bodyMax + 'px',
                'overflow-y': (natural > bodyMax) ? 'auto' : 'hidden'
            });

            // Center the window vertically inside the game stage.
            // The stylesheet uses "margin: 12px auto !important", so the offset has
            // to be written as an important inline style to win.
            var dialogEl = $dialog.length ? $dialog[0] : null;
            if (dialogEl) {
                var dialogHeight = $content.outerHeight(true) || 0;
                var top = Math.round(((stage - dialogHeight) / 2) - 50);
                if (!(top > 8)) top = 8;
                dialogEl.style.setProperty('margin-top', top + 'px', 'important');
                dialogEl.style.setProperty('margin-bottom', '8px', 'important');
            }
        },

        attach: function () {
            var self = this;
            var $modal = $('#WellFieldModal');

            $modal.off('shown.bs.modal.wfLayout').on('shown.bs.modal.wfLayout', function () {
                self.apply();
            });

            $modal.off('hidden.bs.modal.wfLayout').on('hidden.bs.modal.wfLayout', function () {
                $(window).off('resize.wfLayout');
            });

            $(window).off('resize.wfLayout').on('resize.wfLayout', function () {
                clearTimeout(self.resizeTimer);
                self.resizeTimer = setTimeout(function () { self.apply(); }, 120);
            });

            self.apply();
            setTimeout(function () { self.apply(); }, 60);
        }
    };

    // --- Module: Entry Point ---
    function openModalHandler(event) {
        if (!game.gi.isOnHomzone()) {
            game.showAlert(getText('not_home'));
            return;
        }

        $("div[role='dialog']:not(#WellFieldModal):visible").modal("hide");
        $('#WellFieldModal').remove();

        var titleWithIcons = getImageTag('Water', '24px', '24px') + ' ' +
                             getImageTag('Corn', '24px', '24px') + ' ' +
                             Loca.title();

        createModalWindow('WellFieldModal', titleWithIcons);

        State.templateHandler = new SaveLoadTemplate('wf', function (data, name) {
            $("#WellFieldModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
            if (Array.isArray(data)) {
                State.selectedGrids = [];
                data.forEach(function (grid) {
                    if (State.depletedList.some(function (d) { return d.grid === grid; })) {
                        State.selectedGrids.push(grid);
                    }
                });
                UI.updateSelectionUI();
            }
        });

        UI.renderHeader();
        UI.refreshData();
        UI.renderFooter();
        UI.bindEvents();

        $('#WellFieldModal:not(:visible)').modal({
            backdrop: "static"
        });

        Layout.attach();
    }

    // Register script in client tools menu
    addToolsMenuItem(Loca.title(), openModalHandler);

})();