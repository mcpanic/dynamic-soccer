package cs448b.as3.data
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
					
	import flare.vis.data.Data;
	import flare.vis.data.NodeSprite;
	import flare.data.DataSet;
	import flare.data.DataSource;
	import flare.vis.Visualization;
	import flare.vis.operator.encoder.ColorEncoder;
	import flare.vis.operator.encoder.ShapeEncoder;
	import flare.vis.operator.layout.AxisLayout;
	import flare.scale.ScaleType;
			
	public class DataLoader extends Sprite
	{
		public function DataLoader()
		{
			loadData();
		}
        private function loadData():void
        {
        	// Import data in tab-delimited format
        	// Other supported formats:  "json" for JASN, "graphml" for GraphML
            var ds:DataSource = new DataSource( "http://www.stanford.edu/~juhokim/dynamicsoccer/goal.txt", "tab" );
            
            // Load the dataset asynchronuously 
            var loader:URLLoader = ds.load();
            
            // Create an event listen to process the data
            loader.addEventListener( Event.COMPLETE, 
            	function( evt:Event ):void
            	{
	                var dataSet:DataSet = loader.data as DataSet;
	                var data:Data;
	                
	                // Use default function to import data
	                data = Data.fromDataSet( dataSet );
/*
					// Create a data structure by processing the nodes table
					data = new Data();
					
					for each ( var d:Object in dataSet.nodes.data )
					{
						data.addNode(
							{
								Season    : d.Season,
								Team  : d.Team, 
								Round   : d.Round, 
								HomeAway : d.HomeAway, 
								Time  : d.Time,
								Player  : d.Player,
								X   : d.X,
								Y	: d.Y,
								Goal : d.Goal,
								ShotOnGoal : d.ShotOnGoal,
								PK : d.PK
							} 
						);	
					}
					
					// Really meaningful
					// Only here to demonstrate the use of createEdges
					data.createEdges( "data.date", "data.cause" );
*/	                
    	            testData( data );
            	}
            );
        }		

       	private var vis:Visualization;   
       	        
        private function testData( data:Data ):void
        {     	
            vis = new Visualization(data);
            vis.bounds = new Rectangle(0, 0, 600, 500);
            vis.x = 100;
            vis.y = 50;
            this.addChild(vis);
 
            vis.operators.add(new AxisLayout("data.X", "data.Y"));
            vis.operators.add(new ColorEncoder("data.Goal", Data.NODES,
                "lineColor", ScaleType.CATEGORIES));
            //vis.operators.add(new ShapeEncoder("data.Goal"));
            vis.data.nodes.setProperties({fillColor:0, lineWidth:2});
			//trace (data.HomeAway);

            vis.update();
        	
        }
	}
}