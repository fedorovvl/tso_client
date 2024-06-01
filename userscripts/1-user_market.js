try{clearTimeout(_userMarketTimeOut);clearTimeout(_userMarketStart); game.chatMessage("Market timer reset", 'market')}catch (e) {game.chatMessage("Market timer ok", 'market')}
var _userMarketTimeOut = null;
var _userMarketStart = setTimeout(_marketMonitorStartTimed, 5000);
function _marketMonitorStartTimed(){
    if (game.gi.isOnHomzone())
    try {
        clearTimeout(_userMarketStart);
        clearTimeout(_userMarketTimeOut);
        _userMarketStart = null;
        _userMarketTimeOut = null;
        game.gi.SendServerAction(TRADE_GET_UPDATES, 0, 0, 0, null);
        game.showAlert("Рынок обновлен");
    }catch (e) {
        game.chatMessage(e.message, 'market')
    }
    _userMarketTimeOut = setTimeout(_marketMonitorStartTimed, 30000);
}
