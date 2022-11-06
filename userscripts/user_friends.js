addToolsMenuItem(loca.GetText("LAB", "Friends"), _exudFriendsMenuHandler);

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
	}
};
extendBaseLang(_exudFriendsLang, 'exudFriends');
var _exudFriendsSortField = { 'key': 0, 'order': true }
var _exudFriendsExclusiveFields = { 2: false, 4: false }

function _exudFriendsMenuHandler(event) {
	// close all modals
	$("div[role='dialog']:not(#udFriendsModal):visible").modal("hide");
	// create modal
	$('#udFriendsModal').remove();
	createModalWindow('udFriendsModal', loca.GetText("LAB", "Friends"));
	
	$('#udFriendsModal .modal-title').html(getImageTag('Valentines2021SpecialistsBundle', '45px')+' '+loca.GetText("LAB", "Friends"));
	
	if($('#udFriendsModal .modal-header .container-fluid').length == 0){
		$('#udFriendsModal .modal-header').append('<br><div class="container-fluid">' + createTableRow([
			[3, _exudcreateSortingField(loca.GetText("LAB", "UserName"))],
			[1, _exudcreateSortingField(loca.GetText("LAB", "GuildLevel"))],
			[2, _exudcreateSortingField(loca.GetText("LAB", "ProductionStatus"), _exudFriendsGetImage(2, true))],
			[2, _exudcreateSortingField(getText('since', 'exudFriends'))],
			[2, getText('term', 'exudFriends')],
			[2, _exudcreateSortingField(loca.GetText("LAB", "Guild"), _exudFriendsGetImage(4, true))]
		], true)  + '</div>');	
	}
				

	$('#udFriendsModal .modal-header img[id="_exudSortExcl"]').click(_exudFriendsSetIncludeImage);
	$('#udFriendsModal .modal-header .row a').click(_exudchangeSortingField);

	// fill modal data 
	$('#udFriendsModalData').html('<div class="container-fluid"></div>');
	$('#udFriendsModal .modal-header .row div:nth-child('+(_exudFriendsSortField['key'] + 1)+') a').trigger( "click" );

	$('#udFriendsModal:not(:visible)').modal({ backdrop: "static" });
}

function _exudcreateSortingField(name, exclusive)
{
	var field = $('<span>').html('&#8593;').hide().prop('outerHTML') + $('<a>', { 'style': 'cursor: pointer;text-decoration:none;color:#000;' }).html(name).prop('outerHTML');
	return field + (exclusive ? ' ' + exclusive : '');
}

function _exudchangeSortingField(e)
{
	var selfIndex = $(this).parent().index();
	$('#udFriendsModal .modal-header .row span').hide();
	if(_exudFriendsSortField['key'] == selfIndex)
		_exudFriendsSortField['order'] = !_exudFriendsSortField['order'];
	_exudFriendsSortField['key'] = selfIndex;
	$(this).parent().children("span").html(_exudFriendsSortField['order'] ? '&#8593;' : '&#8595;').show();
	$('#udFriendsModalData .container-fluid').html(_exudFriendsGetData());
}

function _exudFriendsSetIncludeImage(e)
{
	var selfIndex = $(this).parent().index();
	_exudFriendsExclusiveFields[selfIndex] = !_exudFriendsExclusiveFields[selfIndex];
	$('#udFriendsModalData .container-fluid').html(_exudFriendsGetData());
	$(this).attr('src', _exudFriendsGetImage(selfIndex));
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
		var dtfex = new window.runtime.flash.globalization.DateTimeFormatter("en-US"); 
		dtfex.setDateTimePattern("MM-dd-yyyy HH:mm"); 

		var _friends = globalFlash.gui.mFriendsList.GetFilteredFriends("", true); //dPlayerListItemVO[]
		if (_friends == null || _friends.length == 0)
			return "Nothing to do";
	
		_friends.sort(_exudFriendsCompare);
	
		_friends.forEach(function(item) {
			if (_exudFriendsExclusiveFields[4]  && item.onlineLast24 == undefined) return;
			if (!item.onlineStatus && _exudFriendsExclusiveFields[2] ) return;
			out += createTableRow([
				[3, item.username],
				[1, item.playerLevel],
				[2, (item.onlineStatus ? getText('online', 'exudFriends') : "")],
				[2 , dtfex.format(new window.runtime.Date(item.friendSince))],
				[2 , loca.FormatDuration(Date.now() - item.friendSince, 6)],
				[2, (item.onlineLast24 != undefined ? loca.GetText("LAB", "YES") : "")]
			]);			
		});
	} catch (e) {
		return _exudFriendsGetData();
	}
	return out;
}

function _exudFriendsCompare(a, b)
{
	var res;
	switch(_exudFriendsSortField['key']) {
		case 1:
			res = (a.playerLevel < b.playerLevel ? -1 : (a.playerLevel == b.playerLevel ? 0 : 1));
		break;
		case 2:
			res = (a.onlineStatus ? -1 : (b.onlineStatus ? 1 : -1));
		break;
		case 3:
			res =  (a.friendSince < b.friendSince ? -1 : (a.friendSince == b.friendSince ? 0 : 1));
		break;
		case 4:
			res =  (a.onlineLast24 != undefined ? -1 : (b.onlineLast24 != undefined ? 1 : -1));
		break;
		default:
			res =  a.username.toLowerCase().localeCompare(b.username.toLowerCase());
		break;
	}
	return (_exudFriendsSortField['order'] ? res : -res);
}