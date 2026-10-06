(function () {
    var KEY = 'userScriptUpdater';
    var API = 'https://api.github.com/repos/fedorovvl/tso_client/contents/userscripts?ref=master';
    var MIN_INTERVAL = 5;
    var settingsWindow = new Modal('userScriptUpdaterModal', '', false);
    var defaults = {
        enabled: true,
        intervalMinutes: 60,
        notifyAvailable: true,
        notifyNewScripts: true,
        autoUpdate: false,
        notifyUpdated: true,
        reloadAfterUpdate: true,
        knownUpdates: {},
        knownRemoteScripts: null
    };

    function isRu() {
        return String(gameLang || '').toLowerCase().indexOf('ru') === 0;
    }

    function tr(ru, en) { return isRu() ? ru : en; }

    function readSettings() {
        var saved = settings.read(null, KEY) || {};
        var value = {};
        for (var name in defaults) value[name] = saved[name] === undefined ? defaults[name] : saved[name];
        if (!value.knownUpdates || Object.prototype.toString.call(value.knownUpdates) !== '[object Object]') value.knownUpdates = {};
        if (value.knownRemoteScripts !== null && Object.prototype.toString.call(value.knownRemoteScripts) !== '[object Array]') value.knownRemoteScripts = null;
        value.intervalMinutes = Math.max(MIN_INTERVAL, parseInt(value.intervalMinutes, 10) || defaults.intervalMinutes);
        return value;
    }

    function saveSettings(value) {
        settings.settings[KEY] = {};
        settings.store(value, KEY);
    }

    function notify(message) {
        try {
            if (typeof notificationShow === 'function' && notifySettings && notifySettings.enabled) notificationShow(message);
            else game.showAlert(message);
        } catch (e) {
            try { game.showAlert(message); } catch (ignored) {}
        }
    }

    function setStatus(message) {
        var status = settingsWindow.sData().find('#userScriptUpdaterStatus');
        if (status.length) status.text(message || '');
    }

    function installedScripts() {
        return typeof getCurrentScripts === 'function' ? getCurrentScripts() : {};
    }

    function writeScript(name, content) {
        var file = air.File.applicationDirectory.resolvePath('userscripts/' + name);
        var stream = new air.FileStream();
        stream.open(file, air.FileMode.WRITE);
        stream.writeUTFBytes(content);
        stream.close();
    }

    function downloadUpdates(items, done) {
        var remaining = items.length;
        var updated = [];
        var failed = [];
        if (!remaining) { done(updated, failed); return; }

        function complete() {
            remaining--;
            if (remaining === 0) done(updated, failed);
        }

        $.each(items, function (_, item) {
            $.ajax({
                url: item.download_url,
                dataType: 'text',
                cache: false,
                global: false,
                timeout: 20000
            }).done(function (content) {
                try {
                    writeScript(item.name, content);
                    updated.push(item.name);
                } catch (e) {
                    failed.push(item.name);
                }
            }).fail(function () {
                failed.push(item.name);
            }).always(complete);
        });
    }

    function finishCheck() {
        window.userScriptUpdaterState.checking = false;
    }

    function checkNow(manual) {
        var state = window.userScriptUpdaterState;
        var config = readSettings();
        if (state.checking || (!manual && !config.enabled)) return;
        state.checking = true;
        setStatus(tr('Проверка обновлений...', 'Checking for updates...'));

        $.ajax({
            url: API,
            dataType: 'json',
            cache: false,
            global: false,
            timeout: 15000
        }).done(function (remote) {
            var local = installedScripts();
            var updates = [];
            var remoteNames = [];
            $.each(remote || [], function (_, item) {
                if (!item || item.type !== 'file' || !/\.js$/i.test(item.name)) return;
                remoteNames.push(item.name);
                if (local[item.name] && local[item.name] !== item.sha) updates.push(item);
            });

            if (config.knownRemoteScripts !== null) {
                var newScripts = remoteNames.filter(function (name) {
                    return config.knownRemoteScripts.indexOf(name) === -1;
                });
                if (config.notifyNewScripts && newScripts.length) {
                    notify(tr('В репозитории появились новые userscripts: ', 'New userscripts were added to the repository: ') + newScripts.join(', '));
                }
            }
            config.knownRemoteScripts = remoteNames;

            if (!updates.length) {
                config.knownUpdates = {};
                saveSettings(config);
                setStatus(tr('Все установленные скрипты актуальны.', 'All installed scripts are up to date.'));
                finishCheck();
                return;
            }

            var fresh = [];
            $.each(updates, function (_, item) {
                if (config.knownUpdates[item.name] !== item.sha) fresh.push(item.name);
                config.knownUpdates[item.name] = item.sha;
            });
            saveSettings(config);

            if (config.notifyAvailable && fresh.length) {
                notify(tr('Доступны обновления userscripts: ', 'Userscript updates available: ') + fresh.join(', '));
            }

            if (!config.autoUpdate) {
                setStatus(tr('Доступно обновлений: ', 'Updates available: ') + updates.length + ' — ' + updates.map(function (item) { return item.name; }).join(', '));
                finishCheck();
                return;
            }

            setStatus(tr('Установка обновлений...', 'Installing updates...'));
            downloadUpdates(updates, function (updated, failed) {
                var latest = readSettings();
                $.each(updated, function (_, name) { delete latest.knownUpdates[name]; });
                saveSettings(latest);
                finishCheck();

                if (updated.length) {
                    setStatus(tr('Обновлено: ', 'Updated: ') + updated.join(', '));
                    if (latest.notifyUpdated) notify(tr('Userscripts обновлены: ', 'Userscripts updated: ') + updated.join(', '));
                    if (latest.reloadAfterUpdate) setTimeout(function () { reloadScripts(null); }, 700);
                }
                if (failed.length) setStatus(tr('Не удалось обновить: ', 'Failed to update: ') + failed.join(', '));
            });
        }).fail(function () {
            setStatus(tr('Не удалось проверить обновления.', 'Could not check for updates.'));
            finishCheck();
        });
    }

    function schedule() {
        var state = window.userScriptUpdaterState;
        if (state.timerId) clearInterval(state.timerId);
        if (state.startupId) clearTimeout(state.startupId);
        state.timerId = null;
        state.startupId = null;
        var config = readSettings();
        if (!config.enabled) return;
        state.startupId = setTimeout(function () { checkNow(false); }, 5000);
        state.timerId = setInterval(function () { checkNow(false); }, config.intervalMinutes * 60000);
    }

    window.userScriptUpdaterOpenSettings = function () {
        var config = readSettings();
        function save() {
            config.enabled = settingsWindow.withsBody('#usuEnabled').is(':checked');
            config.intervalMinutes = Math.max(MIN_INTERVAL, parseInt(settingsWindow.withsBody('#usuInterval').val(), 10) || defaults.intervalMinutes);
            config.notifyAvailable = settingsWindow.withsBody('#usuNotifyAvailable').is(':checked');
            config.notifyNewScripts = settingsWindow.withsBody('#usuNotifyNewScripts').is(':checked');
            config.autoUpdate = settingsWindow.withsBody('#usuAutoUpdate').is(':checked');
            config.notifyUpdated = settingsWindow.withsBody('#usuNotifyUpdated').is(':checked');
            config.reloadAfterUpdate = settingsWindow.withsBody('#usuReload').is(':checked');
            saveSettings(config);
            schedule();
            settingsWindow.shide();
        }

        settingsWindow.settings(save, '');
        settingsWindow.sTitle().text(tr('Обновление userscripts', 'Userscript updates'));
        var body = '';
        body += createTableRow([[9, tr('Проверять обновления', 'Check for updates')], [3, createSwitch('usuEnabled', config.enabled)]]);
        body += createTableRow([[9, tr('Период проверки, минут', 'Check interval, minutes')], [3, '<input id="usuInterval" type="number" min="' + MIN_INTERVAL + '" class="form-control" value="' + config.intervalMinutes + '">']]);
        body += createTableRow([[9, tr('Уведомлять, если доступно обновление', 'Notify when an update is available')], [3, createSwitch('usuNotifyAvailable', config.notifyAvailable)]]);
        body += createTableRow([[9, tr('Уведомлять о новых userscripts в репозитории', 'Notify about new userscripts in the repository')], [3, createSwitch('usuNotifyNewScripts', config.notifyNewScripts)]]);
        body += createTableRow([[9, tr('Обновлять автоматически', 'Update automatically')], [3, createSwitch('usuAutoUpdate', config.autoUpdate)]]);
        body += createTableRow([[9, tr('Уведомлять после обновления', 'Notify after an update')], [3, createSwitch('usuNotifyUpdated', config.notifyUpdated)]]);
        body += createTableRow([[9, tr('Перезагружать userscripts после обновления', 'Reload userscripts after an update')], [3, createSwitch('usuReload', config.reloadAfterUpdate)]]);
        body += '<p id="userScriptUpdaterStatus" style="margin-top:10px"></p>';
        settingsWindow.sData().html('<div class="container-fluid">' + body + '</div>');

        settingsWindow.sFooter().find('.usuCheck').remove();
        settingsWindow.sFooter().prepend(
            $('<button>').attr({'class': 'btn btn-default usuCheck'}).text(tr('Проверить сейчас', 'Check now')).click(function () { checkNow(true); })
        );
        settingsWindow.sshow();
    };

    window.userScriptUpdaterCheckNow = checkNow;
    window.userScriptUpdaterSchedule = schedule;

    if (window.userScriptUpdaterState) {
        if (window.userScriptUpdaterState.timerId) clearInterval(window.userScriptUpdaterState.timerId);
        if (window.userScriptUpdaterState.startupId) clearTimeout(window.userScriptUpdaterState.startupId);
    }
    window.userScriptUpdaterState = {timerId: null, startupId: null, checking: false};
    schedule();
})();
