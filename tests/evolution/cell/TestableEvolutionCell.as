package evolution.cell
{
    import evolution.grid.EvolutionCell;
    import evolution.grid.state.IEvolutionState;

    public class TestableEvolutionCell extends EvolutionCell
    {
        public function TestableEvolutionCell(rowIndex:int, columnIndex:int, state:IEvolutionState)
        {
            super(rowIndex, columnIndex);
            this.state = state;
        }
    }
}
