var info = {};
var missMatch = {};
var customScripts = {}; // Add custom scripts container to global context
var currentCheckboxes = '';

function scriptsManagerWindow() {
    // Hide all modals
    $("div[role='dialog']:not(#managerModal):visible").modal('hide');

    // Create configuration modal window
    createModalWindow('managerModal', getImageTag('BattleBuffKill_random_unit_type_limited') + ' ' + loca.GetText('LAB', 'EventProgression'));

    if ($('#managerModal .managerSubmit').length === 0) {
        $('#managerModal .modal-footer').prepend([
            $('<button>').attr({'class': 'btn btn-primary managerFix'}).text(getText('btn_fix')),
            $('<button>').attr({'class': 'btn btn-primary managerSubmit'}).text(getText('btn_submit'))
        ]);
        $('#managerModal .managerFix').click(managerReinstall);
        $('#managerModal .managerSubmit').click(managerProceed);
    }

    $('.managerSubmit, .managerFix').attr('disabled', true);
    currentCheckboxes = '';
    missMatch = {};
    var out = '<div class="container-fluid">';

    if (info === '') {
        out += '<p>Unable to get info from github</p>';
    }

    out += managerGetData();
    out += '</div>';

    $("#managerModalData").html(out);

    $('#managerModalData [data-toggle="tooltip"]').tooltip({container: 'body'});
    $('#managerModalData input[type=checkbox]').change(function () {
        var checkboxes = '';
        $("#managerModalData input[type=checkbox]").each(function (i, item) {
            checkboxes += +item.checked;
        });
        $('.managerSubmit').attr('disabled', checkboxes === currentCheckboxes);
    });

    if (Object.keys(missMatch).length > 0) {
        $('.managerFix').attr('disabled', false);
    }

    $('#managerModalData a').click(function (event) {
        event.preventDefault();
        air.navigateToURL(new air.URLRequest(this));
    });

    $('#managerModal:not(:visible)').modal({backdrop: 'static'});
}

function managerGetData() {
    var currentScripts = getCurrentScripts();
    var out = createTableRow(
        [
            [2, 'Filename'],
            [3, 'Title'],
            [2, 'Author'],
            [2, 'Description'],
            [1, 'Status'],
            [1, 'Installed'],
            [1, 'Enabled']
        ],
        true
    );

    info = (info === 'error') ? {} : info;

    for (var name in info) {
        var st = checkSize(info[name].size, currentScripts[name]);
        out += createTableRow([
            [2, name],
            [3, getScriptField(info[name])],
            [2, info[name].author],
            [2, '<span data-toggle="tooltip" data-placement="top" title="{0}">{1}</span>'.format(info[name].longDesc, info[name].shortDesc)],
            [1, st === 'ok' ? st : getText('manager_mismatch')],
            [1, '<input type="checkbox" id="' + name + '" ' + (currentScripts[name] ? 'checked' : '') + ' />'],
            [1, '<input type="checkbox" id="en_' + name + '" ' + (enabledScripts[name] || enabledScripts[name] == undefined ? 'checked' : '') + ' />']
        ]);
        if (st !== 'ok') {
            missMatch[name] = true;
        }
        currentCheckboxes += (currentScripts[name] ? '1' : '0');
        delete currentScripts[name];
    }

    for (var item in currentScripts) {
        var scriptInfo = customScripts[item];
        if (typeof scriptInfo !== 'undefined' && scriptInfo !== null) {
            out += createTableRow([
                [2, item],
                [3, getScriptField(scriptInfo)],
                [2, scriptInfo.author],
                [2, '<span data-toggle="tooltip" data-placement="top" title="{0}">{1}</span>'.format(scriptInfo.description, scriptInfo.title)],
                [1, 'custom'],
                [1, '<input type="checkbox" id="' + item + '" checked />'],
	            [1, '<input type="checkbox" id="en_' + item + '" ' + (enabledScripts[item] || enabledScripts[item] == undefined ? 'checked' : '') + ' />']
            ]);
        } else {
            out += createTableRow([
                [2, item],
                [3, 'Do you'],
                [2, 'trust'],
                [2, 'this'],
                [1, 'file?'],
                [1, '<input type="checkbox" id="' + item + '" checked />'],
				[1, '<input type="checkbox" id="en_' + item + '" ' + (enabledScripts[item] || enabledScripts[item] == undefined ? 'checked' : '') + ' />']
           ]);
        }

        currentCheckboxes += '1';
    }

    return out;
}

function managerReinstall() {
    var out = '',
        file, fileName, fileStream;

    for (var item in missMatch) {
        $.get("https://raw.githubusercontent.com/fedorovvl/tso_client/master/userscripts/" + item, function (data) {
            fileName = this.url.replace(/^.*[\\\/]/, '');
            out += '<p>Reinstall ' + fileName + '</p>';
            $("#managerModalData").html('<div class="container-fluid">' + out + '</div>');
            file = new air.File(air.File.applicationDirectory.resolvePath("userscripts/" + fileName).nativePath);
            fileStream = new air.FileStream();
            fileStream.open(file, air.FileMode.WRITE);
            fileStream.writeUTFBytes(data);
            fileStream.close();
            delete missMatch[fileName];
            if (Object.keys(missMatch).length === 0) {
                finishProceed();
            }
        });
    }
}

function getScriptField(data) {
    if (data.url && data.url !== '') {
        return '<a href="' + data.url + '">' + data.name + '</a>';
    }
    return data.name;
}

function checkSize(a, b) {
    if (!a || !b) {
        return 'ok';
    }
    return a === b ? 'ok' : 'mismatch';
}

function getCurrentScripts() {
    var scripts = {};

    air.File.applicationDirectory.resolvePath("userscripts").getDirectoryListing().forEach(function (item) {
        if (item.name !== "99-example.js" && item.name.match(/\.js$/i) !== null) {
            scripts[item.name] = item.size;
        }
    });

    return scripts;
}

function managerProceed() {
    var installed = getCurrentScripts();
    var checkboxes = {};
    var result = {};

    $("#managerModalData input[type=checkbox]").each(function (i, item) {
		if(item.id.match(/^en_/i) === null) {
			checkboxes[item.id] = +item.checked;
		} else {
			enabledScripts[item.id.replace("en_", "")] = +item.checked;
		}
    });

    for (var installedItem in installed) {
        if (!checkboxes[installedItem] && installed[installedItem]) {
            result[installedItem] = false;
        }
    }

    for (var checkboxItem in checkboxes) {
        if (checkboxes[checkboxItem] && !installed[checkboxItem]) {
            result[checkboxItem] = true;
        }
    }

    var out = '',
        file, fileName, fileStream;
    for (var item in result) {

        if (result[item] === false) {
            // Remove scripts
            out += '<p>Remove ' + item + '</p>';
            $("#managerModalData").html('<div class="container-fluid">' + out + '</div>');
            new air.File(air.File.applicationDirectory.resolvePath("userscripts/" + item).nativePath).deleteFile();
            delete result[item];
        } else {
            // Install scripts
            $.get("https://raw.githubusercontent.com/fedorovvl/tso_client/master/userscripts/" + item, function (data) {
                fileName = this.url.replace(/^.*[\\\/]/, '');
                out += '<p>Install ' + fileName + '</p>';
                $("#managerModalData").html('<div class="container-fluid">' + out + '</divp>');
                file = new air.File(air.File.applicationDirectory.resolvePath("userscripts/" + fileName).nativePath);
                fileStream = new air.FileStream();
                fileStream.open(file, air.FileMode.WRITE);
                fileStream.writeUTFBytes(data);
                fileStream.close();
                delete result[fileName];
                if (Object.keys(result).length === 0) {
                    finishProceed();
                }
            });
        }
    }

    if (Object.keys(result).length === 0) {
        finishProceed();
    }
}

function finishProceed() {
	settings.store(enabledScripts, "scripts");
    reloadScripts(null);
    setTimeout(scriptsManagerWindow, 1000);
}

function scriptsManager(event) {
    info = 'error';

    var req = $.get("https://raw.githubusercontent.com/fedorovvl/tso_client/master/userscripts/info.json", function (data) {
        info = JSON.parse(data);
    });

    req.always(function () {
        getInfoTree();
    });
}

function getInfoTree() {
    if (info === 'error') {
        scriptsManagerWindow();
        return;
    }

    var req = $.get("https://api.github.com/repos/fedorovvl/tso_client/contents/userscripts", function (data) {
        data.forEach(function (item) {
            if (info[item.name]) {
                info[item.name].size = item.size;
                info[item.name].sha = item.sha;
            }
        });
    });

    req.always(function () {
        scriptsManagerWindow();
    });
}
