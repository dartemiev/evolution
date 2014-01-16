package evolution.grid.state
{
    /**
     * A state for ALIVE cell.
     */
    public class AliveEvolutionState extends EvolutionState
    {
        public function AliveEvolutionState(color:uint)
        {
            super(color);
        }

        /**
         * @inheritDoc
         */
        override public function nextState(numAliveNeighbors:int):IEvolutionState
        {
            return (numAliveNeighbors < 2 || numAliveNeighbors > 3) ? EvolutionStates.DEAD : this;
        }
    }
}
