var LRUCache = function(size){
    this.capacity = size;
    this.store = {};
    this.tracker = [];
};

LRUCache.prototype.put = function (key, value)
{
	if (!this.store[key] && Object.keys(this.store).length + 1 > this.capacity) {
      var invalidated = this.tracker[0];
      this.tracker.shift();
      delete this.store[invalidated];
    }

    if (this.store[key]) {
      this.tracker.splice(this.tracker.indexOf(key), 1);
    }

    this.store[key] = value;
    this.tracker.push(key);
	updateLRUMenu();
};

function LRULoadLast(event)
{
	var module = event.target.name;
	if(!lruTemplate[module]) { return; }
	shortcutsMenuSelectedRetryHandler(lruTemplate[module].store[lruTemplate[module].tracker.slice(-1)[0]] + moduleToName[module].type, 1);
}

function updateLRUMenu()
{
	var m = [];
	$.each(lruTemplate, function(type) { 
		if(!moduleToName[type]) { return; }
		m.push({ label: moduleToName[type].name + '↓', enabled: false });
		m.push({ label: moduleToName[type].name + ' → ' + loca.GetText("LAB", "ReplayBattle"), name: type, onSelect: LRULoadLast });
		[].concat(lruTemplate[type].tracker).reverse().forEach(function(key) { 
			m.push({ label: "[{0}] {1}".format(dtf.format(new window.runtime.Date(key)), lruTemplate[type].store[key].split("\\").pop().replace(/_/g, "[UNDERSCORE]")), name: lruTemplate[type].store[key] + moduleToName[type].type, onSelect: shortcutsMenuSelectedHandler });
		});
	});
	menu.nativeMenu.getItemByName("LRU").submenu = air.ui.Menu.createFromJSON(m);
}

LRUCache.prototype.get = function(key)
{
	if (Object.keys(this.store).length + 1 > this.capacity) {
      this.tracker.splice(this.tracker.indexOf(key), 1);
      this.tracker.push(key);
    }
    return this.store[key] || -1;
};
