package grid.state
{
    /**
     * A state for DEAD cell.
     */
    public class DeadEvolutionState extends EvolutionState
    {
        public function DeadEvolutionState(color:uint)
        {
            super(color);
        }

        /**
         * @inheritDoc
         */
        override public function nextState(numAliveNeighbors:int):IEvolutionState
        {
            return (numAliveNeighbors == 3) ? EvolutionStates.ALIVE : this;
        }
    }
}
