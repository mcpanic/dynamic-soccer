package {
	import cs448b.as3.data.DataLoader;
	import cs448b.as3.ui.BarChart;
	import cs448b.as3.ui.Controls;
	import cs448b.as3.ui.SoccerField;
	
	import flash.display.Sprite;
	import flash.events.Event;

	// Convenient way to pass in compiler arguments
	// Place after import statements and before first class declaration 
	[SWF(width='1024', height='768', backgroundColor='#aaaaaa', frameRate='30')]
	
	public class DynamicSoccer extends Sprite
	{
		private var dataLoader:DataLoader;
		
		private var soccerField:SoccerField;
		private var barChart:BarChart
		private var controls:Controls;
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
			
			// register callbacks
			controls.gameType = soccerField.gameType;
			controls.shotType = soccerField.shotType;
			controls.roundNo = soccerField.roundNo;
			controls.playerNo = soccerField.playerNo;
			controls.timeCurrent = soccerField.timeCurrent;
		}
		
		/**
		 * Builds sprite
		 */
		public function buildSprite():void
		{
			soccerField.x = 100;
			soccerField.y = 50;
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
		}
	}
}
