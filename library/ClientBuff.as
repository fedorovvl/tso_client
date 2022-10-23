package
{
  import flash.events.*;
  import Model.*;
  import ClientBuffTrackEvent;
  import flash.display.MovieClip;

  public class ClientBuff implements Observer
  {
    private var _dispatcher:EventDispatcher
    
    public function ClientBuff():void
    {
      _dispatcher = new EventDispatcher();
    }
    
    public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
	_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }
    
    public function update(_arg_1:Notifier, _arg_2:String, _arg_3:Object):void
    {
	var event:ClientBuffTrackEvent = new ClientBuffTrackEvent("buffApply", _arg_3, false, false);
	_dispatcher.dispatchEvent(event);
    }
  }
}
