package cs448b.as3.ui
{
	import flare.animate.Transitioner;
	import flare.data.DataSet;
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
	
	public class PlayerGauge extends Sprite implements ControlListener
	{
		private var gaugeWidth:Number = 100;
		private var gaugeHeight:Number = 540;
		
		private var transTime:Number = 0.5;
		
		private var vis:Visualization = null;
		
		// filter values
		private var _gameType:String = "All";
		private var _roundNo:Number = 1;
		private var _playerNo:Number = -1; // Ronaldo
		private var _shotType:Number = 2;
		private var _timeCurrent:Number = 90;
		private var updateIm:Boolean = false;
		
		/**
		 * Constructor
		 */
		public function PlayerGauge(pn:Number = -1)
		{
			_playerNo = pn;
			
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
			vis.bounds = new Rectangle(0, 0, gaugeWidth, gaugeHeight);
		}
		
		public function registerData(ds:DataSet):void//d:Data):void
		{			
			vis.data = Data.fromDataSet(ds);//d; 
			
			vis.operators.add(new VisibilityFilter(theFilter));
			vis.operators[0].immediate = true; // filter immediately!
			
			vis.operators.add(new SortOperator(["-visible","data.ShotType"]));
			
			vis.operators.add(new AxisLayout("data.ShotNum", "data.Player", true, false));
			vis.operators.add(new ColorEncoder("data.ShotType", Data.NODES,
                "fillColor", ScaleType.CATEGORIES, LegendColors.SHOT_PALETTE));
                
			vis.data.nodes.setProperties({
				shape: Shapes.HORIZONTAL_BAR,
				lineAlpha: 0, size: 1.5
				});
				
			// set axis values 			
			vis.xyAxes.yReverse = true;
				
			vis.xyAxes.xAxis.showLines = false;
			vis.xyAxes.xAxis.showLabels = false;
//			vis.xyAxes.xAxis.axisScale.max = gaugeWidth;
//			vis.xyAxes.xAxis.axisScale.min = 0;
//			vis.xyAxes.xAxis.axisScale.flush = true;
			
			vis.xyAxes.yAxis.showLines = false;
//			vis.xyAxes.yAxis.showLabels = false;
//			vis.xyAxes.yAxis.axisScale.max = gaugeHeight;
//			vis.xyAxes.yAxis.axisScale.min = 0;
//			vis.xyAxes.yAxis.axisScale.flush = true;
			
 			vis.update();
		}
		
		public function get playerNumber():Number{ return _playerNo; }
		public function set playerNumber(pn:Number):void{ _playerNo = pn; }
		
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
			if(_playerNo < 0) return true;
			else if(_playerNo == d.data.Player) return true;			
			else return false;
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
		
		// ControlListener
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
			// do nothing for player change
		}
		
		public function shotType(gt:Number):void
		{
			_shotType = gt;			
			
			var al:AxisLayout = vis.operators[2] as AxisLayout;
			al.xField = "data."+getTypeString(gt);
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