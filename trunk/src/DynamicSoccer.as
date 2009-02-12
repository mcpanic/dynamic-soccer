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
		private var dataLoader:DataLoader;		
		private var soccerField:SoccerField;
		private var barChart:BarChart;
		private var barList:BarList;

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
			
			controls = new Controls();
			
			controls.addControlListener(soccerField);
			controls.addControlListener(barChart);
			controls.addControlListener(barList);
			controls.setLuFunc(barList.setPlayerNo);
			controls.setGuFunc(barList.updateShotData);
			
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
			
			barChart.x = 100-4;
			barChart.y = 560;
			addChild(barChart);
			
			barList.x = 970;
			barList.y = 110;
			addChild(barList);
			
		}

		/**
		 * Handles the loaded event
		 */
		public function handleLoaded( evt:Event ):void
		{
			barChart.registerData(dataLoader.dataSet);
			soccerField.registerData(dataLoader.dataSet);
			barList.registerData(dataLoader.dataSet);
			
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
		}
		/**
		 * Handles the match data loaded event
		 */
		public function handleMatchLoaded( evt:Event ):void
		{
			mData.registerData(dataLoader.matchData);
			controls.updateMatchData(mData);
		}	
	}
}
