var LRUCache = function(size){
    this.capacity = size;
    this.store = {};
    this.tracker = [];
};

Array.prototype.findIndex = function(callback)
{
  var list = Object(this);
  var length = list.length >>> 0;
  var thisArg = arguments[1];
  for (var i = 0; i < length; i++) {
    if ( callback.call(thisArg, list[i], i, list) ) {
      return i;
    }
  }
  return -1;
};

LRUCache.prototype.put = function (key, value)
{
	if (!this.store[key] && Object.keys(this.store).length + 1 > this.capacity) {
      var invalidated = this.tracker[0];
      this.tracker.shift();
      delete this.store[invalidated];
    }

    if (this.store[key]) {
      this.tracker.splice(this.tracker.findIndex(function(elem) { return elem === key }), 1);
    }

    this.store[key] = value;
    this.tracker.push(key);
	updateLRUMenu();
};

function updateLRUMenu()
{
	var m = [];
	$.each(lruTemplate, function(type) { 
		m.push({ label: moduleToName[type].name + '↓', enabled: false });
		[].concat(lruTemplate[type].tracker).reverse().forEach(function(key) { 
			m.push({ label: "[{0}] {1}".format(dtf.format(new window.runtime.Date(key)), lruTemplate[type].store[key].split("\\").pop().replace(/_/g, "[UNDERSCORE]")), name: lruTemplate[type].store[key] + moduleToName[type].type, onSelect: shortcutsMenuSelectedHandler });
		});
	});
	menu.nativeMenu.getItemByName("LRU").submenu = air.ui.Menu.createFromJSON(m);
}

LRUCache.prototype.get = function(key)
{
	if (Object.keys(this.store).length + 1 > this.capacity) {
      this.tracker.splice(this.tracker.findIndex(function(elem) { return elem === key }), 1);
      this.tracker.push(key);
    }
    return this.store[key] || -1;
};
