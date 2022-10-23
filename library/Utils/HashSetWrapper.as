// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//Utils.HashSetWrapper

package Utils
{
    import flash.utils.Dictionary;

    public class HashSetWrapper 
    {

        private var _size:uint = 0;
        private var dict:Dictionary = new Dictionary();
        private var array:Array = null;


        public function add(_arg_1:Object):Boolean
        {
            if ((_arg_1 in this.dict))
            {
                return (false);
            };
            this.dict[_arg_1] = true;
            this.array = null;
            this._size++;
            return (true);
        }

        public function isEmpty():Boolean
        {
            return (this._size == 0);
        }

        public function remove(_arg_1:Object):Boolean
        {
            if (!(_arg_1 in this.dict))
            {
                return (false);
            };
            delete this.dict[_arg_1];
            this.array = null;
            this._size = Math.max(0, (this._size - 1));
            return (true);
        }

        public function size():uint
        {
            return (this._size);
        }

        public function clear():void
        {
            this.dict = new Dictionary();
            this.array = null;
            this._size = 0;
        }

        public function toArray():Array
        {
            var _local_1:Object;
            if (!this.array)
            {
                this.array = new Array();
                for (_local_1 in this.dict)
                {
                    this.array.push(_local_1);
                };
            };
            return (this.array);
        }

        public function contains(_arg_1:Object):Boolean
        {
            return (!(this.dict[_arg_1] == null));
        }


    }
}//package Utils

