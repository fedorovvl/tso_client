




(function () {
'use strict';

var MODAL_ID = 'EventRefillModal';
var VERSION   = '1.6.0';
var STORE_KEY = 'tso.refill.state.v1';
var W = (typeof unsafeWindow !== 'undefined') ? unsafeWindow : window;

var disposed = false;
var previous = W.__TSO_REFILL__;
if (previous && typeof previous.dispose === 'function') previous.dispose();


function esc(value) {
  return String(value == null ? '' : value).replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}
function safe(fn, def) { try { var v = fn(); return (v === undefined || v === null) ? def : v; } catch (e) { return def; } }
function clamp(v, a, b) { return v < a ? a : (v > b ? b : v); }
function num(v, d) { v = parseFloat(v); return isFinite(v) ? v : d; }
function fmtInt(n) { return String(Math.round(n)).replace(/\B(?=(\d{3})+(?!\d))/g, ' '); }
/* Source: references/xml/en_lang.xml; UI text comes only from the active game locale. */
function tr(group, key, args) {
  try {
    if (typeof loca !== 'undefined' && loca.GetText &&
        (!loca.hasText || loca.hasText(group, key))) {
      var text = loca.GetText(group, key, args || null);
      if (text && text !== 'undefined' && text.charAt(0) !== '[') return String(text);
    }
  } catch (e) {}
  return '—';
}
function txt(key) { return tr('LAB', key); }
function titleTimeText() {
  
  // If this language uses different word forms, keep the complete localized Duration label.
  var production = txt('DetailsProductionTime').split(/[\s:.,;!?–—()]+/);
  var remaining = txt('TimeRemaining').toLowerCase().split(/[\s:.,;!?–—()]+/);
  var word = '';
  for (var i = 0; i < production.length; i++) {
    for (var j = 0; j < remaining.length; j++) {
      if (production[i].length >= 3 && production[i].toLowerCase() === remaining[j] && production[i].length > word.length) word = production[i];
    }
  }
  return word ? word.charAt(0).toUpperCase() + word.slice(1) : txt('Duration');
}
function titleText() { return titleTimeText() + ' ' + txt('DetailsDeposit'); }
function pad02(n) { return n < 10 ? '0' + n : String(n); }
function editDuration(ms) {
  var minutes = Math.max(0, Math.ceil(num(ms,0) / 60000));
  return pad02(Math.floor(minutes / 1440)) + ':' + pad02(Math.floor(minutes % 1440 / 60)) + ':' + pad02(minutes % 60);
}
function fmtDur(ms) {
  if (ms === Infinity) return '∞';
  if (ms == null || !isFinite(ms) || ms < 0) return txt('NotAvailable');
  var minutes = Math.max(0, Math.ceil(ms / 60000));
  return tr('FOR','DaysShort',[Math.floor(minutes / 1440)]) + ' ' +
    tr('FOR','HoursShort',[Math.floor(minutes % 1440 / 60)]) + ' ' +
    tr('FOR','MinutesShort',[minutes % 60]);
}
function parseManual(value) {
  var m = String(value || '').replace(/\s/g,'').match(/^(\d{1,4}):(\d{1,2}):(\d{1,2})$/);
  if (!m || Number(m[2]) > 23 || Number(m[3]) > 59) return NaN;
  return (Number(m[1]) * 1440 + Number(m[2]) * 60 + Number(m[3])) * 60000;
}


function gi() {
  if (W.swmmo && W.swmmo.application && W.swmmo.application.mGameInterface) {
    return W.swmmo.application.mGameInterface;
  }
  var g = W.game;
  return (g && g.gi) ? g.gi : null;
}

function zone() {
  var g = gi();
  return g ? g.mCurrentPlayerZone : null;
}

function serverNow() {
  var t = safe(function () { return W.TimeUtil.getServerTime(); }, 0);
  if (typeof t === 'number' && t > 1e12) return t;
  var ct = safe(function () { return gi().GetClientTime(); }, 0);
  if (typeof ct === 'number' && ct > 1e12) return ct;
  return Date.now();
}

function each(container, fn) {
  if (!container) return;
  try {
    if (typeof container.forEach === 'function') {
      container.forEach(fn);
      return;
    }
    var arr = container.mContainer || container.mList || container;
    if (Array.isArray(arr)) {
      for (var i = 0; i < arr.length; i++) {
        if (arr[i]) fn(arr[i]);
      }
      return;
    }
    if (typeof container.getVector === 'function') {
      each(container.getVector(), fn);
      return;
    }
    var n = safe(function () { return container.length; }, -1);
    if (n < 0) n = safe(function () { return container.mLength; }, -1);
    if (n >= 0) {
      for (var j = 0; j < n; j++) {
        var v = (typeof container.get === 'function') ? safe(function () { return container.get(j); }, null) : container[j];
        if (v) fn(v);
      }
    }
  } catch (e) {
    console.warn('[refill] each error', e);
  }
}

function gridOf(obj) {
  if (obj == null) return null;
  if (typeof obj === 'number') {
    return { idx: obj, key: String(obj), raw: obj };
  }
  var p = safe(function () { return typeof obj.GetGrid === 'function' ? obj.GetGrid() : obj; }, null);
  if (p == null) return null;
  if (typeof p === 'number') {
    return { idx: p, key: String(p), raw: p };
  }
  var idx = safe(function () { return p.GetGrid ? p.GetGrid() : (p.gridIdx !== undefined ? p.gridIdx : null); }, null);
  if (typeof idx === 'number') {
    return { idx: idx, key: String(idx), raw: idx };
  }
  var x = safe(function () { return p.GetX ? p.GetX() : p.x; }, null);
  var y = safe(function () { return p.GetY ? p.GetY() : p.y; }, null);
  if (typeof x === 'number' && typeof y === 'number') {
    return { idx: x, key: x + ':' + y, raw: p };
  }
  return null;
}


function allowedResource(name) {
  return !!name && name !== 'Wood' && name !== 'RealWood' && name !== 'MahoganyWood';
}
var RES = {
  HalloweenResource: { ev: /halloween|pumpkin/i },
  ValentinesFlower: { ev: /valentin|flower/i }
};
/* Exact GuiIcon IDs from references/xml/icons.xml (iconspack, not RES). */
var DEPOSIT_ICONS = {
  Wood: 'DepositWood', RealWood: 'DepositRealWood', ExoticWood: 'DepositExoticWood',
  Fish: 'DepositFish', Meat: 'DepositMeat', Stone: 'DepositStone', Granite: 'DepositGranite',
  Marble: 'DepositMarble', IronOre: 'DepositIronOre', GoldOre: 'DepositGoldOre', Water: 'DepositWater',
  Corn: 'DepositCorn', Coal: 'DepositCoal', BronzeOre: 'DepositBronzeOre', Salpeter: 'DepositSalpeter',
  TitaniumOre: 'DepositTitaniumOre', HalloweenResource: 'DepositHalloweenResource',
  ValentinesFlower: 'DepositValentinesFlower', HardCurrency: 'DepositHardCurrency',
  CrystalShard: 'DepositCrystalShard', MahoganyWood: 'DepositMahoganyWood',
  PlatinumOre: 'DepositPlatinumOre', ChristmasResource: 'DepositChristmasResource',
  Oilseed: 'DepositOilseed', StarfallStarShards: 'DepositStarfallStarShards'
};
function resMeta(name) {
  return { label: tr('RES', name), icon: DEPOSIT_ICONS[name] || '', ev: RES[name] ? RES[name].ev : null };
}
var iconCache = {};
function imageFrom(module, name, size) {
  if (!name) return '';
  var key = module + ':' + name + ':' + size;
  if (iconCache.hasOwnProperty(key)) return iconCache[key];
  var html = '';
  try {
    // GetGfx returns a 1x1 dummy Bitmap for unknown names, which also encodes as <img>.
    // Inspect bitmap dimensions before encoding so missing assets cannot masquerade as valid icons.
    if (typeof assets !== 'undefined' && assets.GetDummyIcon && typeof getImage === 'function') {
      var bitmap = assets.GetDummyIcon(module + ':' + name);
      var data = bitmap && bitmap.bitmapData;
      if (data && data.width > 1 && data.height > 1) html = getImage(data, size, size);
    } else if (typeof getImageByModule === 'function') {
      html = getImageByModule(module, name, size, size);
    }
  } catch (e) {}
  if (/<img\b/i.test(html)) iconCache[key] = html;
  // Do not cache misses; the icon pack may still be loading.
  return /<img\b/i.test(html) ? html : '';
}
function depositIcon(res, size) {
  var meta = resMeta(res);
  var html = imageFrom('iconspack', meta.icon, size) || imageFrom('resources', res, size);
  return html || '<span class="tsr-icon-missing" title="' + esc(meta.label) + '">◇</span>';
}
function gotoIcon(size) {
  var key = 'goto:' + size;
  if (iconCache.hasOwnProperty(key)) return iconCache[key];
  var html = '';
  try {
    if (typeof assets !== 'undefined' && assets.GetBitmapData && typeof getImage === 'function') {
      var data = assets.GetBitmapData('accuracy.png');
      if (data && data.width > 1 && data.height > 1) html = getImage(data,size,size);
    } else if (typeof getImageTag === 'function') html = getImageTag('accuracy.png',size,size);
  } catch (e) {}
  if (/<img\b/i.test(html)) iconCache[key] = html;
  return /<img\b/i.test(html) ? html : '◎';
}


var DEFAULTS = {
  resource: '', eventKey: '',
  manualEventMs: 0, manualSetAt: 0,
  eventMode: ''
};
var state = load();

function load() {
  var s = {};
  for (var k in DEFAULTS) if (DEFAULTS.hasOwnProperty(k)) s[k] = DEFAULTS[k];
  try {
    var raw = localStorage.getItem(STORE_KEY);
    if (raw) { var o = JSON.parse(raw); for (var j in o) if (o.hasOwnProperty(j)) s[j] = o[j]; }
  } catch (e) {}
  delete s.manualCycleMin;delete s.defaultCycleMin;delete s.speedFactor;
  if (s.eventMode !== 'auto' && s.eventMode !== 'manual' && s.eventMode !== 'event') {
    s.eventMode = s.eventKey ? 'event' : (s.manualEventMs > 0 ? 'manual' : 'auto');
  }
  delete s.buffStrength;
  delete s.queueDelay;
  return s;
}

var saveTimer = 0;
function save() {
  if (disposed) return;
  clearTimeout(saveTimer);
  saveTimer = setTimeout(function () {
    if (!disposed) persist();
  }, 300);
}


function readNumber(fn) {
  var value = safe(fn, null);
  return typeof value === "number" && isFinite(value) ? value : NaN;
}

function clientClock() {
  var t = readNumber(function() { return gi().GetClientTime(); });
  if (isFinite(t) && t > 1e12) return t;
  return serverNow();
}

function timeScale() {
  var value = readNumber(function() { return gi().mGlobalTimeScale; });
  return isFinite(value) && value > 0 ? value : 1;
}

function scanWorld() {
  var world = { deposits: [], producers: [], ok: false };
  var z = zone();
  if (!z) return world;
  var map = safe(function () { return z.mStreetDataMap; }, null);
  if (!map) return world;

  if (map.mDepositContainer) {
    each(map.mDepositContainer, function (d) {
      if (!d) return;
      var g = gridOf(safe(function () { return d.GetGrid(); }, null));
      if (!g) return;
      var resourceName = String(safe(function () { return d.GetName_string(); }, "") || "");
      if (!allowedResource(resourceName)) return;
      world.deposits.push({
        raw: d, grid: g, key: g.key,
        res: resourceName,
        amount: Math.max(0, safe(function () { return d.GetAmount(); }, 0) | 0),
        max:    Math.max(0, safe(function () { return d.GetMaxAmount(); }, 0) | 0)
      });
    });
  }

  if (map.mBuildingContainer) {
    each(map.mBuildingContainer, function(b) {
      if (!b) return;
      var rcd = safe(function() { return b.GetResourceCreation(); }, null);
      if (!rcd) return;
      var def = safe(function() { return rcd.GetResourceCreationDefinition(); }, null);
      if (!def) return;
      var depRes = String(safe(function() { return def.externalResource_string; }, "") || "");
      var removed = readNumber(function() { return def.amountRemoved; });
      if (!depRes || !isFinite(removed) || removed < 0) return;
      var g = gridOf(safe(function() { return b.GetGrid(); }, null));
      if (!g) return;
      var dg = gridOf(safe(function() { return rcd.GetDepositBuildingGridPos(); }, null));
      if (dg && dg.idx < 0) dg = null;
      world.producers.push({
        raw: b,
        grid: g,
        depGrid: dg,
        rcd: rcd,
        definition: def,
        depRes: depRes
      });
    });
  }

  world.ok = true;
  return world;
}

function resolveProducers(world, dep) {
  var out = [];
  for (var i = 0; i < world.producers.length; i++) {
    var p = world.producers[i];
    if (p.depRes === dep.res) {
      if ((p.depGrid && p.depGrid.key === dep.key) || (p.grid && p.grid.key === dep.key)) {
        out.push(p);
      }
    }
  }
  return out;
}

function getActiveBuff(b, scale) {
  var now = clientClock();
  var pb = safe(function() { return b.productionBuff; }, null);
  if (pb && safe(function() { return pb.IsActive(now); }, false)) {
    var def = safe(function() { return pb.GetBuffDefinition(); }, null);
    if (def) {
      var app = safe(function() { return pb.GetApplicanceMode(); }, 0);
      var dur = readNumber(function() { return def.getDuration(app); });
      var start = readNumber(function() { return pb.GetStartTime(); });
      var rem = isFinite(dur) && isFinite(start) ? (start + dur - now) / scale : 0;
      var name = safe(function() { return String(def.GetName_string()); }, "");
      if (rem > 0) {
        return { name: tr("RES", name) || name, remainMs: rem, raw: pb };
      }
    }
  }
  var buffs = safe(function() { return b.GetBuffs(); }, null);
  var found = null;
  each(buffs, function(item) {
    if (found || !item) return;
    if (safe(function() { return item.IsActive(now); }, false)) {
      var def2 = safe(function() { return item.GetBuffDefinition(); }, null);
      if (def2) {
        var app2 = safe(function() { return item.GetApplicanceMode(); }, 0);
        var dur2 = readNumber(function() { return def2.getDuration(app2); });
        var start2 = readNumber(function() { return item.GetStartTime(); });
        var rem2 = isFinite(dur2) && isFinite(start2) ? (start2 + dur2 - now) / scale : 0;
        var name2 = safe(function() { return String(def2.GetName_string()); }, "");
        if (rem2 > 0) {
          found = { name: tr("RES", name2) || name2, remainMs: rem2, raw: item };
        }
      }
    }
  });
  return found;
}

function getBuildingTimes(b, rcd, scale) {
  var uiCycle = readNumber(function() { return b.CalculateWays(); });

  var warehouseMs = readNumber(function() { return b.getWarehouseToWorkyardTime(); });
  if (!(warehouseMs >= 0)) {
    warehouseMs = readNumber(function() { return b.calculateWarehouseTransporttime(); });
  }
  if (!(warehouseMs >= 0)) {
    var p = safe(function() { return rcd.GetPath(); }, null);
    if (p && isFinite(p.pathLenX10000)) warehouseMs = (p.pathLenX10000 / 5) / scale;
  }
  if (!(warehouseMs >= 0)) warehouseMs = 0;

  var depositMs = readNumber(function() { return b.getWorkyardToDepositTime(); });
  if (!(depositMs >= 0)) {
    var dp = safe(function() { return rcd.GetDepositPath(); }, null);
    if (dp && isFinite(dp.pathLenX10000) && dp.pathLenX10000 > 0) {
      depositMs = (dp.pathLenX10000 / 5) / scale;
    } else {
      depositMs = 0;
    }
  }
  if (!(depositMs >= 0)) depositMs = 0;

  var rawWorkSec = readNumber(function() { return rcd.GetWorkTime(); });
  if (!(rawWorkSec > 0)) {
    var def = safe(function() { return rcd.GetResourceCreationDefinition(); }, null);
    if (def) rawWorkSec = readNumber(function() { return def.workTime; });
  }
  var workMs = (rawWorkSec > 0 ? rawWorkSec * 1000 : 60000) / scale;

  var cycleMs = uiCycle;
  if (!(cycleMs > 0)) {
    cycleMs = workMs + 2 * warehouseMs + 2 * depositMs;
  }
  if (cycleMs > 0 && !(workMs > 0)) {
    workMs = Math.max(0, cycleMs - 2 * warehouseMs - 2 * depositMs);
  }

  return {
    cycleMs: Math.max(1000, cycleMs),
    warehouseMs: warehouseMs,
    depositMs: depositMs,
    workMs: workMs
  };
}

function measure(dep, prod) {
  var m = {
    prod: prod,
    working: false,
    cycleMs: 60000,
    warehouseMs: 0,
    depositMs: 0,
    workMs: 60000,
    perCycle: 1,
    perCycleBase: 1,
    rateBuff: 0,
    rateBase: 0,
    buff: null,
    buffRemainMs: 0
  };
  if (!prod) return m;

  var b = prod.raw;
  var rcd = prod.rcd;
  var def = prod.definition;
  var scale = timeScale();

  var active = safe(function() { return b.IsProductionActive(); }, false) === true;
  var upgrading = safe(function() { return b.IsUpgradeInProgress(); }, false) === true;
  var pState = readNumber(function() { return rcd.GetProductionState(); });
  m.working = active && !upgrading && (pState === 0 || pState === 2 || !isFinite(pState));

  var times = getBuildingTimes(b, rcd, scale);
  m.cycleMs = times.cycleMs;
  m.warehouseMs = times.warehouseMs;
  m.depositMs = times.depositMs;
  m.workMs = times.workMs;

  var removed = readNumber(function() { return def.amountRemoved; });
  if (!isFinite(removed) || removed < 0) removed = 1;

  var bonuses = safe(function() { return b.GetUpgradeLevelBonuses(); }, null);
  var baseFactor = 1;
  if (bonuses) {
    var bPct = readNumber(function() { return bonuses.getProductivityInputPercent(); });
    if (isFinite(bPct) && bPct > 0) baseFactor = Math.floor(bPct / 100);
  }

  var factor = readNumber(function() { return b.GetResourceInputFactor(); });
  if (!isFinite(factor) || factor < 1) factor = baseFactor;

  m.perCycle = removed * factor;
  m.perCycleBase = removed * Math.max(1, baseFactor);

  m.buff = getActiveBuff(b, scale);
  m.buffRemainMs = m.buff ? m.buff.remainMs : 0;

  if (m.working && m.cycleMs > 0) {
    m.rateBuff = m.perCycle / m.cycleMs;
    m.rateBase = m.perCycleBase / m.cycleMs;
  }

  return m;
}

function readEvents() {
  var out = [];
  var em = safe(function () { return gi().mEventManager; }, null);
  if (!em) return out;
  var list = safe(function () { return em.GetActiveVisibleEvents(); }, []);
  each(list, function (ev) {
    var name = String(safe(function () { return ev.event_name_string; }, "") || "");
    var stop = Number(safe(function () { return ev.stopDate; }, 0));
    if (!(stop > 0) && name) stop = Number(safe(function () { return em.GetEventStopDate(name); }, 0));
    if (name && isFinite(stop) && stop > serverNow()) out.push({name:name,stopTs:stop});
  });
  return out;
}

function eventRemain(events, resource) {
  var now = serverNow();
  if (state.eventMode === "manual") {
    return Math.max(0, num(state.manualEventMs, 0) - Math.max(0, now - num(state.manualSetAt, now)));
  }
  if (state.eventMode === "event") {
    for (var i = 0; i < events.length; i++) {
      if (events[i].name === state.eventKey) return Math.max(0, events[i].stopTs - now);
    }
    return 0;
  }
  var meta = resMeta(resource || state.resource);
  if (meta.ev) {
    for (var j = 0; j < events.length; j++) {
      if (meta.ev.test(events[j].name) && events[j].stopTs > now) return events[j].stopTs - now;
    }
  }
  return 0;
}

function computeRow(dep, producers, evRem) {
  if (!Array.isArray(producers)) producers = producers ? [producers] : [];
  var models = [];
  var hasWorking = false;
  var totalRateBuff = 0;
  var totalRateBase = 0;
  var minBuffRemMs = 0;
  var anyBuffed = false;

  for (var i = 0; i < producers.length; i++) {
    var m = measure(dep, producers[i]);
    models.push(m);
    if (m.working && (m.rateBuff > 0 || m.rateBase > 0)) {
      hasWorking = true;
      totalRateBuff += m.rateBuff;
      totalRateBase += m.rateBase;
      if (m.buffRemainMs > 0) {
        anyBuffed = true;
        if (!minBuffRemMs || m.buffRemainMs < minBuffRemMs) {
          minBuffRemMs = m.buffRemainMs;
        }
      }
    }
  }

  var amount = dep.amount;
  var dryMs = Infinity;

  if (hasWorking && (totalRateBuff > 0 || totalRateBase > 0)) {
    if (amount <= 0) {
      dryMs = 0;
    } else {
      var buffSpan = anyBuffed ? minBuffRemMs : 0;
      var consumedDuringBuff = totalRateBuff * buffSpan;
      if (consumedDuringBuff >= amount || !(totalRateBase > 0)) {
        dryMs = amount / totalRateBuff;
      } else {
        var remainingAmount = amount - consumedDuringBuff;
        dryMs = buffSpan + (remainingAmount / totalRateBase);
      }
    }
  }

  var needBuff = null;
  if (anyBuffed && minBuffRemMs > 0 && totalRateBuff > 0) {
    var consumedBuff = Math.ceil(totalRateBuff * minBuffRemMs);
    needBuff = Math.max(0, consumedBuff - amount);
  }

  var needEvent = null;
  if (evRem > 0 && (totalRateBuff > 0 || totalRateBase > 0)) {
    var tBuff = anyBuffed ? Math.min(evRem, minBuffRemMs) : 0;
    var tBase = Math.max(0, evRem - tBuff);
    var consumedEv1 = totalRateBuff * tBuff;
    var consumedEv2 = totalRateBase * tBase;
    var totalConsumedEvent = Math.ceil(consumedEv1 + consumedEv2);
    needEvent = Math.max(0, totalConsumedEvent - amount);
  }

  var cap = dep.max > 0 ? (dep.max - dep.amount) : Infinity;
  var overCap = (needEvent != null && needEvent > cap);

  var status = "ok";
  if (dryMs !== Infinity && isFinite(dryMs)) {
    if (anyBuffed && minBuffRemMs > 0 && dryMs < minBuffRemMs) {
      status = "crit";
    } else if (evRem > 0 && dryMs < evRem) {
      status = "warn";
    }
  }

  var ratePerHour = hasWorking ? (totalRateBuff * 3600000) : 0;

  return {
    dep: dep,
    models: models,
    prod: producers[0] || null,
    known: true,
    hasWorking: hasWorking,
    cycleMs: models.length === 1 ? models[0].cycleMs : null,
    perCycle: models.length === 1 ? models[0].perCycle : null,
    amount: dep.amount,
    max: dep.max,
    buffRemMs: minBuffRemMs,
    eventRemMs: evRem,
    dryMs: dryMs,
    needBuff: needBuff,
    needEvent: needEvent,
    capRoom: cap,
    overCap: overCap,
    ratePerHour: ratePerHour,
    status: status
  };
}

function fmtCycle(ms) {
  if (ms == null || !isFinite(ms) || ms < 0) return txt("NotAvailable");
  var seconds = Math.ceil(ms / 1000), parts = [];
  if (seconds >= 86400) parts.push(tr("FOR","DaysShort",[Math.floor(seconds / 86400)]));
  if (seconds >= 3600) parts.push(tr("FOR","HoursShort",[Math.floor(seconds % 86400 / 3600)]));
  if (seconds >= 60) parts.push(tr("FOR","MinutesShort",[Math.floor(seconds % 3600 / 60)]));
  parts.push(tr("FOR","SecondsShort",[seconds % 60]));
  return parts.join(" ");
}

function modelDetails(row) {
  if (!row.models.length) return esc(txt("ProductionDetailsTime") + ": " + txt("NotAvailable"));
  var text = [];
  for (var i = 0; i < row.models.length; i++) {
    var m = row.models[i], b = m.prod;
    var line = "[" + esc(b.grid.key) + "] ";
    if (!m.working) {
      line += esc(txt("Status") + ": " + txt("StatusStopped"));
      text.push(line);
      continue;
    }
    line += esc(txt("DetailsOverallTime") + ": " + fmtCycle(m.cycleMs)) +
      " = 2 × " + esc(fmtCycle(m.warehouseMs)) +
      " + 2 × " + esc(fmtCycle(m.depositMs)) +
      " + " + esc(fmtCycle(m.workMs));
    line += " · " + esc(txt("DetailsDeposit") + ": −" + fmtInt(m.perCycle));
    if (m.buff) {
      line += " · " + esc(txt("Buff") + ": " + m.buff.name + " · " + txt("TimeRemaining") + " " + fmtDur(m.buff.remainMs));
    }
    text.push(line);
  }
  return text.join("<br>");
}

function computeAll() {
  var world = scanWorld();
  var events = readEvents();
  var res = allowedResource(state.resource) ? state.resource : autoResource(world);
  var evRem = eventRemain(events, res);
  var rows = [];

  for (var i = 0; i < world.deposits.length; i++) {
    var d = world.deposits[i];
    if (!allowedResource(d.res) || d.res !== res) continue;
    rows.push(computeRow(d, resolveProducers(world, d), evRem));
  }
  rows.sort(function (a, b) {
    var w = { crit: 0, warn: 1, ok: 2, unknown: 3 };
    if (w[a.status] !== w[b.status]) return w[a.status] - w[b.status];
    return a.dryMs - b.dryMs;
  });
  return { rows: rows, world: world, events: events, evRem: evRem, res: res };
}

function autoResource(world) {
  var seen = {}, order = [];
  for (var i = 0; i < world.deposits.length; i++) {
    var r = world.deposits[i].res;
    if (allowedResource(r) && !seen[r]) { seen[r] = 1; order.push(r); }
  }
  for (var j = 0; j < order.length; j++) if (order[j] === 'HalloweenResource') return order[j];
  for (var k = 0; k < order.length; k++) if (order[k] === 'ValentinesFlower') return order[k];
  return order[0] || '';
}


function focusGrid(grid) {
  if (disposed || !grid) return;
  var gIdx = grid.idx !== undefined ? grid.idx : (typeof grid === 'number' ? grid : (grid.raw && grid.raw.GetGrid ? grid.raw.GetGrid() : null));
  if (gIdx != null) {
    safe(function () {
      if (W.swmmo && W.swmmo.application && W.swmmo.application.mGameInterface) {
        W.swmmo.application.mGameInterface.mCurrentPlayerZone.ScrollToGrid(Number(gIdx));
      } else if (gi() && gi().mCurrentPlayerZone) {
        gi().mCurrentPlayerZone.ScrollToGrid(Number(gIdx));
      }
    });
  }
}

/* ---------------- §12. Custom AIR-friendly TSO controls ---------------- */
var currentRowsData = {};
var manualDirty = false;
function injectStyles() {
  $('#tsrModalStyle').remove();
  var root = '#' + MODAL_ID + '.tsr-ui ';
  var rules = [
    ['.modal-dialog', 'width:900px;max-width:95vw'],
    ['.modal-body', 'max-height:65vh;overflow-y:auto;padding:12px'],
    ['.modal-content', 'color:#f7e7bd;position:relative!important;overflow:visible!important'],
    ['.tsr-toolbar', 'padding:12px;margin-bottom:12px;border:1px solid #98713c;border-radius:5px;background:#35230f;box-shadow:inset 0 1px 0 #664c2c'],
    ['.tsr-toolbar:after', 'content:"";display:table;clear:both'],
    ['.tsr-control', 'float:left;width:28%;padding-right:12px;box-sizing:border-box'],
    ['.tsr-control-duration', 'width:29%'],
    ['.tsr-control-refresh', 'width:15%;padding-right:0'],
    ['.tsr-label', 'display:block;line-height:18px;min-height:20px;margin-bottom:4px;color:#e6c68e;font-size:12px'],
    ['.tsr-select', 'position:relative'],
    ['.tsr-btn:disabled', 'opacity:.55;cursor:default!important'],
    ['.tsr-btn', '-webkit-appearance:none!important;appearance:none!important;box-sizing:border-box!important;border:1px solid #b18a4a!important;border-radius:4px!important;background:#65451f!important;background-image:-webkit-linear-gradient(top,#87602c,#4e3316)!important;background-image:linear-gradient(to bottom,#87602c,#4e3316)!important;color:#fff0c7!important;-webkit-text-fill-color:#fff0c7!important;text-shadow:0 1px #241607!important;box-shadow:inset 0 1px 0 #c29854,inset 0 -1px 0 #26190c,0 1px 2px #140e07!important;font-family:inherit!important;font-size:12px!important;line-height:20px!important;min-height:36px!important;padding:7px 10px!important;cursor:pointer!important;outline:none!important'],
    ['.tsr-btn:hover', 'border-color:#f1cd7d!important;background:#805c2b!important'],
    ['.tsr-btn:focus', 'outline:2px solid #efd18d!important;outline-offset:2px'],
    ['.tsr-select-trigger', 'display:block!important;width:100%!important;text-align:left!important;padding-right:27px!important;position:relative!important;white-space:nowrap;overflow:hidden;text-overflow:ellipsis'],
    ['.tsr-arrow', 'position:absolute;right:10px;top:14px;width:0;height:0;border-left:4px solid transparent;border-right:4px solid transparent;border-top:6px solid #ffe0a2'],
    ['.tsr-options', 'display:none;position:absolute!important;z-index:10000!important;left:0;top:0;width:100%;box-sizing:border-box;margin-top:4px;padding:4px;border:1px solid #c29b55;border-radius:4px;background:#2b1c0d;box-shadow:0 2px 5px #100a04;overflow-y:auto;overflow-x:hidden;max-height:180px'],
    ['.tsr-option', '-webkit-appearance:none!important;display:block!important;box-sizing:border-box!important;width:100%!important;min-height:34px!important;border:1px solid transparent!important;border-radius:2px!important;background:#2b1c0d!important;color:#f7e7bd!important;-webkit-text-fill-color:#f7e7bd!important;font:inherit!important;font-size:12px!important;line-height:20px!important;padding:7px 9px!important;text-align:left!important;white-space:normal!important;cursor:pointer!important'],
    ['.tsr-option:hover,.tsr-option:focus,.tsr-option[aria-selected="true"]', 'background:#65451f!important;border-color:#b18a4a!important;color:#fff6d9!important;outline:none!important'],
    ['.tsr-editor-wrap', 'position:relative;padding-right:43px'],
    ['.tsr-editor', '-webkit-appearance:none!important;appearance:none!important;width:100%!important;font-family:inherit!important;display:block;box-sizing:border-box;min-height:36px;max-height:36px;overflow:hidden;white-space:nowrap;border:1px solid #a5834b!important;border-radius:3px!important;background:#201609!important;background-image:none!important;color:#fff0c7!important;-webkit-text-fill-color:#fff0c7!important;box-shadow:inset 0 2px 5px #0d0804,inset 0 0 0 2px #3b2a12!important;padding:7px 9px!important;line-height:20px!important;font-size:13px!important;outline:none!important;cursor:text;-webkit-user-select:text;user-select:text'],
    ['.tsr-editor:focus', 'border-color:#f6cf7a!important;box-shadow:inset 0 2px 5px #0d0804,0 0 3px #b18a4a!important'],
    ['.tsr-editor[aria-invalid="true"]', 'border-color:#f78b6d!important'],
    ['.tsr-apply', 'position:absolute!important;right:0;top:0;width:36px;padding-left:4px!important;padding-right:4px!important'],
    ['.tsr-refresh', 'width:100%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap'],
    ['.tsr-measures', 'clear:both;line-height:18px;padding:0 8px 8px;color:#d3ba8e;font-size:11px;overflow-wrap:break-word'],
    ['.tsr-help', 'padding:8px 10px;margin-bottom:10px;border-left:3px solid #a48248;color:#e4cda5;font-size:12px;line-height:20px;background:#2b1e0e'],
    ['.tsr-error', 'display:none;color:#ffb197;margin-top:4px;font-size:11px'],
    ['.row', 'margin-left:0;margin-right:0;font-size:12px;line-height:32px'],
    ['.tblHeader', 'box-sizing:border-box;background:#b2a589!important;color:#171006!important;min-height:58px;height:auto;line-height:18px;padding-top:10px;padding-bottom:8px;font-size:12px;font-weight:bold'],
    ['#tsr_table_body .row', 'border-bottom:1px solid #6a5030'],
    ['#tsr_table_body .row:nth-child(even)', 'background:rgba(178,165,137,.12)'],
    ['#tsr_table_body .row:hover', 'background:rgba(166,83,41,.28)'],
    ['.tsr-table-scroll', 'width:100%;overflow-x:auto;overflow-y:hidden;margin-bottom:4px'],
    ['.tsr-table-grid', 'min-width:820px'],
    ['.tsr-resource', 'white-space:nowrap;overflow:hidden;text-overflow:ellipsis'],
    ['.tsr-resource img', 'vertical-align:middle;margin-right:6px'],
    ['.tsr-goto', 'border:0!important;background:transparent!important;color:#f1d8a4!important;padding:2px 4px!important;cursor:pointer;vertical-align:middle;min-width:30px;min-height:30px;margin-right:5px'],
    ['.tsr-goto img', 'margin:0'],
    ['.tsr-goto:focus', 'outline:1px solid #f1cd7d'],
    ['.tsr-icon-missing', 'display:inline-block;min-width:22px;color:#dec390;text-align:center'],
    ['.tsr-amount', 'font-size:13px;color:#ffe0a0'],
    ['.tsr-subtle', 'font-size:11px;color:#d3ba8e'],
    ['.tsr-number', 'color:#ffe0a0;font-weight:bold'],
    ['.tsr-zero', 'color:#afd899'],
    ['.tsr-crit', 'background:rgba(150,43,20,.22)'],
    ['.tsr-foot-table', 'width:100%;font-size:12px;line-height:22px;text-align:left;margin-bottom:8px'],
    ['.tsr-options::-webkit-scrollbar', 'width:10px'],
    ['.tsr-options::-webkit-scrollbar-track', 'background:#241708'],
    ['.tsr-options::-webkit-scrollbar-thumb', 'background:#937040;border:2px solid #241708;border-radius:4px']
  ];
  var css = [];
  for (var i = 0; i < rules.length; i++) {
    var selectors = rules[i][0].split(',');
    for (var j = 0; j < selectors.length; j++) selectors[j] = root + selectors[j];
    css.push(selectors.join(',') + '{' + rules[i][1] + '}');
  }
  css.push('@media(max-width:640px){' + root + '.tsr-control{width:50%;margin-bottom:8px}' + root + '.tsr-control-refresh{padding-right:12px}}');
  $('<style>', {id:'tsrModalStyle'}).text(css.join('\n')).appendTo('head');
}
function customSelect(id, options, value, label) {
  var current = '\u2014', list = '';
  for (var i = 0; i < options.length; i++) {
    var selected = options[i].value === value;
    if (selected) current = options[i].label;
    list += '<button type="button" class="tsr-option" role="option" tabindex="-1" aria-selected="' + selected + '" data-value="' + esc(options[i].value) + '">' + esc(options[i].label) + '</button>';
  }
  return '<div class="tsr-select" id="' + id + '"><button type="button" class="tsr-btn tsr-select-trigger" aria-haspopup="listbox" aria-expanded="false" aria-controls="' + id + '_list" aria-label="' + esc(label) + '" title="' + esc(current) + '"><span class="tsr-value">' + esc(current) + '</span><span class="tsr-arrow"></span></button><div class="tsr-options" id="' + id + '_list" role="listbox" aria-label="' + esc(label) + '">' + list + '</div></div>';
}
function closeChoices() {
  var $modal = $('#' + MODAL_ID);
  // Return the portal to its owner before rerender/dispose; never leave detached menus behind.
  $modal.find('.tsr-options').each(function() {
    var $list = $(this), owner = $list.attr('data-owner');
    $list.removeAttr('style').hide();
    if (owner) $modal.find('#' + owner).append($list);
  });
  $modal.find('.tsr-select-trigger').attr('aria-expanded','false');
}
function openChoice($trigger, keyboard) {
  if (disposed) return;
  var wasOpen = $trigger.attr('aria-expanded') === 'true';
  closeChoices();
  if (wasOpen && !keyboard) return;
  var $choice = $trigger.closest('.tsr-select'), $list = $choice.find('.tsr-options');
  var $content = $trigger.closest('.modal-content');
  if (!$list.length || !$content.length) return;
  // Portal outside .modal-body and toolbar: scroll containers cannot reflow or clip this menu.
  // Use offsets relative to the SAME transformed modal, not fixed viewport coordinates.
  var origin = $content.offset(), field = $trigger.offset();
  var borderLeft = parseFloat($content.css('border-left-width')) || 0;
  var borderTop = parseFloat($content.css('border-top-width')) || 0;
  var top = field.top - origin.top - borderTop + $trigger.outerHeight() + 4;
  var left = field.left - origin.left - borderLeft;
  var below = $content.innerHeight() - top - 8;
  var above = field.top - origin.top - borderTop - 8;
  var up = below < 100 && above > below;
  var height = Math.max(36,Math.min(180,up ? above : below));
  // Critical geometry is inline !important as protection against legacy client styles.
  $list.attr('data-owner',$choice.attr('id')).appendTo($content);
  $list.attr('style','display:block!important;position:absolute!important;float:none!important;clear:none!important;' +
    'z-index:10000!important;box-sizing:border-box!important;margin:0!important;right:auto!important;' +
    'left:' + left + 'px!important;width:' + $trigger.outerWidth() + 'px!important;' +
    'max-height:' + height + 'px!important;' +
    (up ? 'top:auto!important;bottom:' + ($content.innerHeight() - above - 4) + 'px!important;' : 'bottom:auto!important;top:' + top + 'px!important;'));
  $trigger.attr('aria-expanded','true');
  if (keyboard) {
    var $selected = $list.find('[aria-selected="true"]');
    ($selected.length ? $selected : $list.find('.tsr-option').first()).focus();
  }
}
function localizedEvent(name) {
  // Event identifiers are not UI strings; never show a raw English/internal ID as a translation.
  var title = tr('DES',name + '_Title');
  if (title !== '\u2014') return title;
  var groups = ['LAB', 'SHG', 'ACL', 'MEL'];
  for (var i = 0; i < groups.length; i++) {
    var text = tr(groups[i], name);
    if (text !== '\u2014') return text;
  }
  if (/halloween|pumpkin/i.test(name)) return tr('SHG', 'HalloweenEvent');
  if (/valentin|flower/i.test(name)) return tr('SHG', 'ValentineEvent');
  return txt('BuffGroup3');
}
function openModal() {
  if (disposed) return;
  injectStyles();
  $("div[role='dialog']:not(#" + MODAL_ID + "):visible").modal('hide');
  if (!$('#' + MODAL_ID).length) createModalWindow(MODAL_ID, titleText());
  var $modal = $('#' + MODAL_ID).addClass('tsr-ui');
  $modal.find('.modal-title').text(titleText()).attr('title','v' + VERSION);
  $modal.find('.btnClose').text(txt('Close'));
  renderModalData();
  $('#' + MODAL_ID + ':not(:visible)').modal({backdrop:'static'});
}
function numberCell(value, requested) {
  if (value == null) return '<span class="tsr-subtle">' + esc(requested ? txt('NotAvailable') : '—') + '</span>';
  return '<span class="' + (value > 0 ? 'tsr-number' : 'tsr-zero') + '">' + (value > 0 ? '+' : '') + fmtInt(value) + '</span>';
}
function renderModalData() {
  var $modal = $('#' + MODAL_ID);
  if (disposed || !$modal.length) return;
  closeChoices();
  var data = computeAll(), seen = {}, resourceOptions = [], eventOptions = [];
  var resLabel = tr('SHG', 'Resources'), eventLabel = txt('BuffGroup3'), durationLabel = txt('Duration');
  currentRowsData = {};
  manualDirty = false;
  if (!allowedResource(state.resource)) state.resource = data.res;
  for (var i = 0; i < data.world.deposits.length; i++) {
    var rr = data.world.deposits[i].res;
    if (allowedResource(rr) && !seen[rr]) { seen[rr] = true; resourceOptions.push({value:rr,label:resMeta(rr).label}); }
  }
  if (allowedResource(state.resource) && !seen[state.resource]) resourceOptions.push({value:state.resource,label:resMeta(state.resource).label});
  var active = null, metaEvent = resMeta(data.res).ev;
  for (var a = 0; a < data.events.length; a++) {
    if ((state.eventMode === 'event' && data.events[a].name === state.eventKey) ||
        (state.eventMode === 'auto' && metaEvent && metaEvent.test(data.events[a].name))) {
      active = data.events[a]; break;
    }
  }
  var selection = state.eventMode === 'manual' ? '__manual__' : (active ? active.name : '__auto__');
  // No ambiguous "resource -> event" mode in the UI: show an actual event or N/A.
  if (!active) eventOptions.push({value:'__auto__',label:eventLabel + ' · ' + txt('NotAvailable')});
  for (var e = 0; e < data.events.length; e++) {
    var ev = data.events[e];
    eventOptions.push({value:ev.name,label:localizedEvent(ev.name) + ' · ' + fmtDur(Math.max(0,ev.stopTs - serverNow()))});
  }
  eventOptions.push({value:'__manual__',label:durationLabel});
  var horizonLabel = state.eventMode === 'manual' ? durationLabel : eventLabel;
  var manualValue = editDuration(data.evRem);
  var manualAttrs = state.eventMode === 'manual' ? '' : ' disabled="disabled"';
  var toolbar = '<div class="tsr-toolbar">' +
    '<div class="tsr-control"><span class="tsr-label">' + esc(resLabel) + '</span>' + customSelect('tsr_sel_res',resourceOptions,state.resource,resLabel) + '</div>' +
    '<div class="tsr-control"><span class="tsr-label">' + esc(eventLabel) + '</span>' + customSelect('tsr_sel_ev',eventOptions,selection,eventLabel) + '</div>' +
    '<div class="tsr-control tsr-control-duration"><span class="tsr-label" id="tsr_duration_label">' + esc(durationLabel) + ' · ' + esc(tr('FOR','DaysShort',['DD'])) + ' : ' + esc(tr('FOR','HoursShort',['HH'])) + ' : ' + esc(tr('FOR','MinutesShort',['MM'])) + '</span>' +
      '<div class="tsr-editor-wrap"><input type="text" id="tsr_in_manual" class="tsr-editor"' + manualAttrs + ' value="' + esc(manualValue) + '" data-initial="' + esc(manualValue) + '" placeholder="00:00:00" maxlength="10" aria-labelledby="tsr_duration_label" aria-invalid="false" autocomplete="off" spellcheck="false" style="-webkit-appearance:none!important;background:#201609!important;background-image:none!important;color:#fff0c7!important;-webkit-text-fill-color:#fff0c7!important;border:1px solid #a5834b!important;">' +
      '<button type="button" id="tsr_btn_manual" class="tsr-btn tsr-apply"' + manualAttrs + ' title="' + esc(txt('OK')) + '" aria-label="' + esc(txt('OK')) + '">✓</button></div>' +
      '<div id="tsr_manual_error" class="tsr-error" role="alert">' + esc(durationLabel) + ' · 02:03:30</div></div>' +
    '<div class="tsr-control tsr-control-refresh"><span class="tsr-label">&nbsp;</span><button type="button" id="tsr_btn_refresh" class="tsr-btn tsr-refresh">' + esc(txt('Update')) + '</button></div></div>';
  var missing = txt('Missing_Resources');
  var head = createTableRow([[3,esc(txt('DetailsDeposit') + ' / ' + txt('amount'))],[3,esc(txt('TimeRemaining'))],[3,esc(missing) + '<br>' + esc(txt('Time') + ' · ' + txt('Buff'))],[3,esc(missing) + '<br>' + esc(txt('Time') + ' · ' + horizonLabel)]],true);
  var list = '', totalBuff = 0, totalEvent = 0, hasBuff = false, buffTotalKnown = true, eventTotalKnown = data.rows.length > 0;
  for (var k = 0; k < data.rows.length; k++) {
    var m = data.rows[k], key = m.dep.key, meta = resMeta(m.dep.res);
    currentRowsData[key] = m;
    if (!m.known || (m.buffRemMs > 0 && m.needBuff == null)) buffTotalKnown = false;
    if (data.evRem > 0 && m.needEvent == null) eventTotalKnown = false;
    if (m.needBuff != null) {hasBuff = true; totalBuff += m.needBuff;}
    if (m.needEvent != null) totalEvent += m.needEvent;
    var cycleTip = txt('DetailsOverallTime') + ': ' + fmtCycle(m.cycleMs);
    var col1 = '<div class="tsr-resource"><button type="button" class="tsr-goto" data-act="goto" data-key="' + esc(key) + '" title="' + esc(txt('Visit')) + '" aria-label="' + esc(txt('Visit') + ': ' + meta.label) + '">' + gotoIcon('22px') + '</button><span title="' + esc(meta.label) + '">' + depositIcon(m.dep.res,'24px') + '</span> <b class="tsr-amount">' + fmtInt(m.amount) + '</b> <span class="tsr-subtle">[' + esc(key) + ']</span></div>';
    var col2 = '<span title="' + esc(cycleTip) + '" style="color:' + (m.status === 'crit' ? '#ffb197' : m.status === 'warn' ? '#ffe0a0' : m.status === 'unknown' ? '#d3ba8e' : '#afd899') + '">' + esc(fmtDur(m.dryMs)) + '</span>';
    var capMark = m.overCap ? ' <span title="' + esc(txt('Max') + ': ' + fmtInt(m.max)) + '">(!)</span>' : '';
    var row = createTableRow([[3,col1],[3,col2],[3,'<span title="' + esc(txt('Time') + ' · ' + txt('Buff') + ': ' + fmtDur(m.buffRemMs)) + '">' + numberCell(m.needBuff,!m.known || m.buffRemMs > 0) + '</span>'],[3,numberCell(m.needEvent,data.evRem > 0) + capMark]],false);
    list += $(row).append('<div class="tsr-measures">' + modelDetails(m) + '</div>').attr('data-key',key).addClass(m.status === 'crit' ? 'tsr-crit' : '').prop('outerHTML');
  }
  if (!data.world.ok || !data.rows.length) list = '<div class="tsr-help">' + esc(txt('DetailsDeposit')) + ': ' + esc(txt('NotAvailableText')) + '</div>';
  var help = '<div class="tsr-help">' + esc(horizonLabel) + (state.eventMode !== 'manual' ? ': ' + esc(active ? localizedEvent(active.name) : txt('NotAvailable')) : '') + ' · ' + esc(txt('TimeRemaining')) + ' <b>' + esc(data.evRem > 0 ? fmtDur(data.evRem) : '—') + '</b> · ' + esc(missing) + ': <b>+N</b>' + '</div>';
  $('#' + MODAL_ID + 'Data').html('<div class="container-fluid">' + toolbar + help + '<div class="tsr-table-scroll"><div class="tsr-table-grid">' + head + '<div id="tsr_table_body">' + list + '</div></div></div></div>');
  $modal.find('.modal-footer .tsr-foot-table').remove();
  $modal.find('.modal-footer').prepend('<div class="tsr-foot-table">Σ ' + esc(missing) + ' · ' + esc(txt('Buff')) + ': <b>' + (!buffTotalKnown ? esc(txt('NotAvailable')) : hasBuff ? fmtInt(totalBuff) : '—') + '</b> · ' + esc(horizonLabel) + ': <b>' + (data.evRem > 0 ? (eventTotalKnown ? fmtInt(totalEvent) : esc(txt('NotAvailable'))) : '—') + '</b></div>');
  bindEvents();
}
function commitManual() {
  var $field = $('#' + MODAL_ID + ' #tsr_in_manual');
  var value = String($field.val() || '');
  var ms = parseManual(value);
  if (!isFinite(ms) || ms < 0) {
    $field.attr('aria-invalid','true');
    $('#' + MODAL_ID + ' #tsr_manual_error').show();
    return false;
  }
  state.eventMode = 'manual';
  state.eventKey = '';
  state.manualEventMs = ms;
  state.manualSetAt = serverNow();
  save();
  renderModalData();
  return true;
}
function bindEvents() {
  var $modal = $('#' + MODAL_ID);
  $modal.off('.tsrEvents');
  $modal.find('.modal-body').off('.tsrEvents').on('scroll.tsrEvents',closeChoices);
  $(document).off('mousedown.tsrRefillChoices').on('mousedown.tsrRefillChoices',function(e) {
    if (!$(e.target).closest('#' + MODAL_ID + ' .tsr-select,#' + MODAL_ID + ' .tsr-options').length) closeChoices();
  });
  $(window).off('resize.tsrRefillChoices').on('resize.tsrRefillChoices',closeChoices);
  $modal.on('hidden.bs.modal.tsrEvents',closeChoices);
  $modal.on('click.tsrEvents','.tsr-select-trigger',function() {openChoice($(this),false);});
  $modal.on('click.tsrEvents','.tsr-option',function() {
    var $list = $(this).closest('.tsr-options'), value = $(this).attr('data-value'), id = $list.attr('data-owner');
    closeChoices();
    if (id === 'tsr_sel_res') state.resource = value;
    else {
      state.eventMode = value === '__manual__' ? 'manual' : value === '__auto__' ? 'auto' : 'event';
      state.eventKey = state.eventMode === 'event' ? value : '';
    }
    save();renderModalData();
    $('#' + MODAL_ID + ' #' + id + ' .tsr-select-trigger').focus();
  });
  $modal.on('keydown.tsrEvents','.tsr-select-trigger',function(e) {
    if (e.which === 13 || e.which === 32 || e.which === 40 || e.which === 38) {e.preventDefault();openChoice($(this),true);}
    if (e.which === 27) closeChoices();
  });
  $modal.on('keydown.tsrEvents','.tsr-option',function(e) {
    var $options = $(this).parent().find('.tsr-option'), index = $options.index(this);
    if (e.which === 38 || e.which === 40 || e.which === 36 || e.which === 35) {
      e.preventDefault();
      index = e.which === 36 ? 0 : e.which === 35 ? $options.length - 1 : (index + (e.which === 40 ? 1 : -1) + $options.length) % $options.length;
      $options.eq(index).focus();
    }
    if (e.which === 27 || e.which === 9) {
      if (e.which === 27) e.preventDefault();
      var owner = $(this).closest('.tsr-options').attr('data-owner');
      var $trigger = $modal.find('#' + owner + ' .tsr-select-trigger');
      closeChoices();$trigger.focus();
    }
  });
  $modal.on('input.tsrEvents change.tsrEvents keyup.tsrEvents','#tsr_in_manual',function(e) {
    if (e.type === 'keyup' && (e.which === 13 || e.which === 27 || e.which === 9)) return;
    manualDirty = true;$(this).attr('aria-invalid','false');$modal.find('#tsr_manual_error').hide();
  });
  // Use the real text input's native typing, selection and clipboard support in AIR.
  $modal.on('keydown.tsrEvents','#tsr_in_manual',function(e) {
    if (e.which === 13) {e.preventDefault();commitManual();}
    if (e.which === 27) {e.preventDefault();renderModalData();}
  });
  $modal.on('click.tsrEvents','#tsr_btn_manual',commitManual);
  $modal.on('click.tsrEvents','#tsr_btn_refresh',function() {
    var $field = $modal.find('#tsr_in_manual');
    if (manualDirty || $field.val() !== $field.attr('data-initial')) commitManual();else renderModalData();
  });
  $modal.on('click.tsrEvents','[data-act="goto"]',function() {
    var row = currentRowsData[$(this).attr('data-key')];
    if (row && row.dep) focusGrid(row.dep.grid);
  });
}
function persist() {
  try {localStorage.setItem(STORE_KEY,JSON.stringify(state));} catch (e) {}
}
function dispose() {
  if (disposed) return;
  persist();disposed = true;clearTimeout(saveTimer);closeChoices();
  var $modal = $('#' + MODAL_ID);
  $modal.off('.tsrEvents');$modal.find('.modal-body').off('.tsrEvents');
  $(document).off('.tsrRefillChoices');$(window).off('.tsrRefillChoices');
  currentRowsData = {};iconCache = {};
  // Preserve core modal show/hide handlers and the persistent root during transitions.
}


W.__TSO_REFILL__ = {
  version: VERSION,
  open: openModal,
  toggle: openModal,
  refresh: renderModalData,
  dispose: dispose,
  state: state
};


try {
  var menuTitle = titleText();
  addToolsMenuItem(menuTitle, function (event) {
    openModal();
  });
} catch (e) {
  console.warn('[refill] addToolsMenuItem error', e);
}

})();