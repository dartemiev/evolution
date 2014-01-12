package grid
{
    import flash.geom.Point;

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
                assertThat(evoCell.state, equalTo(EvolutionState.DEAD));

                evoGrid.updateCellState(position.x, position.y, EvolutionState.ALIVE);
                assertThat(evoCell.state, equalTo(EvolutionState.ALIVE));

                evoGrid.updateCellState(position.x, position.y, EvolutionState.DEAD);
                assertThat(evoCell.state, equalTo(EvolutionState.DEAD));
            }
        }

        [Test]
        public function testEvolution():void
        {
            evoGrid = new TestableEvolutionGrid(4, 4);
            var positions:Vector.<Point> = getAliveCellsSet1();
            for each (var position:Point in positions)
            {
                evoGrid.updateCellState(position.x, position.y, EvolutionState.ALIVE);
            }
            evoGrid.evolute();

            assertThat(evoGrid.getCellAt(0, 1).state, equalTo(EvolutionState.ALIVE));
//            assertThat(evoGrid.getCellAt(1, 2).state, equalTo(EvolutionState.ALIVE));
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
