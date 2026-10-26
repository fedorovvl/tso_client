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
            $('<button>').attr({'class': 'btn btn-default managerUpdaterSettings'}).text(String(gameLang || '').toLowerCase().indexOf('ru') === 0 ? 'Настройки обновлений' : 'Update settings'),
            $('<button>').attr({'class': 'btn btn-primary managerFix'}).text(getText('btn_fix')),
            $('<button>').attr({'class': 'btn btn-primary managerSubmit'}).text(getText('btn_submit'))
        ]);
        $('#managerModal .managerUpdaterSettings').click(function () {
            if (typeof userScriptUpdaterOpenSettings === 'function') userScriptUpdaterOpenSettings();
        });
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
        var st = checkSize(info[name].sha, currentScripts[name]);
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
            scripts[item.name] = getFileSha(item);
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
            });
        }
    }

    finishProceed();
}

function finishProceed() {
	settings.settings["scripts"] = {};
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
function getFileSha(file)
{
    var headerBytes = []; 
	var contentBytes = [];
	var t=new window.runtime.flash.filesystem.FileStream;
	t.open(file, "read");
    while (t.bytesAvailable > 0) contentBytes.push(t.readUnsignedByte()); 
    t.close();
	var header = "blob " + contentBytes.length + "\0"; 
    for (var i = 0; i < header.length; i++) headerBytes.push(header.charCodeAt(i) & 0xff);  
	return bytesToHex(sha1(headerBytes.concat(contentBytes)));
}

function bytesToHex(t){for(var n="",r=0;r<t.length;r++){var e=(255&t[r]).toString(16);e.length<2&&(e="0"+e),n+=e}return n};
function sha1(r){const n=[-2147483648,8388608,32768,128],f=[24,16,8,0],t=[];t[0]=t[16]=t[1]=t[2]=t[3]=t[4]=t[5]=t[6]=t[7]=t[8]=t[9]=t[10]=t[11]=t[12]=t[13]=t[14]=t[15]=0;var o,e=1732584193,i=4023233417,a=2562383102,u=271733878,h=3285377520,c=0,l=0,v=0,g=0,w=!1,s=!1;function d(){if(w)throw new Error("Hash was finalized")}function z(r){if(!arguments.length)return z;d();for(var n,e=0,i=r.length||0;e<i;){for(s&&(s=!1,t[0]=c,t[16]=t[1]=t[2]=t[3]=t[4]=t[5]=t[6]=t[7]=t[8]=t[9]=t[10]=t[11]=t[12]=t[13]=t[14]=t[15]=0),n=l;e<i&&n<64;++e)t[n>>2]|=r[e]<<f[3&n++];o=n,v+=n-l,n>=64?(c=t[16],l=n-64,E(),s=!0):l=n}return v>4294967295&&(g+=v/4294967296|0,v%=4294967296),z}function p(){d(),w=!0;var r=o;return t[16]=c,t[r>>2]|=n[3&r],c=t[16],r>=56&&(s||E(),t[0]=c,t[16]=t[1]=t[2]=t[3]=t[4]=t[5]=t[6]=t[7]=t[8]=t[9]=t[10]=t[11]=t[12]=t[13]=t[14]=t[15]=0),t[14]=g<<3|v>>>29,t[15]=v<<3,E(),[e>>24&255,e>>16&255,e>>8&255,255&e,i>>24&255,i>>16&255,i>>8&255,255&i,a>>24&255,a>>16&255,a>>8&255,255&a,u>>24&255,u>>16&255,u>>8&255,255&u,h>>24&255,h>>16&255,h>>8&255,255&h]}function E(){var r,n,f=e,o=i,c=a,l=u,v=h;for(r=16;r<80;++r)n=t[r-3]^t[r-8]^t[r-14]^t[r-16],t[r]=n<<1|n>>>31;for(r=0;r<20;r+=5)f=(n=(o=(n=(c=(n=(l=(n=(v=(n=f<<5|f>>>27)+(o&c|~o&l)+v+1518500249+t[r]|0)<<5|v>>>27)+(f&(o=o<<30|o>>>2)|~f&c)+l+1518500249+t[r+1]|0)<<5|l>>>27)+(v&(f=f<<30|f>>>2)|~v&o)+c+1518500249+t[r+2]|0)<<5|c>>>27)+(l&(v=v<<30|v>>>2)|~l&f)+o+1518500249+t[r+3]|0)<<5|o>>>27)+(c&(l=l<<30|l>>>2)|~c&v)+f+1518500249+t[r+4]|0,c=c<<30|c>>>2;for(;r<40;r+=5)f=(n=(o=(n=(c=(n=(l=(n=(v=(n=f<<5|f>>>27)+(o^c^l)+v+1859775393+t[r]|0)<<5|v>>>27)+(f^(o=o<<30|o>>>2)^c)+l+1859775393+t[r+1]|0)<<5|l>>>27)+(v^(f=f<<30|f>>>2)^o)+c+1859775393+t[r+2]|0)<<5|c>>>27)+(l^(v=v<<30|v>>>2)^f)+o+1859775393+t[r+3]|0)<<5|o>>>27)+(c^(l=l<<30|l>>>2)^v)+f+1859775393+t[r+4]|0,c=c<<30|c>>>2;for(;r<60;r+=5)f=(n=(o=(n=(c=(n=(l=(n=(v=(n=f<<5|f>>>27)+(o&c|o&l|c&l)+v-1894007588+t[r]|0)<<5|v>>>27)+(f&(o=o<<30|o>>>2)|f&c|o&c)+l-1894007588+t[r+1]|0)<<5|l>>>27)+(v&(f=f<<30|f>>>2)|v&o|f&o)+c-1894007588+t[r+2]|0)<<5|c>>>27)+(l&(v=v<<30|v>>>2)|l&f|v&f)+o-1894007588+t[r+3]|0)<<5|o>>>27)+(c&(l=l<<30|l>>>2)|c&v|l&v)+f-1894007588+t[r+4]|0,c=c<<30|c>>>2;for(;r<80;r+=5)f=(n=(o=(n=(c=(n=(l=(n=(v=(n=f<<5|f>>>27)+(o^c^l)+v-899497514+t[r]|0)<<5|v>>>27)+(f^(o=o<<30|o>>>2)^c)+l-899497514+t[r+1]|0)<<5|l>>>27)+(v^(f=f<<30|f>>>2)^o)+c-899497514+t[r+2]|0)<<5|c>>>27)+(l^(v=v<<30|v>>>2)^f)+o-899497514+t[r+3]|0)<<5|o>>>27)+(c^(l=l<<30|l>>>2)^v)+f-899497514+t[r+4]|0,c=c<<30|c>>>2;e=e+f|0,i=i+o|0,a=a+c|0,u=u+l|0,h=h+v|0}if(z.finalize=p,z.update=z,arguments.length){for(var H=0;H<arguments.length;H++)z(arguments[H]);return p()}return z};
