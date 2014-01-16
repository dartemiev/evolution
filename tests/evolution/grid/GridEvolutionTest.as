package evolution.grid
{
    import evolution.cell.TestableEvolutionCell;
    import evolution.grid.state.EvolutionStates;
    import evolution.grid.state.IEvolutionState;

    import flash.geom.Point;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    [RunWith("org.flexunit.runners.Parameterized")]
    public class GridEvolutionTest
    {
        public static var evolutionDataProvider:Array =
        [
            [getAliveCellsSet1(), getEvolutionResult1()],
            [getAliveCellsSet2(), getEvolutionResult2()]
        ];

        private var evoGrid:TestableEvolutionGrid;

        [Before]
        public function setup():void
        {
            evoGrid = new TestableEvolutionGrid(4, 4);
        }

        [Test(order=1)]
        public function testInitialization():void
        {
            var evoCell:EvolutionCell;
            var positions:Vector.<Point> = getAliveCellsSet1();
            for each (var position:Point in positions)
            {
                evoCell = evoGrid.getCellAt(position.x, position.y);
                assertThat(evoCell.state, equalTo(EvolutionStates.DEAD));

                evoGrid.updateCellState(position.x, position.y, EvolutionStates.ALIVE);
                assertThat(evoCell.state, equalTo(EvolutionStates.ALIVE));

                evoGrid.updateCellState(position.x, position.y, EvolutionStates.DEAD);
                assertThat(evoCell.state, equalTo(EvolutionStates.DEAD));
            }
        }

        [Test(dataProvider=evolutionDataProvider,order=2)]
        public function testEvolution(cellSet:Vector.<Point>, resultSet:Vector.<EvolutionCell>):void
        {
            evoGrid = new TestableEvolutionGrid(4, 4);
            for each (var position:Point in cellSet)
            {
                evoGrid.updateCellState(position.x, position.y, EvolutionStates.ALIVE);
            }
            evoGrid.evolute();

            for each (var cell:EvolutionCell in resultSet)
            {
                var state:IEvolutionState = evoGrid.getCellAt(cell.rowIndex, cell.columnIndex).state;
                assertThat(state, equalTo(cell.state));
            }
        }

        // --------------------------------------------------------------- //
        //             Cells setup and states result #1                    //
        // --------------------------------------------------------------- //
        private static function getAliveCellsSet1():Vector.<Point>
        {
            var positions:Vector.<Point> = new Vector.<Point>();
            positions.push(new Point(2, 0));
            positions.push(new Point(2, 1));
            positions.push(new Point(2, 2));
            positions.push(new Point(1, 2));
            positions.push(new Point(0, 1));
            return positions;
        }

        private static function getEvolutionResult1():Vector.<EvolutionCell>
        {
            var result:Vector.<EvolutionCell> = new <EvolutionCell>[];
            result.push(new TestableEvolutionCell(0, 0, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(1, 0, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(2, 0, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(3, 0, EvolutionStates.DEAD));

            result.push(new TestableEvolutionCell(0, 1, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(1, 1, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(2, 1, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(3, 1, EvolutionStates.ALIVE));

            result.push(new TestableEvolutionCell(0, 2, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(1, 2, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(2, 2, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(3, 2, EvolutionStates.DEAD));

            result.push(new TestableEvolutionCell(0, 3, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(1, 3, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(2, 3, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(3, 3, EvolutionStates.DEAD));

            return result;
        }

        // --------------------------------------------------------------- //
        //             Cells setup and states result #2                    //
        // --------------------------------------------------------------- //
        private static function getAliveCellsSet2():Vector.<Point>
        {
            var positions:Vector.<Point> = new Vector.<Point>();
            positions.push(new Point(0, 2));
            positions.push(new Point(1, 2));
            positions.push(new Point(2, 2));
            positions.push(new Point(2, 1));
            positions.push(new Point(1, 0));
            return positions;
        }

        private static function getEvolutionResult2():Vector.<EvolutionCell>
        {
            var result:Vector.<EvolutionCell> = new <EvolutionCell>[];
            result.push(new TestableEvolutionCell(0, 0, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(0, 1, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(0, 2, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(0, 3, EvolutionStates.DEAD));

            result.push(new TestableEvolutionCell(1, 0, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(1, 1, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(1, 2, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(1, 3, EvolutionStates.ALIVE));

            result.push(new TestableEvolutionCell(2, 0, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(2, 1, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(2, 2, EvolutionStates.ALIVE));
            result.push(new TestableEvolutionCell(2, 3, EvolutionStates.DEAD));

            result.push(new TestableEvolutionCell(3, 0, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(3, 1, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(3, 2, EvolutionStates.DEAD));
            result.push(new TestableEvolutionCell(3, 3, EvolutionStates.DEAD));

            return result;
        }
    }
}
