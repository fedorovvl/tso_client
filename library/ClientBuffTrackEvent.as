package {
  import flash.events.Event;
  public class ClientBuffTrackEvent extends Event 
  {
    public var data:Object;
    public function ClientBuffTrackEvent (_arg_1:String, _arg_4:Object, _arg_2:Boolean=false, _arg_3:Boolean=false)
    {
      super(_arg_1, _arg_2, _arg_3);
      this.data = _arg_4;
    }
  }
}
