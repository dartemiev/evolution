package grid
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    public class EvolutionGrid
    {
        /**
         * A map of cells involved in evolution by each generation step.
         */
        protected var cellsMap:Dictionary;

        /**
         * Creates new instance of evolution grid.
         * @param rowCount The number of cell in the row.
         * @param columnCount The number of cell in the column.
         */
        public function EvolutionGrid(rowCount:int, columnCount:int)
        {
            createCells(rowCount, columnCount);
            initialize();
        }

        /**
         * Updates cell state at the position.
         * @param rowIndex The index of cell in the row.
         * @param columnIndex The index of cell in the column.
         * @param state New state of cell.
         */
        public function updateCellState(rowIndex:int, columnIndex:int, state:EvolutionState):void
        {
            var hashCode:String = getCellHasCode(rowIndex, columnIndex);
            var cell:EvolutionCell = cellsMap[hashCode];
            cell.state = state;
            normalizeCell(cell);
        }

        public function evolute():void
        {
            var cell:EvolutionCell;
            // evolute all cells
            var stamp:Number = getTimer();
            for each (cell in cellsMap)
            {
                cell.evolute();
            }
            trace("Evolute", getTimer() - stamp, "ms");

            stamp = getTimer();
            normalizeCells();
            trace("Normalize", getTimer() - stamp, "ms");
        }

        public function traceTo(canvas:BitmapData):void
        {
            canvas.lock();
            for each (var cell:EvolutionCell in cellsMap)
            {
                var color:uint = cell.state.color;
                canvas.setPixel(cell.columnIndex, cell.rowIndex, color);
            }
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
                cell.state = EvolutionState.DEAD;
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
            for each (var cell:EvolutionCell in cellsMap)
            {
                cell.normalize();
            }
        }

        private function normalizeCell(cell:EvolutionCell):void
        {
            cell.normalize();
            for each (var neighbor:EvolutionCell in cell.neighbors)
            {
                neighbor.normalize();
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
