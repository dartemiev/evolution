package cell
{
    import grid.EvolutionCell;
    import grid.TestableEvolutionGrid;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isTrue;

    /**
     * This test class tests neighbors for evolution cell.
     * For simplify testing, this test operates with evolution grid with
     * size 3x3, because a grid like that has all necessary cells to test.
     * For example, this grid has 4 cells in the corners with 3 neighbors
     * only, 4 cells on edges with 5 neighbors and one cells in the center
     * (normal cell without exceptions) with full list of neighbors (it's
     * 8 neighbors).
     */
    public class CellNeighborsTest
    {
        private var evoGrid:TestableEvolutionGrid;

        [Before]
        public function setup():void
        {
            evoGrid = new TestableEvolutionGrid(3, 3);
        }

        // --------------------------------------------------------------- //
        //             Corners cell's neighbors tests                      //
        // --------------------------------------------------------------- //
        [Test("Test cell in the top left corner - at position (0,0)")]
        public function testCellAt_0_0():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(0, 0);
            assertThat(neighbors.length, equalTo(3));
            assertThat(isNeighbor(neighbors, 0, 1), isTrue());
            assertThat(isNeighbor(neighbors, 1, 0), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
        }

        [Test("Test cell in the top right corner - at position (0,2)")]
        public function testCellAt_0_2():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(0, 2);
            assertThat(neighbors.length, equalTo(3));
            assertThat(isNeighbor(neighbors, 0, 1), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
            assertThat(isNeighbor(neighbors, 1, 2), isTrue());
        }

        [Test("Test cell in the bottom left corner - at position (2,0)")]
        public function testCellAt_2_0():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(2, 0);
            assertThat(neighbors.length, equalTo(3));
            assertThat(isNeighbor(neighbors, 1, 0), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
            assertThat(isNeighbor(neighbors, 2, 1), isTrue());
        }

        [Test("Test cell in the bottom right corner - at position (2,2)")]
        public function testCellAt_2_2():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(2, 2);
            assertThat(neighbors.length, equalTo(3));
            assertThat(isNeighbor(neighbors, 1, 2), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
            assertThat(isNeighbor(neighbors, 2, 1), isTrue());
        }

        // --------------------------------------------------------------- //
        //               Edges cell's neighbors tests                      //
        // --------------------------------------------------------------- //
        [Test("Test cell on the top edge - at position (0,1)")]
        public function testCellAt_0_1():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(0, 1);
            assertThat(neighbors.length, equalTo(5));
            assertThat(isNeighbor(neighbors, 0, 0), isTrue());
            assertThat(isNeighbor(neighbors, 1, 0), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
            assertThat(isNeighbor(neighbors, 1, 2), isTrue());
            assertThat(isNeighbor(neighbors, 0, 2), isTrue());
        }

        [Test("Test cell on the left edge - at position (1,2)")]
        public function testCellAt_1_2():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(1, 2);
            assertThat(neighbors.length, equalTo(5));
            assertThat(isNeighbor(neighbors, 0, 2), isTrue());
            assertThat(isNeighbor(neighbors, 0, 1), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
            assertThat(isNeighbor(neighbors, 2, 1), isTrue());
            assertThat(isNeighbor(neighbors, 2, 2), isTrue());
        }

        [Test("Test cell on the bottom edge - at position (2,1)")]
        public function testCellAt_2_1():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(2, 1);
            assertThat(neighbors.length, equalTo(5));
            assertThat(isNeighbor(neighbors, 2, 0), isTrue());
            assertThat(isNeighbor(neighbors, 1, 0), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
            assertThat(isNeighbor(neighbors, 1, 2), isTrue());
            assertThat(isNeighbor(neighbors, 2, 2), isTrue());
        }

        [Test("Test cell on the right edge - at position (1,0)")]
        public function testCellAt_1_0():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(1, 0);
            assertThat(neighbors.length, equalTo(5));
            assertThat(isNeighbor(neighbors, 0, 0), isTrue());
            assertThat(isNeighbor(neighbors, 0, 1), isTrue());
            assertThat(isNeighbor(neighbors, 1, 1), isTrue());
            assertThat(isNeighbor(neighbors, 2, 1), isTrue());
            assertThat(isNeighbor(neighbors, 2, 0), isTrue());
        }

        // --------------------------------------------------------------- //
        //              Normal cell's neighbors tests                      //
        // --------------------------------------------------------------- //
        [Test("Test normal cell with full list of neighbors")]
        public function testCellAt_1_1():void
        {
            var neighbors:Vector.<EvolutionCell> = getCellNeighborsAt(1, 1);
            assertThat(neighbors.length, equalTo(8));
            assertThat(isNeighbor(neighbors, 0, 0), isTrue());
            assertThat(isNeighbor(neighbors, 0, 1), isTrue());
            assertThat(isNeighbor(neighbors, 0, 2), isTrue());
            assertThat(isNeighbor(neighbors, 2, 0), isTrue());
            assertThat(isNeighbor(neighbors, 2, 1), isTrue());
            assertThat(isNeighbor(neighbors, 2, 2), isTrue());
            assertThat(isNeighbor(neighbors, 1, 0), isTrue());
            assertThat(isNeighbor(neighbors, 1, 2), isTrue());
        }

        private function getCellNeighborsAt(rowIndex:int, columnIndex:int):Vector.<EvolutionCell>
        {
            var evoCell:EvolutionCell = evoGrid.getCellAt(rowIndex, columnIndex);
            return evoCell.neighbors;
        }

        private static function isNeighbor(cells:Vector.<EvolutionCell>, rowIndex:int, columnIndex:int):Boolean
        {
            for each (var evoCell:EvolutionCell in cells)
            {
                if (evoCell.rowIndex == rowIndex && evoCell.columnIndex == columnIndex)
                {
                    return true;
                }
            }
            return false;
        }
    }
}

