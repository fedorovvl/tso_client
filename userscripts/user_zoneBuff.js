////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////Created by PiTi | In co-operation with Test_Siedler////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

addToolsMenuItem(loca.GetText("HIL", "Help_window_zonebuffs_0"), SearchZoneBuffHandler);
var _searchZoneBuffViewerModalInitialized = false;

var searchStringZB = '';
var zoneBuffArray = [];
var zoneBuffArraySave = [];
var zoneBuffArrayLoad = [];

function SearchZoneBuffHandler(event) {
    $('div[role="dialog"]:not(#searchZoneBuffModal):visible').modal('hide');
    if (!_searchZoneBuffViewerModalInitialized)
        $('#searchZoneBuffModal').remove();
    createModalWindow('searchZoneBuffModal', loca.GetText("HIL", "Help_window_zonebuffs_0"));

    zoneBuff_newTemplates = new SaveLoadTemplate('zonebuff', function (data, name) {
        $("#searchZoneBuffModal .templateFile").html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), loca.GetText("LAB", "AvatarCurrentSelection"), name));
        zoneBuffArrayLoad = data;
        var ZoneBuffList = _getZoneBuffList();
        ZoneBuffList.forEach(function (item) {
        var isBuffInArray = false;
        for (var i = 0; i < zoneBuffArrayLoad.length; i++) {
             if (zoneBuffArrayLoad[i] === item.zonebuffname) {
                  isBuffInArray = true;
                  break;
                 }
             }
                if (isBuffInArray) {
                    $('#_Zonenbuffs_' + item.zonebuffname).prop('checked', true);
                    if (isBuffInArray) {
                        $('#_Zonenbuffs_' + item.zonebuffname).prop('checked', true);
                        if (zoneBuffArray.indexOf(item.zonebuffname) === -1) {
                            zoneBuffArray.push(item.zonebuffname);
                        }
                    }
                }
            });
    });


    $('#searchZoneBuffModal .modal-header').append(
        '<br><div class="container-fluid" id="searchZoneBuffSelectFound"><b>' + loca.GetText("LAB", "Search") + ':</b>&emsp;</div>');

    $('<input>', {
        'type': 'text',
        'id': 'searchZoneBuffFind',
        'class': 'form-control',
        'style': 'display: inline;width: 300px;',
        'value': searchStringZB
    }).appendTo('#searchZoneBuffSelectFound');
    $('<label>&emsp</label>').appendTo('#searchZoneBuffSelectFound');
   
    $('#searchZoneBuffModal .modal-header').append('<br><div class="container-fluid">' + createTableRow([
                [5, loca.GetText("LAB", "Name")],
                [4, loca.GetText("LAB", "amount")],
                [3, loca.GetText("LAB", "Status")]
            ], true) + '</div>');
    $('#searchZoneBuffModal #searchZoneBuffFind').keyup(function (e) {
        searchStringZB = $(e.target).val();
        if (!searchStringZB || searchStringZB == "") {
            $('#searchZoneBuffModalData .container-fluid div:hidden').show();
            return;
        }
        $('#searchZoneBuffModalData .container-fluid .row').each(function (i, item) {
            if ($(item.firstChild).text().toUpperCase().indexOf(searchStringZB.toUpperCase()) == -1) {
                $(item).hide();
            } else {
                $(item).show();
            }
        });
    });
    _updateZoneBuffModalData();
    $('#searchZoneBuffModal:not(:visible)').modal({
        backdrop: 'static'
    });

    $("#searchZoneBuffModal .modal-footer").prepend([
            $('<button>').attr({
                "class": "btn btn-warning upgradeReset"
            }).text(getText('btn_reset')),
            $('<button>').attr({
                "class": "btn btn-success upgradeSubmit"
            }).text(getText('btn_submit')),
        ]);

     $("#searchZoneBuffModal .modal-footer").prepend([
                $('<button>').attr({
                    "class": "btn btn-primary pull-left zoneBuff_newSaveTemplate"
                }).text(getText('save_template')),
                $('<button>').attr({
                    "class": "btn btn-primary pull-left zoneBuff_newLoadTemplate"
                }).text(getText('load_template'))
            ]);

    $('#searchZoneBuffModal .upgradeReset').click(function () {
        zoneBuffArray = [];
        zoneBuffArraySave = [];
        zoneBuffArrayLoad = [];
        _updateZoneBuffModalData();
    });
    $('#searchZoneBuffModal .upgradeSubmit').click(function () {
        $('#searchZoneBuffModal').modal('hide');

        if (zoneBuffArray.length === 0) {
            game.showAlert('Zonenbuffliste ist leer');
        } else if (zoneBuffArray.length !== 0) {
            setTimeout(function () {
                ZoneBuffForClientArray(zoneBuffArray);
            }, 1000);
        }
    });
    $('#searchZoneBuffModal .zoneBuff_newSaveTemplate').click(function () {
        zoneBuffArraySave = [];
        $.each(zoneBuffArray, function (i, zoneBuff) {
            if (zoneBuffArraySave.indexOf(zoneBuff) === -1) {
                zoneBuffArraySave.push(zoneBuff);
            }

        });
        zoneBuff_newTemplates.save(zoneBuffArraySave);
    });
    $('#searchZoneBuffModal .zoneBuff_newLoadTemplate').click(function () {
        zoneBuff_newTemplates.load();

    });
    $("#searchZoneBuffModal .btnClose").click(function (e) {
        zoneBuffArray = [];
        zoneBuffArraySave = [];
        zoneBuffArrayLoad = [];
        $('#searchZoneBuffModal').modal('hide');
    });
}

function _updateZoneBuffModalData() {
    var ZoneBuffList = _getZoneBuffList();
    $('#searchZoneBuffModalData').html(_searchZoneBuffModal(ZoneBuffList));
    $('#searchZoneBuffModalData .container-fluid .row').each(function (i, item) {
        if ($(item.firstChild).text().toUpperCase().indexOf(searchStringZB.toUpperCase()) == -1) {
            $(item).hide();
        } else {
            $(item).show();
        }
    });
}

function _getZoneBuffList() {
    var ZoneBuffList = [];

    var buffVector = game.getBuffs();

    buffVector.forEach(function (data) {
        if (data.GetBuffDefinition().GetBuffType() == 8 && data.GetBuffDefinition().GetName_string() != "ChangeColorScheme") {
            var name = data.GetBuffDefinition().GetName_string();
			var buffobject = data.GetBuffDefinition();
			var amount = data.GetAmount();
            var buff = {
                'zonebuffname': name,
				'zoneBuff' : buffobject,
				'zoneBuffamount' : amount
            };

            ZoneBuffList.push(buff);
        }
    });
    return ZoneBuffList;
}

function _searchZoneBuffModal(ZoneBuffList) {
	
    var out = '<div class="container-fluid">';
    try {
         ZoneBuffList.forEach(function (item) {
                _checkboxZonenbuffs_ = '<input type="checkbox" id="_Zonenbuffs_' + item.zonebuffname + '" />'.format(item.zonebuffname);

                out += createTableRow([
                        [5, loca.GetText("RES", item.zonebuffname)],
                        [4, item.zoneBuffamount],
						[3, _checkboxZonenbuffs_ ]
                    ]);

                $(document).on('click', '#_Zonenbuffs_' + item.zonebuffname, function () {
                    var isChecked = $('#_Zonenbuffs_' + item.zonebuffname ).prop('checked');

                    if (zoneBuffArray.indexOf(item.zonebuffname) === -1 && isChecked) {
                        zoneBuffArray.push(item.zonebuffname);

                    } else if (zoneBuffArray.indexOf(item.zonebuffname) !== -1 && !isChecked) {
                        var index = zoneBuffArray.indexOf(item.zonebuffname);
                        zoneBuffArray.splice(index, 1);
                    }
                });

            });
    } catch (e) {
    }
    out += '</div>';

    return out;
}

function ZoneBuffForClientArray(zoneBuffArray_input) {
    var x = new TimedQueue(1000);
    $.each(zoneBuffArray_input, function (i, zoneBuff) {
		
	var BuffGefunden = false;
	if(game.gi.mZoneBuffManager.isBuffRunning(zoneBuff))
    {
		game.showAlert(loca.GetText("QTG", "buffactive") + " - " + loca.GetText("RES", zoneBuff));
    }
	else if(zoneBuff.indexOf("GeneralSpeedBuff_") !== -1 && !game.gi.IsAdventureZone() )
	{
		game.showAlert(loca.GetText("ACL", "HomeIsland") + " " + loca.GetText("RES", zoneBuff) + " " +loca.GetText("LAB", "NotAvailableText"));
	}
	else if(zoneBuff.indexOf("MultiplierBuffZone2_PremiumFriendBuff1Day") !== -1 && game.gi.isOnHomzone() )
	{
		game.showAlert(loca.GetText("ACL", "HomeIsland") + " " + loca.GetText("SHI", "MultiplierBuffZone2_PremiumFriendBuff1Day") + " " +loca.GetText("LAB", "NotAvailableText"));
	}
    else
    {
		var MyBuffID;
		var buffVector = [];
		buffVector = game.getBuffs();
		buffVector.forEach(function(data){
			if(data.GetBuffDefinition().GetName_string() == zoneBuff) {
				//air.Introspector.Console.log(data);
				BuffGefunden = true;
				MyBuffID = data.GetUniqueId();
			}
		});
		if(BuffGefunden)
		{
			x.add(function () {
			game.showAlert(loca.GetText("LAB", "Buffs") + ": " + loca.GetText("RES", zoneBuff));
			game.gi.SendServerAction(61, 0, 0, 0, MyBuffID);
			});
		}
		else
		{
			game.showAlert(loca.GetText("LAB", "Buffs") + " " +loca.GetText("LAB", "NotAvailableText"));
		}		
	}
    });
    x.run();
    zoneBuffArray_input = [];
    zoneBuffArray = [];
}
