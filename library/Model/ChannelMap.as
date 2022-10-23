// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//Model.ChannelMap

package Model
{
    import Utils.HashMapWrapper;
    import __AS3__.vec.Vector;
    import Model.Notifiers.Channel;
    import __AS3__.vec.*;

    public class ChannelMap 
    {

        public static var mapping:HashMapWrapper = new HashMapWrapper();

        private var emptyVector:Vector.<Notifier> = new Vector.<Notifier>();
        private var mappedChannels:HashMapWrapper = new HashMapWrapper();


        public static function map(_arg_1:String, _arg_2:String):void
        {
            var _local_3:Vector.<String>;
            _local_3 = (mapping.getItem(_arg_2) as Vector.<String>);
            if (_local_3 == null)
            {
                _local_3 = new Vector.<String>();
                mapping.putItem(_arg_2, _local_3);
            };
            _local_3.push(_arg_1);
        }


        public function addObserver(_arg_1:String, _arg_2:String, _arg_3:Observer):Vector.<Notifier>
        {
            var _local_4:Vector.<String>;
            var _local_6:Channel;
            var _local_8:int;
            _local_4 = (mapping.getItem(_arg_1) as Vector.<String>);
            if (_local_4 == null)
            {
                return (this.emptyVector);
            };
            var _local_5:Vector.<Notifier> = new Vector.<Notifier>();
            var _local_7:int = _local_4.length;
            _local_8 = 0;
            while (_local_8 < _local_7)
            {
                _local_6 = (this.mappedChannels.getItem(_local_4[_local_8]) as Channel);
                if (_local_6 == null)
                {
                    _local_6 = new Channel();
                    this.mappedChannels.putItem(_local_4[_local_8], _local_6);
                };
                _local_6.addPropertyObserver(_arg_2, _arg_3);
                _local_5.push(_local_6);
                _local_8++;
            };
            return (_local_5);
        }

        public function send(_arg_1:String, _arg_2:String, _arg_3:Object):void
        {
            var _local_4:Channel = (this.mappedChannels.getItem(_arg_1) as Channel);
            if (_local_4 == null)
            {
                return;
            };
            _local_4.send(_arg_2, _arg_3);
        }


    }
}//package Model

