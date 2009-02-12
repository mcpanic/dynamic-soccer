package cs448b.as3.ui
{
	import flare.animate.Tween;
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;
	
	import flash.display.Sprite;
	
	public class BarGauge extends Sprite implements ControlListener
	{
		private var shotRect:Sprite;
		private var sogRect:Sprite;
		private var goalRect:Sprite;
		
		private var _data:Data;
		
		private var _goalSum:Number = 0;
		private var _sogSum:Number = 0;
		private var _shotSum:Number = 0;
		
		// filter values
		private var _gameType:String = "All";
		private var _roundNo:Number = 1;
		private var _playerNo:Number = -1;
		private var _shotType:Number = 2;
		private var _timeCurrent:Number = 90;
		private var updateIm:Boolean = false;
		
		private var _maxValue:Number = 200;
		private var gaugeWidth:Number = 50;
		private var gaugeHeight:Number = 20;
		
		private var transTime:Number = 0.5;
		
		public function BarGauge(pn:Number = -1)
		{	
			_playerNo = pn;
			
//			this.graphics.beginFill( 0xffffff, 1 );
//            this.graphics.drawRect( 0, 0, gaugeWidth, gaugeHeight );
//            this.graphics.endFill();
			
			initComponents();
			buildSprite();
		}

		public function initComponents():void
		{
			goalRect = new Sprite();
			goalRect.graphics.beginFill(LegendColors.GOAL_COLOR);
			goalRect.graphics.drawRect(0, gaugeHeight*0.1, gaugeWidth, gaugeHeight*0.8);
			goalRect.graphics.endFill();
			
			sogRect = new Sprite();
			sogRect.graphics.beginFill(LegendColors.SHOT_ON_GOAL_COLOR);
			sogRect.graphics.drawRect(0, gaugeHeight*0.1, gaugeWidth, gaugeHeight*0.8);
			sogRect.graphics.endFill();
			
			shotRect = new Sprite();
			shotRect.graphics.beginFill(LegendColors.SHOT_COLOR);
			shotRect.graphics.drawRect(0, gaugeHeight*0.1, gaugeWidth, gaugeHeight*0.8);
			shotRect.graphics.endFill();
		}
		
		public function buildSprite():void
		{
			addChild(shotRect);
			addChild(sogRect);
			addChild(goalRect);
		}
		
		public function get playerNumber():Number{ return _playerNo; }
		public function set playerNumber(pn:Number):void{ _playerNo = pn; update()}
		
		public function registerData(d:Data):void
		{			
			_data = d;
			
			update();
		}
		
		// ControlListener
		// Visability value set functions
		public function gameType(gt:String):void
		{
			_gameType = gt; 		
//			vis.update(new Transitioner(transTime)).play();
			update();
		}
		
		public function roundNo(rn:Number):void
		{
			_roundNo = rn;
						
//			vis.update(new Transitioner(transTime)).play();
			update();
		}
		
		public function playerNo(pnArray:Array):void
		{
			// do nothing for player change
		}
		
		public function shotType(gt:Number):void
		{
			_shotType = gt;			
			
//			var al:AxisLayout = vis.operators[2] as AxisLayout;
//			al.xField = "data."+getTypeString(gt);
//			vis.update(new Transitioner(transTime)).play();
			update();
		}
		
		public function timeCurrent(tc:Number):void
		{
			_timeCurrent = tc;

//			if(updateIm)vis.update();
//			else vis.update(new Transitioner(transTime)).play();
			update();
		}
		
		public function setImmediate(im:Boolean):void
		{
			// there is no immediate flag
			updateIm = im;
		}
		
		private function update():void
		{
			if(_data != null)
			{
				updateSumValues();	 	
				updateBars();	
			}
		}
		
		private function updateSumValues():void
		{
			_goalSum = 0;
			_sogSum = 0;
			_shotSum = 0;
			
			_data.visit(function (ds:DataSprite):void{
				// sum values here
				if( theFilter(ds, 0) ) _goalSum++;
				if( theFilter(ds, 1) ) _sogSum++;
				if( theFilter(ds, 2) ) _shotSum++;
			});
		}
		
		private function updateBars():void
		{
			if(updateIm) shotRect.width = gaugeWidth*_shotSum/_maxValue;
			else 
			{
				if(_shotType == 2)new Tween(shotRect, transTime, {width:gaugeWidth*_shotSum/_maxValue}).play();
				else new Tween(shotRect, transTime, {width:0}).play();
			}
			
			if(updateIm) sogRect.width = gaugeWidth*_sogSum/_maxValue;
			else
			{
				if(_shotType != 0) new Tween(sogRect, transTime, {width:gaugeWidth*_sogSum/_maxValue}).play();
				else new Tween(sogRect, transTime, {width:0}).play();
			}
			
			if(updateIm) goalRect.width = gaugeWidth*_goalSum/_maxValue;
			else new Tween(goalRect, transTime, {width:gaugeWidth*_goalSum/_maxValue}).play();
		}
		
		private function theFilter(d:DataSprite, st:Number):Boolean
		{
			return gameFilter(d) && playerFilter(d) && goalFilter(d, st) && timeFilter(d);
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
		
		private function goalFilter(d:DataSprite, st:Number):Boolean
		{
			if(st == 0 && d.data.ShotType == "g") return true;
			else if(st == 1 && (d.data.ShotType == "o" || d.data.ShotType == "g")) return true;
			else if(st == 2) return true;
			else return false;
		}

		private function timeFilter(d:DataSprite):Boolean
		{
			if(_timeCurrent == 90) return true;
			else if(_timeCurrent >= d.data.Time) return true;
			else return false;
		}
		
		public function getGoals():Number
		{
			return _goalSum;
		}
		
		public function getShotsOnGoal():Number
		{
			return _sogSum;
		}
		
		public function getShots():Number
		{
			return _shotSum;
		}  
	}
}