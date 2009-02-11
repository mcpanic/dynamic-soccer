package {
	import cs448b.as3.data.DataLoader;
	import cs448b.as3.data.MatchData;
	import cs448b.as3.data.PlayerData;
	import cs448b.as3.ui.BarChart;
	import cs448b.as3.ui.Controls;
	import cs448b.as3.ui.SoccerField;
	
	import flash.display.Sprite;
	import flash.events.Event;

	// Convenient way to pass in compiler arguments
	// Place after import statements and before first class declaration 
	[SWF(width='1024', height='768', backgroundColor='#ffffff', frameRate='30')]
	
	public class DynamicSoccer extends Sprite
	{
		private var dataLoader:DataLoader;		
		private var soccerField:SoccerField;
		private var barChart:BarChart
		private var controls:Controls;
		private var pData:PlayerData;
		private var mData:MatchData;
		/**
		 * Constructor
		 */
		public function DynamicSoccer()
		{	
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
			controls = new Controls();
			controls.addControlListener(soccerField);
			controls.addControlListener(barChart);
			
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
			barChart.y = 450;
			addChild(barChart);
		}

		/**
		 * Handles the loaded event
		 */
		public function handleLoaded( evt:Event ):void
		{
			barChart.registerData(dataLoader.data2);
			soccerField.registerData(dataLoader.data);
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
