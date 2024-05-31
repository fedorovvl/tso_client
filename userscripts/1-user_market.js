try{clearTimeout(_userMarketTimeOut); game.chatMessage("Market timer reset")}catch (e) {game.chatMessage("Market timer ok")}
var _userMarketTimeOut = null;
setTimeout(_marketMonitorStartTimed, 5000);
function _marketMonitorStartTimed(){
    try {
        game.gi.SendServerAction(1061, 0, 0, 0, null);
        game.showAlert("Рынок обновлен");
        _userMarketTimeOut = setTimeout(_marketMonitorStartTimed, 30000);
    }catch (e) {
        game.chatMessage(e.message)
    }
}
