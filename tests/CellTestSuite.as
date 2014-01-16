package
{
    import evolution.cell.CellEvolutionTest;
    import evolution.cell.CellNeighborsTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class CellTestSuite
    {
        public var cellNeighbors:CellNeighborsTest;
        public var cellEvolution:CellEvolutionTest;
    }
}
