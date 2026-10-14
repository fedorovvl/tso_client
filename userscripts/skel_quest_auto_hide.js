// Quest auto-hide
// Collapses the quest categories you choose whenever the quest book opens.
// Configure under Tools -> Quest auto-hide; the choice is persisted.
// Nothing is collapsed until you turn a category on.

var skelQAH_MODULE = 'skelQuestAutoHide';

var skelQAH_config = { hide: {}, known: [] };

(function skelQAH_load() {
    try {
        var saved = settings.read(null, skelQAH_MODULE);
        if (saved && saved.hide) { $.extend(true, skelQAH_config, saved); }
    } catch (e) { debug('[skel_quest_auto_hide] ' + e); }
})();

function skelQAH_save() {
    settings.settings[skelQAH_MODULE] = {};
    settings.store(skelQAH_config, skelQAH_MODULE);
}

function skelQAH_loca(section, key, fallback) {
    try {
        var t = loca.GetText(section, key);
        if (t && t.indexOf("undefined") === -1) { return t; }
    } catch (e) {}
    return fallback;
}

function skelQAH_toggle(item) {
    try {
        item.btnTitle.dispatchEvent(new window.runtime.flash.events.MouseEvent("click", true, false));
        return true;
    } catch (e) { debug('[skel_quest_auto_hide] toggle: ' + e); return false; }
}

// A row is expanded when it is meaningfully taller than its own title button.
// The old test compared every row against the shortest row in the book, which
// is only a header height if at least one category happens to be collapsed or
// empty. Measuring each row against its own header drops that assumption.
function skelQAH_isExpanded(item) {
    try {
        var h = item.btnTitle ? item.btnTitle.height : 0;
        if (!h) { return false; }
        return item.height > h * 1.4;
    } catch (e) { return false; }
}

function skelQAH_scan(collapse) {
    var discovered = false;
    try {
        var list = swmmo.application.GAMESTATE_ID_QUEST_BOOK.list;
        if (!list) { return false; }
        var children = list.getChildren();
        var clicked = [];
        children.forEach(function (item) {
            if (!item || !item.categoryId) { return; }
            if (skelQAH_config.known.indexOf(item.categoryId) === -1) {
                skelQAH_config.known.push(item.categoryId);
                discovered = true;
            }
            if (collapse && skelQAH_config.hide[item.categoryId] && skelQAH_isExpanded(item)) {
                clicked.push({ item: item, height: item.height });
                skelQAH_toggle(item);
            }
        });
        if (clicked.length) { skelQAH_undoMisses(clicked); }
    } catch (e) { debug('[skel_quest_auto_hide] ' + e); }
    return discovered;
}

// btnTitle is a toggle, so a row we misjudge as expanded gets opened rather
// than closed. Re-measure once layout settles and click back anything that
// grew; that converges even where the height test guessed wrong.
function skelQAH_undoMisses(clicked) {
    setTimeout(function () {
        clicked.forEach(function (c) {
            try {
                if (c.item.height > c.height) { skelQAH_toggle(c.item); }
            } catch (e) {}
        });
    }, 150);
}

var skelQuestBookTracker = game.getTracker('skelQuestBookTracker', function (ev) {
    skelQuestBookOpenHandler(ev);
});
if (!window.skelQAH_observing) {
    game.gi.channels.ZONE.addPropertyObserver("QUESTBOOK_OPENED", skelQuestBookTracker);
    window.skelQAH_observing = true;
}

// Ready once the rows have been measured. The old test also demanded that the
// rows differ in height, which never comes true in a book where every category
// is already collapsed, so it just retried ten times and gave up.
function skelQAH_ready(children) {
    if (!children || children.length === 0) { return false; }
    var sized = 0;
    children.forEach(function (item) {
        if (!item || !item.categoryId) { return; }
        try {
            if (item.height > 0 && item.btnTitle && item.btnTitle.height > 0) { sized++; }
        } catch (e) {}
    });
    return sized > 0;
}

function skelQAH_scanWhenReady(attempt) {
    setTimeout(function () {
        var children = [];
        try {
            var list = swmmo.application.GAMESTATE_ID_QUEST_BOOK.list;
            if (list) { children = list.getChildren(); }
        } catch (e) { children = []; }
        if (skelQAH_ready(children)) { skelQAH_scan(true); return; }
        if (attempt < 10) { skelQAH_scanWhenReady(attempt + 1); }
    }, attempt === 0 ? 60 : 120);
}

function skelQuestBookOpenHandler(event) {
    skelQAH_scanWhenReady(0);
}

function skelQAH_menuHandler(event) {
    skelQAH_scan(false);
    var w = new Modal('skelQAHWindow', 'Quest auto-hide');
    w.create();
    if (w.withFooter('#skelQAHSave').length === 0) {
        w.Footer().prepend([
            $('<button>').attr({ "id": "skelQAHSave", "class": "btn btn-primary" })
                .text(skelQAH_loca("LAB", "Save", "Save"))
                .click(function () {
                    skelQAH_save();
                    skelQAH_scan(true);
                    w.hide();
                })
        ]);
    }
    var html = '<div class="container-fluid">';
    html += utils.createTableRow([
        [9, skelQAH_loca("LAB", "Quests", "Quests")],
        [3, "Collapse"]
    ], true);
    skelQAH_config.known.slice().sort().forEach(function (id) {
        html += utils.createTableRow([
            [9, skelQAH_loca("LAB", id, id)],
            [3, createSwitch('skelQAH_' + id, !!skelQAH_config.hide[id])]
        ]);
    });
    w.Body().html(html + '</div>');
    w.withBody('[type=checkbox]').change(function (e) {
        skelQAH_config.hide[$(e.target).attr('id').replace('skelQAH_', '')] = $(e.target).is(':checked');
    });
    w.show();
}

addToolsMenuItem("Quest auto-hide", skelQAH_menuHandler);
