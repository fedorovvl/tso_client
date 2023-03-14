var keybindsKeys = {}, keybindsFlippedKeys = {}, keybindsCurrentBinds = {}, keybindsKeysAlt = {},
	keybindsDisabledKeys = ["CONTROL", "ESCAPE", "COMMAND", "ENTER", "CAPS_LOCK", "ALTERNATE", "SHIFT", "ALTERNATE"];

function keybindsRefreshCurrent()
{
	keybindsCurrentBinds = {};
	menu.nativeMenu.items.forEach(function(item){
		if(!item.enabled || item.isSeparator) { return; }
		if(item.submenu != null) {
			keybindsRefreshRecursive(item.submenu.items, [item.label], 1, keybindsCurrentBinds)
		} else {
			if(item.data && item.data.item.onSelect != null) {
				keybindsCurrentBinds[item.data.item.onSelect.name] = keybindsCurrentBinds[item.data.item.onSelect.name] || [];
				keybindsCurrentBinds[item.data.item.onSelect.name].push([item.label, item.name]);
			}
		}
	});
}

function keybindsRefreshRecursive(t, dim, depth, result)
{
	t.forEach(function(item){
		if(!item.enabled || item.isSeparator) { return; }
		dim = dim.slice(0, depth);
		dim.push(item.label);
		if(item.data && item.data.item.onSelect != null) {
			result[item.data.item.onSelect.name] = result[item.data.item.onSelect.name] || [];
			result[item.data.item.onSelect.name].push([dim.join(" > "), item.name]);
		}
		if(item.submenu != null) {
			keybindsRefreshRecursive(item.submenu.items, dim, dim.length, result)
		}
	});
}

function keybindsGetBinds(value) {
	var keybindsSelector = $('<select>', { 'class': 'form-control key' });
	$.each(keybindsCurrentBinds, function(item) {
		keybindsCurrentBinds[item].forEach(function(bind, index) {
			if(item == value[0] && bind[1] == value[1]) {
				keybindsSelector.append($('<option>', { 'value': item, 'id': index, 'selected': 'selected' }).text(bind[0]));
			} else {
				keybindsSelector.append($('<option>', { 'value': item, 'id': index }).text(bind[0]));
			}
		});
	});
	return keybindsSelector;
}

function keybindsKeydownListener(event)
{
	var modifiers = [];
	event.ctrlKey&&modifiers.push("CTRL");
	event.altKey&&modifiers.push("ALT");
	event.shiftKey&&modifiers.push("SHIFT");
	modifiers.push(keybindsFlippedKeys[event.keyCode]);
	$('#keybindsWindow input[type="text"]:focus').val(modifiers.join('+'));
}

function keybindsMenuHandler(event)
{
	keybindsRefreshCurrent();
	xmlToJSON.parseString(window.runtime.flash.utils.describeType(window.runtime.flash.ui.Keyboard)).type.constant.forEach(function(i) {
		var value = parseInt(window.runtime.flash.ui.Keyboard[i.name.v]);
		if(value < 200 && keybindsDisabledKeys.indexOf(i.name.v) == -1) { (i.name.v.length == 1 ? keybindsKeys : keybindsKeysAlt)[i.name.v] = value; }
	});
	keybindsKeys = $.extend(Object.keys(keybindsKeys).sort().reduce(function (r, k) { r[k] = keybindsKeys[k]; return r; }, {}), keybindsKeysAlt);
	keybindsFlippedKeys = Object.keys(keybindsKeys).reduce(function (r, k) { r[keybindsKeys[k]] = k; return r; }, {});
	var w = new Modal('keybindsWindow', utils.getImageTag('icon_dice.png', '45px') + ' ' + getText('hotkeysTitle'));
	w.create();
	$('#keybindsWindow').on("show.bs.modal",function(e){
		window.nativeWindow.stage.removeEventListener("keyDown", stageKeyDownListener);
		window.nativeWindow.stage.addEventListener("keyDown", keybindsKeydownListener);
	});
	$('#keybindsWindow').on("hide.bs.modal",function(e){
		window.nativeWindow.stage.removeEventListener("keyDown", keybindsKeydownListener);
		window.nativeWindow.stage.addEventListener("keyDown", stageKeyDownListener);
	});
	if(w.withFooter('.saveButton').length == 0){
		w.Footer().prepend([
			$("<button>").attr({'class':"btn btn-primary saveButton"}).text(loca.GetText("LAB","Save")).click(function(){
				var result = {}, canSave = true, modifiers = ['CTRL', 'SHIFT', 'ALT'];
				w.withBody('div.row:gt(0)').each(function(i, item) {
					if($(item).find('div:eq(0) input').is(':disabled')) { return; }
					var keycomb = $(item).find('div:eq(0) input').val().split('+'),
						fn = $(item).find('div:eq(1) select').val(),
						arg = $(item).find('div:eq(1) select :selected').prop('id');
						key = keybindsKeys[keycomb.pop()]||false;
					var keycomb = modifiers.map(function(i, index) { return keycomb.indexOf(i)!=-1&&true||false; });
					keycomb.unshift(key);
					if(!key) {
						alert("no key for {0}".format(result[keybind].fn));
						canSave = false;
						return;
					}
					var keybind = keycomb.join('.');
					if(result[keybind]) {
						alert("{0} already binded to {1}".format(keybind, result[keybind].fn));
						canSave = false;
						return;
					}
					result[keybind] = { 'fn': fn, 'arg': keybindsCurrentBinds[fn][arg][1] };
				});
				if(canSave) {
					settings.settings['keybinds'] = {};
					settings.store(result, 'keybinds');
					menu.keybindings = result;
					w.hide();
					game.showAlert(getText('shortcutsSaved'));
				}
			}),
			$("<button>").attr({'class':"btn btn-primary resetButton"}).text(getText('btn_reset')).click(function(){
				settings.settings['keybinds'] = {};
				settings.store({}, 'keybinds');
				menu.show();
				reloadScripts(null);
				shortcutsMakeMenu();
				setTimeout(keybindsMenuHandler, 1000);
			}),
			$("<button>").attr({'class':"btn btn-primary pull-left"}).text(getText('shortcutsAdd')).click(function(){
				w.withBody('.container-fluid').append(createTableRow([
					[4, $('<input>', { 'type': 'text', 'class': 'form-control' })],
					[7, keybindsGetBinds([null,null])],
					[1, '<button type="button" class="close pull-left" value="65.false.false.false"><span>&times;</span></button>']
				]));
				w.withBody(".close").click(function(e) { $(e.currentTarget).closest('.row').remove(); });
				w.withBody('input[type="text"]').keypress(function(e) { e.preventDefault(); });
			})
		]);
	}
	var out = createTableRow([[4, loca.GetText("QUL", "BuffQuestLostCompass_Sub4")],[7, loca.GetText("QUL", "TutMainSupport")],[1, ""]], true);
	$.each(menu.keybindings, function(item) {
		var keybind = item.split('.');
		var currentBind = "{0}{1}{2}{3}".format(keybind[1]=='true'&&'CTRL+'||'', keybind[3]=='true'&&'ALT+'||'', keybind[2]=='true'&&'SHIFT+'||'', keybindsFlippedKeys[keybind[0]]);
		if(menu.keybindings[item].isUser) {
			out += createTableRow([
				[4, $('<input>', { 'type': 'text', 'class': 'form-control', 'value': currentBind, 'disabled': true })],
				[7, $('<select>', { 'class': 'form-control key', 'disabled': true }).append(
					$('<option>', { 'selected': 'selected' }).text(keybindsCurrentBinds[menu.keybindings[item].fn.name][0][0])
				)], [1, '']
			]);
		} else {
			var selectorData = [ menu.keybindings[item].fn.name||menu.keybindings[item].fn, menu.keybindings[item].arg||null ];
			out += createTableRow([
				[4, $('<input>', { 'type': 'text', 'class': 'form-control', 'value': currentBind })],
				[7, keybindsGetBinds(selectorData)],
				[1, '<button type="button" class="close pull-left" value="'+item+'"><span>&times;</span></button>']
			]);
		}
	});
	w.Body().html('<div class="container-fluid">{0}</div>'.format(out));
	w.withBody('input[type="text"]').keypress(function(e) { e.preventDefault(); });
	w.withBody(".close").click(function(e) { $(e.currentTarget).closest('.row').remove(); });
	w.show();
}

