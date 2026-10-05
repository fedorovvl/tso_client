var clientUpdateCheckUrl = "https://api.github.com/repos/fedorovvl/tso_client_swf/releases/tags/latest";
var clientUpdateCheckIntervalId = null;
var clientUpdateCheckInterval = 30 * 60 * 1000;

function clientCurrentSwfCommit()
{
	try {
		return String(game.def("com.bluebyte.tso.util::ClientBuildInfo").getSwfCommit() || '').replace(/^\s+|\s+$/g, '');
	}
	catch(e) { return ''; }
}

function clientUpdateMessage()
{
	return String(gameLang || '').toLowerCase().indexOf('ru') == 0
		? 'Доступна новая версия SWF.'
		: 'A new SWF version is available.';
}

function clientUpdateMenuLabel()
{
	return String(gameLang || '').toLowerCase().indexOf('ru') == 0
		? 'Доступно обновление SWF'
		: 'SWF Update available';
}


function clientShowUpdateMenuItem()
{
	try
	{
		var rootMenu = menu.nativeMenu;
		if(!rootMenu || rootMenu.getItemByName('clientUpdateAvailable')) { return; }
		var onlineMenu = rootMenu.getItemByName('online');
		var item = new air.NativeMenuItem(clientUpdateMenuLabel());
		item.name = 'clientUpdateAvailable';
		item.enabled = false;
		if(onlineMenu) rootMenu.addItemAt(item, rootMenu.getItemIndex(onlineMenu));
		else rootMenu.addItem(item);
	}
	catch(e) {}
}

function clientNotifyUpdate()
{
	var message = clientUpdateMessage();
	if(!window.nativeWindow.active && notifySettings.enabled)
	{
		notificationShow(message);
	}
	else
	{
		game.showAlert(message);
	}
}

function clientCheckForUpdate()
{
	$.ajax({
		url: clientUpdateCheckUrl,
		dataType: 'json',
		cache: false,
		global: false,
		timeout: 15000
	}).done(function(response) {
		var clientAsset = null;
		$.each(response && response.assets ? response.assets : [], function(index, asset) {
			if(asset && asset.name == 'client.swf') { clientAsset = asset; return false; }
		});
		if(!clientAsset) { return; }

		var commitMatch = String(response.body || '').match(/Built from commit\s+([0-9a-f]{40})/i);
		var latestCommit = commitMatch ? commitMatch[1] : '';
		var currentCommit = clientCurrentSwfCommit();
		if(!latestCommit || !currentCommit || latestCommit == currentCommit) { return; }
		clientShowUpdateMenuItem();

		var state = settings.read(null, 'clientUpdate') || {};
		if(state.notifiedCommit == latestCommit) { return; }
		state.notifiedCommit = latestCommit;
		settings.store(state, 'clientUpdate');
		clientNotifyUpdate();
	}).fail(function() {});
}

setTimeout(clientCheckForUpdate, 15000);
clientUpdateCheckIntervalId = setInterval(clientCheckForUpdate, clientUpdateCheckInterval);
