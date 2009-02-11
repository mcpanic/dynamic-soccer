package cs448b.as3.data
{
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;			
	public class MatchData
	{
		private var matchArray:Array;
		
		public static var totalRounds:Number = 38;
		
		public function MatchData()
		{
			matchArray = null;
		}
		public function registerData(d:Data):void
		{
			matchArray = new Array();
			d.visit(getMatchData);
		}   
		private function getMatchData(d:DataSprite):void
		{
			matchArray.push(new Match(d.data.Round, d.data.Home, d.data.Opponent, d.data.ScoreHome, d.data.ScoreAway));
		}			
		public function isHome(index:Number):Boolean
		{

			if (matchArray[index].home == "y")
				return true;
			else
				return false;
		}
		public function getOpponent(index:Number):String
		{
			return matchArray[index].opponent;
		}
		public function getScore(index:Number):String
		{
			var scoreString:String = "";
			if (isHome(index))
				scoreString = matchArray[index].scoreHome + ":" + matchArray[index].scoreAway; 
			else
				scoreString = matchArray[index].scoreAway + ":" + matchArray[index].scoreHome; 
			return scoreString;
		}
		public function getResult(index:Number):String
		{
			var resultString:String = "";
			if (isHome(index))
			{
				if (matchArray[index].scoreHome > matchArray[index].scoreAway)
					resultString = "win";
				else if (matchArray[index].scoreHome < matchArray[index].scoreAway)
					resultString = "lose";
				else
					resultString = "draw";					
			}
			else
			{
				if (matchArray[index].scoreHome < matchArray[index].scoreAway)
					resultString = "win";
				else if (matchArray[index].scoreHome > matchArray[index].scoreAway)
					resultString = "lose";
				else
					resultString = "draw";						
			}
			
			return resultString;
		}
	}

}

	
	class Match
	{
		private var _round:Number;
		private var _home:String;
		private var _opponent:String;
		private var _scoreHome:Number;
		private var _scoreAway:Number;
		public function Match(roundArg:Number, homeArg:String, opponentArg:String, scoreHomeArg:Number, scoreAwayArg:Number)
		{
			_round = roundArg;
			_home = homeArg;
			_opponent = opponentArg;
			_scoreHome = scoreHomeArg;
			_scoreAway = scoreAwayArg;	
		}
		public function get round():Number
		{
			return _round;
		}		
		public function get home():String
		{
			return _home;
		}
		public function get opponent():String
		{
			return _opponent;
		}
		public function get scoreHome():Number
		{
			return _scoreHome;
		}
		public function get scoreAway():Number
		{
			return _scoreAway;
		}		
	}