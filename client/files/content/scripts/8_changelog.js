var changelogUrl = "https://raw.githubusercontent.com/fedorovvl/tso_client_swf/main/CHANGELOG.md";

function changelogEscape(value)
{
	return String(value || '')
		.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
		.replace(/"/g, '&quot;')
		.replace(/'/g, '&#39;');
}

function changelogInline(value)
{
	var text = changelogEscape(value);
	text = text.replace(/\uFE0F/g, '');
	var icons = {
		'✨': '&#9733;',
		'🎨': '&#9670;',
		'⚙': '&#9881;',
		'🚀': '&#9650;',
		'🐛': '&#10010;',
		'🔍': '&#9673;'
	};
	$.each(icons, function(symbol, iconEntity) {
		text = text.split(symbol).join('<span class="changelogIcon">' + iconEntity + '</span>');
	});
	text = text.replace(/`([^`]+)`/g, '<code>$1</code>');
	text = text.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
	text = text.replace(/__([^_]+)__/g, '<strong>$1</strong>');
	text = text.replace(/\*([^*]+)\*/g, '<em>$1</em>');
	text = text.replace(/\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)/g, '<a href="$2" class="changelogExternal">$1</a>');
	return text;
}

function changelogMarkdown(markdown)
{
	var lines = String(markdown || '').replace(/\r\n?/g, '\n').split('\n');
	var html = [];
	var paragraph = [];
	var listType = null;
	var inCode = false;
	var code = [];

	function closeParagraph() {
		if(paragraph.length) {
			html.push('<p>' + changelogInline(paragraph.join(' ')) + '</p>');
			paragraph = [];
		}
	}
	function closeList() {
		if(listType) {
			html.push('</' + listType + '>');
			listType = null;
		}
	}
	function openList(type) {
		closeParagraph();
		if(listType != type) {
			closeList();
			listType = type;
			html.push('<' + type + '>');
		}
	}

	$.each(lines, function(index, rawLine) {
		var line = String(rawLine || '');
		if(/^\s*```/.test(line)) {
			closeParagraph();
			closeList();
			if(inCode) {
				html.push('<pre><code>' + changelogEscape(code.join('\n')) + '</code></pre>');
				code = [];
			}
			inCode = !inCode;
			return;
		}
		if(inCode) {
			code.push(line);
			return;
		}
		if(/^\s*$/.test(line)) {
			closeParagraph();
			closeList();
			return;
		}

		var match = line.match(/^(#{1,6})\s+(.+)$/);
		if(match) {
			closeParagraph();
			closeList();
			var level = match[1].length;
			html.push('<h' + level + '>' + changelogInline(match[2]) + '</h' + level + '>');
			return;
		}
		if(/^\s*(---+|___+|\*\*\*+)\s*$/.test(line)) {
			closeParagraph();
			closeList();
			html.push('<hr>');
			return;
		}
		match = line.match(/^\s*[-*+]\s+(.+)$/);
		if(match) {
			openList('ul');
			html.push('<li>' + changelogInline(match[1]) + '</li>');
			return;
		}
		match = line.match(/^\s*\d+[.)]\s+(.+)$/);
		if(match) {
			openList('ol');
			html.push('<li>' + changelogInline(match[1]) + '</li>');
			return;
		}
		match = line.match(/^\s*>\s?(.*)$/);
		if(match) {
			closeParagraph();
			closeList();
			html.push('<blockquote>' + changelogInline(match[1]) + '</blockquote>');
			return;
		}

		closeList();
		paragraph.push(line.replace(/^\s+|\s+$/g, ''));
	});

	if(inCode && code.length) html.push('<pre><code>' + changelogEscape(code.join('\n')) + '</code></pre>');
	closeParagraph();
	closeList();
	return html.join('');
}

function changelogRenderStatus(w, message)
{
	w.withBody('.changelogContent').html('<div class="text-center" style="padding:35px">' + changelogEscape(message) + '</div>');
}

function changelogLoad(w)
{
	changelogRenderStatus(w, 'Loading changelog...');
	$.ajax({
		url: changelogUrl,
		dataType: 'text',
		cache: false,
		timeout: 15000
	}).done(function(markdown) {
		w.withBody('.changelogContent').html(changelogMarkdown(markdown));
	}).fail(function() {
		changelogRenderStatus(w, 'Could not load CHANGELOG.md');
	});
}

function changelogMenuHandler(event)
{
	var w = new Modal('changelogWindow', 'Changelog');
	w.create();
	w.Body().html(
		'<style>' +
		'#changelogWindow .modal-dialog{width:780px;max-width:90%;}' +
		'#changelogWindow .changelogContent{max-height:65vh;overflow-y:auto;padding:5px 18px 18px;line-height:1.45;user-select:text;}' +
		'#changelogWindow .changelogContent h1{font-size:26px;border-bottom:1px solid #8c7b58;padding-bottom:7px;}' +
		'#changelogWindow .changelogContent h2{font-size:21px;margin-top:24px;border-bottom:1px solid rgba(140,123,88,.55);padding-bottom:5px;}' +
		'#changelogWindow .changelogContent h3{font-size:17px;margin-top:18px;}' +
		'#changelogWindow .changelogIcon{display:inline-block;width:1.25em;text-align:center;font-family:Arial,"Segoe UI Symbol",sans-serif;font-weight:normal;margin-right:4px;}' +
		'#changelogWindow .changelogContent ul,#changelogWindow .changelogContent ol{padding-left:26px;}' +
		'#changelogWindow .changelogContent li{margin:4px 0;}' +
		'#changelogWindow .changelogContent code{background:rgba(0,0,0,.13);padding:1px 4px;border-radius:3px;}' +
		'#changelogWindow .changelogContent pre{background:rgba(0,0,0,.18);padding:10px;overflow:auto;white-space:pre-wrap;}' +
		'#changelogWindow .changelogContent blockquote{border-left:4px solid #8c7b58;padding-left:12px;opacity:.85;}' +
		'</style><div class="changelogContent"></div>'
	);
	w.withBody('.changelogContent').on('click', 'a.changelogExternal', function(e) {
		e.preventDefault();
		navigateToURL($(this).attr('href'));
	});
	w.show();
	changelogLoad(w);
}
