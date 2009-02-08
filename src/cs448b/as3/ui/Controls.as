package cs448b.as3.ui
{
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	
	import flare.display.TextSprite;
	import flare.util.Orientation;
	import flare.vis.controls.ClickControl;
	import flare.vis.controls.HoverControl;
	import flare.vis.events.SelectionEvent;
	import flare.vis.legend.Legend;
	import flare.vis.legend.LegendItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;

	
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
		
		import fl.controls.TileList;
		import fl.controls.ScrollPolicy;
		import fl.data.DataProvider;
		
		public var playerNo:Function;
		private var _playerArray:Array = null;
    	private var _playerSelect:TileList;
    	
    	private function addPlayer():void
		{
			var i:uint;
			var totalRows:uint = 27;
			var dp:DataProvider = new DataProvider();
			dp.addItem({number:"A", firstname:"B", lastname:"C"});
			dp.addItem({Number:"hi", FirstName:getFirstName(1), LastName:getLastName(1)});
			dp.addItem({Number:3, FirstName:getFirstName(3), LastName:getLastName(3)});
			dp.addItem({Number:4, FirstName:getFirstName(4), LastName:getLastName(4)});
			dp.addItem({Number:5, FirstName:getFirstName(5), LastName:getLastName(5)});
			dp.addItem({Number:6, FirstName:getFirstName(6), LastName:getLastName(6)});
			dp.addItem({Number:7, FirstName:getFirstName(7), LastName:getLastName(7)});
			dp.addItem({Number:8, FirstName:getFirstName(8), LastName:getLastName(8)});
			dp.addItem({Number:9, FirstName:getFirstName(9), LastName:getLastName(9)});
			dp.addItem({Number:10, FirstName:getFirstName(10), LastName:getLastName(10)});
			dp.addItem({Number:11, FirstName:getFirstName(11), LastName:getLastName(11)});
			dp.addItem({Number:12, FirstName:getFirstName(12), LastName:getLastName(12)});
			dp.addItem({Number:13, FirstName:getFirstName(13), LastName:getLastName(13)});
			dp.addItem({Number:15, FirstName:getFirstName(15), LastName:getLastName(15)});
			dp.addItem({Number:16, FirstName:getFirstName(16), LastName:getLastName(16)});
			dp.addItem({Number:17, FirstName:getFirstName(17), LastName:getLastName(17)});
			dp.addItem({Number:18, FirstName:getFirstName(18), LastName:getLastName(18)});
			dp.addItem({Number:19, FirstName:getFirstName(19), LastName:getLastName(19)});
			dp.addItem({Number:21, FirstName:getFirstName(21), LastName:getLastName(21)});
			dp.addItem({Number:22, FirstName:getFirstName(22), LastName:getLastName(22)});
			dp.addItem({Number:24, FirstName:getFirstName(24), LastName:getLastName(24)});
			dp.addItem({Number:25, FirstName:getFirstName(25), LastName:getLastName(25)});
			dp.addItem({Number:27, FirstName:getFirstName(27), LastName:getLastName(27)});
			dp.addItem({Number:29, FirstName:getFirstName(29), LastName:getLastName(29)});
			dp.addItem({Number:31, FirstName:getFirstName(31), LastName:getLastName(31)});
			dp.addItem({Number:32, FirstName:getFirstName(32), LastName:getLastName(32)});
			dp.addItem({Number:33, FirstName:getFirstName(33), LastName:getLastName(33)});
			dp.addItem({Number:38, FirstName:getFirstName(38), LastName:getLastName(38)});			
			_playerSelect = new TileList();	
			_playerSelect.dataProvider = dp;
			_playerSelect.allowMultipleSelection = true;
			_playerSelect.scrollPolicy = ScrollPolicy.OFF;
			_playerSelect.columnWidth = 50;
			_playerSelect.rowHeight = 20;
			//_playerSelect.columnCount = 3;
			//_playerSelect.rowCount = totalRows;
			_playerSelect.move(800, 10);

			_playerSelect.addEventListener(Event.CHANGE, playerHandler);
			
			this.addChild(_playerSelect);
		}
        private function getFirstName(no:Number):String
        {
        	return "Juho";
        }
        private function getLastName(no:Number):String
        {
        	return "Kim";
        }        
        private function playerHandler( event:Event ):void
        {
			playerNo(_playerArray);
        }
        
    	import fl.controls.ComboBox;
		import fl.events.ComponentEvent;
		
		private var _gameType:Legend;
		private var _gameFilter:String = "All";
		public var gameType:Function;
		public var roundNo:Function;
    	private var _roundSelect:ComboBox;
		
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
			
			
            //var dp:DataProvider = new DataProvider();
            var totalEntries:uint = 38;
            var i:uint;
     
			_roundSelect = new ComboBox();
			_roundSelect.prompt = "Select a round:";
            for(i=1; i<=totalEntries; i++) {
                _roundSelect.addItem({label:"Round " + i});           
            }			
			_roundSelect.move(650, 130);
			_roundSelect.addEventListener(Event.CHANGE, roundHandler);
			this.addChild(_roundSelect);				
		}
		
        private function roundHandler( event:Event ):void
        {
			roundNo(_roundSelect.selectedIndex+1);
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
		
		public var shotType:Function;
		
		private function addShotType():void
		{
			_shotSlider = new Slider();
            _shotSlider.value = 2;			
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
//		private var _roundSelect:ComboBox;
		
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
			shotType(sliderEvent.value);
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
	            _gameType.y = y;
			}	
			if (_roundSelect) {
				_roundSelect.move(x+100, y+30);
					
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