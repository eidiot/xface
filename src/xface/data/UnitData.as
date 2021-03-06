package xface.data
{
    import p2.reflect.Reflection;
    import p2.reflect.ReflectionMethod;
    import xface.core.UnitMethod;
    import xface.utils.DataUtils;


    /**
     * Data of the unit.
     * @author eidiot
     */
    public class UnitData
    {
        //==========================================================================
        //  Class variables
        //==========================================================================
        private static var postfixList:Array = ["Unit"];
        //==========================================================================
        //  Class public methods
        //==========================================================================
        /**
         * Add to be removed postfixes.
         */
        public static function setPostfix(...postfixes):void
        {
            while (postfixes.length == 1 && postfixes[0] as Array)
            {
                postfixes = postfixes[0];
            }
            postfixList = postfixes;
        }
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>UnitData</code>.
         */
        public function UnitData(unitClass:Class)
        {
            _unitClass = unitClass;
            _reflection = Reflection.create(unitClass);
            _name = reflection.name;
            if (_name.indexOf("::") != -1)
            {
                _name = _name.split("::")[1];
            }
            for each (var postfix:String in postfixList)
            {
                _name = DataUtils.removePostfix(_name, postfix);
            }
            _beforeMethods = getMethodsWithMetadata(reflection, "Before");
            _afterMethods = getMethodsWithMetadata(reflection, "After");
            _testMethods = getMethodsWithMetadata(reflection, "Test");
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  unitClass
        //------------------------------
        private var _unitClass:Class;
        /**
         * Class of the unit.
         */
        public function get unitClass():Class
        {
            return _unitClass;
        }
        //------------------------------
        //  reflection
        //------------------------------
        private var _reflection:Reflection;
        /**
         * Reflection value of the unit.
         */
        public function get reflection():Reflection
        {
            return _reflection;
        }
        //------------------------------
        //  name
        //------------------------------
        private var _name:String;
        /**
         * Name of the unit.
         */
        public function get name():String
        {
            return _name;
        }
        //------------------------------
        //  beforeMethods
        //------------------------------
        private var _beforeMethods:Array;
        /**
         * List of set up methods run before each unit method.
         */
        public function get beforeMethods():Array
        {
            return _beforeMethods.concat();
        }
        //------------------------------
        //  afterMethods
        //------------------------------
        private var _afterMethods:Array;
        /**
         * List of tear down methods run after each unit method.
         */
        public function get afterMethods():Array
        {
            return _afterMethods.concat();
        }
        //------------------------------
        //  testMethods
        //------------------------------
        private var _testMethods:Array;
        /**
         * List of test methods.
         */
        public function get testMethods():Array
        {
            return _testMethods.concat();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getMethodsWithMetadata(reflection:Reflection, metaDataName:String):Array
        {
            var methodReflections:Array = reflection.getMethodsByMetaData(metaDataName);
            var methods:Array = [];
            for each (var methodReflection:ReflectionMethod in methodReflections)
            {
                methods.push(new UnitMethod(this, methodReflection, metaDataName));
            }
            methods.sortOn(["order", "name"], Array.NUMERIC);
            return methods;
        }
    }
}