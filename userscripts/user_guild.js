// ========== GUILD COMMAND

const _exudGuildLang = [ 
								[ ["en-uk"] , 
									[
										[ "menuItemName", "Guild" ] ,
										[ "ColumnName", "Name" ] ,
										[ "ColumnQuest", "Guild Quest" ] ,
										[ "ColumnActive", "Active" ] ,
										[ "ColumnLevel", "Level" ] ,
										[ "Open", "Open" ] ,
										[ "Close", "Close" ] ,
										[ "Active", "true" ] ,
										[ "NoActive", "false" ] ,
										[ "DoNothing", "Nothing to do" ] 										
									]
								] ,
								[ ["pt-br"] , 
									[
										[ "menuItemName", "Guilda" ] ,
										[ "ColumnName", "Nome" ] ,
										[ "ColumnQuest", "Missão" ] ,
										[ "ColumnActive", "Ativo" ] ,
										[ "ColumnLevel", "Nivel" ] ,
										[ "Open", "Aberta" ] ,
										[ "Close", "Fechada" ] ,
										[ "Active", "Sim" ] ,
										[ "NoActive", "Não" ] ,
										[ "DoNothing", "Nada encontrado" ] 										
									]
								]
						];

addToolsMenuItem(_exudGuildGetLabel("menuItemName"), _exudGuildMenuHandler);

function _exudGuildMenuHandler(event) {
	// close all modals
	$("div[role='dialog']:not(#GuildModal):visible").modal("hide");
	// create modal
	createModalWindow('GuildModal', 'Guild Memebrs List');
	// fill modal data 
	$('#GuildModalData').html(_exudGuildGetData());
	// show modal
	$('#GuildModal:not(:visible)').modal({ backdrop: "static" });

}

						
function _exudGuildGetLabel(id)
{
	
	var idL = loca.getSelectedLanguage();
	var ls = _exudGuildGetLanguage(idL);
	
	var y = 0;

	for(y = 0 ; y < ls.length ; y++)
		if (ls[y][0] == id)
			return ls[y][1];

	return "RES not found : " + id;
}	

function _exudGuildGetLanguage(id)
{
	
	var y = 0;
	for(y = 0 ; y < _exudGuildLang.length ; y++)
		if (_exudGuildLang[y][0] == id)
			return _exudGuildLang[y][1];
		
	return _exudGuildLang[0][1]; // English default
}

function _exudGuildGetData() {
	
	var out = '<div class="container-fluid">';
	var guild = swmmo.application.mGameInterface.GetCurrentPlayerGuild();
	
	if (!(guild == null || typeof guild == "undefined")) {
		$("#GuildModal .modal-title").text(guild.name + " (" + guild.members.length + " members)");
		out += '<div class="row"><div class="col-xs-5 col-sm-5 col-lg-5" style="background-color:gray;height:23px">'+_exudGuildGetLabel("ColumnName")+'</div><div style="background-color:gray;height:23px" class="col-xs-3 col-sm-3 col-lg-3">'+_exudGuildGetLabel("ColumnQuest")+'</div><div style="background-color:gray;height:23px" class="col-xs-2 col-sm-2 col-lg-2">'+_exudGuildGetLabel("ColumnActive")+'</div><div style="background-color:gray;height:23px" class="col-xs-2 col-sm-2 col-lg-2">'+_exudGuildGetLabel("ColumnLevel")+'</div></div>';
		var _members = new Array();
		for(key in guild.members)
		{
			_members.push({
				"name" : guild.members[key].username,
				"quest" : (guild.members[key].questsStatus == 3 ? _exudGuildGetLabel("Close") : _exudGuildGetLabel("Open")),
				"active" : (guild.members[key].onlineLast24 ? _exudGuildGetLabel("Active") : _exudGuildGetLabel("NoActive")),
				"level" : guild.members[key].playerLevel
			});
		}
		_members.sort(function(a, b){
			return a.name.toLowerCase().localeCompare(b.name.toLowerCase());
		});

		_members.forEach(function(m) {
			out += '<div class="row"><div class="col-xs-5 col-sm-5 col-lg-5">'+m.name+'</div><div class="col-xs-3 col-sm-3 col-lg-3">'+m.quest+'</div><div class="col-xs-2 col-sm-2 col-lg-2">'+m.active+'</div><div class="col-xs-2 col-sm-2 col-lg-2">'+m.level+'</div></div>';
		});
	}
	else
		out += '<H3>'+_exudGuildGetLabel("DoNothing")+'</H3>';

	return '</div>' + out;
}
