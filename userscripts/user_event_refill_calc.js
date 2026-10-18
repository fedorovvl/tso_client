/* ============================================================
 * userscripts/user_event_refill_calc.js
 * The Settlers Online · Калькулятор и менеджер пополнения залежей
 * Аутентичный дизайн TSO (createTableRow, TSO inputs/buttons, wood/gold theme)
 * ============================================================ */
(function () {
'use strict';

var MODAL_ID = 'EventRefillModal';
var VERSION   = '1.2.0';
var STORE_KEY = 'tso.refill.state.v1';
var W = (typeof unsafeWindow !== 'undefined') ? unsafeWindow : window;

/* ---------------- §1. Утилиты ---------------- */
function safe(fn, def) { try { var v = fn(); return (v === undefined || v === null) ? def : v; } catch (e) { return def; } }
function clamp(v, a, b) { return v < a ? a : (v > b ? b : v); }
function num(v, d) { v = parseFloat(v); return isFinite(v) ? v : d; }
function fmtInt(n) { return String(Math.round(n)).replace(/\B(?=(\d{3})+(?!\d))/g, ' '); }
function fmtDur(ms) {
  if (!(ms > 1000)) return '—';
  var m = Math.floor(ms / 60000),
      d = Math.floor(m / 1440), h = Math.floor((m % 1440) / 60), mm = m % 60;
  if (d > 0) return d + ' д ' + h + ' ч';
  if (h > 0) return h + ' ч ' + mm + ' м';
  return Math.max(1, mm) + ' мин';
}

function parseManual(str) {
  if (!str) return 0;
  var s = String(str).trim();
  var m = s.match(/^(\d+)[dд](\d+)[hч](\d+)[mм]?$/i);
  if (m) return (parseInt(m[1], 10) * 1440 + parseInt(m[2], 10) * 60 + parseInt(m[3], 10)) * 60000;
  m = s.match(/^(\d+)[dд](\d+)[hч]?$/i);
  if (m) return (parseInt(m[1], 10) * 1440 + parseInt(m[2], 10) * 60) * 60000;
  m = s.match(/^(\d+)[hч](\d+)[mм]?$/i);
  if (m) return (parseInt(m[1], 10) * 60 + parseInt(m[2], 10)) * 60000;
  m = s.match(/^(\d+)[dд]?$/i);
  if (m && s.indexOf('d') !== -1 || s.indexOf('д') !== -1) return parseInt(m[1], 10) * 86400000;
  m = s.match(/^(\d+)\s*:\s*(\d+)(?:\s*:\s*(\d+))?$/);
  if (m) {
    if (m[3] !== undefined) return (parseInt(m[1], 10) * 1440 + parseInt(m[2], 10) * 60 + parseInt(m[3], 10)) * 60000;
    return (parseInt(m[1], 10) * 60 + parseInt(m[2], 10)) * 60000;
  }
  var n = parseFloat(s);
  if (isFinite(n) && n > 0) return n * 3600000;
  return 0;
}

/* ---------------- §2. Доступ к клиенту ---------------- */
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

/* ---------------- §3. Реестр ресурсов ---------------- */
var RES = {
  HalloweenResource: { label: 'Тыквы',    icon: 'Pumpkin',             ev: /halloween|pumpkin|тыкв|хэллоуин/i },
  ValentinesFlower:  { label: 'Цветы',    icon: 'ValentinesFlower',    ev: /valentin|flower|цвет|валентин/i },
  TitaniumOre:       { label: 'Титан',    icon: 'TitaniumOre',         ev: null },
  Salpeter:          { label: 'Селитра',  icon: 'Salpeter',            ev: null },
  GoldOre:           { label: 'Золото',   icon: 'GoldOre',             ev: null },
  IronOre:           { label: 'Железо',   icon: 'IronOre',             ev: null },
  Coal:              { label: 'Уголь',    icon: 'Coal',                ev: null },
  Granite:           { label: 'Гранит',   icon: 'Granite',             ev: null },
  ExoticWood:        { label: 'Экзотика', icon: 'ExoticWood',          ev: null },
  Oil:               { label: 'Нефть',    icon: 'Oil',                 ev: null }
};

function resMeta(name) {
  var def = RES[name];
  var loc = '';
  try {
    if (typeof loca !== 'undefined' && loca.GetText) loc = loca.GetText('RES', name);
  } catch (e) {}
  if (def) {
    return { label: loc || def.label, icon: def.icon, ev: def.ev };
  }
  return { label: loc || name || '—', icon: 'accuracy.png', ev: null };
}

function renderResIcon(iconName, size) {
  size = size || '20px';
  try {
    if (typeof getImageTag === 'function') {
      return getImageTag(iconName, size, size);
    }
  } catch (e) {}
  return '';
}

/* ---------------- §4. Состояние ---------------- */
var DEFAULTS = {
  resource: '', eventKey: '',
  manualEventMs: 0, manualSetAt: 0,
  speedFactor: 1,
  defaultCycleMin: 10,
  manualCycleMin: {},
  buffStrength: {},
  queueDelay: 350
};
var state = load();

function load() {
  var s = {};
  for (var k in DEFAULTS) if (DEFAULTS.hasOwnProperty(k)) s[k] = DEFAULTS[k];
  try {
    var raw = localStorage.getItem(STORE_KEY);
    if (raw) { var o = JSON.parse(raw); for (var j in o) if (o.hasOwnProperty(j)) s[j] = o[j]; }
  } catch (e) {}
  s.manualCycleMin = s.manualCycleMin || {};
  s.buffStrength   = s.buffStrength   || {};
  return s;
}

var saveTimer = 0;
function save() {
  clearTimeout(saveTimer);
  saveTimer = setTimeout(function () {
    try { localStorage.setItem(STORE_KEY, JSON.stringify(state)); } catch (e) {}
  }, 300);
}

/* ---------------- §5. Сканирование мира ---------------- */
function scanWorld() {
  var world = { deposits: [], producers: [], ok: false };
  var z = zone();
  if (!z) return world;
  var map = safe(function () { return z.mStreetDataMap; }, null);
  if (!map) return world;

  // Здания добычи
  if (map.mBuildingContainer) {
    each(map.mBuildingContainer, function (b) {
      if (!b) return;
      var g = gridOf(safe(function () { return b.GetGrid(); }, null));
      if (!g) return;
      var rcd = safe(function () { return b.GetResourceCreation(); }, null);
      var dg  = gridOf(safe(function () { return rcd ? rcd.GetDepositBuildingGridPos() : null; }, null));
      world.producers.push({
        raw: b, grid: g, depGrid: dg, rcd: rcd,
        outRes: safe(function () { return rcd.GetOutputResourceName_string(); }, '') ||
                safe(function () { return rcd.outputResourceName_string; }, '')
      });
    });
  }

  // Залежи
  if (map.mDepositContainer) {
    each(map.mDepositContainer, function (d) {
      if (!d) return;
      var g = gridOf(safe(function () { return d.GetGrid(); }, null));
      if (!g) return;
      world.deposits.push({
        raw: d, grid: g, key: g.key,
        res: String(safe(function () { return d.GetName_string(); }, '') || ''),
        amount: safe(function () { return d.GetAmount(); }, 0) | 0,
        max:    safe(function () { return d.GetMaxAmount(); }, 0) | 0
      });
    });
  }

  world.ok = true;
  return world;
}

function resolveProducer(world, dep) {
  var exact = null, same = null, byRes = [];
  for (var i = 0; i < world.producers.length; i++) {
    var p = world.producers[i];
    if (!exact && p.depGrid && p.depGrid.key === dep.key) exact = p;
    if (!same  && p.grid.key === dep.key) same = p;
    if (p.outRes && p.outRes === dep.res) byRes.push(p);
  }
  return exact || same || (byRes.length === 1 ? byRes[0] : null);
}

/* ---------------- §6. Темп производства и баф ---------------- */
function readBuff(bld) {
  var pb = safe(function () { return bld.productionBuff; }, null);
  if (!pb) return null;
  var t = serverNow();
  var active = safe(function () { return pb.IsActive(t); }, false) ||
               safe(function () { return pb.IsActive(Date.now()); }, false);
  if (!active) return null;

  var start = safe(function () { return pb.GetStartTime(); }, 0);
  var app   = safe(function () { return pb.GetApplicanceMode ? pb.GetApplicanceMode() : (gi().mApp || null); }, null);
  var dur   = safe(function () { return pb.GetBuffDefinition().getDuration(app); }, 0);
  if (!(dur > 0)) dur = safe(function () { return pb.getDuration(); }, 0);
  if (!(start > 0) || !(dur > 0)) return { remainMs: 0, durationMs: dur || 0, buffName: '' };

  var buffDef = safe(function () { return pb.GetBuffDefinition(); }, null);
  var buffName = '';
  try {
    if (buffDef && loca && loca.GetText) {
      buffName = loca.GetText('RES', buffDef.GetName_string());
    }
  } catch (e) {}

  var rem = (start + dur) - t;
  if (rem > dur + 60000 || rem < -60000) rem = (start + dur) - Date.now();
  return { remainMs: clamp(rem, 0, dur), durationMs: dur, startTs: start, buffName: buffName };
}

function measure(dep, prod) {
  var cycle = 0, perCycle = 1, buff = null;
  if (prod) {
    var b = prod.raw;
    cycle = safe(function () { return b.CalculateWays(); }, 0);
    if (cycle && typeof cycle === 'object') cycle = cycle.time || cycle.mTime || 0;
    if (!(cycle > 0)) cycle = safe(function () { return b.GetProductionTime(); }, 0);

    var removed = safe(function () { return prod.rcd ? prod.rcd.amountRemoved : 1; }, 0) ||
                  safe(function () { return prod.rcd ? prod.rcd.GetAmountRemoved() : 1; }, 0) || 1;
    var factor  = safe(function () { return b.GetResourceInputFactor(); }, 1) || 1;
    perCycle = Math.max(1, Math.round(removed * factor));
    buff = readBuff(b);
  }
  var ov = state.manualCycleMin[dep.key];
  if (num(ov, 0) > 0) cycle = num(ov, 0) * 60000;
  if (!(cycle > 0)) cycle = num(state.defaultCycleMin, 10) * 60000;

  return { cycleMs: cycle, perCycle: perCycle, buff: buff };
}

/* ---------------- §7. Ивенты ---------------- */
function readEvents() {
  var out = [];
  var em = safe(function () { return gi().mEventManager; }, null);
  if (!em) return out;
  var list = safe(function () { return em.GetActiveVisibleEvents(); }, null) ||
             safe(function () { return em.GetActiveEvents(); }, null);
  each(list, function (ev) {
    if (!ev) return;
    var name = String(safe(function () { return ev.mName; }, '') ||
                      safe(function () { return ev.GetName ? ev.GetName() : ''; }, '') ||
                      safe(function () { return ev.name; }, '') || 'Ивент');
    var stop = safe(function () { return ev.mStopTime; }, 0) ||
               safe(function () { return ev.GetStopTime ? ev.GetStopTime() : 0; }, 0) ||
               safe(function () { return ev.stopTime; }, 0);
    if (typeof stop === 'object' && stop) stop = stop.time || stop.getTime();
    if (stop > 1e9 && stop < 1e12) stop *= 1000;
    if (stop > 0) out.push({ name: name, stopTs: stop });
  });
  return out;
}

function eventRemain(events) {
  var now = serverNow();
  if (state.eventKey) {
    for (var i = 0; i < events.length; i++) {
      if (events[i].name === state.eventKey) {
        var r = events[i].stopTs - now;
        if (r > 0) return r;
      }
    }
  }
  if (state.manualEventMs > 0 && state.manualSetAt > 0) {
    var passed = now - state.manualSetAt;
    var left = state.manualEventMs - passed;
    if (left > 0) return left;
  }
  var meta = resMeta(state.resource);
  if (meta.ev) {
    for (var j = 0; j < events.length; j++) {
      if (meta.ev.test(events[j].name)) {
        var rem = events[j].stopTs - now;
        if (rem > 0) return rem;
      }
    }
  }
  for (var k = 0; k < events.length; k++) {
    var remAny = events[k].stopTs - now;
    if (remAny > 0) return remAny;
  }
  return 0;
}

/* ---------------- §8. Звёздное меню ---------------- */
function starBuffs() {
  var out = [];
  var cp = safe(function () { return gi().mCurrentPlayer; }, null);
  if (!cp) return out;
  var list = safe(function () { return cp.getAvailableBuffs_vector(); }, null);
  each(list, function (b) {
    if (!b) return;
    var def = safe(function () { return b.GetBuffDefinition(); }, null) ||
              safe(function () { return b.buffDefinition; }, null) ||
              safe(function () { return b.mBuffDefinition; }, null);
    if (!def) return;

    var res  = String(safe(function () { return def.GetResourceName_string(); }, '') ||
                      safe(function () { return def.resourceName_string; }, '') || '');
    var name = String(safe(function () { return def.GetName_string(); }, '') ||
                      safe(function () { return def.name_string; }, '') || '');
    var cnt  = safe(function () { return b.GetAmount(); }, 0) || safe(function () { return b.amount; }, 0) || 0;
    var defAmount = safe(function () { return def.GetAmount(); }, 0) || 0;

    var uObj = safe(function () { return b.GetUniqueId ? b.GetUniqueId() : b.GetUniqueID(); }, null);
    var uKey = '';
    if (uObj) {
      if (typeof uObj.toKeyString === 'function') uKey = uObj.toKeyString();
      else if (uObj.uniqueID1 !== undefined) uKey = uObj.uniqueID1 + '_' + uObj.uniqueID2;
      else uKey = String(uObj);
    } else {
      uObj = safe(function () { return b.uniqueID; }, null);
      uKey = String(uObj || name);
    }
    if (!uObj) return;
    out.push({ uid: uObj, key: uKey, res: res, name: name, count: cnt | 0, defAmount: defAmount });
  });
  return out;
}

var SIZE_HINTS = [
  { re: /halloween|pumpkin|тыкв/i, size: 50 },
  { re: /valentin|flower|цвет/i,   size: 50 },
  { re: /titan|титан/i,            size: 100 },
  { re: /salpeter|селитр/i,        size: 100 }
];

function buffSize(entry) {
  if (entry.defAmount > 0) return { size: entry.defAmount, known: true };
  var learned = num(state.buffStrength[entry.key], 0);
  if (learned > 0) return { size: learned, known: true };
  for (var i = 0; i < SIZE_HINTS.length; i++) {
    if (SIZE_HINTS[i].re.test(entry.name) || SIZE_HINTS[i].re.test(entry.res)) {
      return { size: SIZE_HINTS[i].size, known: false };
    }
  }
  return { size: 50, known: false };
}

function packsFor(res) {
  var meta = resMeta(res), out = [], all = starBuffs();
  for (var i = 0; i < all.length; i++) {
    var e = all[i];
    var hit = (e.res && e.res === res) || (!e.res && meta.ev && meta.ev.test(e.name));
    if (!hit) continue;
    var sz = buffSize(e);
    out.push({ uid: e.uid, key: e.key, name: e.name, count: e.count, size: sz.size, known: sz.known });
  }
  return out;
}

function planPack(need, packs) {
  var avail = packs.filter(function (p) { return p.count > 0 && p.size > 0; })
    .map(function (p) { return { uid: p.uid, key: p.key, name: p.name, size: p.size, count: p.count }; })
    .sort(function (a, b) { return b.size - a.size; });
  var picks = [], rem = need | 0, covered = 0;

  if (rem <= 0) return { picks: picks, covered: 0, short: 0 };
  if (!avail.length) return { picks: picks, covered: 0, short: rem };

  for (var i = 0; i < avail.length && rem > 0; i++) {
    var p = avail[i];
    var n = Math.min(p.count, Math.floor(rem / p.size));
    if (n > 0) {
      picks.push({ uid: p.uid, key: p.key, name: p.name, size: p.size, n: n });
      rem -= n * p.size;
      covered += n * p.size;
      p.count -= n;
    }
  }
  if (rem > 0) {
    var tail = null;
    for (var j = 0; j < avail.length; j++) {
      if (avail[j].count > 0 && (!tail || avail[j].size < tail.size)) tail = avail[j];
    }
    if (tail) {
      picks.push({ uid: tail.uid, key: tail.key, name: tail.name, size: tail.size, n: 1 });
      rem -= tail.size;
      covered += tail.size;
    }
  }
  return { picks: picks, covered: covered, short: Math.max(0, rem) };
}

/* ---------------- §9. Ядро расчёта ---------------- */
function computeRow(dep, prod, evRem) {
  var m = measure(dep, prod);
  var T = m.cycleMs,
      c = m.perCycle,
      A = dep.amount,
      speed = clamp(num(state.speedFactor, 1), 1, 20),
      Db = m.buff ? m.buff.remainMs : 0,
      Tb = (speed > 1 && Db > 0) ? T / speed : T;

  function consumed(span, cycle) { return Math.floor(Math.max(0, span) / cycle) * c; }

  var cBuff = Db > 0 ? consumed(Db, Tb) : 0;
  var cRest = consumed(Math.max(0, evRem - Db), T);

  var dryMs;
  if (Db > 0 && A <= cBuff)      dryMs = (A / c) * Tb;
  else if (Db > 0)               dryMs = Db + ((A - cBuff) / c) * T;
  else                           dryMs = (A / c) * T;

  var needBuff  = Db > 0 ? Math.max(0, cBuff - A) : null;
  var needEvent = evRem > 0 ? Math.max(0, cBuff + cRest - A) : null;
  var cap = dep.max > 0 ? dep.max - A : Infinity;

  return {
    dep: dep, prod: prod,
    cycleMs: T, cycleBuffMs: Tb, perCycle: c,
    buff: m.buff,
    amount: A, max: dep.max,
    buffRemMs: Db, eventRemMs: evRem,
    dryMs: dryMs,
    needBuff: needBuff, needEvent: needEvent,
    capRoom: cap,
    overCap: needEvent != null && needEvent > cap,
    ratePerHour: c * 3600000 / T,
    status: (Db > 0 && dryMs < Db) ? 'crit'
          : (evRem > 0 && dryMs < evRem) ? 'warn'
          : 'ok'
  };
}

function computeAll() {
  var world = scanWorld();
  var events = readEvents();
  var evRem = eventRemain(events);
  var res = state.resource || autoResource(world);
  var rows = [];

  for (var i = 0; i < world.deposits.length; i++) {
    var d = world.deposits[i];
    if (d.res !== res) continue;
    rows.push(computeRow(d, resolveProducer(world, d), evRem));
  }
  rows.sort(function (a, b) {
    var w = { crit: 0, warn: 1, ok: 2 };
    if (w[a.status] !== w[b.status]) return w[a.status] - w[b.status];
    return a.dryMs - b.dryMs;
  });
  return { rows: rows, world: world, events: events, evRem: evRem, res: res };
}

function autoResource(world) {
  var seen = {}, order = [];
  for (var i = 0; i < world.deposits.length; i++) {
    var r = world.deposits[i].res;
    if (r && !seen[r]) { seen[r] = 1; order.push(r); }
  }
  for (var j = 0; j < order.length; j++) if (order[j] === 'HalloweenResource') return order[j];
  for (var k = 0; k < order.length; k++) if (order[k] === 'ValentinesFlower') return order[k];
  return order[0] || 'HalloweenResource';
}

/* ---------------- §10. Очередь действий ---------------- */
var queue = [], queueBusy = false;

function enqueue(fn) { queue.push(fn); pump(); }
function pump() {
  if (queueBusy) return;
  var job = queue.shift();
  if (!job) return;
  queueBusy = true;
  try { job(); } catch (e) { console.warn('[refill] job error', e); }
  setTimeout(function () { queueBusy = false; pump(); }, clamp(num(state.queueDelay, 350), 150, 3000));
}

function applyBuffTo(gridIdx, uid) {
  var g = gi();
  if (!g || gridIdx == null || !uid) return false;
  var targetGrid = typeof gridIdx === 'object' ? (gridIdx.idx !== undefined ? gridIdx.idx : gridIdx.raw) : gridIdx;
  return safe(function () {
    g.SendServerAction(61, 0, Number(targetGrid), 0, uid);
    return true;
  }, false);
}

function applyRow(rowModel, pack) {
  if (!pack || !pack.picks.length) return;
  var before = safe(function () { return rowModel.dep.raw.GetAmount(); }, 0);
  var targetGrid = rowModel.dep.grid.idx !== undefined ? rowModel.dep.grid.idx : rowModel.dep.raw.GetGrid();

  pack.picks.forEach(function (p) {
    for (var i = 0; i < p.n; i++) {
      enqueue(function () {
        applyBuffTo(targetGrid, p.uid);
      });
    }
  });

  setTimeout(function () {
    var after = safe(function () { return rowModel.dep.raw.GetAmount(); }, 0);
    var delta = after - before;
    if (delta > 0 && pack.picks[0]) {
      var key = pack.picks[0].key;
      var learned = num(state.buffStrength[key], 0);
      if (!learned || delta > learned) { state.buffStrength[key] = delta; save(); }
    }
    renderModalData();
  }, 2600);
}

/* ---------------- §11. Переход к полю ---------------- */
function focusGrid(grid) {
  if (!grid) return;
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

/* ---------------- §12. Модальное окно в стиле TSO ---------------- */
var currentRowsData = {};

function injectStyles() {
  if ($('#tsrModalStyle').length) return;
  var css = [
    '#EventRefillModal .modal-dialog { width: 750px; max-width: 95vw; }',
    '#EventRefillModal .modal-content { color: #f5eedb; }',
    '#EventRefillModal .modal-header { padding: 10px 15px 5px 15px; }',
    '#EventRefillModal .modal-body { max-height: 65vh; overflow-y: auto; padding: 10px 15px; }',
    '#EventRefillModal .modal-footer { padding: 8px 15px; }',
    '#EventRefillModal input, #EventRefillModal select {',
    '  background-color: #241708 !important;',
    '  color: #ffe6ae !important;',
    '  border: 1px solid #7c5c2a !important;',
    '  border-radius: 3px !important;',
    '  padding: 2px 6px !important;',
    '  font-size: 11px !important;',
    '  font-family: inherit !important;',
    '  box-shadow: inset 0 1px 3px rgba(0,0,0,0.6) !important;',
    '  outline: none !important;',
    '}',
    '#EventRefillModal input:focus, #EventRefillModal select:focus {',
    '  border-color: #ffd97a !important;',
    '  box-shadow: 0 0 5px rgba(255,217,122,0.5) !important;',
    '}',
    '#EventRefillModal input::placeholder {',
    '  color: #8a7047 !important;',
    '}',
    '#EventRefillModal .tsr-toolbar {',
    '  margin-bottom: 8px;',
    '  padding: 6px 10px;',
    '  background: rgba(0, 0, 0, 0.35);',
    '  border: 1px solid rgba(139, 107, 61, 0.4);',
    '  border-radius: 6px;',
    '}',
    '#EventRefillModal .tsr-toolbar select, #EventRefillModal .tsr-toolbar input {',
    '  height: 24px;',
    '  vertical-align: middle;',
    '}',
    '#EventRefillModal .tblHeader {',
    '  background-color: #b2a589;',
    '  height: 24px;',
    '  line-height: 24px;',
    '  color: #000;',
    '  font-weight: bold;',
    '  font-size: 11px;',
    '  padding-left: 6px;',
    '  padding-right: 6px;',
    '}',
    '#EventRefillModal .row {',
    '  margin-left: 0;',
    '  margin-right: 0;',
    '  margin-bottom: 2px;',
    '  line-height: 26px;',
    '  font-size: 11px;',
    '}',
    '#EventRefillModal .row:nth-child(even) { background-color: rgba(178, 165, 137, 0.12); }',
    '#EventRefillModal .row:nth-child(odd)  { background-color: rgba(178, 165, 137, 0.22); }',
    '#EventRefillModal .row:hover { background-color: rgba(166, 83, 41, 0.35); }',
    '#EventRefillModal .row.tsr-crit { background-color: rgba(224, 69, 43, 0.22); }',
    '#EventRefillModal .row.tsr-crit:hover { background-color: rgba(224, 69, 43, 0.38); }',
    '#EventRefillModal .tsr-field-in {',
    '  width: 65px !important;',
    '  height: 22px !important;',
    '  text-align: center !important;',
    '  display: inline-block !important;',
    '  margin-right: 4px !important;',
    '}',
    '#EventRefillModal .tsr-goto {',
    '  cursor: pointer;',
    '  vertical-align: middle;',
    '}',
    '#EventRefillModal .tsr-goto:hover {',
    '  filter: drop-shadow(0 0 3px #ffd97a);',
    '}',
    '#EventRefillModal .tsr-foot-table {',
    '  width: 100%;',
    '  display: flex;',
    '  justify-content: space-between;',
    '  align-items: center;',
    '  font-size: 11px;',
    '}',
    '#EventRefillModal .tsr-flash { animation: tsrFlash 0.9s ease-out; }',
    '@keyframes tsrFlash { 0% { background-color: rgba(255,217,122,0.8); } 100% { background-color: transparent; } }'
  ].join('\n');
  $('<style id="tsrModalStyle">').text(css).appendTo('head');
}

function openModal() {
  injectStyles();

  // Прячем другие модалки, чтобы не конфликтовать со слоем Flash Stage
  $("div[role='dialog']:not(#" + MODAL_ID + "):visible").modal('hide');

  if (!$('#' + MODAL_ID).length) {
    var modalTitle = 'Пополнение залежей (Ивент)';
    try {
      if (typeof loca !== 'undefined' && loca.GetText) {
        modalTitle = loca.GetText('RES', 'HalloweenResource') + ' / ' + loca.GetText('SHG', 'Deposits');
      }
    } catch (e) {}

    createModalWindow(MODAL_ID, modalTitle);
  }

  renderModalData();

  $('#' + MODAL_ID + ':not(:visible)').modal({ backdrop: 'static' });
}

function renderModalData() {
  var $modal = $('#' + MODAL_ID);
  if (!$modal.length) return;

  var data = computeAll();
  currentRowsData = {};

  // Формируем тулбар
  var seen = {}, opts = [];
  for (var i = 0; i < data.world.deposits.length; i++) {
    var rr = data.world.deposits[i].res;
    if (rr && !seen[rr]) { seen[rr] = 1; opts.push(rr); }
  }
  if (!state.resource && data.res) state.resource = data.res;

  var resOptsHtml = opts.map(function (r) {
    return '<option value="' + r + '"' + (r === state.resource ? ' selected' : '') + '>' + resMeta(r).label + '</option>';
  }).join('');

  var evOptsHtml = '<option value="__manual__"' + (!state.eventKey ? ' selected' : '') + '>— вручную —</option>' +
    data.events.map(function (e) {
      return '<option value="' + e.name + '"' + (e.name === state.eventKey ? ' selected' : '') + '>' + e.name + ' (' + fmtDur(e.stopTs - serverNow()) + ')</option>';
    }).join('');

  var manualVal = state.manualEventMs > 0 ? fmtDur(eventRemain(data.events)) : '';

  var toolbarHtml = [
    '<div class="tsr-toolbar">',
      createTableRow([
        [3, '<span style="color:#c9a86a">Ресурс:&nbsp;</span><select id="tsr_sel_res" style="width:110px">' + resOptsHtml + '</select>'],
        [4, '<span style="color:#c9a86a">Ивент:&nbsp;</span><select id="tsr_sel_ev" style="width:150px">' + evOptsHtml + '</select>'],
        [3, '<span style="color:#c9a86a">Конец:&nbsp;</span><input id="tsr_in_manual" type="text" placeholder="авто" value="' + manualVal + '" style="width:75px">'],
        [2, '<div style="text-align:right"><button id="tsr_btn_refresh" class="btn btn-sm btn-primary" title="Обновить">↻ Обновить</button></div>']
      ], false),
    '</div>'
  ].join('');

  // Формируем заголовок таблицы
  var tableHeadRow = createTableRow([
    [3, 'Залежь / Кол-во'],
    [2, 'Исчерпается'],
    [2, 'До бафа'],
    [2, 'До ивента'],
    [3, '<div style="text-align:center">Пополнение</div>']
  ], true);

  // Формируем список полей
  var listHtml = '';
  if (!data.world.ok) {
    listHtml = '<div style="padding:25px;text-align:center;color:#a18b64;font-size:13px">Клиент не готов — перейдите на домашний остров.</div>';
  } else if (!data.rows.length) {
    listHtml = '<div style="padding:25px;text-align:center;color:#a18b64;font-size:13px">Залежей «' + resMeta(state.resource).label + '» на карте не найдено.</div>';
  } else {
    for (var k = 0; k < data.rows.length; k++) {
      var m = data.rows[k];
      var key = m.dep.key;
      currentRowsData[key] = m;
      var meta = resMeta(m.dep.res);

      var resIconHtml = renderResIcon(meta.icon, '18px');
      var gotoIconHtml = renderResIcon('accuracy.png', '18px');
      if (!gotoIconHtml) gotoIconHtml = '◎';

      // Колонка 1: Иконка + Название + Остаток + Кнопка перехода
      var col1 = '<div style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">' +
        '<span class="tsr-goto" data-act="goto" data-key="' + key + '" title="Показать на карте" style="margin-right:4px;">' + gotoIconHtml + '</span>' +
        (resIconHtml ? resIconHtml + '&nbsp;' : '') +
        '<b style="color:#ffd97a">' + m.amount + '</b>' + (m.max > 0 ? '<small style="color:#c9a86a">/' + m.max + '</small>' : '') +
        '&nbsp;<small style="color:#8a7047">[' + key + ']</small>' +
      '</div>';

      // Колонка 2: Исчерпается
      var dryColor = m.status === 'crit' ? '#ff6b6b' : (m.status === 'warn' ? '#ffd97a' : '#72d572');
      var col2 = '<span style="color:' + dryColor + ';font-weight:' + (m.status === 'crit' ? 'bold' : 'normal') + '">' +
        fmtDur(m.dryMs) +
      '</span>';

      // Колонка 3: До конца бафа
      var col3 = '';
      if (m.needBuff == null) {
        col3 = '<span style="color:#7a6d58">—</span>';
      } else if (m.needBuff === 0) {
        col3 = '<span style="color:#72d572">Хватает</span>';
      } else {
        col3 = '<span style="color:#ff6b6b;font-weight:bold">+' + fmtInt(m.needBuff) + '</span>';
      }

      // Колонка 4: До конца ивента
      var col4 = '';
      if (m.needEvent == null) {
        col4 = '<span style="color:#7a6d58">—</span>';
      } else if (m.needEvent === 0) {
        col4 = '<span style="color:#72d572">Хватает</span>';
      } else {
        col4 = '<span style="color:' + (m.status === 'crit' ? '#ff6b6b' : '#ffd97a') + ';font-weight:bold">+' +
          fmtInt(m.needEvent) + (m.overCap ? ' <small style="color:#ff9e80" title="Превышает макс. емкость залежи">(!)</small>' : '') +
        '</span>';
      }

      // Колонка 5: Инпут + Кнопка пополнения
      var recVal = (m.needBuff != null && m.needBuff > 0) ? m.needBuff : (m.needEvent || 0);
      var col5 = '<div style="text-align:right;white-space:nowrap;">' +
        '<input class="tsr-field-in" type="number" min="0" step="1" placeholder="' + (recVal > 0 ? recVal : '0') + '" data-key="' + key + '">' +
        '<button class="btn btn-xs btn-success" data-act="refill-one" data-key="' + key + '" style="vertical-align:middle;padding:2px 8px;">+ Пополнить</button>' +
      '</div>';

      var rowClass = m.status === 'crit' ? 'tsr-crit' : '';
      var rowHtml = createTableRow([
        [3, col1],
        [2, col2],
        [2, col3],
        [2, col4],
        [3, col5]
      ], false);

      // Оборачиваем в data-key для подсветки
      listHtml += $(rowHtml).attr('data-key', key).addClass(rowClass).prop('outerHTML');
    }
  }

  // Обновляем тело
  $('#' + MODAL_ID + 'Data').html(
    '<div class="container-fluid">' +
      toolbarHtml +
      '<div style="margin-bottom:4px">' + tableHeadRow + '</div>' +
      '<div id="tsr_table_body">' + listHtml + '</div>' +
    '</div>'
  );

  // Формируем футер
  var totB = 0, totE = 0, critCount = 0;
  for (var t = 0; t < data.rows.length; t++) {
    if (data.rows[t].needBuff > 0) { totB += data.rows[t].needBuff; critCount++; }
    if (data.rows[t].needEvent > 0) totE += data.rows[t].needEvent;
  }
  var packs = packsFor(state.resource);
  var availTotal = packs.reduce(function (s, p) { return s + p.count * p.size; }, 0);

  var footerHtml = [
    '<div class="tsr-foot-table">',
      '<div style="text-align:left;line-height:1.3">',
        'К бафу: <b style="color:' + (totB > 0 ? '#ff7a5c' : '#ffd97a') + '">' + fmtInt(totB) + '</b> · ',
        'К ивенту: <b style="color:#ffd97a">' + fmtInt(totE) + '</b><br>',
        'Критичных: <b style="color:' + (critCount > 0 ? '#ff7a5c' : '#72d572') + '">' + critCount + '</b> · ',
        'В Звезде: <b style="color:#ffd97a">' + fmtInt(availTotal) + '</b>',
        (packs.length ? '' : ' <span style="color:#ff8b70">(нет пополнях)</span>'),
      '</div>',
      '<div style="display:flex;gap:6px">',
        '<button class="btn btn-warning btn-sm" id="tsr_btn_bulk_buff" style="padding:3px 10px">Пополнить до бафа</button>',
        '<button class="btn btn-primary btn-sm" id="tsr_btn_bulk_event" style="padding:3px 10px">Пополнить до ивента</button>',
      '</div>',
    '</div>'
  ].join('');

  $('#' + MODAL_ID + ' .modal-footer').find('.tsr-foot-table').remove();
  $('#' + MODAL_ID + ' .modal-footer').prepend(footerHtml);

  bindEvents();
}

function bindEvents() {
  var $modal = $('#' + MODAL_ID);
  $modal.off('.tsrEvents');

  // Выбор ресурса
  $modal.on('change.tsrEvents', '#tsr_sel_res', function () {
    state.resource = $(this).val();
    save();
    renderModalData();
  });

  // Выбор ивента
  $modal.on('change.tsrEvents', '#tsr_sel_ev', function () {
    var v = $(this).val();
    if (v === '__manual__') {
      state.eventKey = '';
    } else {
      state.eventKey = v;
      state.manualEventMs = 0;
    }
    save();
    renderModalData();
  });

  // Ручной ввод времени
  $modal.on('change.tsrEvents', '#tsr_in_manual', function () {
    var ms = parseManual($(this).val());
    state.manualEventMs = ms;
    state.manualSetAt = serverNow();
    if (ms > 0) state.eventKey = '';
    save();
    renderModalData();
  });

  // Кнопка обновления
  $modal.on('click.tsrEvents', '#tsr_btn_refresh', function () {
    renderModalData();
  });

  // Клик перехода к полю
  $modal.on('click.tsrEvents', '[data-act="goto"]', function () {
    var key = $(this).attr('data-key');
    var m = currentRowsData[key];
    if (m && m.dep && m.dep.grid) {
      focusGrid(m.dep.grid);
      var $row = $modal.find('.row[data-key="' + key + '"]');
      $row.removeClass('tsr-flash');
      setTimeout(function () { $row.addClass('tsr-flash'); }, 10);
    }
  });

  // Клик одиночного пополнения
  $modal.on('click.tsrEvents', '[data-act="refill-one"]', function () {
    var key = $(this).attr('data-key');
    var m = currentRowsData[key];
    if (!m) return;
    var $in = $modal.find('.tsr-field-in[data-key="' + key + '"]');
    var raw = parseInt($in.val(), 10);
    var need = (isFinite(raw) && raw > 0) ? raw : ((m.needBuff && m.needBuff > 0) ? m.needBuff : (m.needEvent || 0));
    if (need <= 0) {
      alert('Поле полностью обеспечено ресурсом.');
      return;
    }
    var plan = planPack(need, packsFor(state.resource));
    if (plan.short > 0) {
      alert('В Звезде не хватает пополнях на ' + fmtInt(plan.short) + ' ресурса!');
    }
    applyRow(m, plan);
  });

  // Массовое пополнение
  $modal.on('click.tsrEvents', '#tsr_btn_bulk_buff', function () {
    bulkRefill('buff');
  });
  $modal.on('click.tsrEvents', '#tsr_btn_bulk_event', function () {
    bulkRefill('event');
  });
}

function bulkRefill(mode) {
  var data = computeAll();
  var packs = packsFor(state.resource);
  var totalShort = 0, applied = 0;

  data.rows.forEach(function (m) {
    var need = mode === 'buff' ? (m.needBuff || 0) : (m.needEvent || 0);
    if (need <= 0) return;
    var plan = planPack(need, packs);
    if (plan.short > 0) totalShort += plan.short;
    if (plan.picks.length) {
      applyRow(m, plan);
      applied++;
    }
  });

  if (!applied) {
    alert('Все залежи уже обеспечены ресурсом.');
  } else if (totalShort > 0) {
    alert('Запущено пополнение ' + applied + ' полей. Не хватило пополнях в Звезде на ' + fmtInt(totalShort) + ' ед. ресурса.');
  }
}

/* ---------------- §13. Публичный API ---------------- */
W.__TSO_REFILL__ = {
  version: VERSION,
  open: openModal,
  toggle: openModal,
  refresh: renderModalData,
  state: state
};

/* ---------------- §14. Регистрация в меню TSO ---------------- */
try {
  var menuTitle = 'Пополнение залежей (Ивент)';
  try {
    if (typeof loca !== 'undefined' && loca.GetText) {
      menuTitle = loca.GetText('RES', 'HalloweenResource') + ' / ' + loca.GetText('SHG', 'Deposits');
    }
  } catch (e) {}

  addToolsMenuItem(menuTitle, function (event) {
    openModal();
  });
} catch (e) {
  console.warn('[refill] addToolsMenuItem error', e);
}

})();