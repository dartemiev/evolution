package grid
{
    import flash.geom.Point;

    import grid.state.EvolutionStates;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class GridEvolutionTest
    {
        private var evoGrid:TestableEvolutionGrid;

        [Before]
        public function setup():void
        {
            evoGrid = new TestableEvolutionGrid(4, 4);
        }

        [Test]
        public function testInitialization():void
        {
            var evoCell:EvolutionCell;
            evoGrid = new TestableEvolutionGrid(4, 4);
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

        [Test]
        public function testEvolution():void
        {
            evoGrid = new TestableEvolutionGrid(4, 4);
            var positions:Vector.<Point> = getAliveCellsSet1();
            for each (var position:Point in positions)
            {
                evoGrid.updateCellState(position.x, position.y, EvolutionStates.ALIVE);
            }
            evoGrid.evolute();

//            assertThat(evoGrid.getCellAt(0, 1).state, equalTo(EvolutionStates.ALIVE));
//            assertThat(evoGrid.getCellAt(1, 2).state, equalTo(EvolutionStates.ALIVE));
        }

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
    }
}
