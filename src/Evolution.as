package {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import flash.utils.getTimer;

    import evolution.grid.EvolutionGrid;
    import evolution.grid.state.EvolutionStates;

    [SWF(backgroundColor=0x000000, frameRate=31)]
    public class Evolution extends Sprite {
        private static const GRID_WIDTH:int = 4;
        private static const GRID_HEIGHT:int = 4;

        private var canvas:BitmapData;
        private var evoGrid:EvolutionGrid;
        private var generation:int = 0;

        public function Evolution()
        {
            canvas = new BitmapData(GRID_WIDTH, GRID_HEIGHT, false, 0xcccccc);
            var bitmap:Bitmap = new Bitmap(canvas);
            bitmap.scaleX = bitmap.scaleY = 50;
            addChild(bitmap);
            evoGrid = new EvolutionGrid(GRID_HEIGHT, GRID_WIDTH);
            evoGrid.updateCellState(0, 2, EvolutionStates.ALIVE);
            evoGrid.updateCellState(1, 2, EvolutionStates.ALIVE);
            evoGrid.updateCellState(2, 2, EvolutionStates.ALIVE);
            evoGrid.updateCellState(1, 0, EvolutionStates.ALIVE);
            evoGrid.updateCellState(2, 1, EvolutionStates.ALIVE);
            evoGrid.traceTo(canvas);
            //stage.addEventListener(MouseEvent.CLICK, onEvaluate);
            //stage.addEventListener(Event.ENTER_FRAME, onEvaluate);
            var evoTimer:Timer = new Timer(80);
            evoTimer.addEventListener(TimerEvent.TIMER, onEvaluate);
            evoTimer.start();
        }

        private function onEvaluate(event:Event):void
        {
            generation++;

            var stamp:Number = getTimer();
            evoGrid.evolute();
            trace("Evolute", getTimer() - stamp, "ms");

            evoGrid.traceTo(canvas);
        }
    }
}
