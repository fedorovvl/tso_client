/**
 * Explorer Time Matrix for TSO client
 * v1.0
 *
 * Created by
 * .▄▄ ·  ▄▄▄· .▄▄ ·     .▄▄ ·  ▄▄▄· • ▌ ▄ ·.
 * ▐█ ▀. ▐█ ▀█ ▐█ ▀.     ▐█ ▀. ▐█ ▀█ ·██ ▐███▪
 * ▄▀▀▀█▄▄█▀▀█ ▄▀▀▀█▄    ▄▀▀▀█▄▄█▀▀█ ▐█ ▌▐▌▐█·
 * ▐█▄▪▐█▐█ ▪▐▌▐█▄▪▐█    ▐█▄▪▐█▐█ ▪▐▌██ ██▌▐█▌
 *  ▀▀▀▀  ▀  ▀  ▀▀▀▀      ▀▀▀▀  ▀  ▀ ▀▀  █▪▀▀▀
 *
 * You can find me on Discord (sas_sam).
 *
 * If you like my work, you can support me: https://ko-fi.com/sas_sam
 *
 */
var ExplorerTimeMatrix_PFB_RB_STATUS = false;
var ExplorerTimeMatrix_ADV_RB_STATUS = false;

function ExplorerTimeMatrix() {
    this.init = function () {
      this.extensionName = "Explorer Time Matrix";

      this.setTranslates();
      this.setConfig();
    };

    this.setConfig = function () {
      this.config = {
            extensionNamePrefix: 'explorerTimeMatrix',
            modal: {
                isVisible: function() { $('#ExplorerTimeMatrixModal').is(':visible'); },
                name: "ExplorerTimeMatrixModal",
            },
            Enums: {
              specTypes: {
                EXPLORER: 1,
                GEOLOGIST: 2,
              }
            }
        };

        var _prefix = this.config.extensionNamePrefix;
        var elements = {
          PFB_RADIO: _prefix + '_PFB_Status',
          PFB_RADIO_TEXT: _prefix + '_PFB_StatusText',
          ADV_RADIO: _prefix + '_Adv_Status',
          ADV_RADIO_TEXT: _prefix + '_Adv_StatusText',
          TREASURE_TIMES: 'treasureTimes',
          ADVENTURE_TIMES: 'adventureTimes',
          PFB_TIMES: 'pfbTimes',
          NORMAL_TIMES: 'normalTimes',
        };

        var icons = {
          FIND_ADVENTURE: 'ButtonIconFindAdventure',
          FIND_TREASURE: 'ButtonIconFindTreasure',
          TASK_SHORT: 'ButtonIconTaskShort',
          TASK_MEDIUM: 'ButtonIconTaskMedium',
          TASK_LONG: 'ButtonIconTaskLong',
          TASK_VERY_LONG: 'ButtonIconTaskEvenLonger',
          TASK_PROLONG: 'ButtonIconTaskLongest',
          TASK_ARTIFACT: 'ButtonIconTravellingErudite', // icon_travelling_erudite.png
          TASK_RARITY: 'ButtonIconBeanACollada',  // icon_bean_a_colada.png
          PFB: 'MultiplierBuffZone2_PremiumFriendBuff1Day'
        };

        var texts = {
          FIND_ADVENTURE: getImageTag(icons.FIND_ADVENTURE, '25px') + ' ' + loca.GetText("LAB", "SpecialistTaskFindAdventureZone"),
          FIND_TREASURE: getImageTag(icons.FIND_TREASURE, '25px') + ' ' + loca.GetText("LAB", "FindTreasure"),
          SHOW_NORMAL_TIMES: getText('normal_times', 'ExplorerTimeMatrixTranslates'),
          SHOW_PFB_TIMES: getImageTag(icons.PFB, '25px') + ' ' + getText('pfb_times', 'ExplorerTimeMatrixTranslates')
        };

        var specs = {
          'treasures' : [
            { 'val': '1,0', 'text': loca.GetText("LAB", "FindTreasureShort"), 'req': [0,0,8], icon: icons.TASK_SHORT },
            { 'val': '1,1', 'text': loca.GetText("LAB", "FindTreasureMedium"), 'req': [0,0,20], icon: icons.TASK_MEDIUM },
            { 'val': '1,2', 'text': loca.GetText("LAB", "FindTreasureLong"), 'req': [0,0,32], icon: icons.TASK_LONG },
            { 'val': '1,3', 'text': loca.GetText("LAB", "FindTreasureEvenLonger"), 'req': [0,0,40], icon: icons.TASK_VERY_LONG },
             { 'val': '1,6', 'text': loca.GetText("LAB", "FindTreasureLongest"), 'req': [0,0,54], icon: icons.TASK_PROLONG },
            { 'val': '1,4', 'text': loca.GetText("LAB", "FindTreasureTravellingErudite"), 'req': [1,0,0], icon: icons.TASK_ARTIFACT },
            { 'val': '1,5', 'text': loca.GetText("LAB", "FindTreasureBeanACollada"), 'req': [0,1,0], icon: icons.TASK_RARITY }
          ],
          'adventures': [
            { 'val': '2,0', 'text': loca.GetText("LAB", "FindAdventureZoneShort"), 'req': [0,0,26], icon: icons.TASK_SHORT },
            { 'val': '2,1', 'text': loca.GetText("LAB", "FindAdventureZoneMedium"), 'req': [0,0,36], icon: icons.TASK_MEDIUM },
            { 'val': '2,2', 'text': loca.GetText("LAB", "FindAdventureZoneLong"), 'req': [0,0,42], icon: icons.TASK_LONG },
            { 'val': '2,3', 'text': loca.GetText("LAB", "FindAdventureZoneVeryLong"), 'req': [0,0,56], icon: icons.TASK_VERY_LONG }
          ]
        };

        this.config.elements = elements;
        this.config.icons = icons;
        this.config.texts = texts;
        this.config.specs = specs;
    };

    this.setTranslates = function () {
      var translates = {
        'en-uk': {
            'normal_times' : 'Normal times',
            'pfb_times' : 'PFB times',
        },
        'en-us': {
          'normal_times' : 'Normal times',
          'pfb_times' : 'PFB times',
        },
        'de-de': {
          'normal_times' : 'Normale Zeiten',
          'pfb_times' : 'PFB Zeiten',
        }
      };

      extendBaseLang(translates, 'ExplorerTimeMatrixTranslates');
    };

    this.isHome = function () {
        if (!game.gi.isOnHomzone()) {
            game.showAlert(getText("not_home"));
            return false;
        }

        return true;
    };

    this.makeModal = function (event) {
        var namePrefix = this.config.extensionNamePrefix;
        var out = "";

        out += '<div id="' + namePrefix + 'Result"></div>';

        return out;
    };

    this.setModalHeaderFooter = function () {
        var _this = this;
        var modalName = this.config.modal.name;
        var namePrefix = this.config.extensionNamePrefix;
        var elements = this.config.elements;
        var treasures = this.config.specs.treasures;
        var adventures = this.config.specs.adventures;

        var headerRow1 = createTableRow([
          [3, createSwitch(
                elements.PFB_RADIO,
                ExplorerTimeMatrix_PFB_RB_STATUS
              ) +
                '<div style="position: absolute;left: 55px;top: 1px;" id="' +
                elements.PFB_RADIO_TEXT +
                '">{0}</div>'.format(
                  ExplorerTimeMatrix_PFB_RB_STATUS ? _this.config.texts.SHOW_PFB_TIMES : _this.config.texts.SHOW_NORMAL_TIMES
                )],
          [3, createSwitch(
            elements.ADV_RADIO,
            ExplorerTimeMatrix_ADV_RB_STATUS
          ) +
            '<div style="position: absolute;left: 55px;top: 1px;" id="' +
            elements.ADV_RADIO_TEXT +
            '">{0}</div>'.format(
              ExplorerTimeMatrix_ADV_RB_STATUS ? _this.config.texts.FIND_ADVENTURE : _this.config.texts.FIND_TREASURE
            )],
          [6, '']
        ], true);

        // treasure
        var _treasure = '<table style="width: 100%;"><tbody><tr>';
        treasures.forEach(function(item) {
          _treasure += '<td style="width: 14.2%; color:#fff; font-size: 11px;">' + getImageTag(item.icon, '25px') + '</td>';
        });
        _treasure += '</tr></tbody></table>';

        // adventure
        var _adventure = '<table style="width: 100%;"><tbody><tr>';
        adventures.forEach(function(item) {
          _adventure += '<td style="width: 25%; color:#fff; font-size: 11px;">' + getImageTag(item.icon, '25px') + '</td>';
        });
        _adventure += '</tr></tbody></table>';

        var headerRow2 = createTableRow([
                [3, loca.GetText("LAB","Name")],
                [9, _treasure, elements.TREASURE_TIMES],
                [9, _adventure, elements.ADVENTURE_TIMES]
          ], true);

        $("#" + modalName + " .modal-header").append([$('<br/>'), $('<div>', {'class': 'depletedInfo text-center'}), $('<div>', {'class': 'container-fluid'}).html(headerRow1 + headerRow2)]);
    };

    this._isPFBActive = function() {
      game.gi.mZoneBuffManager.isBuffRunning("MultiplierBuffZone2_PremiumFriendBuff1Day")
    };

    this.getAvailableExplorers = function () {
      var _this = this;
      var availableExplorers = [];

      game
        .getSpecialists()
        .sort(specNameSorter)
        .forEach(function (item) {
          if (
            //item.GetTask() !== null ||
            item.GetBaseType() !== _this.config.Enums.specTypes.EXPLORER ||
            item.getPlayerID() === -1
          ) {
            return;
          }

          availableExplorers.push(item);
        });

        this.totalExplorers = availableExplorers.length;

        return availableExplorers;
    };

    this.getTaskDuration = function (task, explorer) {
      var calculatedTime = task.duration; // without any books
      var vectorIndex;

      try {
        // Checking books
        explorer.getSkillTree().getItems_vector().concat(explorer.skills.getItems_vector()).forEach(function(skill) {
          vectorIndex = skill.getLevel() - 1;
          if(vectorIndex == -1) { return; }
          skill.getDefinition().level_vector[vectorIndex].forEach(function(skillDef) {
            if ((((skillDef.type_string.length === 0) || (skillDef.type_string == task.taskName + task.subTaskName)) && (skillDef.modifier_string.toLowerCase() == "searchtime"))) {
              calculatedTime = (skillDef.value != 0) ? skillDef.value : ((calculatedTime * skillDef.multiplier) + skillDef.adder);
            }
          });
        });
      } catch (error) {
        //
      }

      // Checking any other bonuses (PFB)
      calculatedTime = (calculatedTime / explorer.GetSpecialistDescription().GetTimeBonus()) * 100;

      return calculatedTime;
    };

    this.setModalBindings = function () {
      var _this = this;
      var modalName = this.config.modal.name;
      var namePrefix = this.config.extensionNamePrefix;
      var elements = this.config.elements;

      $("#" + elements.PFB_RADIO).change(function(){
        if ($(this).is(':checked')) {
            $("#" + elements.PFB_RADIO_TEXT).html(_this.config.texts.SHOW_PFB_TIMES);
            ExplorerTimeMatrix_PFB_RB_STATUS = true;
            $('.' + elements.NORMAL_TIMES).hide();
            $('.' + elements.PFB_TIMES).show();
        } else {
          $("#" + elements.PFB_RADIO_TEXT).html(_this.config.texts.SHOW_NORMAL_TIMES);
          ExplorerTimeMatrix_PFB_RB_STATUS = false;
          $('.' + elements.PFB_TIMES).hide();
          $('.' + elements.NORMAL_TIMES).show();
        }
      });

      $("#" + elements.ADV_RADIO).change(function(){
        if ($(this).is(':checked')) {
          $("#" + elements.ADV_RADIO_TEXT).html(_this.config.texts.FIND_ADVENTURE);
          ExplorerTimeMatrix_ADV_RB_STATUS = true;
          $('.' + elements.TREASURE_TIMES).hide();
          $('.' + elements.ADVENTURE_TIMES).show();
        } else {
          $("#" + elements.ADV_RADIO_TEXT).html(_this.config.texts.FIND_TREASURE);
          ExplorerTimeMatrix_ADV_RB_STATUS = false;
          $('.' + elements.ADVENTURE_TIMES).hide();
          $('.' + elements.TREASURE_TIMES).show();
        }
      });
    };

    this.updateModalData = function() {
        var _this = this;
        var modalName = this.config.modal.name;
        var namePrefix = this.config.extensionNamePrefix;
        var elements = this.config.elements;
        var treasures = this.config.specs.treasures;
        var adventures = this.config.specs.adventures;
        var out = '';

        if (_this.isHome()) {
          var playerLevel = game.player.GetPlayerLevel();
          var availableExplorers = this.getAvailableExplorers();
          // var explorers = [];

          availableExplorers.forEach(function(explorer) {
            var name = explorer.getName(false);
            var skills = [];
            var skillArtifact = false;
            var skillRarity = false;
            var treasureTimes = '<table style="width: 100%;"><tbody>';
            var adventureTimes = '<table style="width: 100%;"><tbody>';

            explorer.getSkillTree().getItems_vector().forEach(function (skill) {
              skills[skill.getId()] = skill.getLevel() > 0;
            });

            skillArtifact = skills[39];
            skillRarity = skills[40];

            treasureTimes += '<tr>';
            treasures.forEach(function(item) {
              var cat_id = item.val.split(",");
              var task = getTaskInfo(cat_id[0], cat_id[1]);
              var calculatedTime = _this.getTaskDuration(task, explorer);
              var enabled = ((item.req[0] && skillArtifact) || (item.req[1] && skillRarity) || (!item.req[0] && !item.req[1] && playerLevel >= item.req[2]));

              var normalTime = calculatedTime;
              var normalTimeArrival = calculatedTime;
              var pfbTime = calculatedTime;
              var pfbTimeArrival = calculatedTime;

              if (_this._isPFBActive()) {
                normalTime = loca.FormatDuration(calculatedTime / 0.8, 1);
                normalTimeArrival = dtf.format(new window.runtime.Date(Date.now() + normalTime));

                pfbTime = loca.FormatDuration(calculatedTime, 1);
                pfbTimeArrival = dtf.format(new window.runtime.Date(Date.now() + pfbTime));
              } else {
                normalTime = loca.FormatDuration(calculatedTime, 1);
                normalTimeArrival = dtf.format(new window.runtime.Date(Date.now() + calculatedTime));

                pfbTime = loca.FormatDuration(calculatedTime * 0.8, 1);
                pfbTimeArrival = dtf.format(new window.runtime.Date(Date.now() + pfbTime));
              }

              treasureTimes += '<td style="width: 14.2%; color:#fff; font-size: 12px;"><span style="' + (enabled ? '' : 'color: #888;') + '"><span class="' + elements.NORMAL_TIMES + '" data-toggle="tooltip" data-placement="top" title="' + normalTimeArrival + '" data-original-title="' + normalTimeArrival + '">' + normalTime + '</span><span class="' + elements.PFB_TIMES + '" data-toggle="tooltip" data-placement="top" title="' + pfbTimeArrival + '" data-original-title="' + pfbTimeArrival + '">' + pfbTime + '</span></span></td>';
            });

            treasureTimes += '</tr>';

            adventureTimes += '<tr>';
            adventures.forEach(function(item) {
              var cat_id = item.val.split(",");
              var task = getTaskInfo(cat_id[0], cat_id[1]);
              var calculatedTime = _this.getTaskDuration(task, explorer);
              var enabled = ((item.req[0] && art) || (item.req[1] && bean) || (!item.req[0] && !item.req[1] && playerLevel >= item.req[2]));

              var normalTime = calculatedTime;
              var normalTimeArrival = calculatedTime;
              var pfbTime = calculatedTime;
              var pfbTimeArrival = calculatedTime;

              if (_this._isPFBActive()) {
                normalTime = loca.FormatDuration(calculatedTime / 0.8, 1);
                normalTimeArrival = dtf.format(new window.runtime.Date(Date.now() + normalTime));

                pfbTime = loca.FormatDuration(calculatedTime, 1);
                pfbTimeArrival = dtf.format(new window.runtime.Date(Date.now() + pfbTime));
              } else {
                normalTime = loca.FormatDuration(calculatedTime, 1);
                normalTimeArrival = dtf.format(new window.runtime.Date(Date.now() + calculatedTime));

                pfbTime = loca.FormatDuration(calculatedTime * 0.8, 1);
                pfbTimeArrival = dtf.format(new window.runtime.Date(Date.now() + pfbTime));
              }

              adventureTimes += '<td style="width: 25%; color:#fff; font-size: 12px;"><span style="' + (enabled ? '' : 'color: #888;') + '"><span class="' + elements.NORMAL_TIMES + '" data-toggle="tooltip" data-placement="top" title="' + normalTimeArrival + '" data-original-title="' + normalTimeArrival + '">' + normalTime + '</span><span class="' + elements.PFB_TIMES + '" data-toggle="tooltip" data-placement="top" title="' + pfbTimeArrival + '" data-original-title="' + pfbTimeArrival + '">' + pfbTime + '</span></span></td>';
            });

            adventureTimes += '</tr>';

            treasureTimes += '</tr></tbody></table>';
            adventureTimes += '</tr></tbody></table>';

            out += createTableRow([
              [3, name],
              [9, treasureTimes, elements.TREASURE_TIMES],
              [9, adventureTimes, elements.ADVENTURE_TIMES]
            ]);
          });

          $('#' + namePrefix + 'Result').append(out);
          $('[data-toggle="tooltip"]').tooltip();
        }
    };
}

explorerTimeMatrixMenuHandler = function (event) {
  if (!explorerTimeMatrix.isHome()) {
		game.showAlert(getText('not_home'));
    return false;
  }

  var modalName = explorerTimeMatrix.config.modal.name;
  var namePrefix = explorerTimeMatrix.config.extensionNamePrefix;
  var elements = explorerTimeMatrix.config.elements;

  try {
    $("div[role='dialog']:not(#" + modalName + "):visible").modal("hide");
    $("#" + modalName).remove();

    createModalWindow(modalName, explorerTimeMatrix.config.extensionName);

    $("#" + modalName + "Data").html(
      '<div class="container-fluid">{0}</div>'.format(explorerTimeMatrix.makeModal())
    );

    ExplorerTimeMatrix_PFB_RB_STATUS = explorerTimeMatrix._isPFBActive();

    explorerTimeMatrix.setModalHeaderFooter();

    explorerTimeMatrix.updateModalData();

    if (ExplorerTimeMatrix_PFB_RB_STATUS) {
      $('.' + elements.NORMAL_TIMES).hide();
      $('.' + elements.PFB_TIMES).show();
    } else {
      $('.' + elements.PFB_TIMES).hide();
      $('.' + elements.NORMAL_TIMES).show();
    }

    if ($("#" + elements.ADV_RADIO).is(':checked')) {
      $('.' + elements.TREASURE_TIMES).hide();
      $('.' + elements.ADVENTURE_TIMES).show();
    } else {
      $('.' + elements.ADVENTURE_TIMES).hide();
      $('.' + elements.TREASURE_TIMES).show();
    }

    explorerTimeMatrix.setModalBindings();

    $("#" + modalName + ":not(:visible)").modal({
        backdrop: "static",
    });

  } catch (error) {
      //
  }
};

var explorerTimeMatrix = new ExplorerTimeMatrix();
explorerTimeMatrix.init();

addToolsMenuItem(explorerTimeMatrix.extensionName, explorerTimeMatrixMenuHandler);
