package grid.state
{
    /**
     * <code>EvolutionState</code> is enumeration with available states for
     * evolution cell.
     */
    public class EvolutionState implements IEvolutionState
    {
        public function EvolutionState(color:uint)
        {
            _color = color;
        }

        /**
         * @inheritDoc
         */
        public function nextState(numAliveNeighbors:int):IEvolutionState
        {
            return this;
        }

        // --------------------------
        //  Color
        // --------------------------
        private var _color:uint;

        /**
         * @inheritDoc
         */
        public function get color():uint
        {
            return _color;
        }
    }
}
