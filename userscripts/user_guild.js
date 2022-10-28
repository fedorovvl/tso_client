// ========== GUILD COMMAND

addToolsMenuItem(loca.GetText("LAB", "Guild"), _exudGuildMenuHandler);
var _members = new Array();


function _exudGuildMenuHandler(event) {
	// close all modals
	$("div[role='dialog']:not(#GuildModal):visible").modal("hide");
	// create modal
	createModalWindow('GuildModal', 'Guild Memebrs List');
	if($('#GuildModal .modal-footer ._exudCSVexportBtn').length == 0)
	{
		$("#GuildModal .modal-footer").prepend(
			$('<button>').attr({ "id": "_exudCSVexportBtn", "class": "btn btn-primary pull-left _exudCSVexportBtn" }).text("Export CSV")
		);
		$('#GuildModal ._exudCSVexportBtn').click(_exGMCSVexport);
	}
	// fill modal data 
	$('#GuildModalData').html('<div class="container-fluid">{0}</div>'.format(_exudGuildGetData()));
	// show modal
	$("#GuildModal .modal-footer .btn-danger").html(loca.GetText("LAB", "Close"));
	$('#GuildModal:not(:visible)').modal({ backdrop: "static" });

}

function _exGMCSVexport()
{
	var out = 'name;level;quest;active\n';
	_members.forEach(function(m) {
		out += '{0};{1};{2};{3}\n'.format(m.name,m.level,m.quest,m.active);
	});
	var file = new air.File(readLastDir('guild')).resolvePath("guild.csv");
	file.addEventListener(air.Event.COMPLETE, function(event){
		saveLastDir('guild', event.target.parent.nativePath);
	}); 
	file.save(out);
}
						
function _exudGuildGetData() {
	
	var out = '';
	var guild = swmmo.application.mGameInterface.GetCurrentPlayerGuild();
	
	if (guild == null || typeof guild == "undefined") { return '<H3>No Data</H3>'; }
	$("#GuildModal .modal-title").text("{0} ( {2}:{1} )".format(guild.name, guild.members.length, loca.GetText("LAB", "GuildMembers")));
	out += createTableRow([
		[5, loca.GetText("LAB", "UserName")],
		[3, loca.GetText("LAB", "GuildQuestStatus")],
		[2, loca.GetText("LAB", "GuildOnlineLast24")],
		[2, loca.GetText("LAB", "GuildLevel")]
	], true);
	_members = new Array();
	for(key in guild.members)
	{
		_members.push({
			"name" : guild.members[key].username,
			"quest" : (guild.members[key].questsStatus == 3 ? loca.GetText("LAB", "Close") : loca.GetText("LAB", "GuildQuestOpen")),
			"active" : (guild.members[key].onlineLast24 ? loca.GetText("LAB", "YES") : loca.GetText("LAB", "NO")),
			"level" : guild.members[key].playerLevel
		});
	}
	_members.sort(function(a, b){
		return a.name.toLowerCase().localeCompare(b.name.toLowerCase());
	});
	_members.forEach(function(m) {
		out += createTableRow([
			[5, m.name],
			[3, m.quest],
			[2, m.active],
			[2, m.level]
		]);
	});
	return out;
}
