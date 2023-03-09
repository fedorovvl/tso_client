var feedBackLang = {
	'ru-ru': {
		'title': 'Обратная связь',
		'description': 'Уважаемый игрок, если Вам есть что сказать мне, Вы можете легко это сделать с помощью этого скрипта. Просто напишите Ваше предложение, отзыв или критику в текстовое поле ниже и нажмите отправить. Я всегда прислушиваюсь к отзывам на свои разработки и буду рад услышать что Вы думаете :)',
		'regards': 'С уважением',
		'sended': 'Сообщение отправлено!',
		'error': 'Ошибка'
	},
	'en-uk': {
		'title': 'Feedback',
		'description': 'Dear player, if you have something to say, you can easily do it using this script. Simply write your suggestion, review or critique in the text box below and hit submit. I always listen to feedback on my designs and would love to hear what you think :)',
		'regards': 'Best regards',
		'sended': 'Message sent!',
		'error': 'Error'
	},
	'pt-br': {
		'title': 'Opinião',
		'description': 'Caro jogador, se você tem algo a me dizer, pode fazê-lo facilmente com este script. Basta escrever sua sugestão, revisão ou crítica na caixa de texto abaixo e clicar em enviar. Eu sempre ouço comentários sobre meus desenvolvimentos e ficarei feliz em saber o que você pensa :)',
		'regards': 'Com os melhores cumprimentos',
		'sended': 'Mensagem enviada!',
		'error': 'Erro'
	},
	'es-es': {
		'title': 'Opinión',
		'description': 'Estimado jugador, si tiene algo que decirme, puede hacerlo fácilmente con este script. Simplemente escriba su sugerencia, revisión o crítica en el cuadro de texto a continuación y presione enviar. Siempre escucho comentarios sobre mis desarrollos y estaré encantado de escuchar lo que piensas :)',
		'regards': 'Saludos',
		'sended': 'Mensaje enviado!',
		'error': 'Error'
	},
	'fr-fr': {
		'title': 'Retour',
		'description': "Cher joueur, si vous avez quelque chose à me dire, vous pouvez facilement le faire avec ce script. Écrivez simplement votre suggestion, critique ou critique dans la zone de texte ci-dessous et cliquez sur Soumettre. J'écoute toujours les retours sur mes développements et serai ravie de savoir ce que vous en pensez :)",
		'regards': 'Cordialement',
		'sended': 'Message envoyé!',
		'error': 'Erreur'
	},
	'pl-pl': {
		'title': 'Informacja zwrotna',
		'description': 'Drogi graczu, jeśli masz mi coś do powiedzenia, możesz to łatwo zrobić za pomocą tego skryptu. Po prostu napisz swoją sugestię, recenzję lub krytykę w polu tekstowym poniżej i naciśnij Prześlij. Zawsze słucham opinii na temat moich postępów i chętnie usłyszę, co myślisz :)',
		'regards': 'Z poważaniem',
		'sended': 'Wiadomość wysłana!',
		'error': 'Błąd'
	},
	'de-de': {
		'title': 'Rückkopplung',
		'description': 'Lieber Spieler, wenn du mir etwas zu sagen hast, kannst du das ganz einfach mit diesem Skript tun. Schreiben Sie einfach Ihren Vorschlag, Ihre Bewertung oder Ihre Kritik in das Textfeld unten und klicken Sie auf „Senden“. Ich höre mir immer Feedback zu meinen Entwicklungen an und freue mich auf Ihre Meinung :)',
		'regards': 'Mit freundlichen Grüßen',
		'sended': 'Nachricht gesendet!',
		'error': 'Fehler'
	}
};
extendBaseLang(feedBackLang, 'feedback');

function feedbackMenuHandler(event)
{
	var w = new Modal('feedbackWindow', utils.getImageTag('ValentineAdventureRewardBoostConditional', '45px') + ' ' + getText('title', 'feedback'));
	w.create();
	w.Footer().prepend([$('<button>').attr({ "class": "btn btn-primary pull-left feedbackSend" }).text(loca.GetText("LAB", "Send"))]);
	var html = '<div class="container-fluid" style="user-select: all;">';
	html += '<p>{1}</p><p style="float: right;"><small>{2}, SirriS</small></p>'.format(getText('title', 'feedback'),getText('description', 'feedback'),getText('regards', 'feedback'));
	html += '<textarea maxlength=2000 id="feedbackContent" style="width:100%;height:70%;background:none;"/>';
	w.Body().html(html + '<div>');
	w.withFooter('.feedbackSend').click(function() {
		var val = w.withBody('#feedbackContent').val();
		if(val.length < 5) { return; }
		feedbackSendMessage(val);
	});
	w.show();
	setTimeout(function() { w.withBody('#feedbackContent').focus() }, 1000);
}
function feedbackSendMessage(e){var z=['aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd','2ViaG9va3MvMTA4MzQ2NjU5NTU1MDEy','MjAyNC9peGhjUEs1aXlMQm1vMXlKSlR','5R3RwSkxDNnlYZGFVWTFRVUI5VzlVU2tqZ3'],a={username:"Client",content:"",embeds:[{author:{name:document.title},title:gameLang,description:"`"+e+"`",color:15258703}]},t=new(game.def("mx.utils::Base64Decoder"));t.decode(z.join('')+"pBUDNmZVVUME9RTkR5bGJiLWM5WVozVAo="),$.ajax({type:"POST",url:t.toByteArray(),data:JSON.stringify(a),contentType:"application/json; charset=utf-8",dataType:"json",success:function(e){$("#feedbackContent").val(getText('sended', 'feedback')),$('.feedbackSend').hide()},error:function(e){$("#feedbackContent").val(getText('error', 'feedback')+" "+e)}})}
