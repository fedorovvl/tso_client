var feedbackApiUrl = "https://tsofeedback.sirris.su/api.php";
var feedbackPollIntervalId = null;
var feedbackBackgroundPollIntervalId = null;
var feedbackWindowOpen = false;
var feedbackUnreadReminderShown = false;

function feedbackStorageGet() {
	var data = settings.read(null, "feedback");
	return data && data.session ? data.session : null;
}

function feedbackStorageSet(value) {
	var data = settings.read(null, "feedback") || {};
	data.session = value;
	settings.store(data, "feedback");
}

function feedbackLatestSupportMessage(messages) {
	var latest = null;
	$.each(messages || [], function(index, message) {
		if(message.sender == 'support' && (!latest || Number(message.id) > Number(latest.id))) latest = message;
	});
	return latest;
}

function feedbackUpdateMenuBadge(unreadCount) {
	try {
		var helpMenu = menu.nativeMenu.getItemByName('Help');
		var feedbackItem = helpMenu && helpMenu.submenu ? helpMenu.submenu.getItemByName('Feedback') : null;
		if(helpMenu) helpMenu.label = loca.GetText("LAB", "ChatHelp") + (unreadCount > 0 ? ' (' + unreadCount + ')' : '');
		if(feedbackItem) feedbackItem.label = getText('feedbacktitle') + (unreadCount > 0 ? ' (' + unreadCount + ')' : '');
	} catch(e) {}
}

function feedbackClientId() {
	var data = settings.read(null, "feedback") || {};
	var id = data.clientId;
	if(!id) {
		id = Date.now().toString(36) + Math.random().toString(36).substring(2) + Math.random().toString(36).substring(2);
		data.clientId = id;
		settings.store(data, "feedback");
	}
	return id;
}

function feedbackLabels() {
	var language = String(gameLang || "en").toLowerCase();
	if(language.indexOf("ru") == 0) {
		return { empty: "Ответов пока нет.", you: "Вы", support: "Поддержка", placeholder: "Введите сообщение...", sent: "Сообщение отправлено", error: "Не удалось связаться с сервером", newmessage: "Новое сообщение" };
	}
	return { empty: "No replies yet.", you: "You", support: "Support", placeholder: "Enter your message...", sent: "Message sent", error: "Could not reach the server", newmessage: "New message" };
}

function feedbackMenuHandler(event)
{
	var w = new Modal('feedbackWindow', utils.getImageTag('ValentineAdventureRewardBoostConditional', '45px') + ' ' + getText('feedbacktitle'));
	w.create();
	var labels = feedbackLabels();
	var html = '<div class="container-fluid"><p>' + getText('feedbackdescription') + '</p>';
	html += '<div id="feedbackMessages" style="height:260px;overflow-y:auto;border:1px solid #777;padding:8px;margin-bottom:8px;background:rgba(0,0,0,.08);"></div>';
	html += '<textarea maxlength="2000" id="feedbackContent" placeholder="' + labels.placeholder + '" style="width:100%;height:30px;resize:vertical;background:none;"></textarea>';
	html += '<div id="feedbackStatus" style="min-height:20px;padding-top:4px;"></div></div>';
	w.Body().html(html);
	w.Footer().prepend([$('<button>').attr({ "class": "btn btn-primary pull-left feedbackSend" }).text(loca.GetText("LAB", "Send"))]);
	w.withFooter('.feedbackSend').click(function() { feedbackSendMessage(w); });
	$(w.id).on('hidden.bs.modal', function() {
		feedbackWindowOpen = false;
		if(feedbackPollIntervalId !== null) {
			clearInterval(feedbackPollIntervalId);
			feedbackPollIntervalId = null;
		}
	});
	feedbackWindowOpen = true;
	w.show();
	feedbackLoadMessages(w);
	feedbackPollIntervalId = setInterval(function() { feedbackLoadMessages(w); }, 15000);
	setTimeout(function() { w.withBody('#feedbackContent').focus(); }, 300);
}

function feedbackSetStatus(w, text, isError) {
	w.withBody('#feedbackStatus').text(text || '').css('color', isError ? '#b00000' : '');
}

function feedbackFormatTime(value) {
	var match = String(value || '').match(/^(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2}):(\d{2})/);
	if(!match) return '';
	var date = new Date(Date.UTC(Number(match[1]), Number(match[2]) - 1, Number(match[3]), Number(match[4]), Number(match[5]), Number(match[6])));
	function pad(number) { return number < 10 ? '0' + number : String(number); }
	return pad(date.getDate()) + '.' + pad(date.getMonth() + 1) + '.' + date.getFullYear() + ' ' + pad(date.getHours()) + ':' + pad(date.getMinutes());
}

function feedbackScrollToBottom(box) {
	setTimeout(function() {
		if(box && box.length && box[0]) box.scrollTop(box[0].scrollHeight);
	}, 50);
}

function feedbackRequest(options) {
	return $.ajax($.extend({ url: feedbackApiUrl, dataType: 'json', cache: false, timeout: 15000 }, options));
}

function feedbackSendMessage(w) {
	var content = String(w.withBody('#feedbackContent').val() || '').replace(/^\s+|\s+$/g, '');
	if(content.length < 2) { return; }
	var session = feedbackStorageGet();
	var payload = { action: session ? 'message' : 'create', content: content, clientId: feedbackClientId(), displayName: document.title, language: gameLang };
	if(session) {
		payload.ticketId = session.ticketId;
		payload.token = session.token;
	}
	w.withFooter('.feedbackSend').prop('disabled', true);
	feedbackSetStatus(w, '', false);
	feedbackRequest({ type: 'POST', data: JSON.stringify(payload), contentType: 'application/json; charset=utf-8' })
	.done(function(response) {
		if(response.ticketId && response.token) feedbackStorageSet({ ticketId: response.ticketId, token: response.token, lastNotifiedSupportMessageId: 0, lastReadSupportMessageId: 0 });
		w.withBody('#feedbackContent').val('').focus();
		feedbackSetStatus(w, feedbackLabels().sent, false);
		feedbackLoadMessages(w);
	}).fail(function(xhr) {
		var detail = xhr.responseJSON && xhr.responseJSON.error ? ': ' + xhr.responseJSON.error : '';
		feedbackSetStatus(w, feedbackLabels().error + detail, true);
	}).always(function() { w.withFooter('.feedbackSend').prop('disabled', false); });
}

function feedbackLoadMessages(w) {
	var session = feedbackStorageGet();
	if(!session || !session.ticketId || !session.token) {
		w.withBody('#feedbackMessages').html('<div class="text-muted">' + feedbackLabels().empty + '</div>');
		return;
	}
	feedbackRequest({ type: 'GET', data: { action: 'messages', ticketId: session.ticketId, token: session.token } }).done(function(response) {
		var box = w.withBody('#feedbackMessages');
		box.empty();
		var messages = response.messages || [];
		var latestSupportMessage = feedbackLatestSupportMessage(messages);
		if(latestSupportMessage) {
			session.lastReadSupportMessageId = Number(latestSupportMessage.id);
			session.lastNotifiedSupportMessageId = Number(latestSupportMessage.id);
			feedbackStorageSet(session);
		}
		feedbackUpdateMenuBadge(0);
		if(messages.length == 0) {
			box.html('<div class="text-muted">' + feedbackLabels().empty + '</div>');
			return;
		}
		$.each(messages, function(index, message) {
			var own = message.sender == 'client';
			var row = $('<div>').css({ 'margin-bottom': '8px', 'text-align': own ? 'right' : 'left' });
			var caption = own ? feedbackLabels().you : (message.senderName || feedbackLabels().support);
			var messageTime = feedbackFormatTime(message.createdAt);
			if(messageTime) caption += ' · ' + messageTime;
			$('<div>').css({ 'font-weight': 'bold', 'font-size': '12px' }).text(caption).appendTo(row);
			$('<div>').css({ 'display': 'inline-block', 'max-width': '85%', 'padding': '6px 9px', 'border-radius': '6px', 'white-space': 'pre-wrap', 'word-break': 'break-word', 'background': own ? '#d9edf7' : '#eee', 'color': '#222', 'text-align': 'left' }).text(message.content).appendTo(row);
			box.append(row);
		});
		feedbackScrollToBottom(box);
	});
}

function feedbackNotifySupportMessage(message) {
	var text = String(message.content || '');
	if(text.length > 180) text = text.substring(0, 177) + '...';
	var notificationText = feedbackLabels().support + ': ' + feedbackLabels().newmessage;
	if(!window.nativeWindow.active && typeof notificationShow == 'function' && typeof notifySettings != 'undefined' && notifySettings.enabled) {
		notificationShow(notificationText);
	} else {
		game.showAlert(notificationText);
	}
}

function feedbackCheckNewMessages() {
	if(feedbackWindowOpen) return;
	var session = feedbackStorageGet();
	if(!session || !session.ticketId || !session.token) return;
	feedbackRequest({ type: 'GET', data: { action: 'messages', ticketId: session.ticketId, token: session.token } }).done(function(response) {
		var previousNotifiedId = Number(session.lastNotifiedSupportMessageId || session.lastSupportMessageId || 0);
		var lastReadId = Number(session.lastReadSupportMessageId || 0);
		var newestMessage = feedbackLatestSupportMessage(response.messages || []);
		var unreadCount = 0;
		$.each(response.messages || [], function(index, message) {
			if(message.sender == 'support' && Number(message.id) > lastReadId) unreadCount++;
		});
		feedbackUpdateMenuBadge(unreadCount);
		if(newestMessage && Number(newestMessage.id) > previousNotifiedId) {
			session.lastNotifiedSupportMessageId = Number(newestMessage.id);
			feedbackStorageSet(session);
			feedbackUnreadReminderShown = true;
			feedbackNotifySupportMessage(newestMessage);
		} else if(newestMessage && unreadCount > 0 && !feedbackUnreadReminderShown) {
			feedbackUnreadReminderShown = true;
			feedbackNotifySupportMessage(newestMessage);
		}
	});
}

feedbackBackgroundPollIntervalId = setInterval(feedbackCheckNewMessages, 30000);
setTimeout(feedbackCheckNewMessages, 5000);

function navigateToURL(url) { air.navigateToURL(new air.URLRequest(url)); }
function openWikiHandler(event) { navigateToURL("https://github.com/fedorovvl/tso_client/wiki"); }
function openDiscordFRHandler(event) { navigateToURL("https://discord.gg/9G5X7VhA"); }
function openDiscordENHandler(event) { navigateToURL("https://discord.gg/jQZnNAXg99"); }
function openDiscordDEHandler(event) { navigateToURL("https://discord.gg/rm6kmzhPg2"); }
function openDiscordESHandler(event) { navigateToURL("https://discord.gg/Gkt2DYtUyn"); }
function openDonateHandler(event) { navigateToURL("https://ko-fi.com/sirris"); }
function openDonateTfHandler(event) { navigateToURL("https://www.tinkoff.ru/cf/7qUyCUSg6ju"); }
