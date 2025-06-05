if (!specGeoGetDepleted.__patched) {
    const originalSpecGeoGetDepleted = specGeoGetDepleted;

    specGeoGetDepleted = function() {
        var depletedDeposits = originalSpecGeoGetDepleted.call(this);
        var counts = {};

        //selected
        const valueMap = {
            '0,0': 'Stone',
            '0,1': 'BronzeOre',
            '0,2': 'Marble',
            '0,3': 'IronOre',
            '0,4': 'GoldOre',
            '0,5': 'Coal',
            '0,6': 'Granite',
            '0,7': 'TitaniumOre',
            '0,8': 'Salpeter'
        };
        $('#specModalData select').each(function() {
            var val = $(this).val();

            if (val in valueMap) {
                val = valueMap[val];
            }

            if (val) {
                counts[val] = (counts[val] || 0) + 1;
            }
        });
        Object.keys(valueMap).forEach(function (key) {
            var val = valueMap[key];
            if (!(val in counts)) {
                counts[val] = 0;
            }
        });

        game.gi.mCurrentPlayerZone.GetSpecialists_vector().sort(specNameSorter).forEach(function(item) {
            if (item.GetTask() == null || item.GetBaseType() != 2 || item.getPlayerID() == -1) { return; }
            var searchedDeposit = item.GetTask().GetDepositToSearch_string();
            if (counts.hasOwnProperty(searchedDeposit)) {
                counts[searchedDeposit] += 1;
            }
        });

        if (Array.isArray(depletedDeposits)) {
            depletedDeposits.forEach(function(deposit, index) {
                depletedDeposits[index] = formatDepletedDepositsCountString(deposit, counts[index] || 0);
            });
        } else if (typeof depletedDeposits === 'object' && depletedDeposits !== null) {
            Object.keys(depletedDeposits).forEach(function(key) {
                depletedDeposits[key] = formatDepletedDepositsCountString(depletedDeposits[key], counts[key] || 0);
            });
        }

        return depletedDeposits;
    };
    updateSpecTimeRow = function (select, val, selected)
    {
        try
        {
            if (specType == 2){
                var depletedData = specGeoGetDepleted();
                if(Object.keys(depletedData).length > 0) {
                    var deplHtml = loca.GetText("MEL", "DepositDepleted") + ':&nbsp;&nbsp;';
                    $.each(depletedData, function(res, count) {
                        deplHtml += getImageTag(res, '23px', '23px') + '&nbsp;' + count + '&nbsp;&nbsp;';
                    });
                    specWindow.withHeader('.depletedInfo').html(deplHtml);
                }
            }
            var row = $(select).closest('.row').children('div').eq(1);
            row.html((val != undefined && val != '0') ? getTaskDurationText(select.id, selected) : '&nbsp;');
        } catch(e) {
            return "Error " + e;
        }
    }

    function formatDepletedDepositsCountString(depletedDepositCount, depositInProgress){
        if (typeof depletedDepositCount === 'string' && depletedDepositCount.indexOf('/') !== -1){
            var parts = depletedDepositCount.split('/');
            depletedDepositCount = parseInt(parts[1], 10)
            depositInProgress = parseInt(parts[0], 10) + depositInProgress;
        }else{
            depletedDepositCount = parseInt(depletedDepositCount, 10);
        }

        var resultText = depositInProgress + '/' + depletedDepositCount;

        if (depositInProgress > depletedDepositCount) {
            resultText = '<span style="color: orangered">' + resultText + '</span>';
        }
        if (depositInProgress == depletedDepositCount) {
            resultText = '<span style="color: lawngreen">' + resultText + '</span>';
        }
        return resultText
    }
    specGeoGetDepleted.__patched = true;
}