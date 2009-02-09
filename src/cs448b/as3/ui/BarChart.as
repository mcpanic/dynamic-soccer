package cs448b.as3.ui
{
	import flare.scale.ScaleType;
	import flare.util.Shapes;
	import flare.vis.Visualization;
	import flare.vis.data.Data;
	import flare.vis.data.DataList;
	import flare.vis.operator.encoder.ColorEncoder;
	import flare.vis.operator.layout.AxisLayout;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class BarChart extends Sprite
	{
		private var chartWidth:Number = 500;
		private var chartHeight:Number = 200;
		
		private var data:Data;
		
		private var vis:Visualization = null;
		
		public function BarChart()
		{
			this.graphics.beginFill(0xffffff, 1 );   // beginFill( color, alpha )
            this.graphics.drawRect( 0, 0, chartWidth, chartHeight);    // drawRect( left, top, width, height )
            this.graphics.endFill();
            
			initComponents();
			buildSprite();
		}

		public function initComponents():void
		{
			initVis();
		}
		
		public function buildSprite():void
		{
			addChild(vis);
		}
		
		public function initVis(d:Data = null):void
		{
			vis = new Visualization(d);
			vis.bounds = new Rectangle(0, 0, chartWidth, chartHeight);
		}
		
		public function registerData(d:Data):void
		{			
			vis.data = d; 
			
			vis.operators.add(new AxisLayout("data.Time", "data.X"));
			vis.operators.add(new ColorEncoder("data.Time", Data.NODES,
                "lineColor", ScaleType.LINEAR));
			vis.data.nodes.setProperties({
				shape: Shapes.VERTICAL_BAR,
				lineAlpha: 0,
				size: 10
			});
			
            vis.data.nodes.setProperties({fillColor:0, lineWidth:3, size:1});

 			vis.update();
		}
	}
}