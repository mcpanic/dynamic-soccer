package {
	import cs448b.as3.data.DataLoader;
	import cs448b.as3.ui.SoccerField;
	
	import flash.display.Sprite;

	// Convenient way to pass in compiler arguments
	// Place after import statements and before first class declaration 
	[SWF(width='800', height='600', backgroundColor='#aaaaaa', frameRate='30')]
	public class DynamicSoccer extends Sprite
	{
       
		private var soccerField:SoccerField;
		private var dataLoader:DataLoader;
		 
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
			 //dataLoader.loadData();
		}
				
		/**
		 * Initializes components
		 */
		public function initComponents():void
		{
			 soccerField = new SoccerField();
		}
		
		/**
		 * Builds sprite
		 */
		public function buildSprite():void
		{
			this.addChild(soccerField);
		}

	}
}
