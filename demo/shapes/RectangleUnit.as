package shapes
{
    import xface.ui.DemoContentContainer;

    import flash.display.Shape;
    /**
     * @author eidiot
     */
    public class RectangleUnit
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var container:DemoContentContainer;
        //======================================================================
        //  Variables
        //======================================================================
        private var shape:Shape;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            shape = new Shape();
            container.addChild(shape);
            shape.x = 10;
            shape.y = 10;
            container.color = 0x00Ff00;
        }
        [After]
        public function tearDown():void
        {
            shape = null;
            container.color = 0xFFFFFF;
        }
        [Test]
        public function fill_color():void
        {
            with (shape.graphics)
            {
                beginFill(0xFF0000);
                drawRect(0, 0, 200, 100);
                endFill();
            }
        }
        [Test]
        public function only_rim():void
        {
            with (shape.graphics)
            {
                lineStyle(0, 0xFF0000);
                drawRect(0, 0, 200, 100);
                endFill();
            }
        }
    }
}