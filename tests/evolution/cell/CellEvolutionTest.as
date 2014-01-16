package evolution.cell
{
    import evolution.grid.EvolutionCell;
    import evolution.grid.state.EvolutionStates;
    import evolution.grid.state.IEvolutionState;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    /**
     * This test class tests evolution cell from one state to another by some rules.
     * Rules are:
     *  - Any live cell with fewer than two live neighbours dies, as if caused by
     *    under-population.
     *  - Any live cell with two or three live neighbours lives on to the next generation.
     *  - Any live cell with more than three live neighbours dies, as if by overcrowding.
     *  - Any dead cell with exactly three live neighbours becomes a live cell, as if by
     *    reproduction.
     */
    public class CellEvolutionTest
    {
        private var evoCell:EvolutionCell;

        [Before]
        public function setup():void
        {
            evoCell = new EvolutionCell(1, 1);
        }

        [Test]
        /**
         * Tests cell evolution from DEAD state to DEAD, when number of ALIVE neighbors
         * is not equal 3. DEAD cell becomes ALIVE only if 3 neighbors are ALIVE.
         */
        public function testDeadToDeadEvolution():void
        {
            evoCell.state = EvolutionStates.DEAD;
            for (var i:int = 0; i < 8; i++)
            {
                if (i == 3) continue;

                evoCell.neighbors = generateNeighbors(i, EvolutionStates.ALIVE);
                evoCell.evolute();
                assertThat(evoCell.state, equalTo(EvolutionStates.DEAD))
            }
        }

        [Test]
        /**
         * Tests cell evolution from DEAD state to ALIVE. DEAD cell becomes ALIVE only
         * if 3 neighbors are ALIVE.
         */
        public function testDeadToAliveEvolution():void
        {
            evoCell.state = EvolutionStates.DEAD;
            evoCell.neighbors = generateNeighbors(3, EvolutionStates.ALIVE);
            evoCell.evolute();
            assertThat(evoCell.state, equalTo(EvolutionStates.ALIVE))
        }

        [Test]
        /**
         * Tests cell evolution from ALIVE state to ALIVE, when number of ALIVE neighbors
         * is equal 2 or 3. ALIVE cell keeps ALIVE state only if 2 or 3 neighbors are ALIVE.
         */
        public function testAliveToAliveEvolution():void
        {
            evoCell.state = EvolutionStates.ALIVE;
            for (var i:int = 2; i <= 3; i++)
            {
                evoCell.neighbors = generateNeighbors(i, EvolutionStates.ALIVE);
                evoCell.evolute();
                assertThat(evoCell.state, equalTo(EvolutionStates.ALIVE))
            }
        }

        [Test]
        /**
         * Tests cell evolution from ALIVE state to DEAD. ALIVE cell becomes DEAD state
         * only if the number of ALIVE neighbors is not equal 2 or 3.
         */
        public function testAliveToDeadEvolution():void
        {
            evoCell.state = EvolutionStates.ALIVE;
            for (var i:int = 0; i <= 8; i++)
            {
                if (i == 2 || i == 3) continue;

                evoCell.neighbors = generateNeighbors(i, EvolutionStates.ALIVE);
                evoCell.evolute();
                assertThat(evoCell.state, equalTo(EvolutionStates.DEAD))
            }
        }

        private static function generateNeighbors(count:int, state:IEvolutionState):Vector.<EvolutionCell>
        {
            var neighbors:Vector.<EvolutionCell> = new Vector.<EvolutionCell>(count, true);
            for (var i:int = 0; i < count; i++)
            {
                var neighbor:EvolutionCell = new EvolutionCell(-1, -1);
                neighbor.state = state;
                neighbors[i] = neighbor;
            }
            return neighbors;
        }
    }
}
