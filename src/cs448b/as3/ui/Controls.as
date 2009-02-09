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
		private var _homeText:TextSprite;
		private var _awayText:TextSprite;
			
		private var _titleFormat:TextFormat;
		private var _sectionFormat:TextFormat;
		private var _legendFormat:TextFormat;
		private var _textFormat:TextFormat;
		
		private var _controlListener:Array = new Array(2);

		private var totalPlayers:Number = 27;
		
		public function Controls()
		{
			_titleFormat = new TextFormat("Verdana,Tahoma,Arial",16,0,true);
			_sectionFormat = new TextFormat("Verdana,Tahoma,Arial",12,0,true);
			_legendFormat = new TextFormat("Verdana,Tahoma,Arial",11,0,true);
			_textFormat = new TextFormat("Verdana,Tahoma,Arial",10,0,false);

			addSeason();
			addTeam();
			addHomeAway();
			addPlayer();
			addGame();
			addShotType();
			addPlaybackSpeed();
			addTime();
			addPlay();
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
		private function addHomeAway():void
		{
			_homeText = new TextSprite("", _sectionFormat, TextSprite.DEVICE);
			_homeText.htmlText = "Home";
			_homeText.textField.selectable = false;
			this.addChild(_homeText);	
				
			_awayText = new TextSprite("", _sectionFormat, TextSprite.DEVICE);
			_awayText.htmlText = "Away";
			_awayText.textField.selectable = false;
			this.addChild(_awayText);						
		}		

		import fl.events.ListEvent;		
		import fl.controls.CheckBox;
        import flash.events.MouseEvent;
		
//		public var playerNo:Function;
		private var _playerArray:Array;
    	private var _playerSelect:Legend;
        private var _playerBox:Array;
        private var _playerName:Array;
        private var _playerFilter:String = "All";
  		public function addControlListener(cl:ControlListener):void
  		{
  			_controlListener.push(cl);
  		}

    	private function addPlayer():void
		{
			var i:uint;
			
			_playerBox = new Array();
			_playerArray = new Array();	
			_playerName = new Array();		
			for(i=0; i<totalPlayers; i++)
			{
				_playerBox.push(new CheckBox());
				_playerBox[i].label = getPlayerNumber(i);
				_playerBox[i].selected = true;
            	_playerBox[i].addEventListener(MouseEvent.CLICK,playerHandler);
            	addChild(_playerBox[i]);
            	
            	_playerName.push(new TextSprite("", _textFormat, TextSprite.DEVICE));
            	_playerName[i].htmlText = getFirstName(i) + " " + getLastName(i);
            	this.addChild(_playerName[i]);
			}	
			         				
			// create gender filter
			_playerSelect = Legend.fromValues(null, [
				{label:"All",    color:0xff888888},
				{label:"None",   color:0xff8888ff}
			]);
			_playerSelect.orientation = Orientation.LEFT_TO_RIGHT;
			_playerSelect.labelTextFormat = _legendFormat;
			_playerSelect.margin = 3;
			_playerSelect.setItemProperties({buttonMode:true, alpha:0.4});
			//_playerSelect.items.getChildAt(0).alpha = 1;
			_playerSelect.update();
			addChild(_playerSelect);
			
			// change alpha value on legend mouse-over
			new HoverControl(LegendItem, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:LegendItem = LegendItem(e.object);
					li.alpha = 0.4;
				}
			).attach(_playerSelect);
			
			// filter by player on legend click
			new ClickControl(LegendItem, 1, function(e:SelectionEvent):void {
				_playerSelect.setItemProperties({alpha:0.4});
				//e.object.alpha = 1;
				//reinitialize the array to cancel all existing selections
				_playerArray = null;
				_playerArray = new Array();
				if (LegendItem(e.object).text == "All")
				{
					for (i=0; i<totalPlayers; i++)
					{
						_playerBox[i].selected = true;
						_playerArray.push(getPlayerNumber(i));
					}			
				}	
				else if (LegendItem(e.object).text == "None")
				{
					for (i=0; i<totalPlayers; i++)
						_playerBox[i].selected = false;
				}
				firePlayerChanged(_playerArray); //playerNo(_playerArray);
			}).attach(_playerSelect);

		}


		import flare.vis.data.Data;	
		import flare.vis.data.DataSprite;	
		private var numberList:Array;
//		var numberList:Array = new Array(1,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,21,22,24,25,27,29,31,32,33,38);
		private var firstNameList:Array;
		private var lastNameList:Array;
		
		private function getPlayerData(d:DataSprite):void
		{
			numberList.push(d.data.Number);
			firstNameList.push(d.data.FirstName);
			lastNameList.push(d.data.LastName);
			
			//return false;
		}	
		public function registerData(d:Data):void
		{
			numberList = new Array();
			firstNameList = new Array();
			lastNameList = new Array();
			d.visit(getPlayerData);
			updatePlayerData();
		}
		
		private function updatePlayerData():void 
		{
			for(var i:uint=0; i<totalPlayers; i++)
			{
				_playerBox[i].label = getPlayerNumber(i);
            	_playerName[i].htmlText = getFirstName(i) + " " + getLastName(i);
            	
			}				
		}
		private function getPlayerNumber(no:Number):Number
		{
			//return 1;
			if(numberList != null) return numberList[no];
			else return 1;
		}			
        private function getFirstName(no:Number):String
        {
//        	return firstNameList[no];
        	//return "Juho";
        	if(firstNameList != null) return firstNameList[no];
			else return "Juho";
        }
        private function getLastName(no:Number):String
        {
//        	return lastNameList[no];
        	//return "Kim";
        	if(lastNameList != null) return lastNameList[no];
			else return "Kim";
        }   
        
        private function playerHandler( event:MouseEvent ):void
        {
			
			var no:Number = event.target.label;
    		var index:Number = _playerArray.indexOf(no);

    		// if this item is unselected
			if (index != -1)
				_playerArray.splice(index, 1);	
			// if this item is selected
			else
	        	_playerArray.push(no);
			//trace(_playerArray.length);
			firePlayerChanged(_playerArray); //playerNo(_playerArray);
        }
        
    	import fl.controls.ComboBox;
		import fl.events.ComponentEvent;
		
		private var _gameType:Legend;
		private var _gameFilter:String = "All";
		private var _roundTitleText:TextSprite;
    	private var _roundSelect:ComboBox;
		
		private function addGame():void
		{
			// create filter
			_gameType = Legend.fromValues(null, [
				{label:"All",    color:0xff888888},
				{label:"Home",   color:0xff8888ff},
				{label:"Away", color:0xff88ff88},
				{label:"Single", color:0xffff8888}
			]);
			_gameType.orientation = Orientation.LEFT_TO_RIGHT;
			_gameType.labelTextFormat = _legendFormat;
			_gameType.margin = 3;
			_gameType.setItemProperties({buttonMode:true, alpha:0.4});
			_gameType.items.getChildAt(0).alpha = 1;
			_gameType.update();
			addChild(_gameType);
			
			// change alpha value on legend mouse-over
			new HoverControl(LegendItem, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:LegendItem = LegendItem(e.object);
					if (li.text != _gameFilter) li.alpha = 0.4;
				}
			).attach(_gameType);
			
			// filter by game type on legend click
			new ClickControl(LegendItem, 1, function(e:SelectionEvent):void {
				_gameType.setItemProperties({alpha:0.4});
				e.object.alpha = 1;
				_gameFilter = LegendItem(e.object).text;
				fireGameTypeChanged(LegendItem(e.object).text); //gameType(LegendItem(e.object).text);
				if (_gameFilter == "Single")
					_roundSelect.enabled = true;
				else
					_roundSelect.enabled = false;
			}).attach(_gameType);
			
            _roundTitleText = new TextSprite("", _sectionFormat);
            _roundTitleText.text = "Game";
            this.addChild( _roundTitleText );	

            var totalEntries:uint = 38;
            var i:uint;
     
			_roundSelect = new ComboBox();
			_roundSelect.prompt = "Select a round:";
            for(i=1; i<=totalEntries; i++) {
                _roundSelect.addItem({label:"Round " + i});           
            }			
			_roundSelect.move(650, 130);
			_roundSelect.addEventListener(Event.CHANGE, roundHandler);
			_roundSelect.enabled = false;
			this.addChild(_roundSelect);				
		}
		
        private function roundHandler( event:Event ):void
        {
			fireRoundNo(_roundSelect.selectedIndex+1);//roundNo(_roundSelect.selectedIndex+1);
        }

		private var _shotTitleText:TextSprite;
		private var _shotType:Legend;
		private var _shotFilter:String = "Shots";

		
		private function addShotType():void
		{
            _shotTitleText = new TextSprite("", _sectionFormat);
            _shotTitleText.text = "Shot Type";
            this.addChild( _shotTitleText );

            
			// create filter
			_shotType = Legend.fromValues(null, [
				{label:"Goals",    color:0xff888888},
				{label:"Shots on Goal",   color:0xff8888ff},
				{label:"Shots", color:0xff88ff88}
			]);
			_shotType.orientation = Orientation.LEFT_TO_RIGHT;
			_shotType.labelTextFormat = _legendFormat;
			_shotType.margin = 3;
			_shotType.setItemProperties({buttonMode:true, alpha:0.4});
			_shotType.items.getChildAt(2).alpha = 1;
			_shotType.update();
			addChild(_shotType);
			
			// change alpha value on legend mouse-over
			new HoverControl(LegendItem, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:LegendItem = LegendItem(e.object);
					if (li.text != _shotFilter) li.alpha = 0.4;
				}
			).attach(_shotType);
			
			// filter by game type on legend click
			new ClickControl(LegendItem, 1, function(e:SelectionEvent):void {
				_shotType.setItemProperties({alpha:0.4});
				e.object.alpha = 1;
				_shotFilter = LegendItem(e.object).text;
				
				if (_shotFilter == "Goals")
					fireShotTypeChanged(0);//shotType(0);
				else if (_shotFilter == "Shots on Goal")
					fireShotTypeChanged(1);//shotType(1);
				else 
					fireShotTypeChanged(2);//shotType(2);
			}).attach(_shotType);
			            	
		}
        		
		private var _speedSlider:Slider;
		private var _speedTitleText:TextSprite;
		private var _speedText:TextSprite;
		
		private var _playSpeed:Number = 200;
				
		private function addPlaybackSpeed():void
		{
			_speedSlider = new Slider();
            _speedSlider.addEventListener( SliderEvent.CHANGE, showSpeedValue );
            _speedSlider.value = 2;
            this.addChild( _speedSlider );

            _speedTitleText = new TextSprite("", _sectionFormat);
            _speedTitleText.text = "Playback Speed";
            this.addChild( _speedTitleText );	
            
            _speedText = new TextSprite("", _textFormat);
            _speedText.horizontalAnchor = TextSprite.CENTER;
            _speedText.text = "Slowest   Slow    Normal    Fast    Fastest";
            this.addChild( _speedText );			
		}
		
        private function showSpeedValue( sliderEvent:SliderEvent ):void
        {
        	_playSpeed = 1000 - sliderEvent.value * 200;
        }
        
		import flash.text.TextField;
		import flash.text.TextFieldAutoSize;
		private var _timeSlider:Slider;
		private var _timeTitleText:TextSprite;
		private var _timeText:TextSprite;
		private var _timeCurrent:TextField;
		private var _timeCurrentMin:TextSprite;
		
		private function addTime():void
		{
			_timeSlider = new Slider();
            _timeSlider.addEventListener( SliderEvent.CHANGE, showTimeValue );
            _timeSlider.minimum = 0;
			_timeSlider.maximum = 90;
			_timeSlider.value = 90;
            this.addChild( _timeSlider );

            _timeTitleText = new TextSprite("", _sectionFormat);
            _timeTitleText.text = "Game Time (minutes)";
            this.addChild( _timeTitleText );	
            
            _timeText = new TextSprite("", _textFormat);
            _timeText.horizontalAnchor = TextSprite.CENTER;
            _timeText.text = "0                  15                  30                  45                  60                  75                  90";
            this.addChild( _timeText );		

            _timeCurrent = new TextField();
            _timeCurrent.defaultTextFormat = _textFormat;
            _timeCurrent.background = true;
            _timeCurrent.autoSize = TextFieldAutoSize.LEFT;
            _timeCurrent.text = "90";
            this.addChild( _timeCurrent );	 
                       
            _timeCurrentMin = new TextSprite("", _textFormat);
            _timeCurrentMin.horizontalAnchor = TextSprite.CENTER;
            _timeCurrentMin.text = "min.";
            this.addChild( _timeCurrentMin );	             		
		}	

        private function showTimeValue( sliderEvent:SliderEvent ):void
        {
            _timeCurrent.text = sliderEvent.value.toString();
            fireTimechanged(sliderEvent.value);//timeCurrent(sliderEvent.value);
        }    
            
		import fl.controls.Button;		
		private var _playButton:Button;		
		public function addPlay():void
		{
			_playButton = new Button();
			_playButton.label = "Play";
			_playButton.toggle = true;
			_playButton.addEventListener(MouseEvent.CLICK, buttonClick);
			addChild(_playButton);
		}
		
		import flash.utils.*;
		private var curInterval:uint;
	
		private function buttonClick( buttonEvent:MouseEvent ):void
        {
			clearInterval(curInterval);        	
        	if (_playButton.label == "Play")
	        {
	        	_playButton.label = "Stop";
	        	fireImmediate(true);
	        	curInterval = setInterval(playMovie, _playSpeed);	        	
	        }
	        else
	        {
	        	fireImmediate(false);
	        	_playButton.label = "Play";
	        }	
        }    

		private function playMovie():void
		{
			// Play is over, so stop.
			if (_timeSlider.value == 90)
			{
				fireImmediate(false);
				_playButton.label = "Play";
				clearInterval(curInterval);
				return;
   			}
   			_timeSlider.value += 1;
            _timeCurrent.text = _timeSlider.value.toString();
            fireTimechanged(_timeSlider.value);//timeCurrent(_timeSlider.value);		
		}
        		
		public function layout():void
		{
			if (_season) {
				_season.x = 10;
				_season.y = 10; 
			}			
			if (_team) {
				_team.x = 100;
				_team.y = 10; 
			}	
			if (_homeText) {
				_homeText.x = 370;
				_homeText.y = 330;
			}	
			if (_awayText) {
				_awayText.x = 180;
				_awayText.y = 330; 
			}							
			var x:Number = 550;
			var y:Number = 70;
			if (_gameType) {
	            _gameType.x = x;
	            _gameType.y = y+25;
			}	
			if (_roundSelect) {
				_roundSelect.move(x+130, y+50);					
			}
			if (_roundTitleText) {
	            _roundTitleText.x = x-20;
	            _roundTitleText.y = y;				
			}			
			y = 200;	

			if (_shotType) {
	            _shotType.x = x;
	            _shotType.y = y;
			}	
			if (_shotTitleText) {
	            _shotTitleText.x = x-20;
	            _shotTitleText.y = y-30;
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
	            _speedTitleText.x = x-20;
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
			}
			if (_timeTitleText) {
	            _timeTitleText.x = x-20;
	            _timeTitleText.y = y-30;
			}				
			if (_timeText) {
	            _timeText.x = x+250;
	            _timeText.y = y+20;
			}	
			if (_timeCurrent) {
	            _timeCurrent.x = x+530;
	            _timeCurrent.y = y+30;			
			}
			
			if (_timeCurrentMin) {
	            _timeCurrentMin.x = x+580;
	            _timeCurrentMin.y = y+30;				
			}
			
			if (_playButton) {
	            _playButton.x = x+530;		
	            _playButton.y = y-10;		
			}
			x = 800;
			y = 600;	
			if (_playerSelect) {
            	_playerSelect.x = x;
            	_playerSelect.y = y;
			}	
			if (_playerBox) {
				for (var i:Number=0; i<totalPlayers; i++)
				{	
					_playerBox[i].x = 800;
					_playerBox[i].y = i*20+30;	
					_playerName[i].x = 850;
					_playerName[i].y = i*20+33;			
				}
			}			
		}
	
		private function firePlayerChanged(pa:Array):void
		{
			for(var o:Object in _controlListener)
			{
				var cl:ControlListener = _controlListener[o] as ControlListener;
				cl.playerNo(pa);
			}
		}
		
		private function fireGameTypeChanged(gt:String):void
		{
			for(var o:Object in _controlListener)
			{
				var cl:ControlListener = _controlListener[o] as ControlListener;
				cl.gameType(gt);
			}
		}
		
		private function fireShotTypeChanged(st:Number):void
		{
			for(var o:Object in _controlListener)
			{
				var cl:ControlListener = _controlListener[o] as ControlListener;
				cl.shotType(st);
			}
		}
		
		private function fireTimechanged(tc:Number):void
		{
			for(var o:Object in _controlListener)
			{
				var cl:ControlListener = _controlListener[o] as ControlListener;
				cl.timeCurrent(tc);
			}
		}	
		
		private function fireRoundNo(rn:Number):void
		{
			for(var o:Object in _controlListener)
			{
				var cl:ControlListener = _controlListener[o] as ControlListener;
				cl.roundNo(rn);
			}	
		}	
		
		private function fireImmediate(b:Boolean):void
		{
			for(var o:Object in _controlListener)
			{
				var cl:ControlListener = _controlListener[o] as ControlListener;
				cl.setImmediate(b);
			}
		}
	}
}
