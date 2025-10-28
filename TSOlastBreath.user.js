// ==UserScript==
// @name           TSOlastBreath
// @namespace      TSOlastBreath
// @description    Allow run TSO in old client
// @author         Sin aka SirriS
// @grant          none
// @version        1.6
// @include        https://www.thesettlersonline.com.br/*
// @include        https://www.thesettlersonline.com/*
// @include        https://www.thesettlersonline.net/*
// @include        https://www.thesettlersonline.fr/*
// @include        https://www.thesettlersonline.cz/*
// @include        https://www.diesiedleronline.de/*
// @include        https://www.thesettlersonline.gr/*
// @include        https://www.thesettlersonline.it/*
// @include        https://www.juego-thesettlersonline.com/*
// @include        https://www.thesettlersonline.nl/*
// @include        https://www.thesettlersonline.pl/*
// @include        https://www.thesettlersonline.ro/*
// @include        https://www.thesettlersonline.ru/*
// @include        https://www.thesettlersonline.es/*
// ==/UserScript==

(function() {
  var li       = document.createElement ('li');
  li.className = "sub";
    li.innerHTML = '<a id="clplay" href="#">Old client</a>';
  if(document.querySelector(".jsInstance-logout") == null)
    return;
  document.querySelector("#menu ul").appendChild(li);
  var li       = document.createElement ('li');
  li.className = "main";
  li.innerHTML = '<div style="padding-top: 5px;"><input type="checkbox" id="highlight"><label for="highlight">  Highlight</label></div>';
  document.querySelector("#menu ul").appendChild(li);
  var url = new URL(window.location.href);
  document.getElementById("clplay").addEventListener("click", async () => {
    var playNowUrl = (/playNowforwardUrl = "(.+)";/g.exec(document.body.innerHTML))[1];
    if (!playNowUrl) {
        alert("something went wrong playNowforwardUrl");
        return;
    }
    var request = await fetch(url.origin + playNowUrl, {
            method: 'GET',
            credentials: 'include',
            redirect: 'manual'
        });
    var body = await request.text();
    var tso = (/return "(lang.*)"/g.exec(body))[1];
    if (!tso) {
	    alert("something went wrong play page");
	    return;
    }
    if(document.getElementById('highlight').checked == true) {
      tso = decodeURIComponent(tso).replace(/&s=(.*?)\|(.*?)&/,"&s=http://127.0.0.1:9000/$1|http://127.0.0.1:9000/$2&");
    }
    window.location.href = "tso://"+tso+"&baseUri="+encodeURIComponent(url.origin);
    return;
  });
})();