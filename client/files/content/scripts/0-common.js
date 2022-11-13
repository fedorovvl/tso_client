
function getImageTagModule(module, name, w, h)
{
	var bd = assets.GetDummyIcon("{0}:{1}".format(module, name)).bitmapData;
	return getImage(bd, w, h);
}

function getImage(bd, w, h)
{
	var ba = bd.encode(bd.rect, new window.runtime.flash.display.PNGEncoderOptions(true));
	b64encoder.encodeBytes(ba);
	return '<img style="width: {0};height: {1};" src="data:image/png;base64,{2}" />'.format(w ? w : 'auto', h ? h : 'auto', b64encoder.toString());
}

function getImageTag(name, w, h)
{
	var bd = assets.GetBitmapData(name);
	return getImage(bd, w, h);
}

function createToolsMenu()
{
	try{
	existing = window.nativeWindow.menu.getItemByName("Tools");
	if(existing != null) { 
		window.nativeWindow.menu.removeItem(existing);
		createToolsMenu();
		return;
	}
	toolsMenu = new air.NativeMenu();
	reloadItem = new air.NativeMenuItem(loca.GetText("LAB", "Update"));
	reloadItem.addEventListener(air.Event.SELECT, reloadScripts);
	updateItem = new air.NativeMenuItem(loca.GetText("LAB", "ToggleOptionsPanel"));
	updateItem.addEventListener(air.Event.SELECT, scriptsManager);
	toolsMenu.addItem(reloadItem);
	toolsMenu.addItem(updateItem);
	toolsMenu.addItem(new air.NativeMenuItem("", true));
	toolsItem = new air.NativeMenuItem(loca.GetText("RES", "Tool"));
	toolsItem.name = "Tools";
	toolsItem.submenu = toolsMenu;
	window.nativeWindow.menu.addItem(toolsItem);
	} catch(e) {alert(e);}
}

function createTableRow(data, isHeader)
{
	var out = '<div class="row">';
	var i = 0;
	data.forEach(function(item) {
		i++;
		out += '<div class="col-xs-{0} col-sm-{0} col-lg-{0} {2}" {1}>{3}</div>'.format(
			item[0],
			isHeader ? 'style="border-radius:{0};"'.format(i == 1 ? '10px 0px 0px 10px' : (i == data.length ? '0px 10px 10px 0px' : '0px')) : '',
			isHeader ? 'tblHeader ' + (item[2] ? item[2] : '') : (item[2] ? item[2] : ''),
			item[1]
		);
	});
	return out + '</div>';
}

function reloadScripts(event)
{
	$('script[id="user"]').remove();
	createToolsMenu();
	userKeyboardKeys = {};
	air.File.applicationDirectory.resolvePath("userscripts").getDirectoryListing().forEach(function(item) {
		$('head').append($("<script>").attr({ "src": "userscripts/" + item.name + "?" + new Date().getTime(), "id": "user", "type": "text/javascript"}));
	});
}

function createMenuItem(name, fn)
{
	var item = new air.NativeMenuItem(name);
	item.addEventListener(air.Event.SELECT, fn);
	return item;
}
		
function addMenuItem(name, fn, key, ctrl)
{
  item = new air.NativeMenuItem(name);
  if (typeof(fn) == 'function') {
	item.addEventListener(air.Event.SELECT, fn); 
  } else {
	item.submenu = fn;
  }
  window.nativeWindow.menu.addItem(item);
  addKeybBind(fn, key, ctrl);
}

function addToolsMenuItem(name, fn, key, ctrl)
{
	window.nativeWindow.menu.getItemByName("Tools").submenu.addItem(createMenuItem(name, fn));
	addKeybBind(fn, key, ctrl, true);
}

function addKeybBind(fn, key, ctrl, user)
{
	ctrl = ctrl ? ctrl : false;
    if(key != undefined) {
	  keyComb = key.toString() + ctrl.toString();
	  if (keyboardKeys[keyComb] || userKeyboardKeys[keyComb]) {
	  	  alert(key + " already binded");
		  return;
	  }
	  if(!user) {
		keyboardKeys[keyComb] = { "fn": fn };
	  } else {
		userKeyboardKeys[keyComb] = { "fn": fn };
	  }
    }
}

function createModalWindow(id, title)
{
	const modalId = "#" + id;
	if ($(modalId).length == 0) {
		// create new one by copying buffmodal
		$("#dummyModal").clone().attr('id', id).appendTo(".container");
		// change title
		$(modalId + " .modal-title").html(title);
		// change data id
		$(modalId + " .modal-body").attr('id', id + 'Data');
		// translate close button
		$(modalId + " .btnClose").text(loca.GetText("LAB", "Close"));
		// add flipflop
		$(modalId).on('show.bs.modal hide.bs.modal', function () { window.nativeWindow.stage.swapChildrenAt(0, 1); });
	}
}

function createSettingsWindow(id, savefunc, size)
{
	const modalId = "#{0}settings".format(id);
	if ($(modalId).length == 0) {
		// create new one by copying buffmodal
		$("#dummyModal").clone().attr('id', id + 'settings').appendTo(".container");
		// change title
		$(modalId + " .modal-title").addClass('text-center').html(loca.GetText("LAB", "ToggleOptionsPanel"));
		// change data id
		$(modalId + " .modal-body").attr('id', id + 'settingsData');
		// small Window
		$(modalId + " .modal-dialog").removeClass('modal-lg').addClass('modal-dialog-centered '+ (size ? size : ''));
		// translate close button
		$(modalId + " .btnClose").text(loca.GetText("LAB", "Close"));
		// add save button
		$(modalId + " .modal-footer").prepend([
			$('<button>').attr({ "class": "btn btn-primary pull-left" }).text(loca.GetText("LAB", "Save")),
		]);
		$(modalId + " .btn-primary").click(savefunc);
		$(modalId).on('hidden.bs.modal', function () { $(modalId).remove(); });
	}
}

function createSwitch(checkboxId, isChecked)
{
	return $('<label>', { 'class': "switch" })
		.append($('<input>', { 'type': 'checkbox', 'id': checkboxId, 'checked': isChecked }))
		.append($('<span/>', { 'class': 'slider round' })).prop('outerHTML');
}

function getText(id, module)
{
	searchPath = !module ? baseTranslation[gameLang] : baseTranslation[module][gameLang];
	backupPath = !module ? baseTranslation["en-uk"] : baseTranslation[module]["en-uk"];
	searchPath = typeof searchPath == "undefined" ? {} : searchPath;
	backupPath = typeof backupPath == "undefined" ? {} : backupPath;
	if(!searchPath[id] && !backupPath[id]) { return "RES not found : " + id; }
	return searchPath[id] ? searchPath[id] : backupPath[id];
}

function extendBaseLang(data, module)
{
	extend_data = { };
	if(module) {
		extend_data[module] = data;
	} else {
		extend_data = data;
	}
	$.extend(baseTranslation, extend_data);
}

//backward compatibility
function showAlert(message, sameLayer, level) {	showGameAlert(message); }
function showGameAlert(message){ game.showAlert(message); }
function storeSettings(data, module) { settings.store(data, module); }
function readSettings(key, module) { return settings.read(key, module); }

var Settings=function(){this.file=new air.File("file:///"+air.File.applicationDirectory.resolvePath("settings.json").nativePath),this.fs=new air.FileStream,this.settings={}};Settings.prototype={load:function(){try{this.file.exists&&(this.fs.open(this.file,"read"),this.settings=JSON.parse(this.fs.readUTF()),this.fs.close())}catch(t){alert("Error loading settings "+t)}},save:function(){try{this.fs.open(this.file,"write"),this.fs.writeUTF(JSON.stringify(this.settings,null,"  ")),this.fs.close()}catch(t){alert("Error saving settings "+t)}},store:function(t,s){(edata={})[s||"global"]=t,$.extend(!0,this.settings,edata),this.save()},read:function(t,s){try{if(s=s||"global",!this.settings[s]||t&&!this.settings[s][t])return null;return t?this.settings[s][t]:this.settings[s]}catch(i){alert("Settings read error "+i)}}};var SaveLoadTemplate=function(t,e){this.module=t,this.loadCallback=e,this.lastDir=settings.read(t+"lastDir")};SaveLoadTemplate.prototype={setModule:function(t){this.module=t;this.lastDir=settings.read(t+"lastDir")},save:function(t){var e=this;file=new air.File(this.getLastDir()).resolvePath("{0}Template.txt".format(this.module)),file.addEventListener(air.Event.COMPLETE,(function(t){var a={};a[e.module+"lastDir"]=t.target.parent.nativePath,e.lastDir=t.target.parent.nativePath,settings.store(a)})),file.save(JSON.stringify(t,null," "))},getLastDir:function(){return null!=this.lastDir?this.lastDir:air.File.documentsDirectory.nativePath},load:function(){var t=this;file=new air.File(this.getLastDir()),txtFilter=new air.FileFilter("All files","*.*"),file.browseForOpen("Open",[txtFilter]),file.addEventListener(air.Event.SELECT,(function(e){e.target.addEventListener(air.Event.COMPLETE,(function(e){try{var a=JSON.parse(e.target.data);t.loadCallback(a)}catch(t){return void alert(getText("bad_template"))}})),e.target.load()}))}};var TimedQueue=function(e){this.queue=[],this.index=0,this.defaultDelay=e||3e3};TimedQueue.prototype={add:function(e,t){this.queue.push({fn:e,delay:t})},run:function(e){(e||0===e)&&(this.index=e),this.next()},len:function(){return this.queue.length},next:function(){var e=this,t=this.index++,i=this.queue[t],n=this.queue[this.index];i&&(i.fn(),n&&setTimeout((function(){e.next()}),n.delay||this.defaultDelay))},reset:function(){this.index=0}};String.prototype.format=function(){var r=arguments;return this.replace(/{(\d+)}/g,(function(t,n){return void 0!==r[n]?r[n]:t}))};var xmlToJSON = function () { this.version = "1.3.4"; var e = { mergeCDATA: !0, grokAttr: !0, grokText: !0, normalize: !0, xmlns: !0, namespaceKey: "_ns", textKey: "_text", valueKey: "_value", attrKey: "_attr", cdataKey: "_cdata", attrsAsObject: !0, stripAttrPrefix: !0, stripElemPrefix: !0, childrenAsArray: !0 }, t = new RegExp(/(?!xmlns)^.*:/), r = new RegExp(/^\s+|\s+$/g); return this.grokType = function (e) { return /^\s*$/.test(e) ? null : /^(?:true|false)$/i.test(e) ? "true" === e.toLowerCase() : isFinite(e) ? parseFloat(e) : e }, this.parseString = function (e, t) { return this.parseXML(this.stringToXML(e), t) }, this.parseXML = function (a, n) { for (var s in n) e[s] = n[s]; var l = {}, i = 0, o = ""; if (e.xmlns && a.namespaceURI && (l[e.namespaceKey] = a.namespaceURI), a.attributes && a.attributes.length > 0) { var c = {}; for (i; i < a.attributes.length; i++) { var u = a.attributes.item(i); m = {}; var p = ""; p = e.stripAttrPrefix ? u.name.replace(t, "") : u.name, e.grokAttr ? m[e.valueKey] = this.grokType(u.value.replace(r, "")) : m[e.valueKey] = u.value.replace(r, ""), e.xmlns && u.namespaceURI && (m[e.namespaceKey] = u.namespaceURI), e.attrsAsObject ? c[p] = m : l[e.attrKey + p] = m } e.attrsAsObject && (l[e.attrKey] = c) } if (a.hasChildNodes()) for (var y, d, m, h = 0; h < a.childNodes.length; h++)4 === (y = a.childNodes.item(h)).nodeType ? e.mergeCDATA ? o += y.nodeValue : l.hasOwnProperty(e.cdataKey) ? (l[e.cdataKey].constructor !== Array && (l[e.cdataKey] = [l[e.cdataKey]]), l[e.cdataKey].push(y.nodeValue)) : e.childrenAsArray ? (l[e.cdataKey] = [], l[e.cdataKey].push(y.nodeValue)) : l[e.cdataKey] = y.nodeValue : 3 === y.nodeType ? o += y.nodeValue : 1 === y.nodeType && (0 === i && (l = {}), d = e.stripElemPrefix ? y.nodeName.replace(t, "") : y.nodeName, m = xmlToJSON.parseXML(y), l.hasOwnProperty(d) ? (l[d].constructor !== Array && (l[d] = [l[d]]), l[d].push(m)) : (e.childrenAsArray ? (l[d] = [], l[d].push(m)) : l[d] = m, i++)); else o || (e.childrenAsArray ? (l[e.textKey] = [], l[e.textKey].push(null)) : l[e.textKey] = null); if (o) if (e.grokText) { var x = this.grokType(o.replace(r, "")); null !== x && void 0 !== x && (l[e.textKey] = x) } else e.normalize ? l[e.textKey] = o.replace(r, "").replace(/\s+/g, " ") : l[e.textKey] = o.replace(r, ""); return l }, this.xmlToString = function (e) { try { return e.xml ? e.xml : (new XMLSerializer).serializeToString(e) } catch (e) { return null } }, this.stringToXML = function (e) { try { var t = null; return window.DOMParser ? t = (new DOMParser).parseFromString(e, "text/xml") : (t = new ActiveXObject("Microsoft.XMLDOM"), t.async = !1, t.loadXML(e), t) } catch (e) { return null } }, this }.call({}); "undefined" != typeof module && null !== module && module.exports ? module.exports = xmlToJSON : "function" == typeof define && define.amd && define(function () { return xmlToJSON });