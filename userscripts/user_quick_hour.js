(function () {
    if (specSharedHandler.__patched) return;
    var original = specSharedHandler;

    const quickHourUI    = {
        root: 'custom_quickHour',

        select: 'custom_quickHour_select',

        timeMode: {
            button: 'custom_quickHour_btn'
        },

        specGroup: {
            button: 'custom_quickHour_spec_btn'
        },

        selectedTime: 'custom_quickHour_selectedTime'
    };
    const quickHourModes = {
        TIME: {
            BEFORE: 0,
            AFTER_NEAREST: 1
        },
        SPEC_GROUP: {
            TREASURE: 0,
            ADVENTURES: 1
        }
    };

    var quickHourState = {
        'timeSearchMode': quickHourModes.TIME.AFTER_NEAREST,
        'specGroupMode': quickHourModes.SPEC_GROUP.TREASURE
    };


    specSharedHandler = function () {
        original.apply(this, arguments);

        if (specType === 1) {
            debug('new');
            if (!isQuickHourExists()){
                debug('start new logic');
                initQuickHourUI();
                bindQuickHourEvents();
                debug('hour added');
            }
        } else if (isQuickHourExists()) {
            $('#' + quickHourUI.root).remove();
        }
    };

    function initQuickHourUI() {
        var $modalHeader = $('#specModal').find('.modal-header .container-fluid');

        var $row  = $('<div>', {id: quickHourUI.root, 'class': 'row'});
        var $col1 = $('<div>', {
            'class': 'col-xs-10 col-sm-10 col-lg-10',
            'style': 'border-radius:10px 0px 0px 10px;text-align: right;'
        });
        var $col2 = $('<div>', {
            'class': 'col-xs-1 col-sm-1 col-lg-1 tblHeader',
            'style': 'border-radius:10px 0px 0px 10px;overflow:visible;'
        })
        var $col3 = $('<div>', {
            'class': 'col-xs-1 col-sm-1 col-lg-1 tblHeader',
            'style': 'border-radius:0px 10px 10px 0px;'
        });

        //specGroupModeBtn
        var $specGroupModeBtn = $(getImageTag(getIconName('specGroupMode'), '25px'))
            .css('cursor', 'pointer')
            .attr('id', quickHourUI.specGroup.button)
        var $specGroupModeTooltip = $('<div>', {
            css: {
                'display': 'inline-block'
            },
            'data-toggle': 'tooltip',
            'data-placement': 'top',
            title: loca.GetText("LAB", "FindTreasure")
        }).tooltip();

        //timeSeachBtn
        var $timeSearchBtn     = $(getImageTag(getIconName('timeSearch'), '25px'))
            .css('cursor', 'pointer')
            .attr('id', quickHourUI.timeMode.button)
        var $timeSearchTooltip = $('<div>', {
            css: {
                'display': 'inline-block',
                'margin-right': '5px'
            },
            'data-toggle': 'tooltip',
            'data-placement': 'top',
            title: '≈'
        }).tooltip();

        var selectedDateTimeLabel = $('<span>', {
            id: quickHourUI.selectedTime,
            style: 'text-align: right;'
        });

        var $select = $('<select>', {
            id: quickHourUI.select,
            name: quickHourUI.select,
            'class': 'form-control'
        });

        for (var i = 0; i < 24; i++) {
            var hour = (i < 10 ? '0' : '') + i;
            $select.append($('<option>', {value: hour, text: hour}));
        }

        $col1.append(selectedDateTimeLabel);
        $specGroupModeTooltip.append($specGroupModeBtn)
        $timeSearchTooltip.append($timeSearchBtn)
        $col2.append($timeSearchTooltip,$specGroupModeTooltip);
        $col3.append($select);
        $row.append($col1, $col2, $col3);
        $modalHeader.append($row);
    }

    function bindQuickHourEvents() {
        $('#' + quickHourUI.timeMode.button).on('click', function () {
            quickHourState.timeSearchMode =
                quickHourState.timeSearchMode === quickHourModes.TIME.BEFORE
                    ? quickHourModes.TIME.AFTER_NEAREST
                    : quickHourModes.TIME.BEFORE;

            this.src = $(getImageTag(getIconName('timeSearch'), '25px')).attr('src');
            if (quickHourState.timeSearchMode === quickHourModes.TIME.BEFORE) {
                $('#' + quickHourUI.timeMode.button).parent().attr('data-original-title', '≤').tooltip('fixTitle');
            } else {
                $('#' + quickHourUI.timeMode.button).parent().attr('data-original-title', '≈').tooltip('fixTitle');
            }
            applyClosestSkillsByHour();
        });

        $('#' + quickHourUI.specGroup.button).on('click', function (e) {
            quickHourState.specGroupMode = quickHourState.specGroupMode === quickHourModes.SPEC_GROUP.TREASURE
                ? quickHourModes.SPEC_GROUP.ADVENTURES
                : quickHourModes.SPEC_GROUP.TREASURE

            this.src = $(getImageTag(getIconName('specGroupMode'), '25px')).attr('src');
            if (quickHourState.specGroupMode === quickHourModes.SPEC_GROUP.TREASURE) {
                $('#' + quickHourUI.specGroup.button).parent().attr('data-original-title', loca.GetText("LAB", "FindTreasure")).tooltip('fixTitle');
            } else {
                $('#' + quickHourUI.specGroup.button).parent().attr('data-original-title', loca.GetText("LAB", "SpecialistTask7")).tooltip('fixTitle');
            }

            applyClosestSkillsByHour();
        });

        $('#' + quickHourUI.select)
            .off('change.quickHour')
            .on('change.quickHour', applyClosestSkillsByHour);
    }

    function isQuickHourExists(){
        if ($('#' + quickHourUI.root).length > 0) {
            return true;
        }
        return false;
    }

    function applyClosestSkillsByHour() {
        var hour = $('#' + quickHourUI.select).val();
        if (!hour) return;

        var targetDiff = getTargetDiffMinutesFromHour(hour);
        var nextTime   = getNextTargetDateTime(hour);
        var specs      = collectSpecData();
        debug(specs);

        $('#' + quickHourUI.selectedTime).text(nextTime);
        for (var i = 0; i < specs.length; i++) {
            var closestTaskId = pickClosestSkill(specs[i], targetDiff);

            if (closestTaskId) {
                specs[i].select.val(closestTaskId).trigger('change');
                updateSpecTimeRow(specs[i].select[0], specs[i].select.val(), specs[i].select.val());
            }
        }
    }

    function collectSpecData() {
        var result = [];

        $('#specModalData select').each(function () {
            var $select      = $(this);
            var $groups      = $select.find('optgroup');
            var $targetGroup = quickHourState.specGroupMode === quickHourModes.SPEC_GROUP.TREASURE
                ? $groups.eq(0)
                : $groups.eq(1);

            if (!$targetGroup.length) return;

            var skills = [];

            $targetGroup.find('option').each(function () {
                skills.push({
                    task_id: $(this).val()
                });
            });

            result.push({
                spec_id: $select.attr('id'),
                select: $select,
                skills: skills
            });
        });

        return result;
    }

    function pickClosestSkill(spec, targetDiff) {
        var closest = null;
        var minDiff = Infinity;

        for (var i = 0; i < spec.skills.length; i++) {
            var taskId          = spec.skills[i].task_id;
            var durationMinutes = getDurationTime(spec.spec_id, taskId);
            var diff            = Math.abs(durationMinutes - targetDiff);

            if (quickHourState.timeSearchMode === quickHourModes.TIME.BEFORE) {
                if (durationMinutes > targetDiff) {
                    continue;
                }
                diff = targetDiff - durationMinutes;
            } else {
                diff = Math.abs(durationMinutes - targetDiff);
            }

            if (diff < minDiff) {
                minDiff = diff;
                closest = taskId;
            }
        }
        return closest;
    }

    function getIconName(type) {
        if (type === 'timeSearch') {
            return quickHourState.timeSearchMode === quickHourModes.TIME.BEFORE ? 'ArrowRightScroll' : 'ArrowRightScrollHighlight';
        } else if (type === 'specGroupMode') {
            return quickHourState.specGroupMode === quickHourModes.SPEC_GROUP.ADVENTURES ? 'IconMailTypeAdventureLoot' : 'IconMailTypeLoot';
        }
    }

    function getTargetDiffMinutesFromHour(hourStr) {
        var now        = new Date();
        var nowMinutes = now.getHours() * 60 + now.getMinutes();

        var targetMinutes = parseInt(hourStr, 10) * 60;

        if (targetMinutes <= nowMinutes) {
            targetMinutes += 1440;
        }

        return targetMinutes - nowMinutes;
    }

    function getNextTargetDateTime(hourStr) {
        var now = new Date();

        var targetHour = parseInt(hourStr, 10);
        if (isNaN(targetHour) || targetHour < 0 || targetHour > 23) {
            throw new Error('Invalid hourStr');
        }

        var target = new Date(now);
        target.setHours(targetHour, 0, 0, 0);

        if (target <= now) {
            target.setDate(target.getDate() + 1);
        }

        var dd  = ('0' + target.getDate()).slice(-2);
        var mm  = ('0' + (target.getMonth() + 1)).slice(-2);
        var hh  = ('0' + target.getHours()).slice(-2);
        var min = ('0' + target.getMinutes()).slice(-2);

        return dd + '-' + mm + ' ' + hh + ':' + min;
    }

    function getDurationTime(spec_id, task_id) {
        var cat_id         = task_id.split(","),
            task           = getTaskInfo(cat_id[0], cat_id[1]);
        spec_id            = spec_id.split("_");
        var uniqueID       = game.def("Communication.VO::dUniqueID").Create(spec_id[0], spec_id[1]),
            spec           = game.zone.getSpecialist(game.gi.mCurrentViewedZoneID, uniqueID),
            calculatedTime = task.duration,
            vectorIndex;
        spec.getSkillTree().getItems_vector().concat(spec.skills.getItems_vector()).forEach(function (skill) {
            vectorIndex = skill.getLevel() - 1;
            if (vectorIndex == -1) {
                return;
            }
            skill.getDefinition().level_vector[vectorIndex].forEach(function (skillDef) {
                if ((((skillDef.type_string.length === 0) || (skillDef.type_string == task.taskName + task.subTaskName)) && (skillDef.modifier_string.toLowerCase() == "searchtime"))) {
                    calculatedTime = (skillDef.value != 0) ? skillDef.value : ((calculatedTime * skillDef.multiplier) + skillDef.adder);
                }
            });
        });
        return (calculatedTime / spec.GetSpecialistDescription().GetTimeBonus()) * 100 / 1000 / 60;
    }

    specSharedHandler.__patched = true;
})();