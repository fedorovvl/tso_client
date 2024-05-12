var LRUCache = function(size){
    this.capacity = size;
    this.store = {};
    this.tracker = [];
};

LRUCache.prototype.put = function (key, value)
{
	var e = this;
	if (!this.store[key] && Object.keys(this.store).length + 1 > this.capacity) {
      var invalidated = this.tracker[0];
      this.tracker.shift();
      delete this.store[invalidated];
    }

    if (this.store[key]) {
      this.tracker.splice(this.tracker.indexOf(key), 1);
    }
	
	value = mainSettings.shortAsGlobalRelative ? shortcutsGetPath(value, true) : value;
	
	if(this.store[this.tracker.slice(-1).pop()] == value) { 
		return;
	}
	
	if(mainSettings.lruDisableDuplicates) {
		Object.keys(this.store).filter(function(key) {  return e.store[key] == value; }).forEach(function(val) {
			e.tracker.splice(e.tracker.indexOf(parseInt(val)), 1);
			delete e.store[val];
		});
	}

    this.store[key] = value;
    this.tracker.push(key);
	try {
		updateLRUMenu();
	} catch (e) {
		alert("LRU exception" + e);
		debug(e);
	}
};

LRUCache.prototype.check = function(key)
{
	debug(this.store[key]);
	debug(this.tracker.indexOf(key));
}

function LRULoadLast(event)
{
	var module = event.target.name;
	if(!lruTemplate[module]) { return; }
	shortcutsMenuSelectedRetryHandler(lruTemplate[module].store[lruTemplate[module].tracker.slice(-1)[0]] + moduleToName[module].type, 0);
}

function updateLRUMenu()
{
	var m = [{ label: getText('btn_reset'), onSelect: function() { lruTemplate = {}; updateLRUMenu();  } }];
	$.each(lruTemplate, function(type) { 
		if(!moduleToName[type] || mainSettings.lruSkipModules.indexOf(type) > -1) { return; }
		m.push({ label: moduleToName[type].name + '↓', enabled: false });
		m.push({ label: moduleToName[type].name + ' → ' + loca.GetText("LAB", "ReplayBattle"), name: type, onSelect: LRULoadLast });
		[].concat(lruTemplate[type].tracker).reverse().forEach(function(key) { 
			m.push({ label: "[{0}] {1}".format(dtf.format(new window.runtime.Date(key)), lruTemplate[type].store[key].split("\\").pop().replace(/_/g, "[UNDERSCORE]")), name: "{0}-{1}".format(type, key), onSelect: LRUSelectedHandler });
		});
	});
	menu.nativeMenu.getItemByName("LRU").submenu = air.ui.Menu.createFromJSON(m);
}

function LRUSelectedHandler(event)
{
	var keyType = event.target.name.split('-');
	if(!moduleToName[keyType[0]].main) {
		return shortcutsMenuSelectedRetryHandler(lruTemplate[keyType[0]].store[keyType[1]] + moduleToName[keyType[0]].type, 0);
	}
	var data = loadFileWithRetry(lruTemplate[keyType[0]].store[keyType[1]], 0);
	moduleToName[keyType[0]].main();
	moduleToName[keyType[0]].loadFn(JSON.parse(data.data), data.name);
	lruTemplate[keyType[0]].put(Date.now(), lruTemplate[keyType[0]].store[keyType[1]]);
}

LRUCache.prototype.get = function(key)
{
	if (Object.keys(this.store).length + 1 > this.capacity) {
      this.tracker.splice(this.tracker.indexOf(key), 1);
      this.tracker.push(key);
    }
    return this.store[key] || -1;
};
