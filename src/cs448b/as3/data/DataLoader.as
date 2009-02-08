package cs448b.as3.data
{

	
	import flare.data.DataSet;
	import flare.data.DataSource;
	import flare.scale.ScaleType;
	import flare.vis.Visualization;
	import flare.vis.data.Data;
	import flare.vis.operator.encoder.ColorEncoder;
	import flare.vis.operator.layout.AxisLayout;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
			
	public class DataLoader extends Sprite
	{
		private var dataAddress:String;
		private var _data:Data;
		private var ds:DataSource;
		private var loader:URLLoader;

		private var cb:Function = null;
		

		public function DataLoader()
		{
			dataAddress = "http://www.stanford.edu/~juhokim/dynamicsoccer/goal2.txt";

		}
		
		public function get data():Data
		{
			return _data;
		}
		
        public function loadData():void
        {
        	// Import data in tab-delimited format
        	// Other supported formats:  "json" for JASN, "graphml" for GraphML
            ds = new DataSource( dataAddress, "tab" );
            
            // Load the dataset asynchronuously 
            loader = ds.load();
            
            // Create an event listen to process the data
            loader.addEventListener( Event.COMPLETE, 
            	function( evt:Event ):void
            	{
	                var dataSet:DataSet = loader.data as DataSet;
	                
	                // Use default function to import data
	                _data = Data.fromDataSet( dataSet );
           
					//testData();
					
					if(cb != null) cb( evt );
            	}
            );
        }		
        
        public function addLoadEventListener(callback:Function):void
        {
        	cb = callback;
        }
        
        public function removeLoadEventListener():void
        {
        	cb = null;
        }

/* Temporary test visualization function - TO BE DELETED */

       	private var vis:Visualization;   
       	        
        public function testData():void
        {     	
            vis = new Visualization(_data);
            vis.bounds = new Rectangle(0, 0, 600, 500);
            vis.x = 100;
            vis.y = 50;
            addChild(vis);
 
            vis.operators.add(new AxisLayout("_data.X", "_data.Y"));
            vis.operators.add(new ColorEncoder("_data.Goal", Data.NODES,
                "lineColor", ScaleType.CATEGORIES));
            //vis.operators.add(new ShapeEncoder("data.Goal"));
            vis.data.nodes.setProperties({fillColor:0, lineWidth:2});
			//trace (data.HomeAway);

            vis.update();
        	
        }
	}
}