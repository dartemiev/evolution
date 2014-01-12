package grid
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    import grid.state.AliveEvolutionState;
    import grid.state.EvolutionState;
    import grid.state.EvolutionStates;
    import grid.state.EvolutionStates;
    import grid.state.IEvolutionState;

    public class EvolutionGrid
    {
        /**
         * A map of cells involved in evolution by each generation step.
         */
        protected var cellsMap:Dictionary;
        /**
         * A map of cells are needed to normalize after evolution step.
         * This is a part of optimization and performance improvement.
         */
        protected var normalizeCellsMap:Dictionary = new Dictionary(true);
        protected var evoluteCellsMap:Dictionary = new Dictionary(true);

        private var tracer:BitmapData;
        private var tracerEtalon:BitmapData;

        /**
         * Creates new instance of evolution grid.
         * @param rowCount The number of cell in the row.
         * @param columnCount The number of cell in the column.
         */
        public function EvolutionGrid(rowCount:int, columnCount:int)
        {
            tracerEtalon = new BitmapData(columnCount, rowCount, false, EvolutionStates.DEAD.color);
            tracer = tracerEtalon.clone();

            createCells(rowCount, columnCount);
            initialize();
        }

        /**
         * Updates cell state at the position.
         * @param rowIndex The index of cell in the row.
         * @param columnIndex The index of cell in the column.
         * @param state New state of cell.
         */
        public function updateCellState(rowIndex:int, columnIndex:int, state:IEvolutionState):void
        {
            var hashCode:String = getCellHasCode(rowIndex, columnIndex);
            var cell:EvolutionCell = cellsMap[hashCode];
            cell.state = state;
            registerCell(cell);

            tracer.setPixel(cell.columnIndex, cell.rowIndex, state.color);
        }

        public function evolute():void
        {
            normalizeCells();

            tracer = tracerEtalon.clone();
            tracer.lock();

            var evolutionMap:Dictionary = evoluteCellsMap;
            normalizeCellsMap = new Dictionary(true);
            evoluteCellsMap = new Dictionary(true);

            var cell:EvolutionCell;
            for each (cell in evolutionMap)
            {
                var evolved:Boolean = cell.evolute();
                var state:IEvolutionState = cell.state;
                if (evolved == true || state == EvolutionStates.ALIVE)
                {
                    registerCell(cell);
                    tracer.setPixel(cell.columnIndex, cell.rowIndex, state.color);
                }
                else
                {
//                    var hasCode:String = getCellHasCode(cell.rowIndex, cell.columnIndex);
//                    delete normalizeCellsMap[hasCode];
//                    delete evoluteCellsMap[hasCode];
                }
            }
            tracer.unlock();
        }

        public function traceTo(canvas:BitmapData):void
        {
            canvas.lock();
            canvas.draw(tracer);
            canvas.unlock();
        }

        /**
         * Generate empty field with cells to manage them each generation
         * step.
         * @param rowCount The number of cell in the row.
         * @param columnCount The number of cell in the column.
         */
        private function createCells(rowCount:int, columnCount:int):void
        {
            cellsMap = new Dictionary(true);
            for (var rowIndex:int = 0; rowIndex < rowCount; rowIndex++)
            {
                for (var columnIndex:int = 0; columnIndex < columnCount; columnIndex++)
                {
                    var hasCode:String = getCellHasCode(rowIndex, columnIndex);
                    cellsMap[hasCode] = new EvolutionCell(rowIndex, columnIndex);
                }
            }
        }

        /**
         * Initialize evolution grid and cells.
         */
        private function initialize():void
        {
            for each (var cell:EvolutionCell in cellsMap)
            {
                cell.neighbors = findCellNeighbors(cell.rowIndex, cell.columnIndex);
                cell.state = EvolutionStates.DEAD;
            }
        }

        private function findCellNeighbors(rowIndex:int, columnIndex:int):Vector.<EvolutionCell>
        {
            var neighbors:Vector.<EvolutionCell> = new <EvolutionCell>[];
            var positions:Vector.<Point> = getNeighborsPosition(rowIndex, columnIndex);
            for each (var position:Point in positions)
            {
                var hashCode:String = getCellHasCode(position.x, position.y);
                var cell: EvolutionCell = cellsMap[hashCode];
                if (cell != null) neighbors.push(cell);
            }
            return neighbors;
        }

        private function normalizeCells():void
        {
            for each (var cell:EvolutionCell in normalizeCellsMap)
            {
                cell.normalize();
            }
        }

        /**
         * Resisters cell to normalize it and cell's neighbors.
         */
        private function registerCellToNormalize(cell:EvolutionCell):void
        {
            var hasCode:String = getCellHasCode(cell.rowIndex, cell.columnIndex);
            if (normalizeCellsMap[hasCode] == null)
            {
                normalizeCellsMap[hasCode] = cell;
            }
        }

        /**
         * Resisters cell for evolution it next evolution step.
         */
        private function registerCellToEvolution(cell:EvolutionCell):void
        {
            var hasCode:String = getCellHasCode(cell.rowIndex, cell.columnIndex);
            if (evoluteCellsMap[hasCode] == null)
            {
                evoluteCellsMap[hasCode] = cell;
            }
        }

        private function registerCell(cell:EvolutionCell):void
        {
            registerCellToEvolution(cell);
            registerCellToNormalize(cell);
            for each (var neighbor:EvolutionCell in cell.neighbors)
            {
                registerCellToEvolution(neighbor);
                registerCellToNormalize(neighbor);
            }
        }

        /**
         * Returns unique hash code for cell to recognize this cell later in
         * cell map. This has code must be based on cell position (row and
         * column indexes).
         */
        protected static function getCellHasCode(rowIndex:int, columnIndex:int):String
        {
            return rowIndex + "#" + columnIndex;
        }

        /**
         * Returns position of all neighbors around the position. These positions
         * are position of all possible neighbors for cell at this position.
         */
        private static function getNeighborsPosition(rowIndex:int, columnIndex:int):Vector.<Point>
        {
            var positions:Vector.<Point> = new <Point>[];
            // top "line" of neighbors
            positions.push(new Point(rowIndex - 1, columnIndex - 1));
            positions.push(new Point(rowIndex - 1, columnIndex));
            positions.push(new Point(rowIndex - 1, columnIndex + 1));
            // bottom "line" of neighbors
            positions.push(new Point(rowIndex + 1, columnIndex - 1));
            positions.push(new Point(rowIndex + 1, columnIndex));
            positions.push(new Point(rowIndex + 1, columnIndex + 1));
            // left and right neighbors
            positions.push(new Point(rowIndex, columnIndex - 1));
            positions.push(new Point(rowIndex, columnIndex + 1));
            return positions
        }
    }
}
