package cs448b.as3.ui
{
	import cs448b.as3.data.PlayerData;
	
	import flare.data.DataSet;
	import flare.vis.data.Data;
	
	import flash.display.Sprite;
	
	public class BarList extends Sprite implements ControlListener
	{
		private var pgArray:Array;
		
		private var data:Data;
		private var pData:PlayerData;
		
		public function BarList()
		{
			initComponents();
			buildSprite();
		}
		
		private function initComponents():void
		{
			pgArray = new Array();
			
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				pgArray.push(new BarGauge());
			}
		}
		
		private function buildSprite():void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				
				pg.x = 0;//970;
				pg.y = 20*i;//110 + 20*i;
				addChild(pg);
			}
		}
		
		public function updateGaugeMax():void
		{
			var max:Number = 0;
			// find max
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				if(max < pg.getCurrentData()) max = pg.getCurrentData();
			}
			
			// set max
			for(var ii:Number = 0; ii < PlayerData.totalPlayers; ii++)
			{
				var bg:BarGauge = pgArray[ii] as BarGauge;
				bg.setMaxValue(max);
			}
		}
		
		public function registerData(ds:DataSet):void
		{
			data = Data.fromDataSet(ds);
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				
				pg.registerData(data);
			}
		}
		
		public function updatePlayerData(plData:PlayerData):void 
		{
			pData = plData;
			
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.playerNumber = pData.getPlayerNumber(i);
			}
		}

// Visability value set functions
		public function gameType(gt:String):void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.gameType(gt);
				pg.updateSumValues();
			}
			updateGaugeMax();
			updateGaugeUI();
		}
		
		public function updateGaugeUI():void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.updateBars();
			}
		}
		
		public function roundNo(rn:Number):void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.roundNo(rn);
				pg.updateSumValues();
			}
			updateGaugeMax();
			updateGaugeUI();
		}
		
		public function playerNo(pnArray:Array):void
		{
			// do nothing for player change
		}
		
		public function shotType(gt:Number):void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.shotType(gt);
				pg.updateSumValues();
			}
			updateGaugeMax();
			updateGaugeUI();
		}
		
		public function timeCurrent(tc:Number):void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.timeCurrent(tc);
				pg.updateSumValues();
			}
			updateGaugeMax();
			updateGaugeUI();
		}
		
		public function setImmediate(im:Boolean):void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.setImmediate(im);
			}
		}
		
		// special callbacks
		public function setPlayerNo():void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				var pg:BarGauge = pgArray[i] as BarGauge;
				pg.playerNumber = pData.getPlayerNumber(i);
			}
		}
		
		public function updateShotData(c:Controls):void
		{
			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
			{
				// read goal data
				var pg:BarGauge = pgArray[i] as BarGauge;
				
				// Set here
				pData.setNumGoals(i, pg.getGoals());
				pData.setNumShotsOnGoal(i, pg.getShotsOnGoal());
				pData.setNumShots(i, pg.getShots());
			}
		}
	}
}