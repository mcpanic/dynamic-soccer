package cs448b.as3.ui
{
// Data related	
	import cs448b.as3.data.MatchData;
	import cs448b.as3.data.PlayerData;
	
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.Slider;
	import fl.controls.SliderDirection;
	import fl.events.SliderEvent;
	
	import flare.display.TextSprite;
	import flare.util.Orientation;
	import flare.util.Strings;
	import flare.vis.controls.ClickControl;
	import flare.vis.controls.HoverControl;
	import flare.vis.events.SelectionEvent;
	import flare.vis.legend.Legend;
	import flare.vis.legend.LegendItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.*;
				        			
	public class Controls extends Sprite
	{		
		// Text styles	
		private var _titleFormat:TextFormat;
		private var _sectionFormat:TextFormat;
		private var _legendFormat:TextFormat;
		private var _textFormat:TextFormat;
		
		private var _controlListener:Array = new Array(2);

		private var _luFunc:Function;
		private function fireListUpdate():void
		{
			if(_luFunc != null)_luFunc();
		}
		public function setLuFunc(fn:Function):void
		{
			_luFunc = fn;
		}
		
		private var _guFunc:Function;
		private function updateGoal():void{_guFunc(this);}
		public function setGuFunc(fn:Function):void
		{
			_guFunc = fn;
		}
		
		// Constants
//		public static var totalPlayers:Number = 27;
//		public static var totalRounds:Number = 38;
		// Data objects
		private var pData:PlayerData;
		private var mData:MatchData;
		// Season, team related
		private var _seasonText:String =	"2007/08";
		private var _season:TextSprite;
		private var _teamText:String =	"Manchester United";
		private var _team:TextSprite;	
		private var _homeText:TextSprite;
		private var _awayText:TextSprite;
		// Legend related
		private var _shotLegend:Legend;
		private var _shotLegendTitleText:TextSprite;
		private var _shotLegendOutline:Sprite; 
		// Shot type related
		private var _shotTitleText:TextSprite;
		private var _shotType:Legend;
		private var _shotFilter:String = "Shots";
		// Game related			
		private var _gameType:Legend;
		private var _gameFilter:String = "All";
		private var _roundTitleText:TextSprite;
    	private var _roundSelect:ComboBox;
		// Player related		
		//		public var playerNo:Function;
		private var _playerTitleText:TextSprite;
		private var _playerArray:Array;
    	private var _playerSelect:Legend;
        private var _playerBox:Array;
        private var _playerName:Array;
        private var _playerFilter:String = "All";

		private var _playerNumberText:TextSprite;
		private var _playerPositionText:TextSprite;
		private var _playerNameText:TextSprite;
		private var _playerGoalsText:TextSprite;
		private var _playerShotsOnGoalText:TextSprite;
		private var _playerShotsText:TextSprite;
		        
		// Speed related   		
		private var _speedSlider:Slider;
		private var _speedTitleText:TextSprite;
		private var _speedText:TextSprite;
		private var _speedText2:TextSprite;
		private var _playSpeed:Number = 200;
		// Time related   		
		private var _timeSlider:Slider;
		private var _timeTitleText:TextSprite;
		private var _timeText:TextSprite;
		private var _timeCurrent:TextField;
		private var _timeCurrentMin:TextSprite;
		// Play button related	
		private var _playButton:Button;
		// Animattion related		
		private var curInterval:uint;	
		// Info display related
		private var _roundText:TextSprite;
		private var _roundText2:TextSprite;		
		private var _roundText3:TextSprite;
		private var _roundText4:TextSprite;				
					
		public function Controls()
		{
			pData = new PlayerData();
			mData = new MatchData();
			_titleFormat = new TextFormat("Verdana,Tahoma,Arial",16,0,true);
			_sectionFormat = new TextFormat("Verdana,Tahoma,Arial",12,0,true);
			_legendFormat = new TextFormat("Verdana,Tahoma,Arial",11,0,true);
			_textFormat = new TextFormat("Verdana,Tahoma,Arial",10,0,false);

			addSeason();
			addTeam();
			addHomeAway();
			addPlayer();
			addLegend();
			addGame();
			addShotType();
			addPlaybackSpeed();
			addTime();
			addPlay();
			addInfo();
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

  		public function addControlListener(cl:ControlListener):void
  		{
  			_controlListener.push(cl);
  		}
		
    	private function addPlayer():void
		{
			var i:uint;

            _playerTitleText = new TextSprite("", _sectionFormat);
            _playerTitleText.text = "Players";
            this.addChild( _playerTitleText );	
                        
            _playerNumberText = new TextSprite("", _sectionFormat);
            _playerNumberText.text = "No.";
            _playerNumberText.buttonMode = true;
            _playerNumberText.alpha = 0.4;
            this.addChild( _playerNumberText );	

            _playerPositionText = new TextSprite("", _sectionFormat);
            _playerPositionText.text = "Pos.";
            _playerPositionText.buttonMode = true;
            _playerPositionText.alpha = 0.4;
            this.addChild( _playerPositionText );	
            
            _playerNameText = new TextSprite("", _sectionFormat);
            _playerNameText.text = "Name";
            _playerNameText.buttonMode = true;
            _playerNameText.alpha = 0.4;
            this.addChild( _playerNameText );	

            _playerGoalsText = new TextSprite("", _sectionFormat);
            _playerGoalsText.text = "G/";
            _playerGoalsText.buttonMode = true;
            _playerGoalsText.alpha = 0.4;
            this.addChild( _playerGoalsText );	

            _playerShotsOnGoalText = new TextSprite("", _sectionFormat);
            _playerShotsOnGoalText.text = "SG/";
            _playerShotsOnGoalText.buttonMode = true;
            _playerShotsOnGoalText.alpha = 0.4;
            this.addChild( _playerShotsOnGoalText );	
            
            _playerShotsText = new TextSprite("", _sectionFormat);
            _playerShotsText.text = "S";
            _playerShotsText.buttonMode = true;
            _playerShotsText.alpha = 0.4;
            this.addChild( _playerShotsText );	
            
			// change alpha value on legend mouse-over
			new HoverControl(TextSprite, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:TextSprite = TextSprite(e.object);
					li.alpha = 0.4;
				}
			).attach(_playerNumberText);
			// change alpha value on legend mouse-over
			new HoverControl(TextSprite, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:TextSprite = TextSprite(e.object);
					li.alpha = 0.4;
				}
			).attach(_playerPositionText);			
			// change alpha value on legend mouse-over
			new HoverControl(TextSprite, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:TextSprite = TextSprite(e.object);
					li.alpha = 0.4;
				}
			).attach(_playerNameText);
			// change alpha value on legend mouse-over
			new HoverControl(TextSprite, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:TextSprite = TextSprite(e.object);
					li.alpha = 0.4;
				}
			).attach(_playerGoalsText);			
			// change alpha value on legend mouse-over
			new HoverControl(TextSprite, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:TextSprite = TextSprite(e.object);
					li.alpha = 0.4;
				}
			).attach(_playerShotsOnGoalText);			
			// change alpha value on legend mouse-over
			new HoverControl(TextSprite, 0,
				function(e:SelectionEvent):void { e.object.alpha = 1; },
				function(e:SelectionEvent):void {
					var li:TextSprite = TextSprite(e.object);
					li.alpha = 0.4;
				}
			).attach(_playerShotsText);
			// sort by player number
			new ClickControl(TextSprite, 1, function(e:SelectionEvent):void {
				_playerNameText.alpha = 0.4;
				pData.sortWithNumber();
				_playerSortUpdate();
			}).attach(_playerNumberText);	
			// sort by player name
			new ClickControl(TextSprite, 1, function(e:SelectionEvent):void {
				_playerPositionText.alpha = 0.4;
				pData.sortWithPosition();
				_playerSortUpdate();
			}).attach(_playerPositionText);											
			// sort by player name
			new ClickControl(TextSprite, 1, function(e:SelectionEvent):void {
				_playerNameText.alpha = 0.4;
				pData.sortWithName();
				_playerSortUpdate();
			}).attach(_playerNameText);
			// sort by player shots
			new ClickControl(TextSprite, 1, function(e:SelectionEvent):void {
				updateGoal();
				_playerGoalsText.alpha = 0.4;				
				pData.sortWithGoals();
				_playerSortUpdate();
			}).attach(_playerGoalsText);
			// sort by player shots on goal
			new ClickControl(TextSprite, 1, function(e:SelectionEvent):void {
				updateGoal();
				_playerShotsOnGoalText.alpha = 0.4;				
				pData.sortWithShotsOnGoal();
				_playerSortUpdate();
			}).attach(_playerShotsOnGoalText);			
			// sort by player shots
			new ClickControl(TextSprite, 1, function(e:SelectionEvent):void {
				updateGoal();
				_playerShotsText.alpha = 0.4;				
				pData.sortWithShots();
				_playerSortUpdate();
			}).attach(_playerShotsText);
			                                                			
			_playerBox = new Array();
			_playerArray = new Array();	
			_playerName = new Array();		
			for(i=0; i<PlayerData.totalPlayers; i++)
			{
				_playerBox.push(new CheckBox());
//				_playerBox[i].label = pData.getPlayerNumber(i);
				_playerBox[i].label = "0";
				_playerBox[i].selected = true;
//				_playerArray.push(getPlayerNumber(i));
            	_playerBox[i].addEventListener(MouseEvent.CLICK,playerHandler);
            	addChild(_playerBox[i]);
            	
            	_playerName.push(new TextSprite("", _textFormat, TextSprite.DEVICE));
//            	_playerName[i].htmlText = pData.getFirstName(i) + " " + pData.getLastName(i);
            	_playerName[i].htmlText = "Loading...";
            	this.addChild(_playerName[i]);
			}	
			         				
			// create gender filter
			_playerSelect = Legend.fromValues(null, [
				{label:"All",    color:LegendColors.CONTROL_COLOR},
				{label:"None",   color:LegendColors.CONTROL_COLOR}
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
					for (i=0; i<PlayerData.totalPlayers; i++)
					{
						_playerBox[i].selected = true;
						_playerArray.push(pData.getPlayerNumber(i));
					}			
				}	
				else if (LegendItem(e.object).text == "None")
				{
					for (i=0; i<PlayerData.totalPlayers; i++)
						_playerBox[i].selected = false;
				}
				firePlayerChanged(_playerArray); //playerNo(_playerArray);
			}).attach(_playerSelect);

		}
		private function _playerSortUpdate():void
		{
			_playerArray = null;
			_playerArray = new Array();
			for (var i:uint =0; i<PlayerData.totalPlayers; i++)
			{
				_playerArray.push(pData.getPlayerNumber(i));
				_playerBox[i].label = pData.getPlayerNumber(i);				
				_playerName[i].htmlText = " " + pData.getPosition(i) + "  " + pData.getFirstName(i) + " " + pData.getLastName(i);
			}
			//firePlayerChanged(_playerArray);
			fireListUpdate();			
		}
		
		public function updatePlayerData(plData:PlayerData):void 
		{
			pData = null;
			pData = plData;
			for(var i:uint=0; i<PlayerData.totalPlayers; i++)
			{
				_playerArray.push(pData.getPlayerNumber(i));			
				_playerBox[i].label = pData.getPlayerNumber(i);
            	_playerName[i].htmlText = " " + pData.getPosition(i) + "  " + pData.getFirstName(i) + " " + pData.getLastName(i);						          	
			}	
		}
		public function updateMatchData(maData:MatchData):void 
		{
			mData = null;
			mData = maData;
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

    	private function addLegend():void
		{
			// create filter
			_shotLegend = Legend.fromValues(null, [
				{label:"Goals (G)",    color:LegendColors.GOAL_COLOR},
				{label:"Shots on Goal (SG)",   color:LegendColors.SHOT_ON_GOAL_COLOR},//0xff8888ff
				{label:"Shots (S)", color:LegendColors.SHOT_COLOR}
			]);
			_shotLegend.orientation = Orientation.TOP_TO_BOTTOM;
			//_shotLegend.orientation = Orientation.LEFT_TO_RIGHT;
			_shotLegend.labelTextFormat = _textFormat;
			_shotLegend.margin = 3;
			//_shotLegend.setItemProperties({buttonMode:true, alpha:0.4});
			//_shotLegend.items.getChildAt(0).alpha = 1;
			_shotLegend.update();
			addChild(_shotLegend);
				
			_shotLegendTitleText = new TextSprite("", _sectionFormat);
            _shotLegendTitleText.text = "Legend";
            this.addChild( _shotLegendTitleText );	
			
			// draw outlines
			var _shotLegendOutline:Sprite = new Sprite();
			_shotLegendOutline.graphics.lineStyle(1, LegendColors.CONTROL_COLOR, 1);
			_shotLegendOutline.graphics.drawRect(630, 585, 150, 85);
			addChild(_shotLegendOutline);					
		}        
	
		private function addGame():void
		{
			// create filter
			_gameType = Legend.fromValues(null, [
				{label:"All",    color:LegendColors.CONTROL_COLOR},
				{label:"Home",   color:LegendColors.CONTROL_COLOR},//0xff8888ff
				{label:"Away", color:LegendColors.CONTROL_COLOR},//0xff88ff88
				{label:"Single", color:LegendColors.CONTROL_COLOR}//0xffff8888
			]);
			_gameType.orientation = Orientation.TOP_TO_BOTTOM;
			//_gameType.orientation = Orientation.LEFT_TO_RIGHT;
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
				{
					_roundText.alpha = 1;
					_roundText2.alpha = 1;	
					_roundText3.alpha = 1;
					_roundText4.alpha = 1;					
					_roundSelect.enabled = true;
					_roundSelect.selectedIndex = 0;
				}
				else
				{
					_roundText.alpha = 0.4;
					_roundText2.alpha = 0.4;
					_roundText3.alpha = 0.4;
					_roundText4.alpha = 0.4;
					_roundSelect.enabled = false;
				}
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
        	var index:Number = _roundSelect.selectedIndex;
			fireRoundNo(index+1);//roundNo(_roundSelect.selectedIndex+1);
			
			_roundText.htmlText = Strings.format(
				"<b>Round {0}</b>",			
				index+1
			);

			_roundText2.htmlText = Strings.format(
				"<b>[{1} {2}]</b>",			
				index+1,
				mData.getScore(index), 
				mData.getResult(index)
			);
			_roundText3.htmlText = Strings.format(
				"{0} game",
				(mData.isHome(index)? "Home":"Away") 
				);			
			_roundText4.htmlText = Strings.format(
				"vs.{0}",
				mData.getOpponent(index)
				);				
        }
	
		private function addShotType():void
		{
            _shotTitleText = new TextSprite("", _sectionFormat);
            _shotTitleText.text = "Shot Type";
            this.addChild( _shotTitleText );

            
			// create filter
			_shotType = Legend.fromValues(null, [
				{label:"Goals",    color:LegendColors.GOAL_COLOR}, //color:0xff888888
				{label:"Shots on Goal",   color:LegendColors.SHOT_ON_GOAL_COLOR}, //color:0xff8888ff
				{label:"Shots", color:LegendColors.SHOT_COLOR} //color:0xff88ff88
			]);
			_shotType.orientation = Orientation.TOP_TO_BOTTOM;
//			_shotType.orientation = Orientation.LEFT_TO_RIGHT;
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
				
		private function addPlaybackSpeed():void
		{
			_speedSlider = new Slider();
            _speedSlider.addEventListener( SliderEvent.CHANGE, showSpeedValue );
            _speedSlider.direction = SliderDirection.VERTICAL;
            _speedSlider.value = 2;
            this.addChild( _speedSlider );

//            _speedTitleText = new TextSprite("", _sectionFormat);
//            _speedTitleText.text = "Playback Speed";
//            this.addChild( _speedTitleText );	
            
            _speedText = new TextSprite("", _textFormat);
            _speedText.horizontalAnchor = TextSprite.CENTER;
            _speedText.text = "Fast";
            this.addChild( _speedText );
            
            _speedText2 = new TextSprite("", _textFormat);
            _speedText2.horizontalAnchor = TextSprite.CENTER;
            _speedText2.text = "Slow";
            this.addChild( _speedText2 );	            			
		}
		
        private function showSpeedValue( sliderEvent:SliderEvent ):void
        {
        	_playSpeed = 700 - sliderEvent.value * sliderEvent.value * 40;
		    clearInterval(curInterval);
		    curInterval = setInterval(playMovie, _playSpeed);	 
        }

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
            _timeText.htmlText = " 0                 15                  30                  <b>45</b>                  60                  75                 <b>90</b>";
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
            	
		public function addPlay():void
		{
			_playButton = new Button();
			_playButton.label = "Play";
			_playButton.toggle = true;
			_playButton.addEventListener(MouseEvent.CLICK, buttonClick);
			addChild(_playButton);
		}
	
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
		private var _resultOutline:Sprite;
		
		public function addInfo():void
		{						
            _roundText = new TextSprite("", _sectionFormat);
            _roundText.horizontalAnchor = TextSprite.LEFT;
            _roundText.htmlText = "Round";
            _roundText.alpha = 0.4;
            this.addChild( _roundText );	
                     		
            _roundText2 = new TextSprite("", _sectionFormat);
            _roundText2.horizontalAnchor = TextSprite.LEFT;
            _roundText2.htmlText = "Score";
            _roundText2.alpha = 0.4;
            this.addChild( _roundText2 );	

            _roundText3 = new TextSprite("", _textFormat);
            _roundText3.horizontalAnchor = TextSprite.LEFT;
            _roundText3.htmlText = "Home / Away";
            _roundText3.alpha = 0.4;
            this.addChild( _roundText3 );	
            
            _roundText4 = new TextSprite("", _textFormat);
            _roundText4.horizontalAnchor = TextSprite.LEFT;
            _roundText4.htmlText = "Opponent";
            _roundText4.alpha = 0.4;
            this.addChild( _roundText4 );	
                        
			// draw outlines
			var _resultOutline:Sprite = new Sprite();
			_resultOutline.graphics.lineStyle(1, LegendColors.CONTROL_COLOR, 1);
			_resultOutline.graphics.drawRect(650, 65, 135, 85);
			addChild(_resultOutline);	                      	

		}
		        		
		public function layout():void
		{
			var titleMarginX:Number = 10;
			var titleMarginY:Number = 20;
			
			if (_season) {
				_season.x = 260;
				_season.y = 10; 
			}			
			if (_team) {
				_team.x = 350;
				_team.y = 10; 
			}	
			if (_homeText) {
				_homeText.x = 380;//480;
				_homeText.y = 60;
			}	
			if (_awayText) {
				_awayText.x = 280;//180;
				_awayText.y = 60; 
			}	
			
			var x:Number = 645;
			var y:Number = 610;				
			if (_shotLegend) {
	            _shotLegend.x = x;
	            _shotLegend.y = y;
			}				
			if (_shotLegendTitleText) {
	            _shotLegendTitleText.x = x-titleMarginX;
	            _shotLegendTitleText.y = y-titleMarginY;
			}				
			x= 670;
		    y = 70;		
			if (_roundText) {				
	            _roundText.x = x-titleMarginX;
	            _roundText.y = y;				
			}	
			if (_roundText2) {				
	            _roundText2.x = x-titleMarginX;
	            _roundText2.y = y+20;				
			}		
			if (_roundText3) {				
	            _roundText3.x = x-titleMarginX;
	            _roundText3.y = y+40;				
			}	
			if (_roundText4) {				
	            _roundText4.x = x-titleMarginX;
	            _roundText4.y = y+55;				
			}		
						    		
			y = y + 110;										
			if (_gameType) {
	            _gameType.x = x;
	            _gameType.y = y+titleMarginY;
			}	
			if (_roundSelect) {
				_roundSelect.move(x, y+100);					
			}
			if (_roundTitleText) {
	            _roundTitleText.x = x-titleMarginX;
	            _roundTitleText.y = y;				
			}	
	
											
			y = y+180;	

			if (_shotType) {
	            _shotType.x = x;
	            _shotType.y = y;
			}	
			if (_shotTitleText) {
	            _shotTitleText.x = x-titleMarginX;
	            _shotTitleText.y = y-titleMarginY;
			}			

			y = 510;
			if (_speedSlider) {
				_speedSlider.x = x+40;
				_speedSlider.y = y-40;
				_speedSlider.setSize(10, 80);
				// 0: Slowest, 1: Slow, 2: Normal, 3: Fast, 4: Fastest
				_speedSlider.tickInterval = 1;
				_speedSlider.minimum = 0;
				_speedSlider.maximum = 4;
			}
//			if (_speedTitleText) {
//	            _speedTitleText.x = x-titleMarginX;
//	            _speedTitleText.y = y-70;
//			}				
			if (_speedText) {
	            _speedText.x = x+66;
	            _speedText.y = y-45;
			}	
			if (_speedText2) {
	            _speedText2.x = x+66;
	            _speedText2.y = y+30;
			}
						
			x = 100-4;
			y = 510;	
			if (_timeSlider) {
				_timeSlider.x = x;
				_timeSlider.y = y;
				_timeSlider.setSize(500, 30);
				_timeSlider.tickInterval = 15;
			}
			if (_timeTitleText) {
	            _timeTitleText.x = x-titleMarginX;
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
	            _timeCurrentMin.x = x+565;
	            _timeCurrentMin.y = y+30;				
			}
			
			if (_playButton) {
	            _playButton.x = x+530;		
	            _playButton.y = y-10;		
	            _playButton.width = 50;
			}
			x = 790;
			y = 70;	
//			if (_playerInfoText) {				
//	            _playerInfoText.x = x;
//	            _playerInfoText.y = 20;				
//			}	
//			if (_playerInfoText2) {				
//	            _playerInfoText2.x = x;
//	            _playerInfoText2.y = 40;				
//			}				
			if (_playerTitleText) {
            	_playerTitleText.x = x;
            	_playerTitleText.y = y;
			}				

			if (_playerNumberText) {
            	_playerNumberText.x = x+10;
            	_playerNumberText.y = y+20;
			}
			if (_playerPositionText) {
            	_playerPositionText.x = x+40;
            	_playerPositionText.y = y+20;
			}			
			if (_playerNameText) {
            	_playerNameText.x = x+90;
            	_playerNameText.y = y+20;
			}	
			if (_playerGoalsText) {
            	_playerGoalsText.x = x+175;
            	_playerGoalsText.y = y+20;
			}	
			if (_playerShotsOnGoalText) {
            	_playerShotsOnGoalText.x = x+193;
            	_playerShotsOnGoalText.y = y+20;
			}													
			if (_playerShotsText) {
            	_playerShotsText.x = x+219;
            	_playerShotsText.y = y+20;
			}				
				
			if (_playerBox) {
				for (var i:Number=0; i<PlayerData.totalPlayers; i++)
				{	
					_playerBox[i].x = x;
					_playerBox[i].y = i*20+y+40;	
					_playerName[i].x = x+40;
					_playerName[i].y = i*20+y+43;			
				}
			}	
			if (_playerSelect) {
            	_playerSelect.x = x+30;
            	_playerSelect.y = 660;
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
