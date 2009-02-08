package {
	import cs448b.as3.data.DataLoader;
	import cs448b.as3.ui.Controls;
	import cs448b.as3.ui.SoccerField;
	
	import flash.display.Sprite;
	import flash.events.Event;

	// Convenient way to pass in compiler arguments
	// Place after import statements and before first class declaration 
	[SWF(width='800', height='600', backgroundColor='#aaaaaa', frameRate='30')]
	
	public class DynamicSoccer extends Sprite
	{
		private var soccerField:SoccerField;
		private var dataLoader:DataLoader;
		private var controls:Controls; 
		/**
		 * Constructor
		 */
		public function DynamicSoccer()
		{	
			loadData();
			// Init sprite
			var rect:Sprite = new Sprite();
			
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
			controls = new Controls();
		}
		
		/**
		 * Builds sprite
		 */
		public function buildSprite():void
		{
			soccerField.x = 100;
			soccerField.y = 50;
			this.addChild(soccerField);
			this.addChild(controls);
		}

		/**
		 * Handles the loaded event
		 */
		public function handleLoaded( evt:Event ):void
		{
			soccerField.drawPoints(dataLoader.getData());
		}
	}
}
