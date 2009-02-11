package cs448b.as3.ui
{
	import flare.animate.Transitioner;
	import flare.display.TextSprite;
	import flare.scale.ScaleType;
	import flare.util.Shapes;
	import flare.vis.Visualization;
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;
	import flare.vis.operator.SortOperator;
	import flare.vis.operator.encoder.ColorEncoder;
	import flare.vis.operator.filter.VisibilityFilter;
	import flare.vis.operator.layout.AxisLayout;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	public class BarChart extends Sprite implements ControlListener
	{
		private var chartWidth:Number = 500;
		private var chartHeight:Number = 200;
		
		private var transTime:Number = 0.5;
		
		private var data:Data;
		
		private var vis:Visualization = null;
		
		private var textFormat:TextFormat;
		private var xLabel:TextSprite;
		private var yLabel:TextSprite;
		
		// filter values
		private var _gameType:String = "All";
		private var _roundNo:Number = 1;
		private var _playerArray:Array = null;
		private var _shotType:Number = 2;
		private var _timeCurrent:Number = 90;
		private var updateIm:Boolean = false;
		
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
			
			textFormat = new TextFormat("Verdana,Tahoma,Arial",12,0,true);
			xLabel = new TextSprite("Minutes", textFormat);
			yLabel = new TextSprite("Shot#", textFormat);
		}
		
		public function buildSprite():void
		{
			addChild(vis);
			
			xLabel.x = chartWidth/2 - 50;
			xLabel.y = chartHeight + 30;
			addChild(xLabel);
			
			yLabel.x = -yLabel.width-30;
			yLabel.y = chartHeight/2;			
			addChild(yLabel);
		}
		
		public function initVis(d:Data = null):void
		{
			vis = new Visualization(d);
			vis.bounds = new Rectangle(0, 0, chartWidth, chartHeight);
		}
		
		public function registerData(d:Data):void
		{			
			data = d;
			vis.data = d; 
			
			vis.operators.add(new VisibilityFilter(theFilter));
			vis.operators[0].immediate = true; // filter immediately!
			
			vis.operators.add(new SortOperator(["-visible","data.ShotType"]));
			
			vis.operators.add(new AxisLayout("data.TimeBin", "data.ShotNum", false, true));
			vis.operators.add(new ColorEncoder("data.ShotType", Data.NODES,
                "fillColor", ScaleType.CATEGORIES));
			vis.data.nodes.setProperties({
				fillColor: 0xff0abcde,
				shape: Shapes.VERTICAL_BAR,
				lineAlpha: 0, size: 10
			});
			
 			vis.update();
		}
		
		private function getTypeString(t:Number):String
		{
			if(t == 0) return "GoalNum";
			else if(t == 1) return "SogNum";
			else return "ShotNum";
		}
		
		private function theFilter(d:DataSprite):Boolean
		{
			return gameFilter(d) && playerFilter(d) && goalFilter(d) && timeFilter(d);
		}
		
		private function gameFilter(d:DataSprite):Boolean
		{
			if(_gameType == "All") return true;
			else if(_gameType == "Home" && d.data.HomeAway == "Home") return true;
			else if(_gameType == "Away" && d.data.HomeAway == "Away") return true;
			else if(_gameType == "Single" && d.data.Round == _roundNo) return true;
			else return false;
		}
		
		private function playerFilter(d:DataSprite):Boolean
		{
			if(_playerArray == null) return true;
			else
			{
				for(var i:Number = 0; i < _playerArray.length; i++)
				{
					if(_playerArray[i] as Number == d.data.Player) return true;
				}
			}
			
			return false;
		}
		
		private function goalFilter(d:DataSprite):Boolean
		{
			if(_shotType == 0 && d.data.ShotType == "g") return true;
			else if(_shotType == 1 && (d.data.ShotType == "o" || d.data.ShotType == "g")) return true;
			else if(_shotType == 2) return true;
			else return false;
		}

		private function timeFilter(d:DataSprite):Boolean
		{
			if(_timeCurrent == 90) return true;
			else if(_timeCurrent >= d.data.Time) return true;
			else return false;
		}
		
		// Visability value set functions
		public function gameType(gt:String):void
		{
			_gameType = gt; 		
			vis.update(new Transitioner(transTime)).play();
		}
		
		public function roundNo(rn:Number):void
		{
			_roundNo = rn;
						
			vis.update(new Transitioner(transTime)).play();
		}
		
		public function playerNo(pnArray:Array):void
		{
			_playerArray = pnArray;			
			vis.update(new Transitioner(transTime)).play();
		}
		
		public function shotType(gt:Number):void
		{
			_shotType = gt;			
			
			var al:AxisLayout = vis.operators[2] as AxisLayout;
			al.yField = "data."+getTypeString(gt);
			vis.update(new Transitioner(transTime)).play();
		}
		
		public function timeCurrent(tc:Number):void
		{
			_timeCurrent = tc;

			if(updateIm)vis.update();
			else vis.update(new Transitioner(transTime)).play();
		}
		
		public function setImmediate(im:Boolean):void
		{
			updateIm = im;
//			vis.operators[0].immediate = im; // filter immediately!
		}
	}
}