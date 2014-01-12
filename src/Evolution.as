package {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import flash.utils.getTimer;

    import grid.EvolutionGrid;
    import grid.EvolutionState;

    [SWF(backgroundColor=0x000000)]
    public class Evolution extends Sprite {
        private var generation:int = 0;
        /**
         * The visible representation of current state for each generations.
         */
        private var canvas:BitmapData;
        private var evoGrid:EvolutionGrid;
        private var evoTimer:Timer;

        public function Evolution() {
            var width:int = 100;
            var height:int = 100;
            canvas = new BitmapData(width, height, false, 0xcccccc);
            var bitmap:Bitmap = new Bitmap(canvas);
            bitmap.scaleX = bitmap.scaleY = 2;
            addChild(bitmap);

            evoGrid = new EvolutionGrid(height, width);
            evoGrid.updateCellState(0, 2, EvolutionState.ALIVE);
            evoGrid.updateCellState(1, 2, EvolutionState.ALIVE);
            evoGrid.updateCellState(2, 2, EvolutionState.ALIVE);
            evoGrid.updateCellState(1, 0, EvolutionState.ALIVE);
            evoGrid.updateCellState(2, 1, EvolutionState.ALIVE);
            for (var i:int = 0; i < 500; i++)
            {
                evoGrid.updateCellState(Math.random() * height, Math.random() * width, EvolutionState.ALIVE);
            }
            evoGrid.traceTo(canvas);

//            stage.addEventListener(MouseEvent.CLICK, onEvaluate);
//            stage.addEventListener(Event.ENTER_FRAME, onEvaluate);
            evoTimer = new Timer(80);
            evoTimer.addEventListener(TimerEvent.TIMER, onEvaluate);
            evoTimer.start();
        }

        private function onEvaluate(event:Event):void
        {
            evoGrid.evolute();
            evoGrid.traceTo(canvas);
            generation++;
        }
    }
}
