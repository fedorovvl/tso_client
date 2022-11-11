addToolsMenuItem(loca.GetText("LAB", "Friends") + " (Ctrl + F5)", _exudFriendsMenuHandler, 116, true);

var _exudFriendsLang = {
	'en-uk': {
		'online': 'Online',
		'since': 'Friend since ',
		'term': 'Term'
	},
	'ru-ru': {
		'online': 'Онлайн',
		'since': 'Подружились ',
		'term': 'Срок'
	},
	'pl-pl': {
		'online': 'Online',
		'since': 'Od kiedy',
		'term': 'Jak długo'
    },
	'pt-br': {
		'online': 'Ativo',
		'since': 'Amigos desde'
	},
	'de-de': {
		'since': 'Freunde seit ',
		'term': 'Länge'
	},
	'es-es': {
		'online': 'Activo',
		'since': 'Amigos desde'
	}
};
extendBaseLang(_exudFriendsLang, 'exudFriends');
var _exudFriendsSortField = { 'key': 0, 'order': true }
var _exudFriendsExclusiveFields = { 2: false, 4: false }
var _exudFriendsModalInitialized = false;
var _exudFriendsModalIdxOnlineFilter = 2;
var _exudFriendsModalIdxGuildFilter = 4;


function _exudFriendsMenuHandler(event) {
	$("div[role='dialog']:not(#udFriendsModal):visible").modal("hide"); // close others modals
	
	// reopening modal not needed to refresh all data. only if a new script layout was loaded
	// so is faster and shows the last data views
	if(!_exudFriendsModalInitialized || $('#udFriendsModal .modal-header .container-fluid').length > 0 )
		$('#udFriendsModal').remove();
try{	
	if($('#udFriendsModal .modal-header .container-fluid').length == 0){
		$('#udFriendsStyle').remove();
		if($('#udFriendsStyle').length == 0)
		{
			$("head").append($("<style>", { 'id': 'udFriendsStyle' }).text('div .row:hover {background-color: #A65329;}'));
		}
		
		createModalWindow('udFriendsModal', loca.GetText("LAB", "Friends"));
		$('#udFriendsModal .modal-title').html(getImageTag('Valentines2021SpecialistsBundle', '45px')+' '+loca.GetText("LAB", "Friends"));
	
		$('#udFriendsModal .modal-header').append('<br><div class="container-fluid">' + createTableRow([
			[3, _exudcreateSortingField(loca.GetText("LAB", "UserName")) + $('<input>', {
				'type':'text', 'id':'udFriendsFilter', 'class': 'form-control', 'style': 'display: inline;width: 100px;float: right;'
			}).prop('outerHTML')],
			[1, _exudcreateSortingField(loca.GetText("LAB", "GuildLevel"))],
			[2, _exudcreateSortingField(loca.GetText("LAB", "ProductionStatus"), _exudFriendsGetImage(_exudFriendsModalIdxOnlineFilter, true))],
			[2, _exudcreateSortingField(getText('since', 'exudFriends'))],
			[2, _exudcreateSortingField(loca.GetText("LAB", "Guild"), _exudFriendsGetImage(_exudFriendsModalIdxGuildFilter, true))],
			[2, loca.GetText("LAB", "Commands")]
		], true)  + '</div>');	

		$('#udFriendsModal .modal-header img[id="_exudSortExcl"]').click(_exudFriendsSetIncludeImage);
		$('#udFriendsModal .modal-header .row a').click(_exudFriendsChangeSortingField);
		$('#udFriendsModal #udFriendsFilter').keyup(function(e) {
			var val = $(e.target).val();
			if(!val || val == ''){
				$('#udFriendsModalData .container-fluid div:hidden').show();
				return;
			}
			$('#udFriendsModalData .container-fluid .row').each(function(i, item){ 
				if($(item.firstChild.firstChild).text().toUpperCase().indexOf(val.toUpperCase()) == -1) {
					$(item).hide();
				} else {
					$(item).show();
				}					
			});
		});

		// fill modal data 
		$('#udFriendsModalData').html('<div class="container-fluid"></div>');
		_exudFriendsModalInitialized = true;
	}

	_exudFriendsSortField['order'] = !_exudFriendsSortField['order'];  // trigger changes this value, so to make the previous one invert first
	$('#udFriendsModal .modal-header .row div:nth-child('+(_exudFriendsSortField['key'] + 1)+') a').trigger( "click" );
}
catch (efr) {}
			
	$('#udFriendsModal:not(:visible)').modal({ backdrop: "static" });
}

function _exudcreateSortingField(name, exclusive)
{
	var field = $('<span>').html('&#8593;').hide().prop('outerHTML') + $('<a>', { 'style': 'cursor: pointer;text-decoration:none;color:#000;' }).html(name).prop('outerHTML');
	return field + (exclusive ? ' ' + exclusive : '');
}

function _exudFriendsRefresh()
{
	$('#udFriendsModalData .container-fluid').html(_exudFriendsGetData());
	$('#udFriendsModalData a[id^="friends_"]').click(_exudFriendsExecuteCommandAndExit);
}

function _exudFriendsChangeSortingField(e)
{
	var selfIndex = $(this).parent().index();
	$('#udFriendsModal .modal-header .row span').hide();
	if(_exudFriendsSortField['key'] == selfIndex)
		_exudFriendsSortField['order'] = !_exudFriendsSortField['order'];
	_exudFriendsSortField['key'] = selfIndex;
	$(this).parent().children("span").html(!_exudFriendsSortField['order'] ? '&#8593;' : '&#8595;').show();
	_exudFriendsRefresh();
}

function _exudFriendsSetIncludeImage(e)
{
	var selfIndex = $(this).parent().index();
	_exudFriendsExclusiveFields[selfIndex] = !_exudFriendsExclusiveFields[selfIndex];
	$(this).attr('src', _exudFriendsGetImage(selfIndex));
	_exudFriendsRefresh();
}

function _exudFriendsGetImage(st, asImage)
{
	var img = getImageTag(_exudFriendsExclusiveFields[st] ? "hitpoints_positive.png" : "hitpoints_negative.png");
	return !asImage ? $(img).attr('src') : $(img).attr('id', '_exudSortExcl').prop('outerHTML');
}

function _exudFriendsGetData()
{
	var out = "";
	try
	{
		var global = swmmo.getDefinitionByName("global")
		var dtfex = new window.runtime.flash.globalization.DateTimeFormatter("en-US"); 
		if (gameLang.indexOf("en-") > 0)
			dtfex.setDateTimePattern("MM-dd-yyyy HH:mm"); 
		else
			dtfex.setDateTimePattern("dd-MM-yyyy HH:mm"); 

		var _friends = globalFlash.gui.mFriendsList.GetFilteredFriends("", true); //dPlayerListItemVO[]
		if (_friends == null || _friends.length == 0)
			return "Nothing to do";
	
		_friends = _friends.filter(function(x) {
			if (_exudFriendsExclusiveFields[_exudFriendsModalIdxGuildFilter]  && x.onlineLast24 == undefined) return false;
			if (!x.onlineStatus && _exudFriendsExclusiveFields[_exudFriendsModalIdxOnlineFilter] ) return false;
			return true;
		});
		_friends.sort(_exudFriendsCompare);
		var MinFriendsTime = global.tradeFriendDelay * 1000;
	
		_friends.forEach(function(item) {
			var FriendsTime = Date.now() - item.friendSince;
			//_debugClassesDebugMessage("FriendsTime : " + FriendsTime);
			var CanTrade = (FriendsTime > MinFriendsTime);

			out += createTableRow([
				[3, $('<span>', {'style' : 'white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'}).html(item.username).prop('outerHTML')],
				[1, item.playerLevel],
				[2, (item.onlineStatus ? getText('online', 'exudFriends') : "")],
				[2, '<div style="text-align:right">'+dtfex.format(new window.runtime.Date(item.friendSince))+ "<br/>" + loca.FormatDuration(Date.now() - item.friendSince , 6)+ '</div>'],
				[2, (item.onlineLast24 != undefined ? loca.GetText("LAB", "YES") : "")],
				[2, $('<span>', {'style' : 'white-space: nowrap;overflow: hidden;text-overflow: ellipsis;'}).html(_exudFriendsCommandImage('icon_pathfinder.png', 'zone', item.id) 
					+ "&nbsp;" + _exudFriendsCommandImage('unitcapacity_positive.png', 'wishper', item.id)
					+ "&nbsp;" +  (CanTrade ? _exudFriendsCommandImage('emergency_repair_kit.png', 'trade', item.id) : "")
					).prop('outerHTML')]
			]);			
		});
	} catch (e) {
		return _exudFriendsGetData();
	}
	return out;
}

function _exudFriendsCommandImage(img, type, id)
{
	var field =  $('<a>', {'id' : 'friends_'+type+'_' +id, 'style': 'cursor: pointer;text-decoration:none;color:#000;' }).html(getImageTag(img, 24, 24)).prop('outerHTML');
	return field;
}

function _exudFriendsExecuteCommandAndExit(e)
{

	try{
		var cmd = $(this).attr('id').split('_');
		var friend = globalFlash.gui.mFriendsList.GetFriendById(cmd[2]);
		if (friend == null)
			friend = globalFlash.gui.mFriendsList.GetGuildMemberById(cmd[2])
		switch(cmd[1])
		{
			case 'zone':
				swmmo.application.mGameInterface.visitZone(cmd[2]);
				break;
			case 'wishper':
				globalFlash.gui.mChatPanel.ActivatePrivateChat(friend.username);
				break;
			case "trade":
				globalFlash.gui.mTradingPanel.SetData(friend);
				globalFlash.gui.mTradingPanel.Show();
				break;
		}	
		$('#udFriendsModal').modal('hide');
	}
	catch (err) {
		alert("Something was wrong. retry!" + err.message)
	}
}


function _exudFriendsCompare(a, b)
{
	var res;
	switch(_exudFriendsSortField['key']) {
		case 1:
			res = (a.playerLevel < b.playerLevel ? -1 : (a.playerLevel == b.playerLevel ? 0 : 1));
		break;
		case _exudFriendsModalIdxOnlineFilter:
			res = (a.onlineStatus ? -1 : (b.onlineStatus ? 1 : 0));
		break;
		case 3:
			res =  (a.friendSince < b.friendSince ? -1 : (a.friendSince == b.friendSince ? 0 : 1));
		break;
		case _exudFriendsModalIdxGuildFilter:
			res =  (a.onlineLast24 != undefined ? -1 : (b.onlineLast24 != undefined ? 1 : 0));
		break;
		default:
			res =  a.username.toLowerCase().localeCompare(b.username.toLowerCase());
		break;
	}
	return (_exudFriendsSortField['order'] ? res : -res);
}
