package {
	import cs448b.as3.data.DataLoader;
	import cs448b.as3.data.MatchData;
	import cs448b.as3.data.PlayerData;
	import cs448b.as3.ui.BarChart;
	import cs448b.as3.ui.BarGauge;
	import cs448b.as3.ui.BarList;
	import cs448b.as3.ui.Controls;
	import cs448b.as3.ui.SoccerField;

	import flash.system.Security;
	
	import flare.vis.data.Data;
	
	import flash.display.Sprite;
	import flash.events.Event;

	// Convenient way to pass in compiler arguments
	// Place after import statements and before first class declaration 
	[SWF(width='1024', height='768', backgroundColor='#ffffff', frameRate='30')]
	
	public class DynamicSoccer extends Sprite //implements ControlListener
	{
//		private var data:Data;
		
		private var dataLoader:DataLoader;		
		private var soccerField:SoccerField;
		private var barChart:BarChart;
		private var barList:BarList;
//		private var pgArray:Array;

		private var controls:Controls;
		private var pData:PlayerData;
		private var mData:MatchData;
		/**
		 * Constructor
		 */
		public function DynamicSoccer()
		{	
			Security.loadPolicyFile("http://www.stanford.edu/~juhokim/dynamicsoccer/crossdomain.xml");
			loadData();			
			initComponents();
			buildSprite();
		}

		/**
		 * Initializes components
		 */
		public function loadData():void
		{
			dataLoader = new DataLoader();
			dataLoader.addLoadEventListener(handleLoaded); 
			dataLoader.addPlayerLoadListener(handlePlayerLoaded);
			dataLoader.addMatchLoadListener(handleMatchLoaded);
			dataLoader.loadData();
		}
				
		/**
		 * Initializes components
		 */
		public function initComponents():void
		{
			soccerField = new SoccerField();
			barChart = new BarChart();
			barList = new BarList();
			
//			initGauges();			
			
			controls = new Controls();
			
//			controls.addControlListener(this);
			controls.addControlListener(soccerField);
			controls.addControlListener(barChart);
			controls.addControlListener(barList);
			controls.setLuFunc(barList.setPlayerNo);
			controls.setGuFunc(barList.updateShotData);
			
//			addGaugeListeners();
			
			pData = new PlayerData();
			mData = new MatchData();
		}
		
		/**
		 * Builds sprite
		 */
		public function buildSprite():void
		{
			soccerField.x = 50;
			soccerField.y = 50;
			soccerField.scaleX = 1.5;
			soccerField.scaleY = 1.5;
			addChild(soccerField);
			
			addChild(controls);
			
			barChart.x = 100;
			barChart.y = 560;
			addChild(barChart);
			
			barList.x = 970;
			barList.y = 110;
			addChild(barList);
			
//			addGaugesAsChild();
		}

		/**
		 * Handles the loaded event
		 */
		public function handleLoaded( evt:Event ):void
		{
			barChart.registerData(dataLoader.dataSet);
			soccerField.registerData(dataLoader.dataSet);
			barList.registerData(dataLoader.dataSet);
			
//			registerDataGauges();

//			barChart.registerData(dataLoader.data2);
//			soccerField.registerData(dataLoader.data);
//			playerGauge.registerData(dataLoader.data2);
//			controls.registerData(dataLoader.playerData);
		}
		
		/**
		 * Handles the player data loaded event
		 */
		public function handlePlayerLoaded( evt:Event ):void
		{
			pData.registerData(dataLoader.playerData);
			controls.updatePlayerData(pData);
			soccerField.updatePlayerData(pData);
			barList.updatePlayerData(pData);
			
//			setPlayerNo();
		}
		/**
		 * Handles the match data loaded event
		 */
		public function handleMatchLoaded( evt:Event ):void
		{
			mData.registerData(dataLoader.matchData);
			controls.updateMatchData(mData);
		}	
		
//		public function initGauges():void
//		{
//			pgArray = new Array();
//			
//			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
//			{
//				pgArray.push(new BarGauge());
//			}
//		}
		
//		public function addGaugeListeners():void
//		{
//			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
//			{
//				var pg:BarGauge = pgArray[i] as BarGauge;
//				if(pg != null) controls.addControlListener(pg);
//			}
//		}
		
//		public function addGaugesAsChild():void
//		{
//			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
//			{
//				var pg:BarGauge = pgArray[i] as BarGauge;
//				
//				pg.x = 970;
//				pg.y = 110 + 20*i;
//				addChild(pg);
//			}
//		}
		
//		public function registerDataGauges():void
//		{
//			data = Data.fromDataSet(dataLoader.dataSet);
//			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
//			{
//				var pg:BarGauge = pgArray[i] as BarGauge;
//				
//				pg.registerData(data);
//			}
//		}
		
//		public function setPlayerNo():void
//		{
//			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
//			{
//				var pg:BarGauge = pgArray[i] as BarGauge;
//				pg.playerNumber = pData.getPlayerNumber(i);
//			}
//		}
		
//		public function updateShotData(c:Controls):void
//		{
//			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
//			{
//				// read goal data
//				var pg:BarGauge = pgArray[i] as BarGauge;
//				
//				// Set here
//				pData.setNumGoals(i, pg.getGoals());
//				pData.setNumShotsOnGoal(i, pg.getShotsOnGoal());
//				pData.setNumShots(i, pg.getShots());
//			}
//		}
		
		
//		public function updateGaugeMax():void
//		{
//			var max:Number = 0;
//			// find max
//			for(var i:Number = 0; i < PlayerData.totalPlayers; i++)
//			{
//				var pg:BarGauge = pgArray[i] as BarGauge;
//				if(max < pg.getCurrentData()) max = pg.getCurrentData();
//			}
//			
//			// set max
//			for(var ii:Number = 0; ii < PlayerData.totalPlayers; ii++)
//			{
//				var bg:BarGauge = pgArray[ii] as BarGauge;
//				bg.setMaxValue(max);
//			}
//		}
		
//		// Visability value set functions
//		public function gameType(gt:String):void
//		{
//			updateGaugeMax();
//		}
//		
//		public function roundNo(rn:Number):void
//		{
//			updateGaugeMax();
//		}
//		
//		public function playerNo(pnArray:Array):void
//		{
//			// do nothing for player change
//		}
//		
//		public function shotType(gt:Number):void
//		{
//			updateGaugeMax();
//		}
//		
//		public function timeCurrent(tc:Number):void
//		{
//			updateGaugeMax();
//		}
//		
//		public function setImmediate(im:Boolean):void
//		{
//		}
	}
}
