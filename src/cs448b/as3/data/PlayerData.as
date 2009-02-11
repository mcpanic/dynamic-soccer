package cs448b.as3.data
{
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;		
	public class PlayerData
	{
		private var numberList:Array;
//		var numberList:Array = new Array(1,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,21,22,24,25,27,29,31,32,33,38);
		private var firstNameList:Array;
		private var lastNameList:Array;
		public static var totalPlayers:Number = 27;
			
		public function PlayerData()
		{
			numberList = null;
			firstNameList = null;
			lastNameList = null;
		}
		public function registerData(d:Data):void
		{
			numberList = new Array();
			firstNameList = new Array();
			lastNameList = new Array();
			d.visit(getPlayerData);
		}   
		private function getPlayerData(d:DataSprite):void
		{
			numberList.push(d.data.Number);
			firstNameList.push(d.data.FirstName);
			lastNameList.push(d.data.LastName);
			
			//return false;
		}					
		public function getPlayerNumber(no:Number):Number
		{
			if(numberList != null) return numberList[no];
			else return 1;
		}			
        public function getFirstName(no:Number):String
        {
        	if(firstNameList != null) return firstNameList[no];
			else return "-";
        }
        public function getLastName(no:Number):String
        {
        	if(lastNameList != null) return lastNameList[no];
			else return "-";
        }   
		public function getIndexWithNumber(no:Number):Number
		{
			for(var i:uint=0; i<totalPlayers; i++)	
			{
				if (numberList[i] == no)
					return i;
			}
			return -1;
		}		
     	public function getLastNameWithNumber(no:Number):String
     	{
     		var index:Number = getIndexWithNumber(no);
     		if (index == -1)
     			return "-";
        	if(lastNameList != null) 
        		return lastNameList[index];
			else return "-";     		
     	}
     	public function getFirstNameWithNumber(no:Number):String
     	{
     		var index:Number = getIndexWithNumber(no);
     		if (index == -1)
     			return "-";     		
        	if(firstNameList != null) 
        		return firstNameList[index];
			else return "-";     		
     	}     	
	}
}