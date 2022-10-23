// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//Model.Notifier

package Model
{
    import flash.events.EventDispatcher;
    import __AS3__.vec.Vector;
    import Utils.HashMapWrapper;
    import Utils.HashSetWrapper;
    import __AS3__.vec.*;

    public class Notifier extends EventDispatcher implements INotifier 
    {

        private var actionScope:String;
        private var heldBackNotifications_vector:Vector.<Notification> = null;
        private var channelMap:ChannelMap;
        private var observers:HashMapWrapper = null;


        public function notifyPropertyObserver(_arg_1:String, _arg_2:Object):void
        {
            var _local_3:HashSetWrapper;
            var _local_4:Object;
            var _local_5:Observer;
            if (this.heldBackNotifications_vector == null)
            {
                if (this.observers != null)
                {
                    _local_3 = (this.getObservers().getItem(_arg_1) as HashSetWrapper);
                    if (_local_3 != null)
                    {
                        for each (_local_4 in _local_3.toArray())
                        {
                            _local_5 = (_local_4 as Observer);
                            if (((!(_local_5 == null)) && (_local_3.contains(_local_5))))
                            {
                                _local_5.update(this, _arg_1, _arg_2);
                            };
                        };
                    };
                };
                if (this.actionScope != null)
                {
                    this.channelMap.send(this.actionScope, _arg_1, _arg_2);
                };
            }
            else
            {
                this.heldBackNotifications_vector.push(new Notification(_arg_1, _arg_2));
            };
        }

        public function transferObserversTo(_arg_1:Notifier):void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_4:HashSetWrapper;
            var _local_5:Object;
            var _local_6:Observer;
            _arg_1.removeAllObservers();
            for each (_local_2 in this.getObservers().keySet())
            {
                _local_3 = (_local_2 as String);
                _local_4 = (this.getObservers().getItem(_local_3) as HashSetWrapper);
                for each (_local_5 in _local_4.toArray())
                {
                    _local_6 = (_local_5 as Observer);
                    _arg_1.addPropertyObserver(_local_3, _local_6);
                };
            };
            this.observers = null;
            this.getObservers();
        }

        public function pauseNotifications():void
        {
            if (this.heldBackNotifications_vector == null)
            {
                this.heldBackNotifications_vector = new Vector.<Notification>();
            };
        }

        public function addPropertyObserver(_arg_1:String, _arg_2:Observer):void
        {
            var _local_3:HashSetWrapper;
            var _local_4:HashSetWrapper;
            if (this.getObservers().hasKey(_arg_1))
            {
                _local_3 = (this.getObservers().getItem(_arg_1) as HashSetWrapper);
                if (!_local_3.contains(_arg_2))
                {
                    _local_3.add(_arg_2);
                };
            }
            else
            {
                _local_4 = new HashSetWrapper();
                _local_4.add(_arg_2);
                this.getObservers().putItem(_arg_1, _local_4);
            };
        }

        public function removeAllObservers():void
        {
            this.observers = null;
            this.channelMap = null;
            this.actionScope = null;
        }

        public function dispose():void
        {
            this.heldBackNotifications_vector = null;
            this.removeAllObservers();
        }

        private function getObservers():HashMapWrapper
        {
            if (this.observers == null)
            {
                this.observers = new HashMapWrapper();
            };
            return (this.observers);
        }

        public function removePropertyObserver(_arg_1:String, _arg_2:Observer):void
        {
            var _local_3:HashSetWrapper;
            if (this.observers != null)
            {
                _local_3 = (this.getObservers().getItem(_arg_1) as HashSetWrapper);
                if (_local_3 != null)
                {
                    if (_local_3.contains(_arg_2))
                    {
                        _local_3.remove(_arg_2);
                    };
                };
            };
        }

        public function resumeNotifications():void
        {
            var _local_1:Vector.<Notification>;
            var _local_2:Notification;
            if (this.heldBackNotifications_vector != null)
            {
                _local_1 = this.heldBackNotifications_vector;
                this.heldBackNotifications_vector = null;
                for each (_local_2 in _local_1)
                {
                    this.notifyPropertyObserver(_local_2.property, _local_2.newValue);
                };
            };
        }

        public function mapTo(_arg_1:ChannelMap, _arg_2:String):void
        {
            this.channelMap = _arg_1;
            this.actionScope = _arg_2;
        }


    }
}//package Model

