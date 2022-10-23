// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//Utils.HashMapWrapper

package Utils
{
    import flash.utils.Dictionary;

    public class HashMapWrapper 
    {

        private var _keySet:Array;
        private var _valueSet:Array;
        private var dict:Dictionary;
        private var invalidated:Boolean = true;

        public function HashMapWrapper()
        {
            super();
            this.dict = new Dictionary();
            this._valueSet = null;
            this._keySet = null;
        }

        public function keySet():Array
        {
            var _local_1:Object;
            if (this.invalidated)
            {
                this._keySet = new Array();
                for (_local_1 in this.dict)
                {
                    this._keySet.push(_local_1);
                };
            };
            return (this._keySet);
        }

        public function hasKey(_arg_1:Object):Boolean
        {
            return (_arg_1 in this.dict);
        }

        public function getItem(_arg_1:Object):Object
        {
            return (this.dict[_arg_1]);
        }

        public function isEmpty():Boolean
        {
            return (this.keySet().length == 0);
        }

        public function remove(_arg_1:Object):Object
        {
            var _local_2:Object = this.dict[_arg_1];
            delete this.dict[_arg_1];
            this.invalidated = true;
            return (_local_2);
        }

        public function clear():void
        {
            var _local_1:Object;
            for (_local_1 in this.dict)
            {
                delete this.dict[_local_1];
            };
            _local_1 = null;
            this.dict = new Dictionary();
            this.invalidated = true;
        }

        public function putItem(_arg_1:Object, _arg_2:Object):Object
        {
            this.dict[_arg_1] = _arg_2;
            this.invalidated = true;
            return (_arg_2);
        }

        public function keyOf(_arg_1:Object):Object
        {
            var _local_2:Object;
            for (_local_2 in this.dict)
            {
                if (this.dict[_local_2] == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function valueSet():Array
        {
            var _local_1:Object;
            if (this.invalidated)
            {
                this._valueSet = new Array();
                for (_local_1 in this.dict)
                {
                    this._valueSet.push(this.dict[_local_1]);
                };
            };
            return (this._valueSet);
        }


    }
}//package Utils

