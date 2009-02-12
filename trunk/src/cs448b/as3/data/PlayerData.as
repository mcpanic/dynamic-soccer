package cs448b.as3.data
{
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;		
	public class PlayerData
	{
//		private var numberList:Array;
////		var numberList:Array = new Array(1,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,21,22,24,25,27,29,31,32,33,38);
//		private var firstNameList:Array;
//		private var lastNameList:Array;
		private var playerArray:Array;
		public static var totalPlayers:Number = 27;
			
		public function PlayerData()
		{
			playerArray = null;
//			numberList = null;
//			firstNameList = null;
//			lastNameList = null;
		}
		public function registerData(d:Data):void
		{
			playerArray = new Array();
//			numberList = new Array();
//			firstNameList = new Array();
//			lastNameList = new Array();
			d.visit(getPlayerData);
		}   
		private function getPlayerData(d:DataSprite):void
		{
//			numberList.push(d.data.Number);
//			firstNameList.push(d.data.FirstName);
//			lastNameList.push(d.data.LastName);
//			matchArray.push(new Match(d.data.Round, d.data.Home, d.data.Opponent, d.data.ScoreHome, d.data.ScoreAway));
			// Shot statistics are not included
			// It has to be filled with Goal data
			
			playerArray.push(new Player(d.data.Number, d.data.FirstName, d.data.LastName, d.data.Position, 0, 0, 0));		
			trace (playerArray.position);
			//return false;
		}					
		public function getPlayerNumber(no:Number):Number
		{
			if(playerArray != null) return playerArray[no].number;
			else return 0;
		}			
        public function getFirstName(no:Number):String
        {
        	if(playerArray != null) return playerArray[no].firstName;
			else return "-";
        }
        public function getLastName(no:Number):String
        {
        	if(playerArray != null) return playerArray[no].lastName;
			else return "-";
        }   
        public function getPosition(no:Number):String
        {
        	if(playerArray != null) return playerArray[no].position;
			else return "-";
        } 
        public function getNumGoals(no:Number):Number
        {
        	if(playerArray != null) return playerArray[no].numGoals;
			else return 0;
        } 
        public function getNumShotsOnGoal(no:Number):Number
        {
        	if(playerArray != null) return playerArray[no].numShotsOnGoal;
			else return 0;
        }
        public function getNumShots(no:Number):Number
        {
        	if(playerArray != null) return playerArray[no].numShots;
			else return 0;
        }
        public function getIndexWithNumber(no:Number):Number
		{
			for(var i:uint=0; i<totalPlayers; i++)	
			{
				if (playerArray[i].number == no)
					return i;
			}
			return -1;
		}		
     	public function getLastNameWithNumber(no:Number):String
     	{
     		var index:Number = getIndexWithNumber(no);
     		if (index == -1)
     			return "-";
        	if(playerArray != null) 
        		return playerArray[index].lastName;
			else return "-";     		
     	}
     	public function getFirstNameWithNumber(no:Number):String
     	{
     		var index:Number = getIndexWithNumber(no);
     		if (index == -1)
     			return "-";
        	if(playerArray != null) 
        		return playerArray[index].firstName;
			else return "-";  	
     	}     	
     	public function getPositionWithNumber(no:Number):String
     	{
     		var index:Number = getIndexWithNumber(no);
     		if (index == -1)
     			return "-";
        	if(playerArray != null) 
        		return playerArray[index].position;
			else return "-";  	
     	}     	     	
     	public function sortWithNumber():void
     	{
     		playerArray.sort(sortOnNumber);  	     		
     	}          	
     	public function sortWithName():void
     	{
     		//trace(lastNameList);
     		playerArray.sort(sortOnLastName);     		
     		//trace(lastNameList);
     	}          	
     	public function sortWithPosition():void
     	{
     		 playerArray.sort(sortOnPosition);     		
     	}        
     	public function sortWithGoals():void
     	{
     		 playerArray.sort(sortOnGoals);     		
     	}     
     	public function sortWithShotsOnGoal():void
     	{
     		 playerArray.sort(sortOnShotsOnGoal);     		
     	}
     	public function sortWithShots():void
     	{
     		 playerArray.sort(sortOnShots);     		
     	}      
     	
     	// internal sort functions
     	private function sortOnNumber(p1:Player, p2:Player):Number
     	{
		    var a:Number = p1.number;
		    var b:Number = p2.number;
			return _compareNumber(a, b);
     	}     	    	
     	private function sortOnLastName(p1:Player, p2:Player):Number
     	{
		    var a:String = p1.lastName;
		    var b:String = p2.lastName;
			return _compareString(a, b);		
     	}   
     	private function sortOnPosition(p1:Player, p2:Player):Number
     	{
		    var a:String = p1.position;
		    var b:String = p2.position;
			return _compareString(a, b);		
     	}      	
     	private function sortOnGoals(p1:Player, p2:Player):Number
     	{
		    var a:Number = p1.numGoals;
		    var b:Number = p2.numGoals;
			return _compareNumber(a, b);		
     	}    
     	private function sortOnShotsOnGoal(p1:Player, p2:Player):Number
     	{
		    var a:Number = p1.numShotsOnGoal;
		    var b:Number = p2.numShotsOnGoal;
			return _compareNumber(a, b);		
     	}   
     	private function sortOnShots(p1:Player, p2:Player):Number
     	{
		    var a:Number = p1.numShots;
		    var b:Number = p2.numShots;
			return _compareNumber(a, b);		
     	}  
		// Simple comparators     	
     	private function _compareNumber(a:Number, b:Number):Number
     	{
		    if(a > b) {
		        return 1;
		    } else if(a < b) {
		        return -1;
		    } else  {
		        //a == b
		        return 0;
		    }        		
     	}
     	private function _compareString(a:String, b:String):Number
     	{
		    if(a > b) {
		        return 1;
		    } else if(a < b) {
		        return -1;
		    } else  {
		        //a == b
		        return 0;
		    }        		
     	}         	      	     	     	     	     	      	   	  	
     }
}

class Player
{
	private var _number:Number;
	private var _firstName:String;
	private var _lastName:String;
	private var _position:String;
	private var _numGoals:Number;
	private var _numShotsOnGoal:Number;
	private var _numShots:Number;
	public function Player(number:Number, firstName:String, lastName:String, position:String, numGoals:Number, numShotsOnGoal:Number, numShots:Number)
	{
		_number = number;
		_firstName = firstName;
		_lastName = lastName;
		_position = position;
		_numGoals = numGoals;
		_numShotsOnGoal = numShotsOnGoal;
		_numShots = numShots;
	}
	public function get number():Number
	{
		return _number;
	}		
	public function get firstName():String
	{
		return _firstName;
	}
	public function get lastName():String
	{
		return _lastName;
	}
	public function get position():String
	{
		return _position;
	}
	public function get numGoals():Number
	{
		return _numGoals;
	}		
	public function get numShotsOnGoal():Number
	{
		return _numShotsOnGoal;
	}	
	public function get numShots():Number
	{
		return _numShots;
	}	
	public function set numGoals(no:Number):void
	{
		_numGoals = no;
	}		
	public function set numShotsOnGoal(no:Number):void
	{
		_numShotsOnGoal = no;
	}	
	public function set numShots(no:Number):void
	{
		_numShots = no;
	}		
}