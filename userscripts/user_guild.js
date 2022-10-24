// ========== GUILD COMMAND

addToolsMenuItem("Guild", _exudGuildMenuHandler);

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

function _exudGuildGetData() {
	
	var out = '<div class="container-fluid">';
	var guild = swmmo.application.mGameInterface.GetCurrentPlayerGuild();
	
	if (!(guild == null || typeof guild == "undefined")) {
		$("#GuildModal .modal-title").text(guild.name + " (" + guild.members.length + " members)");
		out += '<div class="row"><div class="col-xs-5 col-sm-5 col-lg-5" style="background-color:gray;height:23px">Name</div><div style="background-color:gray;height:23px" class="col-xs-3 col-sm-3 col-lg-3">GuildQuest</div><div style="background-color:gray;height:23px" class="col-xs-2 col-sm-2 col-lg-2">Active</div><div style="background-color:gray;height:23px" class="col-xs-2 col-sm-2 col-lg-2">Level</div></div>';
		var _members = new Array();
		for(key in guild.members)
		{
			_members.push({
				"name" : guild.members[key].username,
				"quest" : (guild.members[key].questsStatus == 3 ? 'Close' : 'Open'),
				"active" : guild.members[key].onlineLast24,
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
		out += '<H3>Nothing to do</H3>';

	return '</div>' + out;
}
