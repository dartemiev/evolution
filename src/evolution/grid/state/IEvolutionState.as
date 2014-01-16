package evolution.grid.state
{
    /**
     * This interface provides public API set that class should implement
     * to be a state of evolution.
     */
    public interface IEvolutionState
    {
        /**
         * A color of state when client wants to trace current evolution grid to
         * bitmap.
         */
        function get color():uint;

        /**
         * Returns new state in evolution phase by number of alive neighbors.
         * @param numAliveNeighbors A number of alive neighbors.
         */
        function nextState(numAliveNeighbors:int):IEvolutionState;
    }
}
