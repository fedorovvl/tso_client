
function feedbackMenuHandler(event)
{
	var w = new Modal('feedbackWindow', utils.getImageTag('ValentineAdventureRewardBoostConditional', '45px') + ' ' + getText('feedbacktitle'));
	w.create();
	if(w.withFooter('.feedbackSend').length == 0) {
		w.Footer().prepend([$('<button>').attr({ "class": "btn btn-primary pull-left feedbackSend" }).text(loca.GetText("LAB", "Send"))]);
		var html = '<div class="container-fluid" style="user-select: all;">';
		html += '<p>{1}</p><p style="float: right;"><small>{2} (aka SirriS)</small></p>'.format(getText('feedbacktitle'),getText('feedbackdescription'),getText('feedbackregards'));
		html += '<textarea maxlength=2000 id="feedbackContent" style="width:100%;height:70%;background:none;"/>';
		w.Body().html(html + '<div>');
		w.withFooter('.feedbackSend').click(function() {
			var val = w.withBody('#feedbackContent').val();
			if(val.length < 5) { return; }
			feedbackSendMessage(val);
		});
	}
	w.show();
	setTimeout(function() { w.withBody('#feedbackContent').focus() }, 1000);
}

function feedbackSendMessage(e) {
    var z = ['aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd', '2ViaG9va3MvMTA4MzQ2NjU5NTU1MDEy', 'MjAyNC9peGhjUEs1aXlMQm1vMXlKSlR', '5R3RwSkxDNnlYZGFVWTFRVUI5VzlVU2tqZ3'],
        a = {
            username: "Client",
            content: "",
            embeds: [{
                author: {
                    name: document.title
                },
                title: gameLang,
                description: "`" + e + "`",
                color: 15258703
            }]
        },
        t = new(game.def("mx.utils::Base64Decoder"));
    t.decode(z.join('') + "pBUDNmZVVUME9RTkR5bGJiLWM5WVozVAo="), $.ajax({
        type: "POST",
        url: t.toByteArray(),
        data: JSON.stringify(a),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(e) {
            $("#feedbackContent").val(getText('feedbacksended'));
			$('.feedbackSend').hide();
        },
        error: function(e) {
            $("#feedbackContent").val(getText('feedbackerror') + " " + e)
        }
    })
};

function navigateToURL(url)
{
	air.navigateToURL(new air.URLRequest(url));
}

function openWikiHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://github.com/fedorovvl/tso_client/wiki"));
}

function openDiscordHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/ScB7RsvxfB"));
}
function openDiscordFRHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/9G5X7VhA"));
}
function openDiscordENHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/jQZnNAXg99"));
}
function openDiscordDEHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/rm6kmzhPg2"));
}
function openDiscordESHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://discord.gg/Gkt2DYtUyn"));
}
function openDonateHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://ko-fi.com/sirris"));
}
function openDonateTfHandler(event)
{
	air.navigateToURL(new air.URLRequest("https://www.tinkoff.ru/cf/7qUyCUSg6ju"));
}