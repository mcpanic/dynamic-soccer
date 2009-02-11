package cs448b.as3.data
{
	import flare.data.DataSet;
	import flare.data.DataSource;
	import flare.vis.data.Data;
	
	import flash.events.Event;
	import flash.net.URLLoader;
			
	public class DataLoader// extends Sprite
	{		
		private var dataAddress:String;
		private var _dataSet:DataSet;
//		private var _data:Data;
//		private var _data2:Data;
		
		private var matchAddress:String;
		private var _matchData:Data;
		
		private var playerAddress:String;
		private var _playerData:Data

		private var cb:Function = null;
		private var pcb:Function = null;
		private var mcb:Function = null;
		
		/**
		 * Constructor
		 */
		public function DataLoader()
		{
			dataAddress = "http://www.stanford.edu/~juhokim/dynamicsoccer/goal.txt";
			playerAddress = "http://www.stanford.edu/~juhokim/dynamicsoccer/player.txt";
			matchAddress = "http://www.stanford.edu/~juhokim/dynamicsoccer/match.txt";
		}
		
		/**
		 * Returns the data set.
		 */
		public function get dataSet():DataSet
		{
			return _dataSet;
		}
		
//		/**
//		 * Returns the goal data.
//		 */
//		public function get data():Data
//		{
//			return _data;
//		}
//		
//		/**
//		 * Returns the goal data.
//		 */
//		public function get data2():Data
//		{
//			return _data2;
//		}
		
		/**
		 * Returns the player data.
		 */
		public function get playerData():Data
		{
			return _playerData;
		}
		
		/**
		 * Returns the match data.
		 */
		public function get matchData():Data
		{
			return _matchData;
		}
		
		/**
		 * Loads the data.
		 */
        public function loadData():void
        {		            
            // Load the dataset asynchronuously
			var loader:URLLoader = new DataSource( dataAddress, "tab" ).load();
            
            // Create an event listen to process the data
            loader.addEventListener( Event.COMPLETE, 
            	function( evt:Event ):void
            	{
	                _dataSet = loader.data as DataSet;
	                
	                // Use default function to import data
//	                _data = Data.fromDataSet( dataSet );
//	                _data2 = Data.fromDataSet( dataSet );
           
					//testData();
					
					if(cb != null) cb( evt );
            	}
            );
            
            // load player data
            var pl:URLLoader = new DataSource(playerAddress, "tab").load();
            pl.addEventListener( Event.COMPLETE, 
            	function( evt:Event ):void
            	{
	                var dataSet:DataSet = pl.data as DataSet;
	                
	                // Use default function to import data
	                _playerData = Data.fromDataSet( dataSet );
	                
	                if(pcb != null) pcb( evt );
            	}
            );
            
            // load match data
            var ml:URLLoader = new DataSource(matchAddress, "tab").load();
            ml.addEventListener( Event.COMPLETE, 
            	function( evt:Event ):void
            	{
	                var dataSet:DataSet = ml.data as DataSet;
	                
	                // Use default function to import data
	                _matchData = Data.fromDataSet( dataSet );
	                
	                if(mcb != null) mcb( evt );
            	}
            );
        }
        
        /**
         * Adds a load event listener 
         */
        public function addLoadEventListener(callback:Function):void
        {
        	cb = callback;
        }
        
        /**
         * Removes a load event listener 
         */
        public function removeLoadEventListener():void
        {
        	cb = null;
        }
        
        /**
         * Adds a load event listener 
         */
        public function addPlayerLoadListener(callback:Function):void
        {
        	pcb = callback;
        }
        
        /**
         * Adds a load event listener 
         */
        public function addMatchLoadListener(callback:Function):void
        {
        	mcb = callback;
        }
	}
}