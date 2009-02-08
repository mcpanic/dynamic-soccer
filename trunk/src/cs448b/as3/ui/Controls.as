package cs448b.as3.ui
{
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	
	import flare.display.TextSprite;
	
	import flash.display.Sprite;
	import flash.text.TextFormat;

//	import flare.vis.operator.filter.VisibilityFilter;
//	import flash.filters.DropShadowFilter;
	import flare.vis.events.SelectionEvent;
//	import flare.vis.events.TooltipEvent;
	import flare.vis.legend.Legend;
	import flare.vis.legend.LegendItem;
	import flare.util.Orientation;
	import flare.vis.controls.ClickControl;
	import flare.vis.controls.HoverControl;

	
	import flash.events.Event;

	
	public class Controls extends Sprite
	{
		private var _seasonText:String =	"2007/08";
		private var _season:TextSprite;
		private var _teamText:String =	"Manchester United";
		private var _team:TextSprite;		
		private var _titleFormat:TextFormat;
		private var _sectionFormat:TextFormat;
		private var _textFormat:TextFormat;


		public function Controls()
		{
			_titleFormat = new TextFormat("Verdana,Tahoma,Arial",16,0,true);
			_sectionFormat = new TextFormat("Verdana,Tahoma,Arial",12,0,true);
			_textFormat = new TextFormat("Verdana,Tahoma,Arial",10,0,false);

			addSeason();
			addTeam();
			addPlayer();
			addGame();
			addShotType();
			addPlaybackSpeed();
			addTime();
			layout();
		}
		
		public function addSeason():void
		{		
			_season = new TextSprite("", _titleFormat, TextSprite.DEVICE);
			_season.htmlText = _seasonText;
			_season.textField.selectable = false;
			this.addChild(_season);			

		}
		private function addTeam():void
		{
			_team = new TextSprite("", _titleFormat, TextSprite.DEVICE);
			_team.htmlText = _teamText;
			_team.textField.selectable = false;
			this.addChild(_team);				
		}
		private function addPlayer():void
		{
		}


		private var _gameType:Legend;
		private var _gameFilter:String = "All";
		public var gameType:Function;
		
		private function addGame():void
		{
			// create gender filter
			_gameType = Legend.fromValues(null, [
				{label:"All",    color:0xff888888},
				{label:"Home",   color:0xff8888ff},
				{label:"Away", color:0xff88ff88},
				{label:"Single", color:0xffff8888}
			]);
			_gameType.orientation = Orientation.LEFT_TO_RIGHT;
			_gameType.labelTextFormat = _sectionFormat;
			_gameType.margin = 3;
			_gameType.setItemProperties({buttonMode:true, alpha:0.3});
			_gameType.items.getChildAt(0).alpha = 1;
			_gameType.update();
			addChild(_gameType);
			
			// change alpha value on legend mouse-over
			new HoverControl(LegendItem, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:LegendItem = LegendItem(e.object);
					if (li.text != _gameFilter) li.alpha = 0.3;
				}
			).attach(_gameType);
			
			// filter by gender on legend click
			new ClickControl(LegendItem, 1, function(e:SelectionEvent):void {
				_gameType.setItemProperties({alpha:0.3});
				e.object.alpha = 1;
				//_gameFilter = LegendItem(e.object).text;
				gameType(LegendItem(e.object).text);
			}).attach(_gameType);
			
		}

		/** Callback for filter events. */
		private function onFilter(evt:Event=null):void
		{
//			_query = _search.query.toLowerCase().split(/\|/);
//			if (_query.length==1 && _query[0].length==0) _query.pop();
//			
//			if (_t && _t.running) _t.stop();
//			_t = _vis.update(_dur);
//			_t.play();
//			
//			_exact = false; // reset exact match after each search
		}


		private var _shotSlider:Slider;
		private var _shotTitleText:TextSprite;
		private var _shotText:TextSprite;

		private function addShotType():void
		{
			_shotSlider = new Slider();
            _shotSlider.addEventListener( SliderEvent.CHANGE, showShotTypeValue );
            this.addChild( _shotSlider );

            _shotTitleText = new TextSprite("", _sectionFormat);
            _shotTitleText.text = "Shot Type";
            this.addChild( _shotTitleText );
            
            _shotText = new TextSprite("", _textFormat);
            _shotText.horizontalAnchor = TextSprite.CENTER;
            _shotText.text = "Goals           Shots on Goal           Shots";
            this.addChild( _shotText );			
		}
		
		private var _speedSlider:Slider;
		private var _speedTitleText:TextSprite;
		private var _speedText:TextSprite;
				
		private function addPlaybackSpeed():void
		{
			_speedSlider = new Slider();
            _speedSlider.addEventListener( SliderEvent.CHANGE, showSpeedValue );
            this.addChild( _speedSlider );

            _speedTitleText = new TextSprite("", _sectionFormat);
            _speedTitleText.text = "Playback Speed";
            this.addChild( _speedTitleText );	
            
            _speedText = new TextSprite("", _textFormat);
            _speedText.horizontalAnchor = TextSprite.CENTER;
            _speedText.text = "Slowest   Slow    Normal    Fast    Fastest";
            this.addChild( _speedText );			
		}

		private var _timeSlider:Slider;
		private var _timeTitleText:TextSprite;
		private var _timeText:TextSprite;
		
		private function addTime():void
		{
			_timeSlider = new Slider();
            _timeSlider.addEventListener( SliderEvent.CHANGE, showTimeValue );
            this.addChild( _timeSlider );

            _timeTitleText = new TextSprite("", _sectionFormat);
            _timeTitleText.text = "Game Time (minutes)";
            this.addChild( _timeTitleText );	
            
            _timeText = new TextSprite("", _textFormat);
            _timeText.horizontalAnchor = TextSprite.CENTER;
            _timeText.text = "0                  15                  30                  45                  60                  75                  90";
            this.addChild( _timeText );				
		}	
		
        private function showShotTypeValue( sliderEvent:SliderEvent ):void
        {
        	// Filtering task to come here...
        	
            //_shotText.htmlText = "Slider = " + sliderEvent.value.toString();
        }
        private function showSpeedValue( sliderEvent:SliderEvent ):void
        {
            //_speedText.htmlText = "Slider = " + sliderEvent.value.toString();
        }
        private function showTimeValue( sliderEvent:SliderEvent ):void
        {
            //_timeText.htmlText = "Slider = " + sliderEvent.value.toString();
        }        
		
		public function layout():void
		{
			if (_season) {
				_season.x = 10;
				_season.y = 10; //_bounds.top - _title.height - 45;
			}			
			if (_team) {
				_team.x = 100;
				_team.y = 10; //_bounds.top - _title.height - 45;
			}	
			var x:Number = 550;
			var y:Number = 100;
			if (_gameType) {
	            _gameType.x = x;
	            _gameType.y = y+30;
			}	
			
			y = 200;	
			if (_shotSlider) {
				_shotSlider.x = x;
				_shotSlider.y = y;
				_shotSlider.setSize(200, 30);
				// 0: Goals, 1: Shots on goals, 2: Shots
				_shotSlider.minimum = 0;
				_shotSlider.maximum = 2;
			}
			if (_shotTitleText) {
	            _shotTitleText.x = x;
	            _shotTitleText.y = y-30;
			}			
			if (_shotText) {
	            _shotText.x = x+100;
	            _shotText.y = y+30;
			}
	
			y = 300;
			if (_speedSlider) {
				_speedSlider.x = x;
				_speedSlider.y = y;
				_speedSlider.setSize(200, 30);
				// 0: Slowest, 1: Slow, 2: Normal, 3: Fast, 4: Fastest
				_speedSlider.minimum = 0;
				_speedSlider.maximum = 4;
			}
			if (_speedTitleText) {
	            _speedTitleText.x = x;
	            _speedTitleText.y = y-30;
			}				
			if (_speedText) {
	            _speedText.x = x+100;
	            _speedText.y = y+30;
			}	
			
			x = 100;
			y = 400;	
			if (_timeSlider) {
				_timeSlider.x = x;
				_timeSlider.y = y;
				_timeSlider.setSize(500, 30);
				// 0: Slowest, 1: Slow, 2: Normal, 3: Fast, 4: Fastest
				_timeSlider.minimum = 0;
				_timeSlider.maximum = 90;
			}
			if (_timeTitleText) {
	            _timeTitleText.x = x;
	            _timeTitleText.y = y-30;
			}				
			if (_timeText) {
	            _timeText.x = x+250;
	            _timeText.y = y+30;
			}					
		}		
	}
}