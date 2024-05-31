try{clearTimeout(_userMarketTimeOut); myMessage("Market timer reset")}catch (e) {myMessage("Market timer ok")}
var _userMarketTimeOut = null;
setTimeout(_marketMonitorStartTimed, 5000);
function _marketMonitorStartTimed(){
    try {
        game.gi.SendServerAction(1061, 0, 0, 0, null);
        game.showAlert("Рынок обновлен");
        _userMarketTimeOut = setTimeout(_marketMonitorStartTimed, 30000);
    }catch (e) {
        myMessage(e.message)
    }
}
