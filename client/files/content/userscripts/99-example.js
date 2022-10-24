// use addMenuItem from main script
addToolsMenuItem("UserExample", ExampleMenuHandler);

function ExampleMenuHandler(event)
{
	// close all modals
	$( "div[role='dialog']:not(#exampleModal):visible").modal("hide");
	// create modal
	createModalWindow('exampleModal', 'Example modal window');
	// fill modal data 
	$('#exampleModalData').html(ExampleMakeModal());
	// bind buttons
	$('#exampleModalData .showlevelbtn').click(ex_get_level);
	// show modal
	$('#exampleModal:not(:visible)').modal({backdrop: "static"});
}

function ex_get_level()
{
	alert('Your level is - ' + swmmo.application.mGameInterface.mHomePlayer.GetPlayerLevel());
}

function ExampleMakeModal()
{
	var out = '<div class="container-fluid"><H3>Hello from example</H3>';
	out += '<p>This is example user defined modal window from file located at ' + air.File.applicationDirectory.resolvePath("user.js").nativePath + '</p>';
	out += '<p>You can write your own script with custom logiс to extend client functionality. You can also use functions from main file index.html, jquery and jquery-ui library</p>';
	out += '<p>Main vars: <ul><li>air - air aliases to as3 classes, check AIRAliases.js</li>';
	out += '<li>swmmo - entrypoint to client.swf main loader class ' + swmmo + '</li>';
	out += '<li>swmmo.application - entrypoint to game class ' + swmmo.application + '</li>';
	out += '<li>loca - instance of ingame cLocaManager class</li>';
	out += '<li>window.runtime - property allows you to instantiate and use the built-in runtime classes from within the application sandbox</li>';
	out += '</ul></p><p>To instantiate class from client.swf use swmmo.getDefinitionByName method, for example swmmo.getDefinitionByName("Communication.VO::dUniqueID")</p>';
	out += '<p>Example: <button type="button" class="btn btn-sm showlevelbtn">Show my level</button></p>';
	return out + '</div>';
}

