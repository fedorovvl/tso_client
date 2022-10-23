// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//Model.Notifiers.Channel

package Model.Notifiers
{
    import Model.Notifier;

    public class Channel extends Notifier 
    {


        public function send(_arg_1:String, _arg_2:Object):void
        {
            notifyPropertyObserver(_arg_1, _arg_2);
        }


    }
}//package Model.Notifiers

