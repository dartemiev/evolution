package grid
{
    public class EvolutionState
    {
        public static const DEAD:EvolutionState = new EvolutionState(0x000000, "dead");
        public static const ALIVE:EvolutionState = new EvolutionState(0xffffff, "alive");

        public function EvolutionState(color:uint, name:String)
        {
            _color = color;
            _name = name;
        }

        private var _color:uint;
        public function get color():uint
        {
            return _color;
        }


        private var _name:String;
        public function toString():String
        {
            return _name;
        }
    }
}
