package
{
    import cell.CellEvolutionTest;
    import cell.CellNeighborsTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class CellTestSuite
    {
        public var cellNeighbors:CellNeighborsTest;
        public var cellEvolution:CellEvolutionTest;
    }
}
