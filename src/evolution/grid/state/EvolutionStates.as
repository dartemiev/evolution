package evolution.grid.state
{
    /**
     * <code>EvolutionStates</code> is enumeration with available states for
     * evolution cell.
     */
    public class EvolutionStates
    {
        public static const DEAD:IEvolutionState = new DeadEvolutionState(0x000000);
        public static const ALIVE:IEvolutionState = new AliveEvolutionState(0xffffff);
    }
}
