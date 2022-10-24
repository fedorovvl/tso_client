var TimedQueue = function(defaultDelay){
    this.queue = [];
    this.index = 0;
    this.defaultDelay = defaultDelay || 3000;
};

TimedQueue.prototype = {
    add: function(fn, delay){
        this.queue.push({
            fn: fn,
            delay: delay
        });
    },
    run: function(index){
        (index || index === 0) && (this.index = index);
        this.next();
    },
	len: function(){
		return this.queue.length;
	},
    next: function(){
        var self = this
        , i = this.index++
        , at = this.queue[i]
        , next = this.queue[this.index]
        if(!at) return;
        at.fn();
        next && setTimeout(function(){
            self.next();
        }, next.delay||this.defaultDelay);
    },
    reset: function(){
        this.index = 0;
    }
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
	toolsMenu.addItem(reloadItem);
	toolsMenu.addItem(new air.NativeMenuItem("", true));
	toolsItem = new air.NativeMenuItem(loca.GetText("RES", "Tool"));
	toolsItem.name = "Tools";
	toolsItem.submenu = toolsMenu;
	window.nativeWindow.menu.addItem(toolsItem);
	} catch(e) {alert(e);}
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

function createModalWindow(id, title)
{
	const modalId = "#" + id;
	if ($(modalId).length == 0) {
		// create new one by copying buffmodal
		$("#buffModal").clone().attr('id', id).appendTo(".container");
		// change title
		$(modalId + " .modal-title").text(title);
		// change data id
		$(modalId + " .modal-body").attr('id', id + 'Data');
		// remove buttons except close
		$(modalId + " .modal-footer button:not(.btn-danger)").remove();
		// add flipflop
		$(modalId).on('show.bs.modal hide.bs.modal', function () { window.nativeWindow.stage.swapChildrenAt(0, 1); });
	}
}

function addToolsMenuItem(name, fn, key, ctrl)
{
	existing = window.nativeWindow.menu.getItemByName("Tools");
	item = new air.NativeMenuItem(name);
	item.addEventListener(air.Event.SELECT, fn); 
	existing.submenu.addItem(item);
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

function showAlert(message, sameLayer, level)
{
	$('#'+level+'alertMessage').text(message);
	if(!sameLayer) { window.nativeWindow.stage.swapChildrenAt(0, 1); }
	$('.alert-'+level).show(500);
	setTimeout(function(){ 
		$('.alert-'+level).hide(500);
		if(!sameLayer) setTimeout(function(){ window.nativeWindow.stage.swapChildrenAt(0, 1); }, 500);
	}, 1500);
}

function saveLastDir(type, dir)
{
	try{
		file = new air.File("file:///" + air.File.applicationDirectory.resolvePath(type + "lastDir.dat").nativePath);
		var fileStream = new air.FileStream();
		fileStream.open(file, air.FileMode.WRITE);
		fileStream.writeUTF(dir);
		fileStream.close();
	}catch(e){}
}

function readLastDir(type)
{
	try{
		file = new air.File("file:///" + air.File.applicationDirectory.resolvePath(type + "lastDir.dat").nativePath);
		if(file.exists) {
			var fileStream = new air.FileStream();
			fileStream.open(file, air.FileMode.READ);
			dir = fileStream.readUTF();
			fileStream.close();
			return dir;
		}
	}catch(e){ return air.File.documentsDirectory.nativePath; }
	return air.File.documentsDirectory.nativePath;
}

var xmlToJSON = function () { this.version = "1.3.4"; var e = { mergeCDATA: !0, grokAttr: !0, grokText: !0, normalize: !0, xmlns: !0, namespaceKey: "_ns", textKey: "_text", valueKey: "_value", attrKey: "_attr", cdataKey: "_cdata", attrsAsObject: !0, stripAttrPrefix: !0, stripElemPrefix: !0, childrenAsArray: !0 }, t = new RegExp(/(?!xmlns)^.*:/), r = new RegExp(/^\s+|\s+$/g); return this.grokType = function (e) { return /^\s*$/.test(e) ? null : /^(?:true|false)$/i.test(e) ? "true" === e.toLowerCase() : isFinite(e) ? parseFloat(e) : e }, this.parseString = function (e, t) { return this.parseXML(this.stringToXML(e), t) }, this.parseXML = function (a, n) { for (var s in n) e[s] = n[s]; var l = {}, i = 0, o = ""; if (e.xmlns && a.namespaceURI && (l[e.namespaceKey] = a.namespaceURI), a.attributes && a.attributes.length > 0) { var c = {}; for (i; i < a.attributes.length; i++) { var u = a.attributes.item(i); m = {}; var p = ""; p = e.stripAttrPrefix ? u.name.replace(t, "") : u.name, e.grokAttr ? m[e.valueKey] = this.grokType(u.value.replace(r, "")) : m[e.valueKey] = u.value.replace(r, ""), e.xmlns && u.namespaceURI && (m[e.namespaceKey] = u.namespaceURI), e.attrsAsObject ? c[p] = m : l[e.attrKey + p] = m } e.attrsAsObject && (l[e.attrKey] = c) } if (a.hasChildNodes()) for (var y, d, m, h = 0; h < a.childNodes.length; h++)4 === (y = a.childNodes.item(h)).nodeType ? e.mergeCDATA ? o += y.nodeValue : l.hasOwnProperty(e.cdataKey) ? (l[e.cdataKey].constructor !== Array && (l[e.cdataKey] = [l[e.cdataKey]]), l[e.cdataKey].push(y.nodeValue)) : e.childrenAsArray ? (l[e.cdataKey] = [], l[e.cdataKey].push(y.nodeValue)) : l[e.cdataKey] = y.nodeValue : 3 === y.nodeType ? o += y.nodeValue : 1 === y.nodeType && (0 === i && (l = {}), d = e.stripElemPrefix ? y.nodeName.replace(t, "") : y.nodeName, m = xmlToJSON.parseXML(y), l.hasOwnProperty(d) ? (l[d].constructor !== Array && (l[d] = [l[d]]), l[d].push(m)) : (e.childrenAsArray ? (l[d] = [], l[d].push(m)) : l[d] = m, i++)); else o || (e.childrenAsArray ? (l[e.textKey] = [], l[e.textKey].push(null)) : l[e.textKey] = null); if (o) if (e.grokText) { var x = this.grokType(o.replace(r, "")); null !== x && void 0 !== x && (l[e.textKey] = x) } else e.normalize ? l[e.textKey] = o.replace(r, "").replace(/\s+/g, " ") : l[e.textKey] = o.replace(r, ""); return l }, this.xmlToString = function (e) { try { return e.xml ? e.xml : (new XMLSerializer).serializeToString(e) } catch (e) { return null } }, this.stringToXML = function (e) { try { var t = null; return window.DOMParser ? t = (new DOMParser).parseFromString(e, "text/xml") : (t = new ActiveXObject("Microsoft.XMLDOM"), t.async = !1, t.loadXML(e), t) } catch (e) { return null } }, this }.call({}); "undefined" != typeof module && null !== module && module.exports ? module.exports = xmlToJSON : "function" == typeof define && define.amd && define(function () { return xmlToJSON });