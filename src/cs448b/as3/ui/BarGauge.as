package cs448b.as3.ui
{
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;
	
	import flash.display.Sprite;
	
	public class BarGauge extends Sprite implements ControlListener
	{
		private var shotRect:Sprite;
		private var sogRect:Sprite;
		private var goalRect:Sprite;
		
		private var _data:Data;
		
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
		public function set playerNumber(pn:Number):void{ _playerNo = pn; }
		
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
		}
		
		private function update():void
		{
			//TODO: update length here
			if(_data != null)
			{
				var goal:Number = 0;
				var sog:Number = 0;
				var shot:Number = 0;
				
				_data.visit(function (ds:DataSprite):void{
					// TODO: sum values here
					if( theFilter(ds, 0) ) goal++;
					if( theFilter(ds, 1) ) sog++;
					if( theFilter(ds, 2) ) shot++;
				});
				 	
				shotRect.width = gaugeWidth*shot/_maxValue;
				sogRect.width = gaugeWidth*sog/_maxValue;
				goalRect.width = gaugeWidth*goal/_maxValue;
			}
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
	}
}