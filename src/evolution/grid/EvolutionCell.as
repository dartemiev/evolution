package evolution.grid
{
    import evolution.grid.state.EvolutionState;
    import evolution.grid.state.EvolutionStates;
    import evolution.grid.state.IEvolutionState;

    /**
     * A single cell that has state of evolution (dead, alive, etc.) and displays
     * this state each generation step.
     */
    public class EvolutionCell
    {
        /**
         * A state of cell before evaluation. Each time when state of cell is
         * changed, this value is last state of cell.
         */
        private var _oldState:IEvolutionState;

        private var aliveNeighborsCount:int;

        private var needNormalize:Boolean;
        private var firstRun:Boolean ;

        /**
         * Creates evolution cell at the position.
         * @param rowIndex The index of cell in the row.
         * @param columnIndex The index of cell in the column.
         */
        public function EvolutionCell(rowIndex:int, columnIndex:int)
        {
            _rowIndex = rowIndex;
            _columnIndex = columnIndex;

            firstRun = true;
        }

        public function normalize():void
        {
            if (firstRun == false && needNormalize == false) return;

            // pre-calculate number of alive neighbors
            aliveNeighborsCount = 0;
            for (var i:int = 0; i < neighbors.length; i++)
            {
                var neighbor:EvolutionCell = neighbors[i];
                if (neighbor.state == EvolutionStates.ALIVE)
                {
                    aliveNeighborsCount++;
                }
            }
            // old state should last state after evolution
            _oldState = _state;

            needNormalize = false;
        }

        public function evolute():Boolean
        {
            _state = _state.nextState(aliveNeighborsCount);

            var evolved:Boolean = _oldState != _state;
            if (evolved)
            {
                needNormalize = true;
                for each (var neighbor:EvolutionCell in _neighbors)
                {
                    neighbor.needNormalize = true;
                }
            }

            firstRun = false;
            return evolved;
        }

        public function toString():String
        {
            return "EvolutionCell(rowIndex=" + rowIndex + ", columnIndex=" + columnIndex + ", " +
                "aliveNeighborsCount=" + aliveNeighborsCount + ", " +
                "oldState=" + _oldState + ", state=" + state + ")";
        }

        // --------------------------
        //  Row index
        // --------------------------
        private var _rowIndex:int;

        /**
         * The index of cell in the row.
         */
        public function get rowIndex():int
        {
            return _rowIndex;
        }

        // --------------------------
        //  Column index
        // --------------------------
        private var _columnIndex:int;

        /**
         * The index of cell in the column.
         */
        public function get columnIndex():int
        {
            return _columnIndex;
        }

        // --------------------------
        //  Neighbors
        // --------------------------
        private var _neighbors:Vector.<EvolutionCell>;

        /**
         * A list of neighbors around of cells. This list contains 8
         * neighbors, but in corners or edges list contains 3 (in the
         * corner) or 5 (on the edge) neighbors.
         */
        public function get neighbors():Vector.<EvolutionCell>
        {
            return _neighbors;
        }

        /**
         * @private
         */
        public function set neighbors(value:Vector.<EvolutionCell>):void
        {
            _neighbors = value;
            normalize();
        }

        // --------------------------
        //  Current state
        // --------------------------
        private var _state:IEvolutionState;

        /**
         * Current state of cell.
         * @see evolution.grid.state.EvolutionState
         */
        public function get state():IEvolutionState
        {
            return _state;
        }

        /**
         * @private
         */
        public function set state(value:IEvolutionState):void
        {
            _state = value;
        }

    }
}
