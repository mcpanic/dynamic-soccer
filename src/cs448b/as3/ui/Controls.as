package cs448b.as3.ui
{
	import flare.display.TextSprite;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	
	public class Controls extends Sprite
	{
		public function Controls()
		{
			addSeason();
			addTeam();
			addPlayer();
			addGame();
			addShotType();
			addPlaybackSpeed();
			addTimeSlider();
			layout();
		}
		
		private var _seasonText:String =	"2007/08";
		private var _season:TextSprite;
		private var _teamText:String =	"Manchester United";
		private var _team:TextSprite;		
		private var _fmt:TextFormat = new TextFormat("Helvetica,Arial",16,0,true);

		public function addSeason():void
		{		
			_season = new TextSprite("", _fmt, TextSprite.DEVICE);
			_season.htmlText = _seasonText;
			_season.textField.selectable = false;
			this.addChild(_season);			

		}
		private function addTeam():void
		{
			_team = new TextSprite("", _fmt, TextSprite.DEVICE);
			_team.htmlText = _teamText;
			_team.textField.selectable = false;
			this.addChild(_team);				
		}
		private function addPlayer():void
		{
		}
		private function addGame():void
		{
		}
		private function addShotType():void
		{
		}
		private function addPlaybackSpeed():void
		{
		}
		private function addTimeSlider():void
		{
		}	
		public function layout():void
		{
			if (_season) {
				_season.x = 10;
				_season.y = 30; //_bounds.top - _title.height - 45;
			}			
			if (_team) {
				_team.x = 100;
				_team.y = 30; //_bounds.top - _title.height - 45;
			}			
		}		
	}
}