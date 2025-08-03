if (!menuBuffsHandler.__patched) {
    const originalmenuBuffsHandler = menuBuffsHandler;
    var buffsImagesCache  = []
    var buildImagesCache  = [];

    var menuBuffsHandler = function menuBuffsHandler(arg) {
        originalmenuBuffsHandler(arg);

        $('[id^="BuffPoss_"]').off('click').on('click', function () {
            var grid = this.id.replace("BuffPoss_", "");
            _BUFF_GoTo(grid);
        });
    }

    var getBuffsAvailableHTML = function () {
        var buffNeeded = {};
        $.each(buffRecordFiltered, function (i, item) {
            buffNeeded[item.buffName] = (buffNeeded[item.buffName] || 0) + 1;
            getBuffImgFromCache(item.buffName);
        });
        if (Object.keys(buffNeeded).length > 0) {
            var result = '<br><p>{0}</p>'.format(getText('buff_used'));
            result += createTableRow([
                [8, loca.GetText("LAB", 'Buff')],
                [2, loca.GetText("LAB", 'Requires')],
                [2, loca.GetText("LAB", 'Available')]
            ], true);
            var count;
            for (var buffName in buffNeeded) {
                count = getBuffAvailableCount(buffName);
                result += createTableRow([
                    [8, getBuffImgFromCache(buffName) + '&nbsp;' + loca.GetText("RES", buffName)],
                    [2, buffNeeded[buffName]],
                    [2, count, count >= buffNeeded[buffName] ? "buffReady" : "buffNotReady"]
                ]);
            }
            return result;
        }
        return '';
    }

    var getBuffHTML = function () {
        var result = '<p>{0} {1}</p>'.format(getText('buff_zoneowner'), buffRecord["zoneUser"]),
            isZoneRight = true;
        if (buffRecord["zoneId"] != game.gi.mCurrentViewedZoneID) {
            result += '<p><strong>' + getText('buff_not_your_zone') + '</strong></p>';
            isZoneRight = false;
        }

        result += createTableRow([
            [1, '#'],
            [4, loca.GetText("LAB", 'Name')],
            [1, loca.GetText("LAB", 'GuildLevel')],
            [4, loca.GetText("LAB", 'Buff')],
            [2, loca.GetText("LAB", 'ProductionStatus')]
        ], true);
        buffRecordFiltered = [];
        var status;
        $.each(buffRecord['data'], function (index, data) {
            status = getBuffStatus(data, isZoneRight);
            // too dirty
            if (data['buffName'].indexOf("RemoveBuff") >= 0) {
                if (status == 'buff_buffed') {
                    status = 'buff_ready';
                } else if (status == 'buff_ready') {
                    status = 'buff_not_buffed';
                }
            }

            var cssClass = '';

            switch (status) {
                case 'buff_ready':
                    cssClass = 'buffReady'
                    break;
                case 'buff_buffed':
                    cssClass = 'buffed'
                    break;
                case 'buff_notactive':
                    cssClass = 'notActive'
                    break;
                case 'buff_wrong_name':
                    cssClass = 'wrongName'
                    break;
                case 'buff_not_exist':
                    cssClass = 'buffNotReady'
                    break;
                default:
                    cssClass = 'buffNotReady';
                    break;
            }

            if (status == 'buff_ready') {
                buffRecordFiltered.push(data);
            }
            var buildingGoto = getImageTag('accuracy.png', '24px', '24px').replace('<img', '<img id="BuffPoss_' + data['buiGrid'] + '"').replace('style="', 'style="cursor: pointer;');
            result += createTableRow([
                [1, buildingGoto],
                [4, getBuildImageFromCache(data['buiName']) + '&nbsp;' + loca.GetText("BUI", data['buiName'])],
                [1, getBuiLevel(data)],
                [4, getBuffImgFromCache(data['buffName']) + '&nbsp;' + loca.GetText("RES", data['buffName'])],
                [2, getText(status) + '<button type="button" class="close" value="' + data['buiGrid'] + '"><span>&times;</span></button>', cssClass]
            ]);
        });
        buffsImagesCache = [];
        buildImagesCache = [];
        return result;
    }

    function _BUFF_GoTo(g) {
        try {
            $('#buffModal').modal('hide');
            swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(g);
        } catch (e) {
            debug(e);
        }
    }

    function getBuffImgFromCache(buffName){
        if (buffsImagesCache[buffName] === undefined){
            buffsImagesCache[buffName] = getImageTag(buffName, '24px');
        }
        return buffsImagesCache[buffName];
    }

    function getBuildImageFromCache(buiName){
        if (buildImagesCache[buiName] === undefined){
            buildImagesCache[buiName] = getImageTag(buiName, '24px');
        }
        return buildImagesCache[buiName];
    }

    menuBuffsHandler.__patched = true;
}