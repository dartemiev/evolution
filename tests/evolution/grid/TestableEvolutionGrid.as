package evolution.grid
{
    public class TestableEvolutionGrid extends EvolutionGrid
    {
        public function TestableEvolutionGrid(rowCount:int, columnCount:int)
        {
            super(rowCount, columnCount);
        }

        public function getCellAt(rowIndex:int, columnIndex:int):EvolutionCell
        {
            var hashCode:String = getCellHasCode(rowIndex, columnIndex);
            return cellsMap[hashCode];
        }
    }
}
