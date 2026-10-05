var ShortcutTrader = (function () {

    // Clean up any stale injected styles or modal nodes from previous reloads
    try {
        $('#FT_TraderSettlersStyle').remove();
        $('#FT_FriendTraderModal').remove();
        $('#FT_ItemPickerModal').remove();
    } catch (e) {}

    // ─── Constants & Configuration ───────────────────────────────────────────

    var SCRIPT_CONST = {
        PREFIX:            'FT',
        NAME:              loca.GetText("QUL", "MiadTropicalSunQ2") + ', ' + loca.GetText("ACL", "SellGoods_1"),
        TRADE_TYPES:       { MARKET: 'market', FRIEND: 'friend' },
        TRADE_QUEUE_DELAY: 3000,
        BUTTON_COOLDOWN:   3000,
        SLOT_TYPE: {
            FREE_SLOT:            0,
            PAID_SLOT_WITH_GEMS:  1,
            PAID_SLOT_WITH_COINS: 2,
            FRIEND_TO_FRIEND:     4
        },
        TRADE_STATUS: {
            ACTIVE:            0,
            EXPIRED:           1,
            EXPIRED_SOLDTO:    2,
            EXPIRED_SOME_SOLD: 3,
            EXPIRED_ALL_SOLD:  4
        },
        MSG: {
            SEND_TRADE:         1049,
            REFRESH_TRADES:     1062,
            REQUEST_TRADE_DATA: 1061
        },
        MODE_ICONS: {
            MARKET: 'ChristmasMarketNormal',
            FRIEND: 'MultiplierBuffZone2_PremiumFriendBuff1DaySoccer'
        }
    };

    var buildTemplates;
    var _selectedOfferRes = 'Fish';
    var _selectedCostRes  = 'Coin';
    var _iconCache        = {};

    // ─── Safe Localization & Format Helpers ───────────────────────────────────

    function safeLoca(group, id, fallback) {
        try {
            if (typeof loca !== 'undefined' && loca && loca.GetText) {
                var t = loca.GetText(group, id);
                if (t && t.indexOf('[undefined') === -1 && t.indexOf('[missing') === -1) {
                    return t;
                }
            }
        } catch (e) {}
        return fallback !== undefined ? fallback : id;
    }

    function getCategoryLocalizedName(catKey) {
        var translated = safeLoca("LAB", catKey, null);
        if (translated) return translated;
        var fallbacks = {
            'WarehouseTab1': 'Базовые',
            'WarehouseTab2': 'Улучшенные',
            'WarehouseTab3': 'Усовершенствованные',
            'WarehouseTab4': 'Искусные',
            'WarehouseTab5': 'Войска',
            'WarehouseTab6': 'Событие',
            'WarehouseTab7': 'Коллекции',
            'WarehouseTab8': 'Элита',
            'Buffs':         'Усилители',
            'Adventures':    'Приключения',
            'Buildings':     'Здания'
        };
        return fallbacks[catKey] || catKey;
    }

    // Real FillDeposit_* buff names from gfx_settings (Buff name="FillDeposit_*").
    // Used only as a fallback after the composite icon (see getDepositCompositeIcon).
    var DEPOSIT_ICON_MAP = {
        'Fish':        ['FillDeposit_Fishfood'],
        'Meat':        ['FillDeposit_Hunter'],
        'Corn':        ['FillDeposit_Wheat_01'],
        'Marble':      ['FillDeposit_Marble'],
        'Stone':       ['FillDeposit_Stone'],
        'Granite':     ['FillDeposit_Granite'],
        'TitaniumOre': ['FillDeposit_Titanium'],
        'Salpeter':    ['FillDeposit_Salpeter'],
        'IronOre':     ['buff_fill_deposit_iron']
    };
    // Legacy keys that do not exist as game resources
    var DEPOSIT_RES_ALIASES = { 'Wheat': 'Corn' };
    function isValidBitmap(obj) {
        if (!obj) return false;
        var bd = obj.bitmapData || obj;
        return !!(bd && typeof bd.width === 'number' && bd.width > 1 && bd.height > 1);
    }

    function safeGetImage(obj, size) {
        if (!obj) return '';
        var bd = obj.bitmapData || obj;
        if (isValidBitmap(bd) && typeof utils !== 'undefined' && utils.getImage) {
            try {
                return utils.getImage(bd, size, size);
            } catch (e) {}
        }
        return '';
    }

    function closeSelectMenus() {
        try {
            $('.st-select-menu').each(function () {
                var $m = $(this);
                $m.hide();
                if (!$m.hasClass('st-portal')) return;
                var w = $m.data('stWrap');
                if (w && $.contains(document.documentElement, w)) {
                    $m.removeClass('st-portal');
                    this.setAttribute('style', $m.data('stOrigStyle') || '');
                    this.style.display = 'none';
                    w.appendChild(this);
                } else {
                    $m.remove();
                }
            });
        } catch (e) {}
    }

    // Menu is moved into the modal root (outside overflow:hidden rows) and positioned absolutely.
    function positionSelectMenu($trigger, $menu, $wrap, host) {
        var t = $trigger && $trigger[0], m = $menu && $menu[0];
        if (!t || !m || !host || !t.getBoundingClientRect) return;
        if (!$menu.hasClass('st-portal')) {
            $menu.data('stWrap', $wrap[0]);
            $menu.data('stOrigStyle', m.getAttribute('style') || '');
            $menu.addClass('st-portal');
            host.appendChild(m);
        }
        var sp = function (k, v) { m.style.setProperty(k, v, 'important'); };
        var isRes = $menu.hasClass('st-res-menu');
        sp('display', 'block'); sp('position', 'absolute');
        sp('top', '0px'); sp('left', '0px'); sp('right', 'auto'); sp('bottom', 'auto');
        sp('margin', '0px'); sp('z-index', '100000');
        var vw = window.innerWidth || document.documentElement.clientWidth || 1024;
        var vh = window.innerHeight || document.documentElement.clientHeight || 768;
        var hr = host.getBoundingClientRect();
        var bTop = Math.max(0, hr.top) + 4, bBot = Math.min(vh, hr.bottom) - 4;
        var bLeft = Math.max(0, hr.left) + 4, bRight = Math.min(vw, hr.right) - 4;
        var r = t.getBoundingClientRect();
        var w = Math.min(Math.max(r.width, isRes ? 280 : 230), bRight - bLeft);
        var below = bBot - r.bottom - 2, above = r.top - bTop - 2;
        var maxH = isRes ? 360 : 320;
        var up = below < 160 && above > below;
        var h = Math.max(60, Math.min(maxH, up ? above : below));
        var left = Math.min(Math.max(bLeft, r.left), bRight - w);
        sp('width', w + 'px'); sp('max-height', h + 'px');
        var mh = Math.min(h, m.offsetHeight || h);
        var top = up ? Math.max(bTop, r.top - 2 - mh) : r.bottom + 2;
        var o = m.getBoundingClientRect();
        sp('top', Math.round(top - o.top) + 'px');
        sp('left', Math.round(left - o.left) + 'px');
    }

    function getNativeIcon(names, size) {
        if (typeof assets === 'undefined' || !assets || !assets.GetBitmapData) return '';
        for (var i = 0; i < names.length; i++) {
            try {
                var bd = assets.GetBitmapData(names[i]);
                if (isValidBitmap(bd)) return safeGetImage(bd, size);
            } catch (e) {}
        }
        return '';
    }

    function getFillDepositLocalizedName(resKey) {
        var resLoc = getItemLocalizedName(resKey, 'resource') || resKey;
        var base = safeLoca("RES", "FillDeposit", "Добавить к залежи");
        base = base.replace(/\{\d+,?[A-Z]*\}/g, '')
                   .replace(/ед\.\s*ресурса/gi, '')
                   .replace(/[:\s]+$/, '')
                   .trim();
        if (!base) base = "Добавить к залежи";
        return base + ': ' + resLoc;
    }

    function getItemLocalizedName(name, type) {
        if (!name) return '';
        try {
            if (name.indexOf("FillDeposit_") === 0) {
                var resKey1 = name.replace("FillDeposit_", "");
                return getFillDepositLocalizedName(resKey1);
            }
            if (name.indexOf("FillDeposit") === 0 && name !== "FillDeposit") {
                var resKey2 = name.replace("FillDeposit", "");
                return getFillDepositLocalizedName(resKey2);
            }
            if (name === "FillDeposit") {
                var baseFill = safeLoca("RES", "FillDeposit", "Добавить к залежи");
                return baseFill.replace(/\{\d+,?[A-Z]*\}/g, '').replace(/ед\.\s*ресурса/gi, '').replace(/[:\s]+$/, '').trim();
            }
            var groups = type === 'adventure' ? ['ADN', 'RES', 'SHI', 'LAB']
                       : type === 'building'  ? ['BUI', 'RES', 'SHI', 'LAB']
                       : type === 'buff'      ? ['SHI', 'RES', 'BUI', 'ADN', 'LAB']
                       : ['RES', 'SHI', 'BUI', 'ADN', 'LAB'];
            for (var i = 0; i < groups.length; i++) {
                var val = safeLoca(groups[i], name, null);
                if (val) return val;
            }
        } catch (e) {}
        return name;
    }

    // Read the full inventory, not the zone-filtered/cached star-menu view.
    // An accessible empty vector is authoritative: do not resurrect old stock.
    function getStarBuffs() {
        var gi = (typeof game !== 'undefined' && game) ? game.gi : null;
        if (!gi) return [];
        var players = [gi.mCurrentPlayer, gi.mHomePlayer];
        for (var p = 0; p < players.length; p++) {
            try {
                var vec = players[p] ? players[p].mAvailableBuffs_vector : null;
                if (vec && typeof vec.length === 'number') return vec;
            } catch (eSv) {}
        }
        // Compatibility fallback only when the raw inventory is unavailable.
        for (var q = 0; q < players.length; q++) {
            try {
                if (players[q] && players[q].getBuffsSortedForStarMenu) {
                    var arr = players[q].getBuffsSortedForStarMenu();
                    if (arr && typeof arr.length === 'number') return arr;
                }
            } catch (eSb) {}
        }
        return [];
    }

    var _starBuffIconMap = null;
    var _starBuffIconMapTs = 0;
    function getStarBuffIconMap() {
        var nowTs = Date.now();
        if (_starBuffIconMap && (nowTs - _starBuffIconMapTs) < 30000) return _starBuffIconMap;
        _starBuffIconMapTs = nowTs;
        _starBuffIconMap = {};
        try {
            if (typeof game !== 'undefined' && game && game.gi) {
                var starBuffs = getStarBuffs();
                if (starBuffs) {
                    var sLen = starBuffs.length || 0;
                    for (var s = 0; s < sLen; s++) {
                        var sItem = starBuffs[s];
                        if (!sItem && starBuffs.getItemAt) sItem = starBuffs.getItemAt(s);
                        if (!sItem) continue;
                        var sType = sItem.GetType ? sItem.GetType() : '';
                        var sDef  = sItem.GetBuffDefinition ? sItem.GetBuffDefinition() : null;
                        var sbName = sDef ? sDef.GetName_string() : sType;
                        var srName = sItem.GetResourceName_string ? sItem.GetResourceName_string() : '';
                        if (sItem.GetBuffIconData) {
                            var sData = sItem.GetBuffIconData();
                            if (sData) {
                                if (sbName && !_starBuffIconMap[sbName]) _starBuffIconMap[sbName] = sData;
                                if (srName && !_starBuffIconMap[srName]) _starBuffIconMap[srName] = sData;
                                if (sType === 'FillDeposit' && srName) _starBuffIconMap['FillDeposit_' + srName] = sData;
                            }
                        }
                    }
                }
            }
        } catch (e) {}
        return _starBuffIconMap;
    }

    function getDepositFallbackSvg(size) {
        size = size || '32px';
        return '<svg width="' + size + '" height="' + size + '" viewBox="0 0 32 32" style="display:block;margin:auto;">' +
               '<defs>' +
               '  <radialGradient id="ft_dep_bg" cx="50%" cy="40%" r="55%">' +
               '    <stop offset="0%" stop-color="#8a6435"/>' +
               '    <stop offset="100%" stop-color="#3b2512"/>' +
               '  </radialGradient>' +
               '  <linearGradient id="ft_dep_gold" x1="0%" y1="0%" x2="100%" y2="100%">' +
               '    <stop offset="0%" stop-color="#ffe8a1"/>' +
               '    <stop offset="50%" stop-color="#d4a34b"/>' +
               '    <stop offset="100%" stop-color="#8c5e21"/>' +
               '  </linearGradient>' +
               '</defs>' +
               '<rect x="2" y="2" width="28" height="28" rx="4" fill="url(#ft_dep_bg)" stroke="url(#ft_dep_gold)" stroke-width="1.5"/>' +
               '<path d="M4 25 L10 13 L15 18 L21 11 L28 25 Z" fill="#6d502f" stroke="#967142" stroke-width="0.8"/>' +
               '<path d="M9 25 L12 18 L19 18 L22 25 Z" fill="#42301c" stroke="#d4a34b" stroke-width="0.8"/>' +
               '<circle cx="13" cy="21" r="1.5" fill="#ffe8a1"/>' +
               '<circle cx="18" cy="21" r="1.5" fill="#ffe8a1"/>' +
               '<circle cx="23" cy="9" r="6" fill="#1e4620" stroke="#ffd88a" stroke-width="1"/>' +
               '<path d="M23 5.5 L23 12.5 M19.5 9 L26.5 9" stroke="#75e075" stroke-width="1.8" stroke-linecap="round"/>' +
               '</svg>';
    }

    // Same as the original client (Frame.DisplayContent, CONTENT_TYPE_DEPOSIT_BUFF):
    // background = GetBuffIcon("FillDeposit") ("FillDeposit_Fishfood" for Fish),
    // foreground = GetResourceIcon(resource).
    function getDepositCompositeIcon(res, size) {
        if (!res || typeof assets === 'undefined' || !assets) return '';
        var px = parseInt(size, 10) || 34;
        var fgPx = Math.round(px * 0.68);
        var bg = '';
        if (assets.GetBuffIcon) {
            var bgKeys = (res === 'Fish') ? ['FillDeposit_Fishfood', 'FillDeposit'] : ['FillDeposit'];
            for (var b = 0; b < bgKeys.length && !bg; b++) {
                try { bg = safeGetImage(assets.GetBuffIcon(bgKeys[b]), px + 'px'); } catch (eBg) {}
            }
        }
        var fg = '';
        if (assets.GetResourceIcon) {
            try { fg = safeGetImage(assets.GetResourceIcon(res), fgPx + 'px'); } catch (eFg) {}
        }
        if (!fg) return '';
        return '<div class="ft-dep-icon" style="width:' + px + 'px;height:' + px + 'px;">' +
                 (bg ? '<div class="ft-dep-layer ft-dep-bg">' + bg + '</div>' : '') +
                 '<div class="ft-dep-layer ft-dep-fg">' + fg + '</div>' +
               '</div>';
    }

    // Cache of single-key lookups: hits forever, misses for 60s (each miss in
    // gAssetManager.GetGfx logs a warning and scans loadedGfxVector - expensive).
    var _singleIconCache = {};
    function tryLoadSingleIcon(key, size) {
        if (!key || typeof key !== 'string') return '';
        var ck = key + '|' + size;
        var hit = _singleIconCache[ck];
        var now = Date.now();
        if (hit && (hit.v || (now - hit.t) < 60000)) return hit.v;
        var v = tryLoadSingleIconRaw(key, size);
        _singleIconCache[ck] = { v: v, t: now };
        return v;
    }

    function tryLoadSingleIconRaw(key, size) {
        if (!key || typeof key !== 'string') return '';
        var k = key.trim();
        if (!k) return '';
        var tag = '';

        if (typeof assets !== 'undefined' && assets) {
            // 1. Buff icon
            if (!tag && assets.GetBuffIcon) {
                try { tag = safeGetImage(assets.GetBuffIcon(k, true), size); } catch (e1) {}
            }
            // 2. Resource icon
            if (!tag && assets.GetResourceIcon) {
                try { tag = safeGetImage(assets.GetResourceIcon(k, true), size); } catch (e2) {}
            }
            // 3. Direct BitmapData
            if (!tag && assets.GetBitmapData) {
                try {
                    tag = safeGetImage(assets.GetBitmapData(k), size) ||
                          safeGetImage(assets.GetBitmapData(k + '.png'), size);
                } catch (e3) {}
            }
            // 4. Dummy Icon with lowercase module prefixes (matching AS3 getIconFromLookupName)
            if (!tag && assets.GetDummyIcon) {
                try {
                    tag = safeGetImage(assets.GetDummyIcon("buffs:" + k), size) ||
                          safeGetImage(assets.GetDummyIcon("resources:" + k), size) ||
                          safeGetImage(assets.GetDummyIcon("shopitems:" + k), size) ||
                          safeGetImage(assets.GetDummyIcon("buildings:" + k), size);
                } catch (e4) {}
            }
            // 5. Building icon
            if (!tag && assets.GetBuildingIcon) {
                try { tag = safeGetImage(assets.GetBuildingIcon(k, true), size); } catch (e5) {}
            }
        }

        // 6. getImageByModule helper from 0-common.js
        if (!tag && typeof getImageByModule === 'function') {
            try {
                tag = getImageByModule('buffs', k, size, size) ||
                      getImageByModule('resources', k, size, size);
            } catch (e6) {}
        }

        return tag;
    }

    function getItemIconTag(name, type, size) {
        size = size || '34px';
        if (!name || typeof name !== 'string') {
            return '<span style="display:inline-block;width:' + size + ';height:' + size + ';background:rgba(0,0,0,0.3);border-radius:3px;"></span>';
        }
        var cacheKey = name + '_' + (type || '') + '_' + size;
        if (_iconCache[cacheKey]) {
            return _iconCache[cacheKey];
        }

        var isDepositRefill = false;
        var rawRes = '';
        if (name.indexOf('FillDeposit_') === 0) {
            isDepositRefill = true;
            rawRes = name.replace('FillDeposit_', '').trim();
        } else if (name.indexOf('FillDeposit') === 0) {
            isDepositRefill = true;
            if (name !== 'FillDeposit') rawRes = name.replace('FillDeposit', '').trim();
        } else if (name.indexOf('AddResource_') === 0) {
            rawRes = name.replace('AddResource_', '').trim();
        }

        if (rawRes && DEPOSIT_RES_ALIASES[rawRes]) rawRes = DEPOSIT_RES_ALIASES[rawRes];

        if (isDepositRefill && rawRes) {
            var depTag = getDepositCompositeIcon(rawRes, size);
            if (depTag) {
                _iconCache[cacheKey] = depTag;
                return depTag;
            }
        }

        var candidates = [];
        if (isDepositRefill) {            if (rawRes && DEPOSIT_ICON_MAP[rawRes]) {
                var depCandidates = DEPOSIT_ICON_MAP[rawRes];
                for (var dc = 0; dc < depCandidates.length; dc++) {
                    if (candidates.indexOf(depCandidates[dc]) === -1) candidates.push(depCandidates[dc]);
                }
            }
            if (rawRes) {
                if (candidates.indexOf('FillDeposit_' + rawRes) === -1) candidates.push('FillDeposit_' + rawRes);
                if (candidates.indexOf(rawRes) === -1) candidates.push(rawRes);
                if (candidates.indexOf('Deposit' + rawRes) === -1) candidates.push('Deposit' + rawRes);
                if (candidates.indexOf('deposit_' + rawRes.toLowerCase()) === -1) candidates.push('deposit_' + rawRes.toLowerCase());
            }
            if (candidates.indexOf('buff_fill_deposit') === -1) candidates.push('buff_fill_deposit');
            if (candidates.indexOf('FillDeposit') === -1) candidates.push('FillDeposit');
            if (candidates.indexOf('buff_fill_deposit_iron') === -1) candidates.push('buff_fill_deposit_iron');
            if (candidates.indexOf('AddResource') === -1) candidates.push('AddResource');
            if (candidates.indexOf(name) === -1) candidates.push(name);
        } else {
            candidates.push(name);
        }

        var itemInfo = null;
        try {
            if (typeof GameDataSource !== 'undefined' && GameDataSource.getItemInfo) {
                itemInfo = GameDataSource.getItemInfo(name);
            }
        } catch (eInfo) {}

        if (itemInfo) {
            if (itemInfo.buffName && candidates.indexOf(itemInfo.buffName) === -1) candidates.push(itemInfo.buffName);
            if (itemInfo.resourceName && candidates.indexOf(itemInfo.resourceName) === -1) candidates.push(itemInfo.resourceName);
            if (itemInfo.iconName && candidates.indexOf(itemInfo.iconName) === -1) candidates.push(itemInfo.iconName);
        }

        var tag = '';
        for (var c = 0; c < candidates.length && !tag; c++) {
            tag = tryLoadSingleIcon(candidates[c], size);
        }

        // Star Menu live icon data if present in inventory (cached lookup)
        if (!tag && typeof game !== 'undefined' && game.gi) {
            var sMap = getStarBuffIconMap();
            for (var sc = 0; sc < candidates.length && !tag; sc++) {
                var sData = sMap[candidates[sc]];
                if (sData) {
                    if ($.isArray(sData) && sData.length >= 2 && typeof getImageByModule === 'function') {
                        try { tag = getImageByModule(sData[0], sData[1], size, size); } catch (eSm1) {}
                    } else {
                        try { tag = safeGetImage(sData, size); } catch (eSm2) {}
                    }
                }
            }
        }

        // Dedicated deposit fallback SVG ensuring an icon ALWAYS appears
        if (!tag && isDepositRefill) {
            tag = getDepositFallbackSvg(size);
        }

        if (!tag) {
            tag = '<span style="display:inline-block;width:' + size + ';height:' + size + ';background:rgba(212,163,75,0.15);border:1px dashed #7c5828;border-radius:4px;line-height:' + size + ';text-align:center;font-size:10px;color:#d4a34b;">?</span>';
        }

        _iconCache[cacheKey] = tag;
        return tag;
    }

    function formatStockBadge(num) {
        if (!num) return '';
        var n = typeof num === 'number' ? num : parseInt(String(num).replace(/[^\d]/g, ''), 10);
        if (!n || isNaN(n) || n <= 0) return '';
        // Always floor (never overstate stock). One decimal while value < 10 units:
        // 1 500 -> 1.5k, 999 999 -> 999k, 2 995 000 -> 2.9M, 12 400 000 -> 12M
        function cut(v, div, suffix) {
            var tenths = Math.floor(v / (div / 10));
            var s = tenths < 100 ? String(tenths / 10) : String(Math.floor(tenths / 10));
            return s + suffix;
        }
        if (n >= 1000000000) return cut(n, 1000000000, 'B');
        if (n >= 1000000)    return cut(n, 1000000, 'M');
        if (n >= 1000)       return cut(n, 1000, 'k');
        return String(n);
    }

    function formatExactNumber(n) {
        return String(Math.floor(n)).replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
    }

    function escAttr(s) {
        return String(s).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }

    function getCachedIconTag(name, type, size) {
        if (!name || typeof name !== 'string') return '';
        return _iconCache[name + '_' + (type || '') + '_' + size] || '';
    }

    function formatFraction(input) {
        var n = parseInt(input, 10);
        return (n >= 1 && n <= 4) ? (n + '/4') : String(input);
    }

    // ─── Style Manager ────────────────────────────────────────────────────────

    var StyleManager = (function () {
        var STYLE_ID = 'FT_TraderSettlersStyle';

        function inject() {
            try { $('#' + STYLE_ID).remove(); } catch (e) {}

            var css =
                '/* Header top spacing: pushes title and info icon down by 20px */' +
                '#FT_FriendTraderModal .modal-header {' +
                '  padding-top: 25px !important;' +
                '}' +
                '#FT_FriendTraderModal .modal-header a, ' +
                '#FT_FriendTraderModal .modal-header .modal-title {' +
                '  vertical-align: middle !important;' +
                '}' +
                '/* Settlers-styled Inputs & Selects */' +
                '#FT_FriendTraderModal input[type="number"], ' +
                '#FT_FriendTraderModal input[type="text"], ' +
                '#FT_FriendTraderModal select, ' +
                '#FT_FriendTraderModal .form-control, ' +
                '#FT_ItemPickerModal input[type="text"], ' +
                '#FT_ItemPickerModal .form-control {' +
                '  color-scheme: dark !important;' +
                '  background-color: #1a1209 !important;' +
                '  background-image: linear-gradient(180deg, #22160c 0%, #150d06 100%) !important;' +
                '  color: #f7e2be !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  border-radius: 4px !important;' +
                '  box-shadow: inset 0 1px 3px rgba(0,0,0,0.8) !important;' +
                '  padding: 2px 6px !important;' +
                '  height: 26px !important;' +
                '  font-size: 12px !important;' +
                '  font-weight: 600 !important;' +
                '  display: inline-block !important;' +
                '  vertical-align: middle !important;' +
                '}' +
                '#FT_FriendTraderModal select option, ' +
                '#FT_FriendTraderModal select optgroup {' +
                '  background-color: #1a1209 !important;' +
                '  color: #f7e2be !important;' +
                '}' +
                '#FT_FriendTraderModal input:focus, ' +
                '#FT_FriendTraderModal select:focus, ' +
                '#FT_ItemPickerModal input:focus {' +
                '  border-color: #d4a34b !important;' +
                '  box-shadow: 0 0 6px rgba(212,163,75,0.7), inset 0 1px 3px rgba(0,0,0,0.8) !important;' +
                '  outline: none !important;' +
                '}' +
                '/* Custom Settlers Dropdown */' +
                '.st-select-wrapper {' +
                '  position: relative !important;' +
                '  display: inline-block !important;' +
                '  vertical-align: middle !important;' +
                '  box-sizing: border-box !important;' +
                '}' +
                '.st-select-trigger {' +
                '  display: block !important;' +
                '  width: 100% !important;' +
                '  height: 26px !important;' +
                '  line-height: 20px !important;' +
                '  padding: 2px 20px 2px 7px !important;' +
                '  background-color: #1a1209 !important;' +
                '  background-image: linear-gradient(180deg, #22160c 0%, #150d06 100%) !important;' +
                '  color: #f7e2be !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  border-radius: 4px !important;' +
                '  box-shadow: inset 0 1px 3px rgba(0,0,0,0.8) !important;' +
                '  cursor: pointer !important;' +
                '  user-select: none !important;' +
                '  font-size: 12px !important;' +
                '  font-weight: 600 !important;' +
                '  white-space: nowrap !important;' +
                '  overflow: hidden !important;' +
                '  text-overflow: ellipsis !important;' +
                '  position: relative !important;' +
                '  box-sizing: border-box !important;' +
                '}' +
                '.st-select-trigger:hover, ' +
                '.st-select-trigger:focus {' +
                '  border-color: #d4a34b !important;' +
                '  box-shadow: 0 0 6px rgba(212,163,75,0.7), inset 0 1px 3px rgba(0,0,0,0.8) !important;' +
                '}' +
                '.st-select-label {' +
                '  display: inline-block !important;' +
                '  vertical-align: middle !important;' +
                '  overflow: hidden !important;' +
                '  text-overflow: ellipsis !important;' +
                '  white-space: nowrap !important;' +
                '  max-width: 85% !important;' +
                '  color: #f7e2be !important;' +
                '}' +
                '.st-select-arrow {' +
                '  position: absolute !important;' +
                '  right: 6px !important;' +
                '  top: 50% !important;' +
                '  margin-top: -6px !important;' +
                '  font-size: 8px !important;' +
                '  color: #d4a34b !important;' +
                '  pointer-events: none !important;' +
                '  line-height: 12px !important;' +
                '  user-select: none !important;' +
                '}' +
                '.st-select-menu {' +
                '  display: none;' +
                '  position: absolute !important;' +
                '  top: 100% !important;' +
                '  left: 0 !important;' +
                '  right: 0 !important;' +
                '  z-index: 1070 !important;' +
                '  margin-top: 2px !important;' +
                '  max-height: 180px !important;' +
                '  overflow-y: auto !important;' +
                '  overflow-x: hidden !important;' +
                '  background-color: #1a1209 !important;' +
                '  background-image: none !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  border-radius: 4px !important;' +
                '  box-shadow: 0 3px 6px rgba(0,0,0,0.8) !important;' +
                '  padding: 2px 0 !important;' +
                '  box-sizing: border-box !important;' +
                '}' +
                '.st-select-option {' +
                '  padding: 4px 8px !important;' +
                '  font-size: 12px !important;' +
                '  font-weight: 600 !important;' +
                '  color: #f7e2be !important;' +
                '  cursor: pointer !important;' +
                '  white-space: nowrap !important;' +
                '  overflow: hidden !important;' +
                '  text-overflow: ellipsis !important;' +
                '  user-select: none !important;' +
                '  transition: background 0.12s, color 0.12s !important;' +
                '}' +
                '.st-select-option:hover {' +
                '  background-color: rgba(212, 163, 75, 0.35) !important;' +
                '  color: #ffffff !important;' +
                '}' +
                '.st-select-option.selected {' +
                '  background-color: #5a3d1c !important;' +
                '  color: #ffd88a !important;' +
                '  font-weight: bold !important;' +
                '}' +
                '/* Add Row Bootstrap Layout */' +
                '#FT_FriendTraderModal .FT_AddRowContainer .row, ' +
                '#FT_FriendTraderModal .FT_AddRowContainer .row > div {' +
                '  overflow: visible !important;' +
                '}' +
                '#FT_FriendTraderModal .FT_AddRowContainer .row {' +
                '  background: rgba(0, 0, 0, 0.15) !important;' +
                '  border-radius: 4px !important;' +
                '  margin: 2px 0 5px 0 !important;' +
                '  padding: 3px 0 !important;' +
                '  min-height: 32px !important;' +
                '  line-height: 26px !important;' +
                '}' +
                '#FT_FriendTraderModal .FT_AddRowContainer .row > div {' +
                '  vertical-align: middle !important;' +
                '  padding: 0 4px !important;' +
                '}' +
                '.st-slot-box {' +
                '  display: inline-block !important;' +
                '  white-space: nowrap !important;' +
                '  vertical-align: middle !important;' +
                '  background: rgba(0,0,0,0.08) !important;' +
                '  border-radius: 4px !important;' +
                '  padding: 2px 4px !important;' +
                '}' +
                '.st-res-menu { right: auto !important; width: 270px !important; max-height: 320px !important; }' +
                '.st-select-search-wrap { position: -webkit-sticky; position: sticky; top: 0; z-index: 2; padding: 4px 6px !important; background: #1a1209 !important; border-bottom: 1px solid #5a3d1c !important; }' +
                '#FT_FriendTraderModal input.st-select-search { display: block !important; width: 100% !important; height: 24px !important; box-sizing: border-box !important; padding: 2px 7px !important; background: #0e0904 !important; color: #f7e2be !important; border: 1px solid #7c5828 !important; border-radius: 3px !important; font-size: 12px !important; outline: none !important; box-shadow: inset 0 1px 2px rgba(0,0,0,0.9) !important; }' +
                '#FT_FriendTraderModal input.st-select-search:focus { border-color: #d4a34b !important; box-shadow: 0 0 5px rgba(212,163,75,0.6), inset 0 1px 2px rgba(0,0,0,0.9) !important; }' +
                '.st-select-group { padding: 6px 8px 3px 8px !important; font-size: 11px !important; font-weight: bold !important; color: #d4a34b !important; text-transform: uppercase; letter-spacing: 0.5px; border-top: 1px solid rgba(124,88,40,0.5) !important; cursor: default !important; -webkit-user-select: none !important; user-select: none !important; }' +
                '.st-slot-btn {' +
                '  width: 26px !important;' +
                '  height: 26px !important;' +
                '  background: linear-gradient(180deg, #382515 0%, #1f140a 100%) !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  border-radius: 4px !important;' +
                '  display: inline-block !important;' +
                '  vertical-align: middle !important;' +
                '  cursor: pointer !important;' +
                '  box-shadow: 0 2px 4px rgba(0,0,0,0.6), inset 0 1px 0 rgba(255,255,255,0.15) !important;' +
                '  padding: 0 !important;' +
                '  margin: 0 !important;' +
                '  text-align: center !important;' +
                '  user-select: none !important;' +
                '}' +
                '.st-slot-btn:hover {' +
                '  border-color: #f0c36d !important;' +
                '  box-shadow: 0 0 6px rgba(240,195,109,0.7) !important;' +
                '}' +
                '.st-slot-btn img {' +
                '  width: 20px !important;' +
                '  height: 20px !important;' +
                '  display: inline-block !important;' +
                '  vertical-align: middle !important;' +
                '  margin-top: 2px !important;' +
                '  object-fit: contain !important;' +
                '  pointer-events: none !important;' +
                '}' +
                '.st-add-btn {' +
                '  width: 26px !important;' +
                '  height: 26px !important;' +
                '  background: linear-gradient(180deg, #3d6b2c 0%, #204014 100%) !important;' +
                '  border: 1px solid #579848 !important;' +
                '  border-radius: 4px !important;' +
                '  display: inline-block !important;' +
                '  display: -webkit-inline-box !important;' +
                '  display: inline-flex !important;' +
                '  -webkit-box-pack: center !important;' +
                '  -webkit-box-align: center !important;' +
                '  align-items: center !important;' +
                '  justify-content: center !important;' +
                '  vertical-align: middle !important;' +
                '  text-align: center !important;' +
                '  line-height: 24px !important;' +
                '  cursor: pointer !important;' +
                '  box-shadow: 0 2px 4px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.2) !important;' +
                '  padding: 0 !important;' +
                '  margin: 0 !important;' +
                '  box-sizing: border-box !important;' +
                '}' +
                '.st-add-btn:hover {' +
                '  border-color: #8ce65a !important;' +
                '  box-shadow: 0 0 8px rgba(140,230,90,0.6) !important;' +
                '  transform: scale(1.05) !important;' +
                '}' +
                '.st-add-btn img {' +
                '  width: 18px !important;' +
                '  height: 18px !important;' +
                '  display: block !important;' +
                '  margin: 0 auto !important;' +
                '  object-fit: contain !important;' +
                '  pointer-events: none !important;' +
                '}' +
                '.st-add-btn span {' +
                '  display: inline-block !important;' +
                '  margin: 0 auto !important;' +
                '  line-height: 24px !important;' +
                '  vertical-align: middle !important;' +
                '  text-align: center !important;' +
                '}' +
                '/* Beautiful & Compact Trades List */' +
                '#FT_FriendTraderModal .tblHeader > div, ' +
                '#FT_FriendTraderModal .row.tblHeader > div {' +
                '  background: #B2A589 !important;' +
                '  color: #000 !important;' +
                '  font-weight: bold !important;' +
                '  padding: 3px 6px !important;' +
                '  font-size: 11px !important;' +
                '  border: none !important;' +
                '}' +
                '#FT_FriendTraderModal .FT_Trades .row {' +
                '  background: rgba(178, 165, 137, 0.12) !important;' +
                '  border: none !important;' +
                '  border-radius: 4px !important;' +
                '  margin: 1px 0 !important;' +
                '  padding: 2px 6px !important;' +
                '  min-height: 28px !important;' +
                '  line-height: 24px !important;' +
                '  transition: background 0.15s !important;' +
                '}' +
                '#FT_FriendTraderModal .FT_Trades .row:nth-child(even) {' +
                '  background: rgba(178, 165, 137, 0.22) !important;' +
                '}' +
                '#FT_FriendTraderModal .FT_Trades .row:hover {' +
                '  background: rgba(166, 83, 41, 0.35) !important;' +
                '}' +
                '#FT_FriendTraderModal .FT_Trades .row > div {' +
                '  font-size: 12px !important;' +
                '  vertical-align: middle !important;' +
                '  padding: 0 4px !important;' +
                '}' +

                '/* Item Picker Modal Styling */' +
                '#FT_ItemPickerModal { z-index: 1060 !important; }' +
                '#FT_ItemPickerModal .modal-dialog { width: 630px !important; max-width: 95vw !important; margin: 30px auto !important; }' +
                '#FT_ItemPickerModal .modal-content {' +
                '  border: none !important;' +
                '  box-shadow: none !important;' +
                '  background: transparent !important;' +
                '}' +
                '#FT_ItemPickerModal .modal-header {' +
                '  padding: 16px 22px 6px 22px !important;' +
                '  border-bottom: 0px !important;' +
                '}' +
                '#FT_ItemPickerModal .modal-title {' +
                '  white-space: normal !important;' +
                '  overflow: visible !important;' +
                '  text-overflow: clip !important;' +
                '  font-size: 15px !important;' +
                '  font-weight: bold !important;' +
                '  color: #ffd88a !important;' +
                '  text-shadow: 1px 1px 2px rgba(0,0,0,0.9) !important;' +
                '  margin-top: 10px !important;' +
                '}' +
                '#FT_ItemPickerModal .modal-body {' +
                '  height: auto !important;' +
                '  max-height: 80vh !important;' +
                '  overflow: visible !important;' +
                '  padding: 6px 22px !important;' +
                '}' +
                '.st-picker-search-bar { display: table !important; width: 100% !important; table-layout: auto !important; margin-bottom: 8px !important; }' +
                '.st-psb-search { display: table-cell !important; width: 100% !important; vertical-align: middle !important; padding-right: 10px !important; }' +
                '.st-psb-toggles { display: table-cell !important; vertical-align: middle !important; white-space: nowrap !important; }' +
                '#FT_ItemPickerModal .st-psb-search input.form-control { display: block !important; width: 100% !important; height: 28px !important; box-sizing: border-box !important; }' +
                '.st-picker-tabs {' +
                '  display: block !important;' +
                '  white-space: normal !important;' +
                '  overflow-x: hidden !important;' +
                '  overflow-y: visible !important;' +
                '  margin-bottom: 6px !important;' +
                '  padding: 2px 0 4px 0 !important;' +
                '  border-bottom: 1px solid #7c5828 !important;' +
                '}' +
                '.st-picker-tab {' +
                '  display: inline-block !important;' +
                '  vertical-align: middle !important;' +
                '  background: #24170d !important;' +
                '  border: 1px solid #5a3d1c !important;' +
                '  color: #d6bc92 !important;' +
                '  padding: 3px 7px !important;' +
                '  margin: 2px 2px !important;' +
                '  font-size: 11px !important;' +
                '  font-weight: 600 !important;' +
                '  border-radius: 4px !important;' +
                '  cursor: pointer !important;' +
                '  user-select: none !important;' +
                '  transition: all 0.12s ease !important;' +
                '}' +
                '.st-picker-tab:hover {' +
                '  background: #3a2717 !important;' +
                '  border-color: #8e6530 !important;' +
                '  color: #fff !important;' +
                '}' +
                '.st-picker-tab.active {' +
                '  background: linear-gradient(180deg, #6c4b22 0%, #483115 100%) !important;' +
                '  border-color: #d4a34b !important;' +
                '  color: #fff2cc !important;' +
                '  box-shadow: 0 0 6px rgba(212,163,75,0.4) !important;' +
                '}' +
                '/* Items Matrix - TSO Trade Style */' +
                '.st-picker-grid {' +
                '  display: block !important;' +
                '  text-align: left !important;' +
                '  height: 360px !important;' +
                '  max-height: 360px !important;' +
                '  overflow-y: auto !important;' +
                '  overflow-x: hidden !important;' +
                '  padding: 6px !important;' +
                '  margin: 0 !important;' +
                '  background: rgba(0,0,0,0.3) !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  border-radius: 4px !important;' +
                '  box-sizing: border-box !important;' +
                '}' +
                '#FT_ItemPickerModal .modal-footer {' +
                '  padding: 8px 22px 18px 22px !important;' +
                '  margin-top: 0px !important;' +
                '  border-top: 0px !important;' +
                '  text-align: right !important;' +
                '}' +
                '#FT_ItemPickerModal .modal-footer .btn, ' +
                '#FT_ItemPickerModal .modal-footer .btn:hover, ' +
                '#FT_ItemPickerModal .modal-footer .btn:focus, ' +
                '#FT_ItemPickerModal .modal-footer .btn:active, ' +
                '#FT_FriendTraderModal .modal-footer .btn, ' +
                '#FT_FriendTraderModal .modal-footer .btn:hover, ' +
                '#FT_FriendTraderModal .modal-footer .btn:focus, ' +
                '#FT_FriendTraderModal .modal-footer .btn:active {' +
                '  color: #000000 !important;' +
                '}' +
                '#FT_ItemPickerModal #FT_ItemPickerModal_ConfirmBtn:disabled, ' +
                '#FT_ItemPickerModal #FT_ItemPickerModal_ConfirmBtn[disabled] {' +
                '  opacity: 0.45 !important;' +
                '  cursor: not-allowed !important;' +
                '  pointer-events: none !important;' +
                '  filter: grayscale(0.5) !important;' +
                '}' +
                '#FT_ItemPickerModal #FT_ItemPickerModal_ConfirmBtn:not([disabled]) {' +
                '  opacity: 1 !important;' +
                '  cursor: pointer !important;' +
                '  pointer-events: auto !important;' +
                '  box-shadow: 0 0 8px rgba(92, 184, 92, 0.8) !important;' +
                '}' +
                '/* Authentic TSO Trade Cards (86px x 42px) */' +
                '.st-item-tile {' +
                '  display: inline-block !important;' +
                '  vertical-align: top !important;' +
                '  width: 86px !important;' +
                '  height: 42px !important;' +
                '  margin: 2px !important;' +
                '  background-color: #836641 !important;' +
                '  background-image: linear-gradient(180deg, #91754f 0%, #755734 100%) !important;' +
                '  border-top: 1px solid #a88d66 !important;' +
                '  border-left: 1px solid #a88d66 !important;' +
                '  border-right: 1px solid #48341e !important;' +
                '  border-bottom: 1px solid #48341e !important;' +
                '  border-radius: 2px !important;' +
                '  position: relative !important;' +
                '  cursor: pointer !important;' +
                '  text-align: left !important;' +
                '  box-shadow: 0 1px 2px rgba(0,0,0,0.5), inset 1px 1px 0 rgba(255,255,255,0.18), inset -1px -1px 0 rgba(0,0,0,0.3) !important;' +
                '  box-sizing: border-box !important;' +
                '  padding: 0 !important;' +
                '  overflow: hidden !important;' +
                '  user-select: none !important;' +
                '}' +
                '.st-item-tile:hover {' +
                '  border: 1px solid #ffd88a !important;' +
                '  box-shadow: 0 0 6px rgba(255,216,138,0.85), inset 1px 1px 0 rgba(255,255,255,0.25) !important;' +
                '  z-index: 5 !important;' +
                '}' +
                '.st-item-tile.selected {' +
                '  border: 2px solid #ffd88a !important;' +
                '  box-shadow: 0 0 8px rgba(255, 216, 138, 0.95), inset 0 0 4px rgba(255, 216, 138, 0.4) !important;' +
                '  background-image: linear-gradient(180deg, #9f835b 0%, #856642 100%) !important;' +
                '  z-index: 6 !important;' +
                '}' +
                '.st-tile-icon-box {' +
                '  position: absolute !important;' +
                '  left: 3px !important;' +
                '  top: 0 !important;' +
                '  bottom: 0 !important;' +
                '  width: 38px !important;' +
                '  height: 42px !important;' +
                '  margin: 0 !important;' +
                '  padding: 0 !important;' +
                '  overflow: visible !important;' +
                '  pointer-events: none !important;' +
                '  text-align: center !important;' +
                '}' +
                '.st-tile-icon-box img, ' +
                '.st-item-tile img, ' +
                '.st-tile-icon-box svg, ' +
                '.st-tile-icon-box span {' +
                '  position: absolute !important;' +
                '  top: 0 !important;' +
                '  bottom: 0 !important;' +
                '  left: 0 !important;' +
                '  right: 0 !important;' +
                '  margin: auto !important;' +
                '  max-width: 32px !important;' +
                '  max-height: 32px !important;' +
                '  width: auto !important;' +
                '  height: auto !important;' +
                '  display: block !important;' +
                '  object-fit: contain !important;' +
                '  image-rendering: -webkit-optimize-contrast !important;' +
                '  image-rendering: crisp-edges !important;' +
                '  pointer-events: none !important;' +
                '}' +
                '.ft-dep-icon { position: relative !important; display: inline-block !important; vertical-align: middle; overflow: visible !important; }' +
                '.st-tile-icon-box > .ft-dep-icon { position: absolute !important; top: 0 !important; bottom: 0 !important; left: 0 !important; right: 0 !important; margin: auto !important; }' +
                '.ft-dep-icon > .ft-dep-layer { position: absolute !important; top: 0 !important; left: 0 !important; right: 0 !important; bottom: 0 !important; }' +
                '.ft-dep-icon > .ft-dep-layer > img { position: absolute !important; top: 0 !important; bottom: 0 !important; left: 0 !important; right: 0 !important; margin: auto !important; width: auto !important; height: auto !important; }' +
                '.ft-dep-icon > .ft-dep-bg > img, #FT_ItemPickerModal_PreviewIcon .ft-dep-icon > .ft-dep-bg > img { max-width: 100% !important; max-height: 100% !important; }' +
                '.ft-dep-icon > .ft-dep-fg > img, #FT_ItemPickerModal_PreviewIcon .ft-dep-icon > .ft-dep-fg > img { max-width: 68% !important; max-height: 68% !important; }' +
                '#FT_ItemPickerModal_PreviewIcon {' +                '  position: relative !important;' +
                '}' +
                '#FT_ItemPickerModal_PreviewIcon img, ' +
                '#FT_ItemPickerModal_PreviewIcon svg {' +
                '  position: absolute !important;' +
                '  top: 0 !important;' +
                '  bottom: 0 !important;' +
                '  left: 0 !important;' +
                '  right: 0 !important;' +
                '  margin: auto !important;' +
                '  max-width: 32px !important;' +
                '  max-height: 32px !important;' +
                '}' +
                '.st-tile-stock {' +
                '  position: absolute !important;' +
                '  right: 5px !important;' +
                '  top: 0 !important;' +
                '  bottom: 0 !important;' +
                '  left: 45px !important;' +
                '  line-height: 42px !important;' +
                '  text-align: right !important;' +
                '  color: #1a140d !important;' +
                '  font-size: 11px !important;' +
                '  font-weight: bold !important;' +
                '  text-shadow: 0 1px 0 rgba(255,255,255,0.3) !important;' +
                '  white-space: nowrap !important;' +
                '  overflow: hidden !important;' +
                '  text-overflow: clip !important;' +
                '  pointer-events: none !important;' +
                '}' +
                '.st-tile-badge {' +
                '  display: none !important;' +
                '}' +
                '/* TSO-styled checkboxes */' +
                '.st-check { position: relative !important; display: inline-block !important; vertical-align: middle !important; margin: 0 !important; padding: 0 !important; cursor: pointer !important; -webkit-user-select: none !important; user-select: none !important; font-weight: normal !important; line-height: 16px !important; }' +
                '.st-check input[type="checkbox"] { position: absolute !important; left: 0 !important; top: 0 !important; width: 1px !important; height: 1px !important; margin: 0 !important; padding: 0 !important; opacity: 0 !important; overflow: hidden !important; }' +
                '.st-check .st-check-box { position: relative !important; display: inline-block !important; vertical-align: middle !important; width: 16px !important; height: 16px !important; box-sizing: border-box !important; border: 1px solid #a07a3c !important; border-radius: 3px !important; background: #4a3219 !important; box-shadow: inset 0 1px 3px rgba(0,0,0,0.7) !important; -webkit-transition: border-color 0.12s, box-shadow 0.12s, background-color 0.12s !important; transition: border-color 0.12s, box-shadow 0.12s, background-color 0.12s !important; }' +
                '.st-check .st-check-box:after { content: ""; position: absolute !important; left: 4px !important; top: 1px !important; width: 5px !important; height: 9px !important; border: solid #f3d9a4 !important; border-width: 0 2px 2px 0 !important; -webkit-transform: rotate(45deg) !important; transform: rotate(45deg) !important; display: none !important; }' +
                '.st-check:hover .st-check-box { border-color: #ffd88a !important; box-shadow: 0 0 5px rgba(255,216,138,0.55), inset 0 1px 3px rgba(0,0,0,0.95) !important; }' +
                '.st-check input:checked + .st-check-box { border-color: #e0b866 !important; background: #8a5f2c !important; box-shadow: 0 0 5px rgba(255,216,138,0.55), inset 0 1px 0 rgba(255,232,180,0.35) !important; }' +
                '.st-check input:checked + .st-check-box:after { display: block !important; }' +
                '.st-check input:disabled + .st-check-box { opacity: 0.35 !important; box-shadow: none !important; }' +
                '.st-check input:disabled ~ .st-check-text { opacity: 0.45 !important; }' +
                '.st-check-row input:disabled + .st-check-box { cursor: not-allowed !important; }' +
                '.st-check .st-check-text { display: inline-block !important; vertical-align: middle !important; margin-left: 7px !important; font-size: 12px !important; font-weight: 600 !important; color: #d6bc92 !important; white-space: nowrap !important; text-shadow: 1px 1px 1px #000 !important; }' +
                '.st-check input:checked ~ .st-check-text { color: #ffd88a !important; }' +
                '.st-check-pill { height: 28px !important; line-height: 26px !important; padding: 0 11px 0 9px !important; margin-left: 6px !important; box-sizing: border-box !important; background-color: #1a1209 !important; background-image: linear-gradient(180deg, #2e1e12 0%, #191008 100%) !important; border: 1px solid #7c5828 !important; border-radius: 4px !important; box-shadow: 0 1px 3px rgba(0,0,0,0.5) !important; }' +
                '.st-check-pill:hover { border-color: #d4a34b !important; }' +
                '.st-check-pill .st-check-box { margin-top: -2px !important; }' +
                '.st-check-row { margin: 0 8px 0 0 !important; }' +
                '/* Mode Switch Icon Buttons */' +
                '.st-mode-btn-group {' +
                '  display: inline-flex !important;' +
                '  align-items: center !important;' +
                '  gap: 3px !important;' +
                '  vertical-align: middle !important;' +
                '}' +
                '.st-mode-icon-btn img { width: 22px !important; height: 22px !important; display: block !important; opacity: 0.6; pointer-events: none !important; }' +
                '.st-mode-icon-btn:hover img, .st-mode-icon-btn.active img { opacity: 1; }' +
                '.st-mode-toggle { opacity: 0.45; }' +
                '.st-mode-toggle:hover { opacity: 0.8; }' +
                '.st-mode-toggle.active, .st-mode-toggle.active:hover { opacity: 1; }' +
                '.st-mode-toggle { display: inline-block !important; vertical-align: middle !important; text-align: center !important; line-height: 28px !important; }' +
                '.st-mode-toggle img { margin: 3px auto 0 auto !important; }' +
                '#FT_FriendTraderModal .container-fluid > .row { margin-left: 0 !important; margin-right: 0 !important; }' +
                '#FT_FriendTraderModal .container-fluid > .row > div { padding-left: 4px !important; padding-right: 4px !important; }' +
                '.st-mode-icon-btn {' +
                '  width: 30px !important;' +
                '  height: 30px !important;' +
                '  padding: 0 !important;' +
                '  margin: 0 !important;' +
                '  background-color: #1a1209 !important;' +
                '  background-image: linear-gradient(180deg, #2e1e12 0%, #191008 100%) !important;' +
                '  border: 1px solid #7c5828 !important;' +
                '  border-radius: 4px !important;' +
                '  color: #d6bc92 !important;' +
                '  cursor: pointer !important;' +
                '  display: inline-flex !important;' +
                '  align-items: center !important;' +
                '  justify-content: center !important;' +
                '  box-shadow: 0 1px 3px rgba(0,0,0,0.5) !important;' +
                '  transition: all 0.12s ease !important;' +
                '  outline: none !important;' +
                '}' +
                '.st-mode-icon-btn:hover {' +
                '  border-color: #ffd88a !important;' +
                '  color: #ffffff !important;' +
                '  box-shadow: 0 0 6px rgba(255,216,138,0.5) !important;' +
                '}' +
                '.st-mode-icon-btn.active {' +
                '  background-color: #5c3e1c !important;' +
                '  background-image: linear-gradient(180deg, #5c3e1c 0%, #3a2611 100%) !important;' +
                '  border: 1px solid #ffd88a !important;' +
                '  color: #ffd88a !important;' +
                '  box-shadow: 0 0 6px rgba(255,216,138,0.6), inset 0 1px 3px rgba(0,0,0,0.6) !important;' +
                '}';

            $('head').append('<style id="' + STYLE_ID + '">' + css + '</style>');
        }

        return { inject: inject };
    })();

    // ─── Game Data Source ─────────────────────────────────────────────────────

    var GameDataSource = (function () {
        var _friendsList  = null;
        var _resourceList = null;
        var _itemsMap     = {};

        function getFriendsList() {
            if (!_friendsList) {
                try {
                    var raw = globalFlash.gui.mFriendsList.GetFilteredFriends('', true);
                    _friendsList = [];
                    for (var i = 0; i < raw.length; i++) {
                        _friendsList.push({ id: raw[i].id, name: raw[i].username });
                    }
                    _friendsList.sort(function (a, b) {
                        var nameA = (a.name || '').toLowerCase();
                        var nameB = (b.name || '').toLowerCase();
                        return nameA.localeCompare(nameB);
                    });
                } catch (e) {
                    _friendsList = [];
                }
            }
            return _friendsList;
        }

        function getResourceList() {
            if (_resourceList) return _resourceList;

            var byCategory = {};
            var catNames = [];
            _itemsMap = {};

            function addCat(cat) {
                if (!byCategory.hasOwnProperty(cat)) {
                    byCategory[cat] = [];
                    catNames.push(cat);
                }
            }

            function addItem(cat, itemObj) {
                if (!itemObj || !itemObj.name || typeof itemObj.name !== 'string') return;
                var trimmedName = itemObj.name.trim();
                if (!trimmedName || trimmedName === 'null' || trimmedName === 'undefined') return;
                if (trimmedName === 'AddResource' || trimmedName.indexOf('AddResource_') === 0 || trimmedName === 'FillDeposit') return;
                itemObj.name = trimmedName;
                if (!itemObj.localizedName || itemObj.localizedName === 'undefined' || itemObj.localizedName === 'null') {
                    itemObj.localizedName = getItemLocalizedName(trimmedName, itemObj.type);
                }
                if (_itemsMap[trimmedName]) return;
                _itemsMap[trimmedName] = itemObj;
                addCat(cat);
                byCategory[cat].push(itemObj);
            }

            try {
                var gEconomics = swmmo.getDefinitionByName("ServerState::gEconomics");
                var products   = gEconomics.mResourceDefaultDefinition_vector;
                var eventMgr   = game.gi.mEventManager;
                var allWarehouseRes = [];

                // 1. Warehouse Resources
                for (var p = 0; p < products.length; p++) {
                    var prod = products[p];
                    if (!prod.tradable) continue;

                    var evtDef = gEconomics.mMap_EventResourceDefaultDefinition
                        ? gEconomics.mMap_EventResourceDefaultDefinition[prod.resourceName_string]
                        : null;
                    if (evtDef && evtDef.requiredEventName_string && eventMgr && !eventMgr.isEventStarted(evtDef.requiredEventName_string)) {
                        continue;
                    }

                    var cat = prod.group_string || prod.category_string || "WarehouseTab7";
                    var clMatch = cat.match(/^CL(\d+)$/);
                    if (clMatch) { cat = "WarehouseTab" + clMatch[1]; }
                    else if (cat === "Event") { cat = "WarehouseTab6"; }
                    else if (cat === "Collectibles") { cat = "WarehouseTab7"; }
                    if (cat === "WarehouseTab5") cat = "WarehouseTab8";

                    allWarehouseRes.push(prod.resourceName_string);
                    addItem(cat, {
                        name:          prod.resourceName_string,
                        type:          'resource',
                        category:      cat,
                        localizedName: getItemLocalizedName(prod.resourceName_string, 'resource')
                    });
                }

                // 2. Buffs from global definitions
                var buffMap = swmmo.getDefinitionByName("global").map_BuffName_BuffDefinition;
                var defines = game.def("defines");
                var seenBuffKeys = {};

                for (var bk in buffMap) {
                    var bd = buffMap[bk];
                    if (!bd) continue;
                    var bId   = bd.GetId ? bd.GetId() : -1;
                    var bName = bd.GetName_string ? bd.GetName_string() : bk;
                    var rName = bd.GetResourceName_string ? bd.GetResourceName_string() : '';

                    if (bId === defines.ADVENTURE_BUFF_ID ||
                        bId === defines.BUILD_BUILDING_BUFF_ID ||
                        bId === defines.HIRED_MILITARY_BUFF_ID ||
                        bName.indexOf(defines.CHANGE_COLOR_SCHEME_BUFF) === 0 ||
                        (bd.IsChangeSkinBuff && bd.IsChangeSkinBuff()) ||
                        (bd.IsChangeDefaultSkinBuff && bd.IsChangeDefaultSkinBuff())) {
                        continue;
                    }

                    var reqEvt = bd.GetRequieredEvent ? bd.GetRequieredEvent() : null;
                    if (reqEvt && eventMgr && !eventMgr.isEventStarted(reqEvt)) {
                        continue;
                    }

                    var isFillDeposit = (bName === defines.FILL_DEPOSIT_BUFF || bName === 'FillDeposit' || bk === 'FillDeposit');
                    var isAddResource = (bName === 'AddResource' || bk === 'AddResource');
                    if (isAddResource) continue;
                    if (!isFillDeposit && !bd.IsTradable(rName)) continue;

                    if (isFillDeposit) {
                        var subRes = rName ? rName.split(',') : [];
                        var defaultDepositRes = [
                            'IronOre', 'GoldOre', 'Coal', 'BronzeOre', 'Marble',
                            'Stone', 'Granite', 'Salpeter', 'TitaniumOre', 'Meat', 'Fish',
                            'Corn'
                        ];
                        for (var d = 0; d < defaultDepositRes.length; d++) {
                            if (subRes.indexOf(defaultDepositRes[d]) === -1) {
                                subRes.push(defaultDepositRes[d]);
                            }
                        }
                        try {
                            var starItemsF = getStarBuffs();
                            if (starItemsF) {
                                var sLenF = starItemsF.length || 0;
                                for (var stF = 0; stF < sLenF; stF++) {
                                    var siF = starItemsF[stF];
                                    if (!siF && starItemsF.getItemAt) siF = starItemsF.getItemAt(stF);
                                    if (siF && (siF.GetType && siF.GetType() === 'FillDeposit')) {
                                        var sResF = siF.GetResourceName_string ? siF.GetResourceName_string() : '';
                                        if (sResF && subRes.indexOf(sResF) === -1) {
                                            subRes.push(sResF);
                                        }
                                    }
                                }
                            }
                        } catch (eStarFill) {}

                        for (var s = 0; s < subRes.length; s++) {
                            var sub = subRes[s].trim();
                            if (!sub || seenBuffKeys['FillDeposit_' + sub]) continue;
                            seenBuffKeys['FillDeposit_' + sub] = true;
                            seenBuffKeys['FillDeposit'] = true;
                            addItem('Buffs', {
                                name:          'FillDeposit_' + sub,
                                type:          'buff',
                                buffName:      'FillDeposit',
                                resourceName:  sub,
                                category:      'Buffs',
                                localizedName: getFillDepositLocalizedName(sub)
                            });
                        }
                    } else {
                        var keyName = bName || rName;
                        if (!keyName || seenBuffKeys[keyName]) continue;
                        if (keyName === 'AddResource' || keyName === 'FillDeposit') continue;
                        seenBuffKeys[keyName] = true;
                        var iconCandidate = '';
                        if (bd.GetIcon_string) {
                            try { iconCandidate = bd.GetIcon_string(); } catch (eIco) {}
                        }
                        if (!iconCandidate && bd.GetIconName_string) {
                            try { iconCandidate = bd.GetIconName_string(); } catch (eIco2) {}
                        }
                        addItem('Buffs', {
                            name:          keyName,
                            type:          'buff',
                            buffName:      bName,
                            resourceName:  rName,
                            iconName:      iconCandidate,
                            category:      'Buffs',
                            localizedName: getItemLocalizedName(keyName, 'buff')
                        });
                    }
                }

                // 3. Shop Items (Strict Tradability Check matching client_scripts.txt:310614)
                try {
                    var ShopItemGroupClass = swmmo.getDefinitionByName("ShopSystem::cShopItemGroup");
                    var shopGroups = ShopItemGroupClass.GetAllShopItemGroups(true, game.gi);
                    if (shopGroups) {
                        for (var sg = 0; sg < shopGroups.length; sg++) {
                            var sGroup = shopGroups[sg];
                            if (!sGroup || !sGroup.shopItems_vector) continue;
                            for (var si = 0; si < sGroup.shopItems_vector.length; si++) {
                                var shopItem = sGroup.shopItems_vector[si];
                                var shopItemName = shopItem.GetName_string ? shopItem.GetName_string() : '';
                                var contents = shopItem.GetShopItemContent_vector ? shopItem.GetShopItemContent_vector() : [];
                                for (var sc = 0; sc < contents.length; sc++) {
                                    var itemContent = contents[sc];
                                    var cName = itemContent.GetName_string ? itemContent.GetName_string().trim() : '';
                                    var cRes  = itemContent.GetResourceName_string ? itemContent.GetResourceName_string().trim() : '';
                                    if (!cName || cName === 'AddResource' || cName === 'FillDeposit') continue;
                                    var bDef  = buffMap[cName];
                                    if (bDef && ((bDef.GetId && bDef.GetId() === defines.HIRED_MILITARY_BUFF_ID) ||
                                                 (cName.indexOf(defines.CHANGE_COLOR_SCHEME_BUFF) === 0) ||
                                                 (bDef.IsChangeSkinBuff && bDef.IsChangeSkinBuff()) ||
                                                 (bDef.IsChangeDefaultSkinBuff && bDef.IsChangeDefaultSkinBuff()))) {
                                        if (bDef.IsTradable(cRes)) {
                                            var kName = cRes || cName;
                                            if (!kName || kName === 'AddResource' || kName === 'FillDeposit') continue;
                                            if (!seenBuffKeys[kName]) {
                                                seenBuffKeys[kName] = true;
                                                addItem('Buffs', {
                                                    name:          kName,
                                                    type:          'buff',
                                                    buffName:      cName,
                                                    resourceName:  cRes,
                                                    iconName:      shopItemName,
                                                    category:      'Buffs',
                                                    localizedName: getItemLocalizedName(kName, 'buff')
                                                });
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch (eShop) {}

                // 4. Adventures
                try {
                    var AdvDef = swmmo.getDefinitionByName("AdventureSystem::cAdventureDefinition");
                    var advs   = AdvDef.map_AdventureName_AdventureDefinition.valueSet();
                    for (var ak in advs) {
                        var adv = advs[ak];
                        if (adv && adv.IsTradable && adv.IsTradable()) {
                            var advName = adv.GetName ? adv.GetName() : adv.mName_string;
                            if (advName && typeof advName === 'string') advName = advName.trim();
                            if (!advName) continue;
                            addItem('Adventures', {
                                name:          advName,
                                type:          'adventure',
                                stockKeys:     ['Adventure|' + advName, String(adv.mName_string || '')],
                                category:      'Adventures',
                                localizedName: getItemLocalizedName(advName, 'adventure')
                            });
                        }
                    }
                } catch (eAdv) {}

                // 5. Buildings
                try {
                    var blds = swmmo.getDefinitionByName("global").buildingGroup.mGOList_vector;
                    for (var bl = 0; bl < blds.length; bl++) {
                        var bld = blds[bl];
                        if (bld && bld.isTradable && bld.isTradable()) {
                            var bldGfx = bld.mGfxResourceListName_string;
                            if (bldGfx && typeof bldGfx === 'string') bldGfx = bldGfx.trim();
                            if (!bldGfx) continue;
                            var bldAlt = '';
                            try { bldAlt = String(bld.GetName_string ? bld.GetName_string() : (bld.mName_string || '')); } catch (eBn) {}
                            addItem('Buildings', {
                                name:          bldGfx,
                                type:          'building',
                                stockKeys:     ['BuildBuilding|' + bldGfx, bldAlt ? 'BuildBuilding|' + bldAlt : '', bldAlt],
                                category:      'Buildings',
                                localizedName: getItemLocalizedName(bldGfx, 'building')
                            });
                        }
                    }
                } catch (eBld) {}

                var categoryOrder = [
                    "WarehouseTab1", "WarehouseTab2", "WarehouseTab3", "WarehouseTab4",
                    "WarehouseTab8", "WarehouseTab6", "WarehouseTab7",
                    "Buffs", "Adventures", "Buildings"
                ];

                _resourceList = [];
                for (var co = 0; co < categoryOrder.length; co++) {
                    var cNameOrder = categoryOrder[co];
                    if (byCategory[cNameOrder] && byCategory[cNameOrder].length > 0) {
                        byCategory[cNameOrder].sort(function(a, b) {
                            return a.localizedName.localeCompare(b.localizedName);
                        });
                        _resourceList.push({
                            categoryName:          cNameOrder,
                            localizedCategoryName: getCategoryLocalizedName(cNameOrder),
                            items:                 byCategory[cNameOrder]
                        });
                    }
                }

                for (var cRest in byCategory) {
                    if (categoryOrder.indexOf(cRest) === -1 && byCategory[cRest].length > 0) {
                        byCategory[cRest].sort(function(a, b) {
                            return a.localizedName.localeCompare(b.localizedName);
                        });
                        _resourceList.push({
                            categoryName:          cRest,
                            localizedCategoryName: getCategoryLocalizedName(cRest),
                            items:                 byCategory[cRest]
                        });
                    }
                }
            } catch (e) {
                debug("getResourceList error: " + e);
                _resourceList = [];
            }
            return _resourceList;
        }

        function getPlayerStockMap(includeStar) {
            if (includeStar === undefined) includeStar = true;
            var stockMap = {};

            // 1. Warehouse Resources
            try {
                var pRes = null;
                if (typeof game !== 'undefined' && game) {
                    if (typeof game.getResources === 'function') {
                        try { pRes = game.getResources(); } catch (eGr) {}
                    }
                    if (!pRes && game.gi && game.gi.mCurrentPlayerZone && game.gi.mHomePlayer) {
                        try { pRes = game.gi.mCurrentPlayerZone.GetResources(game.gi.mHomePlayer); } catch (ePr) {}
                    }
                }
                if (pRes) {
                    var rVec = null;
                    if (typeof pRes.GetResources_Vector === 'function') {
                        try { rVec = pRes.GetResources_Vector(); } catch (eRv) {}
                    }
                    if (!rVec && typeof pRes.GetPlayerResources_vector === 'function') {
                        try {
                            var rGroup = 0;
                            try {
                                var rEnum = game.def("Enums::RESOURCE_GROUP") || game.def("Enums.RESOURCE_GROUP");
                                if (rEnum && rEnum.ALL !== undefined) rGroup = rEnum.ALL;
                            } catch (eEnum) {}
                            rVec = pRes.GetPlayerResources_vector(rGroup);
                        } catch (ePrv) {}
                    }
                    if (rVec) {
                        for (var r = 0; r < rVec.length; r++) {
                            var resItem = rVec[r];
                            if (resItem && resItem.name_string) {
                                var rawAmt = resItem.amount;
                                var parsedAmt = typeof rawAmt === 'number' ? rawAmt : parseInt(String(rawAmt).replace(/[^\d]/g, ''), 10);
                                stockMap[resItem.name_string] = isNaN(parsedAmt) ? 0 : parsedAmt;
                            }
                        }
                    }
                }
            } catch (eRes) {
                debug("getPlayerStockMap resources error: " + eRes);
            }

            // 2. Star menu items (Buffs, FillDeposit, Adventures, Buildings)
            if (includeStar) {
                try {
                    if (typeof game !== 'undefined' && game && game.gi) {
                        var bList = getStarBuffs();
                        if (bList) {
                            var bCount = bList.length || 0;
                            for (var b = 0; b < bCount; b++) {
                                try {
                                var item = bList[b];
                                if (!item && bList.getItemAt) item = bList.getItemAt(b);
                                if (!item) continue;
                                var def   = item.GetBuffDefinition ? item.GetBuffDefinition() : null;
                                var sType = String((item.GetType ? item.GetType() : '') || '');
                                var bName = String((def && def.GetName_string ? def.GetName_string() : '') || sType);
                                var rName = String((item.GetResourceName_string ? item.GetResourceName_string() : '') || '');
                                var rawAmtStar = item.GetAmount ? item.GetAmount() : (item.amount || 1);
                                var amt = typeof rawAmtStar === 'number' ? rawAmtStar : parseInt(String(rawAmtStar).replace(/[^\d]/g, ''), 10);
                                if (isNaN(amt) || amt <= 0) amt = 1;

                                if (bName) stockMap[bName] = (stockMap[bName] || 0) + amt;
                                var isDepositBuff = (String(bName || '').indexOf('FillDeposit') === 0 ||
                                                     String(sType || '').indexOf('FillDeposit') === 0);
                                if (rName && rName !== bName && !isDepositBuff) stockMap[rName] = (stockMap[rName] || 0) + amt;
                                if (rName) stockMap[bName + '|' + rName] = (stockMap[bName + '|' + rName] || 0) + amt;

                                if (sType === 'FillDeposit' || bName === 'FillDeposit') {
                                    if (rName) {
                                        stockMap['FillDeposit_' + rName] = (stockMap['FillDeposit_' + rName] || 0) + amt;
                                    }
                                }
                                } catch (eItem) {
                                    debug('getPlayerStockMap star item error: ' + eItem);
                                }
                            }
                        }
                    }
                } catch (eBuff) {
                    debug("getPlayerStockMap buffs error: " + eBuff);
                }
            }

            return stockMap;
        }

        // Stock for a picker item: exact name, then "buff|resource", then extra keys
        function getItemStock(item, map) {
            if (!item || !map) return 0;
            var v = map[item.name] || 0;
            if (!v && item.buffName && item.resourceName) v = map[item.buffName + '|' + item.resourceName] || 0;
            if (!v && item.stockKeys) {
                for (var k = 0; k < item.stockKeys.length && !v; k++) {
                    if (item.stockKeys[k]) v = map[item.stockKeys[k]] || 0;
                }
            }
            return v;
        }

        function getItemInfo(name) {
            if (!_resourceList) getResourceList();
            return _itemsMap[name] || null;
        }

        function invalidate() {
            _friendsList  = null;
            _resourceList = null;
            _itemsMap     = {};
        }

        return {
            getFriendsList:    getFriendsList,
            getResourceList:   getResourceList,
            getPlayerStockMap: getPlayerStockMap,
            getItemStock:      getItemStock,
            getItemInfo:       getItemInfo,
            invalidate:        invalidate
        };
    })();

    // ─── Item Picker Modal ────────────────────────────────────────────────────

    var ItemPickerModal = (function () {
        var MODAL_ID          = 'FT_ItemPickerModal';
        var _initialized      = false;
        var _targetSlot       = 'offer';
        var _curCategory      = 'ALL';
        var _searchQuery      = '';
        var _onlyInStock      = false;
        var _includeStar      = true;
        var _onSelectCb       = null;
        var _stockMap         = {};
        var _filteredList     = [];
        var _searchTimer      = null;
        var _selectedItemName = null;
        var _iconJob          = 0;

        // Fill icons that are not cached yet in small batches, so the grid
        // appears immediately and the UI does not freeze on the first open.
        function loadPendingIcons($grid) {
            var job   = ++_iconJob;
            var boxes = $grid.find('.st-tile-icon-box[data-pending]').get();
            var idx   = 0;
            function step() {
                if (job !== _iconJob) return;
                var end = Math.min(idx + 24, boxes.length);
                for (; idx < end; idx++) {
                    var box  = boxes[idx];
                    var tile = box.parentNode;
                    var nm   = tile ? tile.getAttribute('data-name') : null;
                    if (!nm) continue;
                    var inf  = GameDataSource.getItemInfo(nm);
                    try { box.innerHTML = getItemIconTag(nm, inf ? inf.type : null, '34px'); } catch (eIc) {}
                    box.removeAttribute('data-pending');
                }
                if (idx < boxes.length) setTimeout(step, 0);
            }
            step();
        }

        function create() {
            $('#' + MODAL_ID).remove();

            var modalHtml =
                '<div class="modal fade" id="' + MODAL_ID + '" role="dialog" tabindex="-1">' +
                '  <div class="modal-dialog modal-lg">' +
                '    <div class="modal-content">' +
                '      <div class="modal-header">' +
                '        <button type="button" class="close" data-dismiss="modal" style="color:#ffd88a;opacity:0.85;font-size:24px;margin-top:8px;outline:none;">&times;</button>' +
                '        <h4 class="modal-title" id="' + MODAL_ID + '_Title">' + safeLoca("LAB", "SelectTradeResources", "Выбор товара") + '</h4>' +
                '      </div>' +
                '      <div class="modal-body">' +
                '        <div class="st-picker-search-bar">' +
                '          <div class="st-psb-search">' +
                '            <input type="text" id="' + MODAL_ID + '_Search" class="form-control" placeholder="' + safeLoca("LAB", "Filter", "Поиск товара...") + '" style="width:100%;">' +
                '          </div>' +
                '          <div class="st-psb-toggles">' +
                '            <label class="st-check st-check-pill" title="' + safeLoca("LAB", "Available", "Только в наличии") + '">' +
                '              <input type="checkbox" id="' + MODAL_ID + '_StockOnly">' +
                '              <span class="st-check-box"></span>' +
                '              <span class="st-check-text">' + safeLoca("LAB", "Available", "В наличии") + '</span>' +
                '            </label>' +
                '            <label class="st-check st-check-pill" title="' + safeLoca("LAB", "IncludeStar", "Учитывать запасы в звездном меню") + '">' +
                '              <input type="checkbox" id="' + MODAL_ID + '_IncludeStar" checked="checked">' +
                '              <span class="st-check-box"></span>' +
                '              <span class="st-check-text">+ ' + safeLoca("LAB", "StarMenu", "Звезда") + '</span>' +
                '            </label>' +
                '          </div>' +
                '        </div>' +
                '        <div class="st-picker-tabs" id="' + MODAL_ID + '_Tabs"></div>' +
                '        <div class="st-picker-grid" id="' + MODAL_ID + '_Grid"></div>' +
                '      </div>' +
                '      <div class="modal-footer" style="padding:10px 22px 18px 22px !important;margin-top:0px !important;border-top:0px !important;">' +
                '        <div id="' + MODAL_ID + '_PreviewBar" style="float:left;text-align:left;max-width:360px;height:36px;line-height:36px;overflow:hidden;white-space:nowrap;">' +
                '          <span id="' + MODAL_ID + '_PreviewIcon" style="display:inline-block;vertical-align:middle;margin-right:8px;width:34px;height:34px;"></span>' +
                '          <span id="' + MODAL_ID + '_PreviewName" style="display:inline-block;vertical-align:middle;color:#ffd88a;font-weight:bold;font-size:13px;text-shadow:1px 1px 2px #000;overflow:hidden;text-overflow:ellipsis;max-width:310px;"></span>' +
                '        </div>' +
                '        <div style="float:right;">' +
                '          <button type="button" class="btn btn-success" id="' + MODAL_ID + '_ConfirmBtn" disabled="disabled" style="margin-right:8px;color:#000000 !important;font-weight:bold;">' + safeLoca("LAB", "Confirm", "Подтвердить") + '</button>' +
                '          <button type="button" class="btn btn-default btnClose" data-dismiss="modal">' + safeLoca("LAB", "Close", "Закрыть") + '</button>' +
                '        </div>' +
                '        <div style="clear:both;"></div>' +
                '      </div>' +
                '    </div>' +
                '  </div>' +
                '</div>';

            $('body').append(modalHtml);

            $('#' + MODAL_ID + '_Search').on('input', function () {
                var val = $(this).val().toLowerCase().trim();
                if (_searchTimer) clearTimeout(_searchTimer);
                _searchTimer = setTimeout(function () {
                    _searchQuery = val;
                    renderGrid();
                }, 150);
            });

            $('#' + MODAL_ID + '_StockOnly').on('change', function () {
                _onlyInStock = $(this).is(':checked');
                renderGrid();
            });

            $('#' + MODAL_ID + '_IncludeStar').on('change', function () {
                _includeStar = $(this).is(':checked');
                renderGrid();
            });

            $('#' + MODAL_ID + '_Tabs').on('click', '.st-picker-tab', function () {
                _curCategory = $(this).data('cat');
                $('#' + MODAL_ID + '_Tabs .st-picker-tab').removeClass('active');
                $(this).addClass('active');
                renderGrid();
            });

            var $grid = $('#' + MODAL_ID + '_Grid');

            $('#' + MODAL_ID).on('hidden.bs.modal', function () {
                _iconJob++;
                try { $('.tooltip').remove(); } catch (eTip) {}
            });

            // Clicking an item tile ONLY selects it and displays preview.
            // Confirmation via Confirm button is strictly required.
            $grid.on('click', '.st-item-tile', function () {
                var itemName = $(this).attr('data-name');
                if (itemName) {
                    selectItem(itemName);
                }
            });

            $('#' + MODAL_ID + '_ConfirmBtn').on('click', function () {
                confirmSelection();
            });

            _initialized = true;
        }

        function selectItem(itemName) {
            _selectedItemName = itemName;
            var $grid = $('#' + MODAL_ID + '_Grid');
            $grid.find('.st-item-tile').removeClass('selected');
            $grid.find('.st-item-tile').filter(function () {
                return this.getAttribute('data-name') === itemName;
            }).addClass('selected');

            var info = GameDataSource.getItemInfo(itemName);
            var locName = info ? info.localizedName : getItemLocalizedName(itemName);
            var itemType = info ? info.type : null;
            var iconTag = getItemIconTag(itemName, itemType, '34px');

            $('#' + MODAL_ID + '_PreviewIcon').html(iconTag);
            $('#' + MODAL_ID + '_PreviewName')
                .css({ color: '#ffd88a', fontStyle: 'normal' })
                .text(locName)
                .attr('title', locName);
            $('#' + MODAL_ID + '_PreviewBar').show();
            $('#' + MODAL_ID + '_ConfirmBtn')
                .prop('disabled', false)
                .removeAttr('disabled');
        }

        function confirmSelection() {
            if (_selectedItemName && _onSelectCb) {
                _onSelectCb(_selectedItemName);
            }
            $('#' + MODAL_ID).modal('hide');
        }

        function open(targetSlot, onSelectCallback, initialItemName) {
            create();
            _targetSlot       = targetSlot;
            _onSelectCb       = onSelectCallback;
            _searchQuery      = '';
            _includeStar      = true;
            _stockMap         = null;
            _onlyInStock      = false;
            _curCategory      = 'ALL';
            _selectedItemName = null;

            $('#' + MODAL_ID).find('.modal-content').css({ 'border': 'none', 'box-shadow': 'none' });

            $('#' + MODAL_ID + '_StockOnly').prop('checked', false);
            $('#' + MODAL_ID + '_IncludeStar').prop('checked', true);
            $('#' + MODAL_ID + '_Search').val('');

            var titleText = targetSlot === 'offer'
                ? safeLoca("QUL", "DaiTheProposal", "Предложение")
                : safeLoca("LAB", "Cost", "Стоимость");
            $('#' + MODAL_ID + '_Title').text(titleText);

            // Preview initial state
            $('#' + MODAL_ID + '_Grid .st-item-tile').removeClass('selected');
            $('#' + MODAL_ID + '_PreviewIcon').empty();
            $('#' + MODAL_ID + '_PreviewName')
                .css({ color: '#c4a675', fontStyle: 'italic' })
                .text(safeLoca("LAB", "SelectTradeResources", "Нажмите на ресурс для выбора..."))
                .removeAttr('title');
            $('#' + MODAL_ID + '_PreviewBar').show();
            $('#' + MODAL_ID + '_ConfirmBtn')
                .prop('disabled', true)
                .attr('disabled', 'disabled');

            if (initialItemName) {
                selectItem(initialItemName);
            }

            renderTabs();
            renderGrid();

            $('#' + MODAL_ID).modal({ backdrop: 'static', show: true });
            setTimeout(function () {
                $('#' + MODAL_ID + '_Search').focus();
            }, 200);
        }

        function renderTabs() {
            var categories = GameDataSource.getResourceList();
            var tabsHtml   = [];

            var allLabel = safeLoca("LAB", "All", "Все");
            tabsHtml.push('<span class="st-picker-tab' + (_curCategory === 'ALL' ? ' active' : '') + '" data-cat="ALL">' + allLabel + '</span>');

            for (var c = 0; c < categories.length; c++) {
                var cat = categories[c];
                var isActive = (_curCategory === cat.categoryName);
                tabsHtml.push(
                    '<span class="st-picker-tab' + (isActive ? ' active' : '') + '" data-cat="' + cat.categoryName + '">' +
                    cat.localizedCategoryName + '</span>'
                );
            }

            $('#' + MODAL_ID + '_Tabs').html(tabsHtml.join(''));
        }

        function renderGrid() {
            try { $('.tooltip').remove(); } catch (eRem) {}
            _iconJob++;
            var categories = GameDataSource.getResourceList();
            _filteredList = [];
            var seenNames = {};

            // Refresh on every render (tabs/search/toggles), not only on open.
            _stockMap = GameDataSource.getPlayerStockMap(_includeStar);

            for (var c = 0; c < categories.length; c++) {
                var cat = categories[c];
                if (_curCategory !== 'ALL' && _curCategory !== cat.categoryName) continue;

                for (var i = 0; i < cat.items.length; i++) {
                    var item = cat.items[i];
                    if (!item || !item.name) continue;
                    if (seenNames[item.name]) continue;
                    seenNames[item.name] = true;

                    var stock = GameDataSource.getItemStock(item, _stockMap);
                    if (_onlyInStock && stock <= 0) continue;

                    if (_searchQuery) {
                        if (item._searchKey === undefined) {
                            item._searchKey = ((item.localizedName || '') + '\n' + (item.name || '') + '\n' +
                                               (cat.localizedCategoryName || '')).toLowerCase();
                        }
                        if (item._searchKey.indexOf(_searchQuery) === -1) continue;
                    }

                    _filteredList.push({ item: item, stock: stock });
                }
            }

            var $grid = $('#' + MODAL_ID + '_Grid');
            $grid.empty().scrollTop(0);

            if (_filteredList.length === 0) {
                $grid.html('<div style="text-align:center;padding:25px;color:#8a7050;">' + safeLoca("LAB", "NotFound", "Ничего не найдено") + '</div>');
                return;
            }

            var html = [];
            for (var k = 0; k < _filteredList.length; k++) {
                var entry    = _filteredList[k];
                var itm      = entry.item;
                if (!itm || !itm.name) continue;
                var stk      = entry.stock;
                var stockTxt = stk > 0 ? formatStockBadge(stk) : '';
                var tooltip  = (itm.localizedName || itm.name) + (stk > 0 ? ' — ' + formatExactNumber(stk) : '');
                var isSel    = (itm.name === _selectedItemName);
                var safeName = escAttr(itm.name);
                var safeTip  = escAttr(tooltip);
                var iconHtml = getCachedIconTag(itm.name, itm.type, '34px');
                var iconAttr = iconHtml ? '' : ' data-pending="1"';


                html.push(
                    '<div class="st-item-tile' + (isSel ? ' selected' : '') + '" data-name="' + safeName + '" title="' + safeTip + '">' +
                    '  <div class="st-tile-icon-box"' + iconAttr + '>' + iconHtml + '</div>' +
                    '  <div class="st-tile-stock">' + stockTxt + '</div>' +
                    '</div>'
                );
            }
            $grid.html(html.join(''));
            loadPendingIcons($grid);
        }

        return { open: open };
    })();

    // ─── User Trades Reader ───────────────────────────────────────────────────

    var UserTradesReader = (function () {

        function getDataProvider() {
            try {
                var GuiBase = swmmo.getDefinitionByName("GUI::cGuiBaseElement");
                var tw      = GuiBase.GetPanel("GAMESTATE_ID_TRADE_WINDOW");
                if (!tw || !tw.userPlaceOffersList) return null;
                return tw.userPlaceOffersList.dataProvider;
            } catch (e) {
                return null;
            }
        }

        function isReady() {
            var dp = getDataProvider();
            return !!(dp && dp.length > 0);
        }

        function isActiveOrder(t) {
            if (!t || !t.offer) return false;
            var hasOffer = !!(t.offer.name_string || t.offer.buffName_string || t.offer.resourceName_string);
            if (!hasOffer) return false;
            return (t.status === SCRIPT_CONST.TRADE_STATUS.ACTIVE) || (t.coolDownTime > 0);
        }

        function extractTradeItemName(itemVO) {
            if (!itemVO) return '';
            var bName = itemVO.buffName_string || '';
            var rName = itemVO.resourceName_string || '';
            var nName = itemVO.name_string || '';
            if (bName === 'FillDeposit' || nName === 'FillDeposit') {
                return rName ? ('FillDeposit_' + rName) : 'FillDeposit';
            }
            return nName || rName || bName || '';
        }

        function getUserTrades() {
            var dp = getDataProvider();
            if (!dp) return [];
            var result = [];
            for (var i = 0; i < dp.length; i++) {
                var t = dp.getItemAt(i);
                if (!isActiveOrder(t)) continue;
                var offerName = extractTradeItemName(t.offer);
                var costName  = extractTradeItemName(t.costs);
                result.push({
                    tradeID:       t.tradeID,
                    slotType:      t.slotType,
                    slotPos:       t.slotPos,
                    status:        t.status,
                    coolDownTime:  t.coolDownTime,
                    runningTime:   t.runningTime || '',
                    remainingLots: t.remainingLots,
                    totalLots:     t.totalLots,
                    lots:          t.totalLots || 1,
                    offerResName:  offerName,
                    offerResAmount:t.offer ? (t.offer.amount || 0) : 0,
                    costResName:   costName,
                    costResAmount: t.costs ? (t.costs.amount  || 0) : 0
                });
            }
            return result;
        }

        // Trades sent in this session that the client data does not show yet.
        // The server / trade window update with a delay, so they are counted
        // right away and dropped once the real data has them (or after 90 s).
        var PENDING_TTL = 90000;
        var _pending = {};

        function isMarketSlotType(st) {
            return st === SCRIPT_CONST.SLOT_TYPE.FREE_SLOT || st === SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS;
        }

        function getRealMarketSlotKeys() {
            var keys = {};
            try {
                var trades = getUserTrades();
                for (var i = 0; i < trades.length; i++) {
                    if (isMarketSlotType(trades[i].slotType)) keys[trades[i].slotType + '_' + trades[i].slotPos] = true;
                }
            } catch (eT) {}
            try {
                var td    = game.gi.mHomePlayer.mTradeData;
                var free  = td.getNextFreeSlotForType(SCRIPT_CONST.SLOT_TYPE.FREE_SLOT);
                var coins = td.getNextFreeSlotForType(SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS);
                if (free > 0) keys[SCRIPT_CONST.SLOT_TYPE.FREE_SLOT + '_0'] = true;
                for (var c = 0; c < coins; c++) keys[SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS + '_' + c] = true;
            } catch (eN) {}
            return keys;
        }

        // Busy market slots: real ones + pending ones (keys "slotType_slotPos")
        function getBusyMarketSlotKeys() {
            var keys = getRealMarketSlotKeys();
            var now  = Date.now();
            for (var k in _pending) {
                if (!_pending.hasOwnProperty(k)) continue;
                if (keys[k] || (now - _pending[k]) > PENDING_TTL) { delete _pending[k]; continue; }
                keys[k] = true;
            }
            return keys;
        }

        function notePlaced(slotType, slotPos) {
            if (!isMarketSlotType(slotType)) return;
            _pending[slotType + '_' + slotPos] = Date.now();
        }

        function hasPending() {
            for (var k in _pending) { if (_pending.hasOwnProperty(k)) return true; }
            return false;
        }

        function getCountActiveTrades() {
            var keys = getBusyMarketSlotKeys(), n = 0;
            for (var k in keys) { if (keys.hasOwnProperty(k)) n++; }
            return n;
        }

        return {
            isReady:               isReady,
            getUserTrades:         getUserTrades,
            getCountActiveTrades:  getCountActiveTrades,
            getBusyMarketSlotKeys: getBusyMarketSlotKeys,
            notePlaced:            notePlaced,
            hasPending:            hasPending
        };
    })();

    // ─── Slot Capacity ────────────────────────────────────────────────────────

    var SlotCapacity = (function () {

        function getMaxCoinsSlots() {
            try { return swmmo.getDefinitionByName("global").activateSlotsWithCoins_vector.length; }
            catch (e) { return 10; }
        }

        function getUsedSlotsForType(slotType) {
            try {
                return game.gi.mHomePlayer.mTradeData.getNextFreeSlotForType(slotType);
            } catch (e) {
                return 0;
            }
        }

        function getRemainingMarketCapacity() {
            var activeCount = UserTradesReader.getCountActiveTrades();
            return Math.max(0, getMaxCoinsSlots() + 1 - activeCount);
        }

        // Picks the first free market slot not in busyKeys and marks it as taken.
        function resolveSlot(busyKeys) {
            var FREE  = SCRIPT_CONST.SLOT_TYPE.FREE_SLOT;
            var COINS = SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS;
            if (!busyKeys[FREE + '_0']) {
                busyKeys[FREE + '_0'] = true;
                return { slotType: FREE, slotPos: 0 };
            }
            var maxCoins = getMaxCoinsSlots();
            for (var pos = 0; pos < maxCoins; pos++) {
                if (!busyKeys[COINS + '_' + pos]) {
                    busyKeys[COINS + '_' + pos] = true;
                    return { slotType: COINS, slotPos: pos };
                }
            }
            return null;
        }

        return {
            getRemainingMarketCapacity: getRemainingMarketCapacity,
            getUsedSlotsForType:        getUsedSlotsForType,
            getMaxCoinsSlots:           getMaxCoinsSlots,
            resolveSlot:                resolveSlot
        };
    })();

    // ─── Local Trade Injector ─────────────────────────────────────────────────

    var LocalTradeInjector = (function () {
        var _idCounter = -1000;

        function inject(slotType, slotPos, offerName, offerAmount, costName, costAmount, lots) {
            try {
                var VOClass = game.def("Communication.VO.TradeWindow::dTradeObjectVO");
                var ACClass = swmmo.getDefinitionByName("mx.collections::ArrayCollection");

                var vo            = new VOClass();
                vo.id             = _idCounter--;
                vo.senderID       = game.gi.mHomePlayer.GetPlayerId();
                vo.receiverID     = 0;
                vo.type           = 0;
                vo.slotType       = slotType;
                vo.slotPos        = slotPos;
                vo.created        = new Date().getTime();
                vo.remainingTime  = 3600000 * 6;
                vo.lotsRemaining  = lots || 1;
                vo.deleted        = 0;
                vo.coolDownTime   = 0;
                vo.isTradeCancled = false;
                vo.senderName     = '';
                vo.offer          = offerName + ',' + offerAmount + '|' + costName + ',' + costAmount + '|' + (lots || 1);

                var col = new ACClass();
                col.addItem(vo);
                game.gi.mHomePlayer.mTradeData.setUserPlacedOffers(col);
            } catch (e) {
                debug('LocalTradeInjector.inject error: ' + e);
            }
        }

        function injectMissing(slots) {
            var existing     = UserTradesReader.getUserTrades();
            var existingKeys = {};
            for (var e = 0; e < existing.length; e++) {
                existingKeys[existing[e].slotType + '_' + existing[e].slotPos] = true;
            }
            try {
                var td = game.gi.mHomePlayer.mTradeData;
                if (td.getNextFreeSlotForType(SCRIPT_CONST.SLOT_TYPE.FREE_SLOT) > 0) existingKeys[SCRIPT_CONST.SLOT_TYPE.FREE_SLOT + '_0'] = true;
                var nc = td.getNextFreeSlotForType(SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS);
                for (var c = 0; c < nc; c++) existingKeys[SCRIPT_CONST.SLOT_TYPE.PAID_SLOT_WITH_COINS + '_' + c] = true;
            } catch (eTd) {}
            for (var i = 0; i < slots.length; i++) {
                var s = slots[i];
                if (!s || !s.slot) continue;
                var key = s.slot.slotType + '_' + s.slot.slotPos;
                if (existingKeys[key]) continue;
                inject(
                    s.slot.slotType, s.slot.slotPos,
                    s.tr.offerResName, s.tr.offerResAmount,
                    s.tr.costResName,  s.tr.costResAmount,
                    s.tr.UserName
                );
            }
        }

        return { inject: inject, injectMissing: injectMissing };
    })();

    // ─── Settings Service ─────────────────────────────────────────────────────

    var SettingsService = (function () {
        var STATE = initStateData();

        function initStateData() {
            return {
                tradesData: {
                    isMarketTradeMode: true,
                    zone_id:           game.gi ? game.gi.mCurrentViewedZoneID : 0,
                    friendsTrades:     [],
                    marketTrades:      [],
                    useClassicInput:   false
                },
                modalInitialized: false
            };
        }

        function resetState()  {
            var keepClassic = !!(STATE && STATE.tradesData && STATE.tradesData.useClassicInput);
            STATE = initStateData();
            STATE.tradesData.useClassicInput = keepClassic;
            return STATE;
        }
        function getState()    { return STATE; }
        function setState(s)   { STATE = s; }

        function saveSettings() {
            settings.settings[SCRIPT_CONST.PREFIX + '_SETTINGS'] = {};
            settings.store(STATE.tradesData, SCRIPT_CONST.PREFIX + '_SETTINGS');
        }

        function getCurrentTrades() {
            return STATE.tradesData.isMarketTradeMode
                ? STATE.tradesData.marketTrades
                : STATE.tradesData.friendsTrades;
        }

        function removeTrade(index) {
            if (STATE.tradesData.isMarketTradeMode) {
                STATE.tradesData.marketTrades.splice(index, 1);
            } else {
                STATE.tradesData.friendsTrades.splice(index, 1);
            }
        }

        function getTradeModeType() {
            return STATE.tradesData.isMarketTradeMode
                ? SCRIPT_CONST.TRADE_TYPES.MARKET
                : SCRIPT_CONST.TRADE_TYPES.FRIEND;
        }

        function isMarketModeON() { return STATE.tradesData.isMarketTradeMode; }

        // Input mode lives in its own settings key (FT_UI), so Reset and template
        // loading (which replace tradesData) never lose it between launches.
        var UI_KEY = SCRIPT_CONST.PREFIX + '_UI';

        function isClassicInput() {
            try {
                var m = settings.read('inputMode', UI_KEY);
                if (m === 'classic') return true;
                if (m === 'rich')    return false;
            } catch (eR) {}
            return !!(STATE.tradesData && STATE.tradesData.useClassicInput);
        }

        function setClassicInput(val) {
            if (!STATE.tradesData) STATE.tradesData = {};
            STATE.tradesData.useClassicInput = !!val;
            try { settings.store({ inputMode: val ? 'classic' : 'rich' }, UI_KEY); } catch (eS) {}
            saveSettings();
        }

        return {
            getState: getState, setState: setState, resetState: resetState,
            saveSettings: saveSettings, removeTrade: removeTrade,
            getCurrentTrades: getCurrentTrades, getTradeModeType: getTradeModeType,
            isMarketModeON: isMarketModeON,
            isClassicInput: isClassicInput, setClassicInput: setClassicInput
        };
    })();

    // ─── UI Map ───────────────────────────────────────────────────────────────

    var UIMap = {
        ids: {
            modal:             SCRIPT_CONST.PREFIX + '_FriendTraderModal',
            modalData:         SCRIPT_CONST.PREFIX + '_FriendTraderModalData',
            modeMarketBtn:     SCRIPT_CONST.PREFIX + '_ModeMarket',
            modeFriendBtn:     SCRIPT_CONST.PREFIX + '_ModeFriend',
            modeFriendLbl:     SCRIPT_CONST.PREFIX + '_MainModeLabel',
            modeClassicBtn:    SCRIPT_CONST.PREFIX + '_ModeClassicBtn',
            modeRichBtn:       SCRIPT_CONST.PREFIX + '_ModeRichBtn',
            slotInfo:          SCRIPT_CONST.PREFIX + '_SlotInfo',
            selectCounter:     SCRIPT_CONST.PREFIX + '_SelectCounter',

            offerSlotBtn:      SCRIPT_CONST.PREFIX + '_OfferSlotBtn',
            costSlotBtn:       SCRIPT_CONST.PREFIX + '_CostSlotBtn',
            offerInputStr:     SCRIPT_CONST.PREFIX + '_AddOffer_',
            costInputStr:      SCRIPT_CONST.PREFIX + '_AddCost_',
            offerSelectStr:    SCRIPT_CONST.PREFIX + '_OfferList_',
            costSelectStr:     SCRIPT_CONST.PREFIX + '_CostList_',

            addOfferInput:  function (m) { return this.offerInputStr  + m; },
            addCostInput:   function (m) { return this.costInputStr   + m; },
            offerSelect:    function (m) { return this.offerSelectStr + m; },
            costSelect:     function (m) { return this.costSelectStr  + m; },
            friendSelector: function (m) { return SCRIPT_CONST.PREFIX + '_friend_selector_' + m; },
            marketSelector: function (m) { return SCRIPT_CONST.PREFIX + '_market_scroll_'   + m; }
        },
        classes: {
            modeBtn:          SCRIPT_CONST.PREFIX + '_ModeBtn',
            addRowContainer:  SCRIPT_CONST.PREFIX + '_AddRowContainer',
            tradesContainer:  SCRIPT_CONST.PREFIX + '_Trades',
            deleteTrade:      SCRIPT_CONST.PREFIX + '_delTrade',
            sendTrade:        SCRIPT_CONST.PREFIX + '_SendTrade',
            addTradeBtn:      SCRIPT_CONST.PREFIX + '_AddTradeBtn',
            offerResourceImg: SCRIPT_CONST.PREFIX + '_OfferResourceImg',
            costResourceImg:  SCRIPT_CONST.PREFIX + '_CostResourceImg',
            resetBtn:         SCRIPT_CONST.PREFIX + '_reset-btn',
            sendAllBtn:       SCRIPT_CONST.PREFIX + '_send-all-btn',
            selectTrade:      SCRIPT_CONST.PREFIX + '_select-trade-chkbox',
            selectAllBtn:     SCRIPT_CONST.PREFIX + '_select-trade-btn',
            saveTemplateBtn:  SCRIPT_CONST.PREFIX + '_save-temp-btn',
            loadTemplateBtn:  SCRIPT_CONST.PREFIX + '_load-temp-btn'
        }
    };

    // ─── UI Renderer ──────────────────────────────────────────────────────────

    var UIRenderer = (function () {

        function renderHeader() {
            var isMarket = SettingsService.isMarketModeON();

            var marketIcon = '', friendIcon = '';
            try { marketIcon = getImageTag(SCRIPT_CONST.MODE_ICONS.MARKET, '50px'); } catch (e) {}
            try { friendIcon = getImageTag(SCRIPT_CONST.MODE_ICONS.FRIEND, '50px'); } catch (e) {}

            var btnBase = 'cursor:pointer;border:2px solid transparent;border-radius:5px;padding:2px;display:inline-block;vertical-align:middle;margin-right:8px;transition:opacity 0.15s;';
            var marketBtn =
                '<span id="' + UIMap.ids.modeMarketBtn + '" class="' + UIMap.classes.modeBtn + '" ' +
                'data-mode="' + SCRIPT_CONST.TRADE_TYPES.MARKET + '" title="' + loca.GetText("LAB", "Marketplace") + '" ' +
                'style="' + btnBase + 'opacity:' + (isMarket ? '1' : '0.4') + '">' + marketIcon + '</span>';
            var friendBtn =
                '<span id="' + UIMap.ids.modeFriendBtn + '" class="' + UIMap.classes.modeBtn + '" ' +
                'data-mode="' + SCRIPT_CONST.TRADE_TYPES.FRIEND + '" title="' + loca.GetText("LAB", "Friends") + '" ' +
                'style="' + btnBase + 'opacity:' + (!isMarket ? '1' : '0.4') + '">' + friendIcon + '</span>';

            var modeLabel =
                '<span id="' + UIMap.ids.modeFriendLbl + '" ' +
                'style="vertical-align:middle;font-weight:bold;font-size:14px;color:#ffd88a;margin-left:4px;">' +
                loca.GetText("LAB", isMarket ? "Marketplace" : "Friends") + '</span>';

            var isClassic = SettingsService.isClassicInput();
            var quickIcon = getNativeIcon(['ButtonIconInstant', 'ButtonIconHalfTheTime'], '22px') ||
                            '<span style="font-size:13px;font-weight:bold;line-height:22px;">&#9889;</span>';
            var richIcon  = getNativeIcon(['StarMenuTabIconAll', 'SearchBtnIcon', 'ButtonIconMagnifier'], '22px') ||
                            '<span style="font-size:13px;font-weight:bold;line-height:22px;">&#8862;</span>';
            var modeTitleRich  = safeLoca("LAB", "Filter", "Удобный UI (каталог с поиском): ВКЛ");
            var modeTitleQuick = safeLoca("LAB", "Filter", "Удобный UI (каталог с поиском): ВЫКЛ — быстрый ввод");
            var inputModeSwitch =
                '<div style="float:right;margin-top:18px;margin-right:4px;" class="st-mode-btn-group">' +
                '  <button type="button" class="st-mode-icon-btn st-mode-toggle' + (!isClassic ? ' active' : '') + '" id="' + UIMap.ids.modeRichBtn + '" data-title-on="' + escAttr(modeTitleRich) + '" data-title-off="' + escAttr(modeTitleQuick) + '" title="' + escAttr(isClassic ? modeTitleQuick : modeTitleRich) + '">' +
                '    ' + richIcon +
                '  </button>' +
                '</div>';

            var modeRow = '<div style="margin-bottom:8px;display:block;white-space:nowrap;">' + inputModeSwitch + marketBtn + friendBtn + modeLabel + '<div style="clear:both;"></div></div>';

            var tableHeadHtml = createTableRow([
                [4, safeLoca("QUL", "DaiTheProposal", "Предложение")],
                [4, safeLoca("LAB", "Cost", "Стоимость")],
                [2, '<span id="tableHeader">' + safeLoca("LAB", isMarket ? "Lot" : "Friends", isMarket ? "Лот" : "Друг") + '</span>'],
                [2, safeLoca('LAB', 'Tasks', 'Действия')]
            ], true);

            var $modal = $('#' + UIMap.ids.modalData);
            $modal.append(
                '<div class="container-fluid">' +
                modeRow +
                '<div style="margin-bottom:5px;padding:4px 8px;background:rgba(0,0,0,0.08);border-radius:4px;font-size:12px;">' +
                '<span id="' + UIMap.ids.slotInfo + '"></span>' +
                '<span id="' + UIMap.ids.selectCounter + '" style="float: right"></span>' +
                '</div>' +
                tableHeadHtml +
                '</div>'
            );

            $modal.find('.container-fluid').append('<div class="' + UIMap.classes.addRowContainer + '"></div>');
            addTradeRow(SettingsService.getTradeModeType());
            $modal.find('.container-fluid').append('<div class="' + UIMap.classes.tradesContainer + '"></div>');

            renderSlotInfo();
            updateSelectCounter();
        }

        function renderBody() {
            var isMarket = SettingsService.isMarketModeON();
            var trades   = isMarket
                ? SettingsService.getState().tradesData.marketTrades
                : SettingsService.getState().tradesData.friendsTrades;

            var $container = $('#' + UIMap.ids.modal)
                .find('.container-fluid')
                .find('.' + UIMap.classes.tradesContainer)
                .empty();

            for (var i = 0; i < trades.length; i++) {
                var trade = trades[i];
                if (isMarket  && trade.userId !== 0) continue;
                if (!isMarket && trade.userId === 0) continue;
                $container.append(renderTradeRow(trade, i));
            }

            renderSlotInfo();
            updateSelectCounter();
        }

        function renderFooter() {
            var $footer = $('#' + UIMap.ids.modal).find('.modal-footer');

            // Counter label sits between the two action buttons so it's visible
            // while the user is selecting rows.
            $footer.prepend([
                createButton(UIMap.classes.resetBtn      + ' btn-warning', getText('btn_reset')),
                createButton(UIMap.classes.sendAllBtn    + ' btn-success', getText('btn_submit') + ' ' + loca.GetText("LAB", "All")),
                createButton(UIMap.classes.selectAllBtn  + ' btn-success', getText('btn_submit') + ' ' + loca.GetText("LAB", "SelectedResource")),
                createButton(UIMap.classes.saveTemplateBtn + ' btn-primary pull-left', getText('save_template')),
                createButton(UIMap.classes.loadTemplateBtn + ' btn-primary pull-left', getText('load_template'))
            ]);
        }

        function updateModeButtons() {
            var isMarket = SettingsService.isMarketModeON();
            $('#' + UIMap.ids.modeMarketBtn).css('opacity', isMarket  ? '1' : '0.4');
            $('#' + UIMap.ids.modeFriendBtn).css('opacity', !isMarket ? '1' : '0.4');
            $('#tableHeader').text(loca.GetText("LAB", isMarket ? "Lot" : "Friends"));
            $('#' + UIMap.ids.modeFriendLbl).text(loca.GetText("LAB", isMarket ? "Marketplace" : "Friends"));
        }

        function renderSlotInfo() {
            if (!SettingsService.isMarketModeON()) {
                $('#' + UIMap.ids.slotInfo).hide();
                return;
            }
            var remaining = SlotCapacity.getRemainingMarketCapacity();
            var maxCoins  = SlotCapacity.getMaxCoinsSlots();
            var total     = maxCoins + 1;
            var used      = total - remaining;
            var color     = remaining === 0 ? '#ff6b6b' : remaining <= 2 ? '#ffc048' : '#55efc4';
            var warn      = remaining === 0
                ? ' &nbsp;<span style="color:#ff6b6b;font-weight:bold;">&#9888; ' + safeLoca("LAB", "NoSlots", "Нет мест!") + '</span>'
                : ' &nbsp;<span style="color:#b29875;">(' + safeLoca("LAB", "Available", "Доступно") + ': ' + remaining + ')</span>';

            $('#' + UIMap.ids.slotInfo)
                .show()
                .html('<span style="color:#ffd88a;font-weight:bold;">' + safeLoca("LAB", "Slot", "Место") + ': </span>' +
                    '<strong style="color:' + color + ';font-size:12px;">' + used + ' / ' + total + '</strong>' + warn);
        }

        function updateSelectCounter() {
            var $counter = $('#' + UIMap.ids.selectCounter);

            if (!SettingsService.isMarketModeON()) {
                $counter.text('');
                $('.' + UIMap.classes.selectTrade).prop('disabled', false);
                return;
            }

            var remaining = SlotCapacity.getRemainingMarketCapacity();
            var $boxes    = $('.' + UIMap.classes.selectTrade);
            var checked   = $boxes.filter(':checked').length;

            var color = checked === 0 ? '#f7e2be'
                : checked < remaining ? '#55efc4'
                : checked === remaining ? '#ffc048'
                : '#ff6b6b';

            $counter.html(
                safeLoca("LAB", "OrdersWaiting", "Выбрано") + ': <strong style="color:' + color + ';font-size:12px;">' +
                checked + ' / ' + remaining + '</strong>'
            );

            $boxes.each(function () {
                if (!$(this).prop('checked')) {
                    $(this).prop('disabled', checked >= remaining);
                }
            });
        }

        function createSettlersDropdown(selectId, items, width) {
            var $wrapper = $('<div>', {
                'class': 'st-select-wrapper',
                style:   'width:100%;max-width:' + (width || '110px') + ';'
            });

            var $hiddenSelect = $('<select>', {
                id:      selectId,
                style:   'display:none !important;'
            });

            var firstVal   = items.length ? items[0].value : '';
            var firstLabel = items.length ? items[0].label : '';

            for (var i = 0; i < items.length; i++) {
                var it = items[i];
                var $opt = $('<option>', { value: it.value }).text(it.label);
                if (i === 0) $opt.prop('selected', true);
                $hiddenSelect.append($opt);
            }

            var $trigger = $('<div>', {
                'class': 'st-select-trigger',
                title:   firstLabel,
                html:    '<span class="st-select-label">' + firstLabel + '</span>' +
                         '<span class="st-select-arrow">&#9660;</span>'
            });

            var $menu = $('<div>', {
                'class': 'st-select-menu'
            });
            if (items.length > 5) {
                $menu.append('<div class="st-select-search-wrap"><input type="text" class="st-select-search" placeholder="' +
                    escAttr(safeLoca("LAB", "Filter", "Поиск...")) + '"></div>');
            }

            for (var j = 0; j < items.length; j++) {
                var item = items[j];
                var $optDiv = $('<div>', {
                    'class':      'st-select-option' + (j === 0 ? ' selected' : ''),
                    'data-value': item.value,
                    title:        item.label,
                    text:         item.label
                });
                $menu.append($optDiv);
            }

            $wrapper.append($hiddenSelect, $trigger, $menu);
            return $wrapper;
        }

        function addTradeRow(mode) {
            var isClassic  = SettingsService.isClassicInput();
            var inputOffer = createNumberInput(UIMap.ids.addOfferInput(mode), 1, isClassic ? '65px' : '75px');
            var inputCost  = createNumberInput(UIMap.ids.addCostInput(mode), 1, isClassic ? '65px' : '75px');

            var offerCol, costCol;

            if (isClassic) {
                var categories = GameDataSource.getResourceList();
                var selectOffer = createResourceSelect(UIMap.ids.offerSelect(mode), categories, _selectedOfferRes);
                var selectCost  = createResourceSelect(UIMap.ids.costSelect(mode), categories, _selectedCostRes);

                var offerIcon = $('<div>', {
                    'class': UIMap.classes.offerResourceImg,
                    style:   'display:inline-block;vertical-align:middle;margin-right:4px;',
                    html:    getItemIconTag(_selectedOfferRes, null, '20px')
                });

                var costIcon = $('<div>', {
                    'class': UIMap.classes.costResourceImg,
                    style:   'display:inline-block;vertical-align:middle;margin-right:4px;',
                    html:    getItemIconTag(_selectedCostRes, null, '20px')
                });

                offerCol = $('<div>', { style: 'white-space:nowrap;line-height:26px;' })
                    .append(offerIcon, inputOffer, selectOffer);
                costCol  = $('<div>', { style: 'white-space:nowrap;line-height:26px;' })
                    .append(costIcon, inputCost, selectCost);
            } else {
                var offerItemInfo = GameDataSource.getItemInfo(_selectedOfferRes);
                var offerItemName = offerItemInfo ? offerItemInfo.localizedName : getItemLocalizedName(_selectedOfferRes);
                var offerSlotBtn  = $('<div>', {
                    id:        UIMap.ids.offerSlotBtn,
                    'class':   'st-slot-btn',
                    title:     offerItemName + ' (' + safeLoca("LAB", "Select", "Нажмите для выбора") + ')',
                    style:     'display:inline-block;vertical-align:middle;margin-right:6px;',
                    html:      getItemIconTag(_selectedOfferRes, null, '20px')
                });

                var costItemInfo = GameDataSource.getItemInfo(_selectedCostRes);
                var costItemName = costItemInfo ? costItemInfo.localizedName : getItemLocalizedName(_selectedCostRes);
                var costSlotBtn  = $('<div>', {
                    id:        UIMap.ids.costSlotBtn,
                    'class':   'st-slot-btn',
                    title:     costItemName + ' (' + safeLoca("LAB", "Select", "Нажмите для выбора") + ')',
                    style:     'display:inline-block;vertical-align:middle;margin-right:6px;',
                    html:      getItemIconTag(_selectedCostRes, null, '20px')
                });

                offerCol = $('<div>', { style: 'white-space:nowrap;line-height:26px;' })
                    .append(offerSlotBtn, inputOffer);
                costCol  = $('<div>', { style: 'white-space:nowrap;line-height:26px;' })
                    .append(costSlotBtn, inputCost);
            }

            var targetDropdown;
            if (mode === SCRIPT_CONST.TRADE_TYPES.FRIEND) {
                var friends = GameDataSource.getFriendsList();
                var friendItems = [];
                for (var f = 0; f < friends.length; f++) {
                    friendItems.push({ value: friends[f].id, label: friends[f].name });
                }
                if (!friendItems.length) {
                    friendItems.push({ value: 0, label: safeLoca("LAB", "None", "Нет") });
                }
                targetDropdown = createSettlersDropdown(UIMap.ids.friendSelector(mode), friendItems, '140px');
            } else {
                var marketItems = [];
                for (var l = 1; l <= 4; l++) {
                    marketItems.push({ value: l, label: formatFraction(l) });
                }
                targetDropdown = createSettlersDropdown(UIMap.ids.marketSelector(mode), marketItems, '90px');
            }

            var addBtnImg = '';
            try { addBtnImg = getImageTag('AvatarAdd', '18px'); } catch (e) {}
            if (!addBtnImg) {
                addBtnImg = '<span>+</span>';
            }

            var addBtn = $('<div>', {
                id:        UIMap.classes.addTradeBtn,
                'class':   UIMap.classes.addTradeBtn + ' st-add-btn',
                title:     safeLoca("LAB", "Add", "Добавить лот"),
                html:      addBtnImg
            });

            var targetCol = $('<div>', { 'class': 'nohide', style: 'white-space:nowrap;line-height:26px;overflow:visible;' })
                .append(targetDropdown);
            var actionCol = $('<div>', { style: 'white-space:nowrap;line-height:26px;' })
                .append(addBtn);

            var row = createTableRow([
                [4, offerCol],
                [4, costCol],
                [2, targetCol],
                [2, actionCol]
            ], false);

            $('#' + UIMap.ids.modalData + ' .container-fluid .' + UIMap.classes.addRowContainer).append(row);
        }

        function renderTradeRow(item, index) {
            var delBtn = $('<div>', {
                'class':   UIMap.classes.deleteTrade,
                'data-index': index,
                title:     safeLoca("LAB", "Delete", "Удалить"),
                css:       { cursor: 'pointer', display: 'inline-block', verticalAlign: 'middle' },
                html:      getItemIconTag('Close', null, '25px')
            });

            var sendBtn = $('<div>', {
                'class':   UIMap.classes.sendTrade,
                'data-index': index,
                title:     safeLoca("LAB", "Trade", "Отправить лот"),
                css:       { cursor: 'pointer', display: 'inline-block', verticalAlign: 'middle', marginRight: '8px' },
                html:      getItemIconTag('Trade', null, '25px')
            });

            var checkBox = $('<label>', { 'class': 'st-check st-check-row', title: safeLoca("LAB", "Select", "Выбрать") })
                .append($('<input>', {
                    type:         'checkbox',
                    'class':      UIMap.classes.selectTrade,
                    'data-index': index
                }))
                .append('<span class="st-check-box"></span>');

            var actions = $('<div>', { css: { 'white-space': 'nowrap', 'line-height': '24px' } })
                .append(sendBtn, checkBox, delBtn);

            var offerIconTag = getItemIconTag(item.offerResName, null, '22px');
            var costIconTag  = getItemIconTag(item.costResName, null, '22px');
            var offerName    = getItemLocalizedName(item.offerResName);
            var costName     = getItemLocalizedName(item.costResName);

            var offerView = '<span title="' + offerName + '" style="display:inline-block;vertical-align:middle;white-space:nowrap;">' +
                            offerIconTag + '<span style="vertical-align:middle;margin-left:5px;font-weight:bold;color:#ffd88a;font-size:12px;">' + item.offerResAmount + '</span></span>';
            var costView  = '<span title="' + costName + '" style="display:inline-block;vertical-align:middle;white-space:nowrap;">' +
                            costIconTag + '<span style="vertical-align:middle;margin-left:5px;font-weight:bold;color:#ffd88a;font-size:12px;">' + item.costResAmount + '</span></span>';

            var targetView = '<span style="vertical-align:middle;font-size:12px;font-weight:600;">' + formatFraction(item.UserName) + '</span>';

            return createTableRow([
                [4, offerView],
                [4, costView],
                [2, targetView],
                [2, actions]
            ], false);
        }

        // Game-styled dropdown (same look as .st-select-*): the hidden <select> keeps
        // the value for handleAddTrade; the visible menu has category headers + search.
        function createResourceSelect(id, categories, selectedVal) {
            var optHtml = [], menuHtml = [];
            var selLabel = '', firstLabel = '';
            menuHtml.push('<div class="st-select-search-wrap"><input type="text" class="st-select-search" placeholder="' +
                          escAttr(safeLoca("LAB", "Filter", "Поиск...")) + '"></div>');
            for (var c = 0; c < categories.length; c++) {
                var cat = categories[c];
                optHtml.push('<optgroup label="' + escAttr(cat.localizedCategoryName) + '">');
                menuHtml.push('<div class="st-select-group">' + escAttr(cat.localizedCategoryName) + '</div>');
                for (var i = 0; i < cat.items.length; i++) {
                    var it    = cat.items[i];
                    var lbl   = it.localizedName || it.name;
                    var isSel = !!selectedVal && selectedVal === it.name;
                    if (!firstLabel) firstLabel = lbl;
                    if (isSel) selLabel = lbl;
                    optHtml.push('<option value="' + escAttr(it.name) + '"' + (isSel ? ' selected="selected"' : '') + '>' + escAttr(lbl) + '</option>');
                    menuHtml.push('<div class="st-select-option' + (isSel ? ' selected' : '') + '" data-value="' + escAttr(it.name) +
                                  '" title="' + escAttr(lbl) + '">' + escAttr(lbl) + '</div>');
                }
                optHtml.push('</optgroup>');
            }
            if (!selLabel) selLabel = firstLabel;
            return $(
                '<div class="st-select-wrapper st-res-select" style="width:150px;margin-left:4px;">' +
                  '<select id="' + id + '" style="display:none !important;">' + optHtml.join('') + '</select>' +
                  '<div class="st-select-trigger" title="' + escAttr(selLabel) + '">' +
                    '<span class="st-select-label">' + escAttr(selLabel) + '</span>' +
                    '<span class="st-select-arrow">&#9660;</span>' +
                  '</div>' +
                  '<div class="st-select-menu st-res-menu">' + menuHtml.join('') + '</div>' +
                '</div>'
            );
        }

        function createNumberInput(id, value, width) {
            return $('<input>', {
                type:    'number',
                id:      id,
                name:    id,
                value:   value || 1,
                min:     1,
                'class': 'form-control',
                style:   'display:inline-block;width:' + (width || '75px') + ';height:26px;vertical-align:middle;text-align:right;'
            });
        }

        function createButton(classes, text) {
            return $('<button>').addClass('btn ' + classes).text(text);
        }

        return {
            renderHeader:        renderHeader,
            renderBody:          renderBody,
            renderFooter:        renderFooter,
            addTradeRow:         addTradeRow,
            renderTradeRow:      renderTradeRow,
            renderSlotInfo:      renderSlotInfo,
            updateModeButtons:   updateModeButtons,
            updateSelectCounter: updateSelectCounter
        };
    })();

    // ─── Actions Service ──────────────────────────────────────────────────────

    var ActionsService = (function () {

        function init() {
            var $modal     = $('#' + UIMap.ids.modal);
            var $modalData = $('#' + UIMap.ids.modalData).css({ 'padding-top': '4px' });

            $modalData
                .off('click', '.' + UIMap.classes.modeBtn)
                .on('click',  '.' + UIMap.classes.modeBtn, handleModeSwitch)
                .off('click', '.' + UIMap.classes.deleteTrade)
                .on('click',  '.' + UIMap.classes.deleteTrade, handleDeleteTrade)
                .off('click', '.' + UIMap.classes.sendTrade)
                .on('click',  '.' + UIMap.classes.sendTrade, handleSendTrade)
                .off('click', '.' + UIMap.classes.addTradeBtn)
                .on('click',  '.' + UIMap.classes.addTradeBtn, handleAddTrade)
                .off('click', '#' + UIMap.ids.offerSlotBtn)
                .on('click',  '#' + UIMap.ids.offerSlotBtn, function () {
                    ItemPickerModal.open('offer', function (selectedName) {
                        _selectedOfferRes = selectedName;
                        var info = GameDataSource.getItemInfo(selectedName);
                        var locName = info ? info.localizedName : getItemLocalizedName(selectedName);
                        $('#' + UIMap.ids.offerSlotBtn)
                            .html(getItemIconTag(selectedName, null, '20px'))
                            .attr('title', locName + ' (' + safeLoca("LAB", "Select", "Нажмите для выбора") + ')');
                    }, _selectedOfferRes);
                })
                .off('click', '#' + UIMap.ids.costSlotBtn)
                .on('click',  '#' + UIMap.ids.costSlotBtn, function () {
                    ItemPickerModal.open('cost', function (selectedName) {
                        _selectedCostRes = selectedName;
                        var info = GameDataSource.getItemInfo(selectedName);
                        var locName = info ? info.localizedName : getItemLocalizedName(selectedName);
                        $('#' + UIMap.ids.costSlotBtn)
                            .html(getItemIconTag(selectedName, null, '20px'))
                            .attr('title', locName + ' (' + safeLoca("LAB", "Select", "Нажмите для выбора") + ')');
                    }, _selectedCostRes);
                })
                .off('click', '#' + UIMap.ids.modeRichBtn)
                .on('click',  '#' + UIMap.ids.modeRichBtn, function () {
                    var $b = $(this);
                    var toRich = SettingsService.isClassicInput ? SettingsService.isClassicInput() : !$b.hasClass('active');
                    SettingsService.setClassicInput(!toRich);
                    $b.toggleClass('active', toRich);
                    $b.attr('title', $b.attr(toRich ? 'data-title-on' : 'data-title-off') || '');
                    closeSelectMenus();
                    $('.' + UIMap.classes.addRowContainer).empty();
                    UIRenderer.addTradeRow(SettingsService.getTradeModeType());
                })
                .off('change', '[id^="' + UIMap.ids.offerSelectStr + '"]')
                .on('change',  '[id^="' + UIMap.ids.offerSelectStr + '"]', function () {
                    var val = $(this).val();
                    _selectedOfferRes = val;
                    $('.' + UIMap.classes.offerResourceImg).html(getItemIconTag(val, null, '20px'));
                })
                .off('change', '[id^="' + UIMap.ids.costSelectStr + '"]')
                .on('change',  '[id^="' + UIMap.ids.costSelectStr + '"]', function () {
                    var val = $(this).val();
                    _selectedCostRes = val;
                    $('.' + UIMap.classes.costResourceImg).html(getItemIconTag(val, null, '20px'));
                })
                .off('change', '.' + UIMap.classes.selectTrade)
                .on('change',  '.' + UIMap.classes.selectTrade, handleCheckboxChange)
                .off('input change', '[id^="' + UIMap.ids.offerInputStr + '"]')
                .on('input change',  '[id^="' + UIMap.ids.offerInputStr + '"]', handleInputSanitize)
                .off('input change', '[id^="' + UIMap.ids.costInputStr  + '"]')
                .on('input change',  '[id^="' + UIMap.ids.costInputStr  + '"]', handleInputSanitize)
                .off('click', '.st-select-trigger')
                .on('click',  '.st-select-trigger', function (e) {
                    e.stopPropagation();
                    var $wrap = $(this).closest('.st-select-wrapper');
                    var $menu = $wrap.find('.st-select-menu');
                    var wasOpen = $menu.is(':visible') || $('.st-select-menu.st-portal:visible').filter(function () { return $(this).data('stWrap') === $wrap[0]; }).length > 0;
                    closeSelectMenus();
                    $menu = $wrap.find('.st-select-menu');
                    if (!wasOpen && $menu.length) {
                        try { positionSelectMenu($(this), $menu, $wrap, $modal[0]); } catch (eP) { $menu.show(); }
                        var $srch = $menu.find('.st-select-search');
                        if ($srch.length) {
                            $srch.val('').trigger('input');
                            setTimeout(function () { try { $srch.focus(); } catch (eF) {} }, 0);
                        }
                        var $cur = $menu.find('.st-select-option.selected');
                        if ($cur.length) $menu.scrollTop(Math.max(0, $cur[0].offsetTop - 70));
                    }
                });

            // Menu handlers live on the modal root: open menus are moved there (outside modalData).
            $modal
                .off('keydown keypress', '.st-select-search')
                .on('keydown keypress',  '.st-select-search', function (e) {
                    e.stopPropagation();
                    if (e.type === 'keydown' && (e.keyCode === 13 || e.which === 13)) {
                        e.preventDefault();
                        var $first = $(this).closest('.st-select-menu').children('.st-select-option').filter(function () { return this.style.display !== 'none'; }).first();
                        if ($first.length) $first.trigger('click');
                    }
                })
                .off('mousedown', '.st-select-search')
                .on('mousedown',  '.st-select-search', function (e) {
                    e.stopPropagation();
                    var el = this; setTimeout(function () { try { el.focus(); } catch (eF) {} }, 0);
                })
                .off('input keyup change paste', '.st-select-search')
                .on('input keyup change paste',  '.st-select-search', function (e) {
                    if (e && e.type === 'keyup') e.stopPropagation();
                    var inp = this;
                    if (e && e.type === 'paste') { setTimeout(function () { $(inp).trigger('change'); }, 0); return; }
                    if (inp._stLastQ === inp.value && e && e.type !== 'change') return;
                    inp._stLastQ = inp.value;
                    var q = String(this.value || '').toLowerCase().trim();
                    var $head = null, headHas = false;
                    $(this).closest('.st-select-menu').children('.st-select-group, .st-select-option').each(function () {
                        if (this.className.indexOf('st-select-group') !== -1) {
                            if ($head) $head.toggle(headHas);
                            $head = $(this); headHas = false;
                            return;
                        }
                        var txt = String(this.textContent || '').toLowerCase();
                        var val = String(this.getAttribute('data-value') || '').toLowerCase();
                        var ok  = !q || txt.indexOf(q) !== -1 || val.indexOf(q) !== -1;
                        this.style.display = ok ? '' : 'none';
                        if (ok) headHas = true;
                    });
                    if ($head) $head.toggle(headHas);
                })
                .off('click', '.st-select-menu')
                .on('click',  '.st-select-menu', function (e) { e.stopPropagation(); })
                .off('click', '.st-select-option')
                .on('click',  '.st-select-option', function (e) {
                    e.stopPropagation();
                    var $optDiv  = $(this);
                    var val      = $optDiv.attr('data-value');
                    var label    = $optDiv.text();
                    var $ownMenu = $optDiv.closest('.st-select-menu');
                    var $wrap    = $optDiv.closest('.st-select-wrapper');
                    if (!$wrap.length) $wrap = $($ownMenu.data('stWrap'));
                    var $select  = $wrap.find('select');
                    var $trigger = $wrap.find('.st-select-trigger');

                    $select.val(val).trigger('change');
                    $select.find('option').prop('selected', false);
                    $select.find('option[value="' + val + '"]').prop('selected', true);

                    $trigger.find('.st-select-label').text(label);
                    $trigger.attr('title', label);

                    $ownMenu.find('.st-select-option').removeClass('selected');
                    $optDiv.addClass('selected');

                    closeSelectMenus();
                });

            $modal.off('click.stDropdown').on('click.stDropdown', function () {
                closeSelectMenus();
            });
            $modal.find('.modal-body, .container-fluid').off('scroll.stDropdown').on('scroll.stDropdown', function () {
                closeSelectMenus();
            });
            $(window).off('resize.stDropdown').on('resize.stDropdown', function () {
                closeSelectMenus();
            });

            $modal
                .off('click', '.' + UIMap.classes.resetBtn)
                .on('click',  '.' + UIMap.classes.resetBtn, handleReset)
                .off('click', '.' + UIMap.classes.sendAllBtn)
                .on('click',  '.' + UIMap.classes.sendAllBtn, handleSubmitAll)
                .off('click', '.' + UIMap.classes.selectAllBtn)
                .on('click',  '.' + UIMap.classes.selectAllBtn, handleSubmitAllSelected)
                .off('click', '.' + UIMap.classes.saveTemplateBtn)
                .on('click',  '.' + UIMap.classes.saveTemplateBtn, handleSaveTemplate)
                .off('click', '.' + UIMap.classes.loadTemplateBtn)
                .on('click',  '.' + UIMap.classes.loadTemplateBtn, handleLoadTemplate);

            $('.' + UIMap.classes.tradesContainer).sortable({ items: '.row', update: handleSortTrades });
        }

        function handleCheckboxChange() {
            UIRenderer.updateSelectCounter();
        }

        function handleModeSwitch() {
            var clickedMode = $(this).attr('data-mode');
            var isMarket    = SettingsService.isMarketModeON();
            var currentMode = isMarket ? SCRIPT_CONST.TRADE_TYPES.MARKET : SCRIPT_CONST.TRADE_TYPES.FRIEND;
            if (clickedMode === currentMode) return;

            SettingsService.getState().tradesData.isMarketTradeMode =
                (clickedMode === SCRIPT_CONST.TRADE_TYPES.MARKET);

            UIRenderer.updateModeButtons();
            $('.' + UIMap.classes.addRowContainer).empty();
            UIRenderer.addTradeRow(clickedMode);
            UIRenderer.renderBody();
            SettingsService.saveSettings();
        }

        function handleSendTrade() {
            if ($(this).css('pointer-events') === 'none') return;
            var index  = $(this).data('index');
            var trades = SettingsService.getCurrentTrades();
            disableSendButtons();
            TradeService.send([trades[index]]);
        }

        function handleSortTrades(event, ui) {
            var currentIndex = ui.item.find('.' + UIMap.classes.deleteTrade).data('index');
            var nextElement  = ui.item.nextAll('.row').find('.' + UIMap.classes.deleteTrade).first();
            var nextIndex    = nextElement.length ? nextElement.data('index') : null;
            var state        = SettingsService.getState();
            var trades       = SettingsService.getCurrentTrades();
            var moved        = trades[currentIndex];
            if (moved === undefined) return;
            trades.splice(currentIndex, 1);
            if (nextIndex !== null && trades[nextIndex] !== undefined) {
                trades.splice(trades.indexOf(trades[nextIndex]), 0, moved);
            } else {
                trades.push(moved);
            }
            if (SettingsService.isMarketModeON()) { state.tradesData.marketTrades  = trades; }
            else                                  { state.tradesData.friendsTrades = trades; }
            SettingsService.setState(state);
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleDeleteTrade() {
            SettingsService.removeTrade($(this).data('index'));
            UIRenderer.renderBody();
            SettingsService.saveSettings();
        }

        function handleAddTrade() {
            var mode           = SettingsService.getTradeModeType();
            var isClassic      = SettingsService.isClassicInput();
            var offerResName   = isClassic
                ? ($('#' + UIMap.ids.offerSelect(mode)).val() || _selectedOfferRes || 'Fish')
                : (_selectedOfferRes || 'Fish');
            var offerResAmount = parseInt($('#' + UIMap.ids.addOfferInput(mode)).val(), 10);
            var costResName    = isClassic
                ? ($('#' + UIMap.ids.costSelect(mode)).val() || _selectedCostRes || 'Coin')
                : (_selectedCostRes || 'Coin');
            var costResAmount  = parseInt($('#' + UIMap.ids.addCostInput(mode)).val(), 10);

            if (!offerResAmount || !costResAmount || offerResAmount <= 0 || costResAmount <= 0) {
                TradeNotify.alertCannotAfford();
                return;
            }

            var userId = 0, userName;
            if (mode === SCRIPT_CONST.TRADE_TYPES.FRIEND) {
                var $fs = $('#' + UIMap.ids.friendSelector(mode));
                userId   = parseInt($fs.val(), 10);
                userName = $fs.find('option:selected').text();
            } else {
                userName = parseInt($('#' + UIMap.ids.marketSelector(mode)).find('option:selected').val(), 10);
            }

            SettingsService.getCurrentTrades().push({
                offerResName:   offerResName,
                offerResAmount: offerResAmount,
                costResName:    costResName,
                costResAmount:  costResAmount,
                userId:         userId,
                UserName:       userName
            });

            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleReset() {
            SettingsService.resetState();
            SettingsService.saveSettings();
            UIRenderer.renderBody();
        }

        function handleSubmitAll() {
            var trades = SettingsService.getCurrentTrades();
            if (!trades.length) return;
            $('#' + UIMap.ids.modal).modal('hide');
            TradeService.send(trades);
        }

        function handleSubmitAllSelected() {
            var current = SettingsService.getCurrentTrades();
            var trades  = [];
            $('.' + UIMap.classes.selectTrade + ':checked').each(function () {
                var idx = $(this).data('index');
                if (idx !== undefined) trades.push(current[parseInt(idx, 10)]);
            });
            if (!trades.length) return;
            $('#' + UIMap.ids.modal).modal('hide');
            TradeService.send(trades);
        }

        function handleSaveTemplate() {
            if (buildTemplates) buildTemplates.save(SettingsService.getState().tradesData);
        }

        function handleLoadTemplate() {
            if (buildTemplates) buildTemplates.load();
        }

        function handleInputSanitize() {
            var v = this.value.replace(/\D/g, '');
            this.value = v ? Math.max(1, parseInt(v, 10)) : 1;
        }

        function disableSendButtons() {
            $('.' + UIMap.classes.sendTrade).css({ opacity: 0.5, 'pointer-events': 'none' });
            setTimeout(function () {
                $('.' + UIMap.classes.sendTrade).css({ opacity: 1, 'pointer-events': '' });
            }, SCRIPT_CONST.BUTTON_COOLDOWN);
        }

        return { init: init };
    })();

    // ─── Trade Service ────────────────────────────────────────────────────────

    var TradeService = (function () {

        function send(trades) {
            if (!Array.isArray(trades) || !trades.length) { TradeNotify.alertCannotAfford(); return; }

            var isMarket = SettingsService.isMarketModeON();

            var filtered = [];
            for (var t = 0; t < trades.length; t++) {
                var ok = isMarket ? (trades[t].userId === 0) : (trades[t].userId !== 0);
                if (ok) filtered.push(trades[t]);
            }
            if (!filtered.length) return;

            if (isMarket) {
                var remaining = SlotCapacity.getRemainingMarketCapacity();
                if (remaining <= 0) { TradeNotify.alertNoSlots(); return; }
                if (filtered.length > remaining) {
                    TradeNotify.alertSlotsTrimmed(filtered.length, remaining);
                    filtered = filtered.slice(0, remaining);
                }
            }

            var slots           = [];
            var queue           = new TimedQueue(SCRIPT_CONST.TRADE_QUEUE_DELAY);
            var successCount    = 0;
            var totalTrades     = filtered.length;
            var playerResources = game.gi.mCurrentPlayerZone.GetResources(game.gi.mHomePlayer);

            var busyKeys = isMarket ? UserTradesReader.getBusyMarketSlotKeys() : {};

            for (var i = 0; i < filtered.length; i++) {
                var trade = filtered[i];
                if (!TradeValidator.isTradeAllowed(trade)) { totalTrades--; continue; }

                var tradeOffer = TradeOfferFactory.create(trade, playerResources);
                if (!tradeOffer) { totalTrades--; continue; }

                var slotInfo = null;
                if (isMarket) {
                    slotInfo = SlotCapacity.resolveSlot(busyKeys);
                    if (!slotInfo) { totalTrades--; continue; }
                    TradeOfferFactory.applyMarketRecipient(tradeOffer, trade, slotInfo);
                } else {
                    TradeOfferFactory.applyFriendRecipient(tradeOffer, trade);
                }

                slots.push({ slot: slotInfo, tr: trade });

                (function (offer, tr, si) {
                    TradeQueue.enqueue(queue, offer, tr, function () {
                        if (si) UserTradesReader.notePlaced(si.slotType, si.slotPos);
                        successCount++;
                        TradeNotify.showSuccess(tr, successCount, totalTrades);
                        refreshSlotUI();
                        watchSlots();
                    });
                })(tradeOffer, trade, slotInfo);
            }

            if (queue.len() > 0) {
                (function (capturedSlots) {
                    queue.add(function () {
                        setTimeout(function () {
                            LocalTradeInjector.injectMissing(capturedSlots);
                            refreshTrades();
                            refreshSlotUI();
                            watchSlots();
                        }, SCRIPT_CONST.TRADE_QUEUE_DELAY);
                    });
                })(slots);

                queue.run();
            }
        }

        function refreshSlotUI() {
            try {
                if ($('#' + UIMap.ids.slotInfo).length) {
                    UIRenderer.renderSlotInfo();
                    UIRenderer.updateSelectCounter();
                }
            } catch (eR) {}
        }

        // Live slot counter: re-renders every 1.5 s while the trader window is
        // open (only when the numbers changed), so "Место X / Y" follows sends,
        // sales and expirations without reopening the window.
        var _slotTimer = null, _lastSlotSig = '';
        function watchSlots() {
            if (_slotTimer) return;
            _slotTimer = setInterval(function () {
                var $m = $('#' + UIMap.ids.modal);
                if (!$m.length || !$m.is(':visible')) {
                    if (!UserTradesReader.hasPending()) { clearInterval(_slotTimer); _slotTimer = null; }
                    return;
                }
                var sig = '';
                try { sig = String(UserTradesReader.getCountActiveTrades()); } catch (eS) {}
                if (sig !== _lastSlotSig) {
                    _lastSlotSig = sig;
                    refreshSlotUI();
                }
            }, 1500);
        }

        function refreshTrades() {
            try {
                game.gi.mClientMessages.SendMessagetoServer(SCRIPT_CONST.MSG.REFRESH_TRADES,     game.gi.mCurrentViewedZoneID, null);
                game.gi.mClientMessages.SendMessagetoServer(SCRIPT_CONST.MSG.REQUEST_TRADE_DATA, game.gi.mCurrentViewedZoneID, null);
            } catch (e) {}
        }

        return { send: send, refreshTrades: refreshTrades, watchSlots: watchSlots };
    })();

    // ─── Trade Validator ──────────────────────────────────────────────────────

    var TradeValidator = (function () {
        function isTradeAllowed(trade) {
            var isMarket = SettingsService.getState().tradesData.isMarketTradeMode;
            if (!isMarket && trade.userId === 0)  return false;
            if ( isMarket && trade.userId !== 0)  return false;
            if (!isMarket) {
                var friends  = GameDataSource.getFriendsList();
                var isFriend = false;
                for (var f = 0; f < friends.length; f++) {
                    if (friends[f].id == trade.userId) { isFriend = true; break; }
                }
                if (!isFriend) { TradeNotify.alertAddFriend(); return false; }
            }
            return true;
        }
        return { isTradeAllowed: isTradeAllowed };
    })();

    // ─── Trade Offer Factory ──────────────────────────────────────────────────

    var TradeOfferFactory = (function () {
        function create(trade, playerResources) {
            var offer = new (game.def("Communication.VO::dTradeOfferVO"));
            if (!applyOffer(offer, trade, playerResources)) return null;
            applyCost(offer, trade);
            return offer;
        }

        function applyMarketRecipient(offer, trade, slotInfo) {
            offer.receipientId = 0;
            offer.lots         = trade.UserName;
            offer.slotType     = slotInfo.slotType;
            offer.slotPos      = slotInfo.slotPos;
        }

        function applyFriendRecipient(offer, trade) {
            offer.receipientId = trade.userId;
            offer.slotType     = SCRIPT_CONST.SLOT_TYPE.FRIEND_TO_FRIEND;
            offer.lots         = 0;
            offer.slotPos      = 0;
        }

        function applyOffer(offer, trade, playerResources) {
            return TradeResources.getResourceDef(trade.offerResName)
                ? TradeResources.applyOfferResource(offer, trade, playerResources)
                : TradeResources.applyOfferBuff(offer, trade);
        }

        function applyCost(offer, trade) {
            if (TradeResources.getResourceDef(trade.costResName)) {
                TradeResources.applyCostResource(offer, trade);
            } else {
                TradeResources.applyCostBuff(offer, trade);
            }
        }

        return {
            create:               create,
            applyMarketRecipient: applyMarketRecipient,
            applyFriendRecipient: applyFriendRecipient
        };
    })();

    // ─── Trade Resources ──────────────────────────────────────────────────────

    var TradeResources = (function () {

        function getResourceDef(name) {
            try {
                return swmmo.getDefinitionByName("ServerState::gEconomics").GetResourcesDefaultDefinition(name);
            } catch (e) {
                return null;
            }
        }

        function findTradableBuff(name, requiredAmount) {
            requiredAmount = requiredAmount || 1;
            try {
                var itemInfo = null;
                try { itemInfo = GameDataSource.getItemInfo(name); } catch (eInfo) {}
                var targetBuffName = itemInfo && itemInfo.buffName ? itemInfo.buffName : name;
                var targetResName  = itemInfo && itemInfo.resourceName ? itemInfo.resourceName : '';

                if (name.indexOf('FillDeposit_') === 0) {
                    targetBuffName = 'FillDeposit';
                    targetResName = name.replace('FillDeposit_', '');
                }

                var buffs = getStarBuffs();
                if (!buffs) buffs = [];

                var candidate = null;
                var bLen = buffs.length || 0;
                for (var i = 0; i < bLen; i++) {
                    var item = buffs[i];
                    if (!item && buffs.getItemAt) item = buffs.getItemAt(i);
                    if (!item) continue;
                    var def = item.GetBuffDefinition ? item.GetBuffDefinition() : null;
                    var bType = item.GetType ? item.GetType() : '';
                    var buffName = def ? def.GetName_string() : bType;
                    if (!buffName) buffName = bType;
                    var resName = item.GetResourceName_string ? item.GetResourceName_string() : '';
                    var isMatch = false;

                    if (targetBuffName === 'FillDeposit' || name.indexOf('FillDeposit_') === 0) {
                        if ((buffName === 'FillDeposit' || bType === 'FillDeposit') && resName === targetResName) isMatch = true;
                    } else if (buffName === name || resName === name || (buffName === targetBuffName && (!targetResName || resName === targetResName))) {
                        isMatch = true;
                    }

                    if (isMatch && (!def || (def.IsTradable && def.IsTradable(resName)))) {
                        var vo = item.CreateBuffVOFromBuff ? item.CreateBuffVOFromBuff() : item;
                        if (vo.amount >= requiredAmount) {
                            return vo;
                        }
                        if (!candidate) candidate = vo;
                    }
                }
                return candidate;
            } catch (e) {
                debug("findTradableBuff error: " + e);
                return null;
            }
        }

        function applyOfferResource(offer, trade, playerResources) {
            var amount = trade.offerResAmount;
            if (SettingsService.isMarketModeON()) amount *= trade.UserName;
            try {
                if (!playerResources.HasPlayerResource(trade.offerResName, amount)) {
                    TradeNotify.alertCannotAfford();
                    return false;
                }
            } catch (e) {
                TradeNotify.alertCannotAfford();
                return false;
            }
            var res = new (game.def("Communication.VO::dResourceVO"));
            res.amount = res.producedAmount = trade.offerResAmount;
            res.name_string = trade.offerResName;
            offer.offerRes = res;
            return true;
        }

        function applyOfferBuff(offer, trade) {
            var buff = findTradableBuff(trade.offerResName, trade.offerResAmount);
            if (!buff || buff.amount < trade.offerResAmount) {
                TradeNotify.alertCannotAfford();
                return false;
            }
            buff.amount = trade.offerResAmount;
            offer.offerBuff = buff;
            return true;
        }

        function applyCostResource(offer, trade) {
            var res = new (game.def("Communication.VO::dResourceVO"));
            res.amount = res.producedAmount = trade.costResAmount;
            res.name_string = trade.costResName;
            offer.costsRes = res;
        }

        function applyCostBuff(offer, trade) {
            var buff = new (game.def("Communication.VO::dBuffVO"));
            buff.sourceZoneId = game.gi.mCurrentViewedZoneID;
            buff.amount = trade.costResAmount;
            buff.resourceName_string = trade.costResName;

            var itemInfo = GameDataSource.getItemInfo(trade.costResName);
            if (itemInfo) {
                if (itemInfo.type === 'adventure') {
                    buff.buffName_string = 'Adventure';
                    buff.resourceName_string = itemInfo.resourceName || trade.costResName;
                } else if (itemInfo.type === 'building') {
                    buff.buffName_string = 'BuildBuilding';
                    buff.resourceName_string = itemInfo.resourceName || trade.costResName;
                } else if (itemInfo.buffName === 'FillDeposit' || trade.costResName.indexOf('FillDeposit_') === 0) {
                    buff.buffName_string = 'FillDeposit';
                    buff.resourceName_string = itemInfo.resourceName || trade.costResName.replace('FillDeposit_', '');
                } else if (itemInfo.type === 'buff') {
                    buff.buffName_string = itemInfo.buffName || trade.costResName;
                    buff.resourceName_string = itemInfo.resourceName || trade.costResName;
                } else {
                    buff.buffName_string = getResourceTypeByName(trade.costResName);
                }
            } else if (trade.costResName.indexOf('FillDeposit_') === 0) {
                buff.buffName_string = 'FillDeposit';
                buff.resourceName_string = trade.costResName.replace('FillDeposit_', '');
            } else {
                buff.buffName_string = getResourceTypeByName(trade.costResName);
            }

            offer.costsBuff = buff;
        }

        function getResourceTypeByName(name) {
            try {
                var nr = swmmo.getDefinitionByName("global").buildingGroup.GetNrFromName(name);
                if (nr !== 195) return 'BuildBuilding';
                var adv = swmmo.getDefinitionByName("AdventureSystem::cAdventureDefinition")
                    .map_AdventureName_AdventureDefinition.getItem(name);
                if (adv) return 'Adventure';
            } catch (e) {}
            return name;
        }

        return {
            getResourceDef:     getResourceDef,
            applyOfferResource: applyOfferResource,
            applyOfferBuff:     applyOfferBuff,
            applyCostResource:  applyCostResource,
            applyCostBuff:      applyCostBuff
        };
    })();

    // ─── Trade Queue ──────────────────────────────────────────────────────────

    var TradeQueue = {
        enqueue: function (queue, offer, trade, cb) {
            queue.add(function () {
                game.gi.mClientMessages.SendMessagetoServer(
                    SCRIPT_CONST.MSG.SEND_TRADE,
                    game.gi.mCurrentViewedZoneID,
                    offer
                );
                cb();
                try {
                    globalFlash.gui.mAvatarMessageList.AddMessage('TradeInitiated');
                } catch (e) {}
            });
        }
    };

    // ─── Trade Notify ─────────────────────────────────────────────────────────

    var TradeNotify = {
        alertCannotAfford: function () {
            game.showAlert(safeLoca('LAB', 'CannotAffordSendTrade', 'Недостаточно ресурсов на складе!'));
        },
        alertAddFriend: function () {
            game.showAlert(safeLoca('QUL', 'SocialMedium8', 'Друзья') + ' ' + safeLoca('LAB', 'AddFriend', 'Добавить друга'));
        },
        alertNoSlots: function () {
            game.showAlert(safeLoca('LAB', 'NoSlots', 'Нет свободных торговых слотов!'));
        },
        alertSlotsTrimmed: function (req, allowed) {
            game.showAlert(
                safeLoca('LAB', 'OrdersWaiting', 'Заказов ожидает') + ': ' + req + '. ' +
                safeLoca('LAB', 'RemainingItemsPerPlayer', 'Разрешено слотов') + ': ' + allowed
            );
        },
        showSuccess: function (trade, success, total) {
            var msg = safeLoca('LAB', 'TradeOffer', 'Предложение сделки') + ' ';
            msg += trade.userId === 0
                ? safeLoca('MES', 'TradeInitiated', 'выставлено на рынок')
                : safeLoca('LAB', 'User', 'Игрок') + ': ' + trade.UserName;
            msg += ' (' + success + '/' + total + ')';
            game.showAlert(msg);
        }
    };

    // ─── Bootstrap & Initialization ───────────────────────────────────────────

    function OpenShortCutTraderModal() {
        try {
            if (!game.gi.isOnHomzone()) {
                game.showAlert(getText('not_home', null) || 'Вы должны быть на домашнем острове!');
                return;
            }

            StyleManager.inject();

            var state = SettingsService.getState();
            if (state.tradesData.zone_id !== game.gi.mCurrentViewedZoneID) SettingsService.resetState();

            $("div[role='dialog']:not(#" + UIMap.ids.modal + "):visible").modal('hide');
            $('#' + UIMap.ids.modal).remove();
            $('#FT_ItemPickerModal').remove();

            createModalWindow(UIMap.ids.modal, SCRIPT_CONST.NAME);
            $('#' + UIMap.ids.modal).find('.modal-content').css({ 'border': 'none', 'box-shadow': 'none' });

            buildTemplates = new SaveLoadTemplate('short_trade', function (data, name) {
                $("#" + UIMap.ids.modal + " .templateFile")
                    .html("{0} ({1}: {2})".format('&nbsp;'.repeat(5), safeLoca("LAB", "AvatarCurrentSelection", "Текущий выбор"), name));
                if (SettingsService.isMarketModeON()) {
                    data.friendsTrades = state.tradesData.friendsTrades;
                } else {
                    data.marketTrades  = state.tradesData.marketTrades;
                }
                data.isMarketTradeMode = state.tradesData.isMarketTradeMode;
                state.tradesData = data;
                SettingsService.setState(state);
                SettingsService.saveSettings();
                UIRenderer.renderBody();
            });

            $.extend(state.tradesData, settings.read(null, SCRIPT_CONST.PREFIX + '_SETTINGS'));
            SettingsService.setState(state);

            UIRenderer.renderHeader();
            UIRenderer.renderBody();
            UIRenderer.renderFooter();

            ActionsService.init();
            $('#' + UIMap.ids.modal + ':not(:visible)').modal({ backdrop: 'static' });
            TradeService.refreshTrades();
            TradeService.watchSlots();
        } catch (e) {
            debug('OpenShortCutTraderModal error: ' + e);
        }
    }

    function init() {
        try {
            TradeService.refreshTrades();
            window.OpenShortCutTraderModal = OpenShortCutTraderModal;
            addToolsMenuItem(SCRIPT_CONST.NAME, window.OpenShortCutTraderModal);
        } catch (e) {
            debug('ShortcutTrader.init error: ' + e);
        }
    }

    return {
        init:                 init,
        openModal:            OpenShortCutTraderModal,
        getUserTrades:        function () { return UserTradesReader.getUserTrades(); },
        getCountActiveTrades: function () { return UserTradesReader.getCountActiveTrades(); },
        isTradesReady:        function () { return UserTradesReader.isReady(); }
    };
})();

ShortcutTrader.init();