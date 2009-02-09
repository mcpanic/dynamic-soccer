package cs448b.as3.ui
{
	import flare.animate.Transitioner;
	import flare.scale.ScaleType;
	import flare.util.palette.ColorPalette;
	import flare.util.palette.SizePalette;
	import flare.vis.Visualization;
	import flare.vis.data.Data;
	import flare.vis.data.DataSprite;
	import flare.vis.operator.encoder.ColorEncoder;
	import flare.vis.operator.encoder.SizeEncoder;
	import flare.vis.operator.filter.VisibilityFilter;
	import flare.vis.operator.layout.AxisLayout;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class SoccerField extends Sprite
	{
		private var fieldWidth:Number = 385;
		private var fieldHeight:Number = 265;
		private var offset:Number = 5;
		
		private var transTime:Number = 0.5;
		
		private var vis:Visualization = null;
		
		// filter values
		private var _gameType:String = "All";
		private var _roundNo:Number = 1;
		
		private var _playerArray:Array = null;
		
		private var _shotType:Number = 2;
		
		/**
		 * Constructor
		 */
		public function SoccerField()
		{
			this.graphics.beginFill( 0x3a6629, 1 );   // beginFill( color, alpha )
            this.graphics.drawRect( 0, 0, fieldWidth+2*offset+1, fieldHeight+2*offset+1 );    // drawRect( left, top, width, height )
            this.graphics.endFill();
            
			initComponents();
			buildSprite();
		}

		/**
		 * Initializes components
		 */
		public function initComponents():void
		{
			drawLines();
			initVis();
		}
		
		/**
		 * Builds sprite
		 */
		public function buildSprite():void
		{
			addChild(vis);
		}
		
		public function initVis():void
		{
			vis = new Visualization();
			vis.bounds = new Rectangle(0, 0, fieldWidth, fieldHeight);
            vis.x = offset;
            vis.y = offset;
		}
		
		/**
		 * Draw the lines
		 */
		public function drawLines():void
		{
			// draw outlines
			var outLine:Sprite = new Sprite();
			outLine.graphics.lineStyle(1, 0xffffff); 
			outLine.graphics.drawRect(5, 5, fieldWidth, fieldHeight);
			addChild(outLine);
			
			// draw center line
			var centerLine:Sprite = new Sprite();
			centerLine.graphics.lineStyle(1, 0xffffff); 
			centerLine.graphics.moveTo(fieldWidth/2+offset, offset);
			centerLine.graphics.lineTo(fieldWidth/2+offset, offset+fieldHeight)
			this.addChild(centerLine);
			
			// draw center circle
			var centerCircle:Sprite = new Sprite();
			centerCircle.graphics.lineStyle(1, 0xffffff); 
			centerCircle.graphics.drawCircle(offset+fieldWidth/2, offset+fieldHeight/2, 36);
			addChild(centerCircle);
			
			// draw left penalty box
			var leftPBox:Sprite = new Sprite();
			leftPBox.graphics.lineStyle(1, 0xffffff); 
			leftPBox.graphics.drawRect(offset, offset+52, 67, 161);
			addChild(leftPBox);
			
			// draw right penalty box
			var rightPBox:Sprite = new Sprite();
			rightPBox.graphics.lineStyle(1, 0xffffff); 
			rightPBox.graphics.drawRect(offset+fieldWidth-67, offset+52, 67, 161);
			addChild(rightPBox);
			
			// draw left small box
			var leftSBox:Sprite = new Sprite();
			leftSBox.graphics.lineStyle(1, 0xffffff); 
			leftSBox.graphics.drawRect(offset, offset+95, 23, 75);
			addChild(leftSBox);
			
			// draw right small box
			var rightSBox:Sprite = new Sprite();
			rightSBox.graphics.lineStyle(1, 0xffffff); 
			rightSBox.graphics.drawRect(offset+fieldWidth-23, offset+95, 23, 75);
			addChild(rightSBox);
			
			// draw left PK area
			var leftPKLine:Sprite = new Sprite();
			leftPKLine.graphics.lineStyle(1, 0xffffff); 
			leftPKLine.graphics.moveTo(offset+67+1, offset+103);
			leftPKLine.graphics.curveTo(offset+67+20+1, offset+103+59/2, offset+67+1, offset+103+59);
			addChild(leftPKLine);
			
			// draw right PK area
			var rightPKLine:Sprite = new Sprite();
			rightPKLine.graphics.lineStyle(1, 0xffffff); 
			rightPKLine.graphics.moveTo(offset+fieldWidth-67, offset+103);
			rightPKLine.graphics.curveTo(offset+fieldWidth-67-20, offset+103+59/2, offset+fieldWidth-67, offset+103+59);
			addChild(rightPKLine);
		}
	
		/**
		 * Draws the given points
		 */
		public function registerData(d:Data):void
		{
			vis.data = d;

			vis.operators.add(new AxisLayout("data.X", "data.Y"));
			vis.operators.add(new ColorEncoder("data.Goal", Data.NODES,
                "lineColor", ScaleType.CATEGORIES, 
                new ColorPalette([0xafaec7e8, 0xffd62728])));
			vis.operators.add(new SizeEncoder("data", Data.NODES, new SizePalette(0.05, 0.1)));
			
            vis.data.nodes.setProperties({fillColor:0, lineWidth:3, size:1});

			// set axis values 			
			vis.xyAxes.xAxis.showLines = false;
			vis.xyAxes.xAxis.axisScale.max = fieldWidth;
			vis.xyAxes.xAxis.axisScale.min = 0;
			vis.xyAxes.xAxis.axisScale.flush = true;
			vis.xyAxes.xAxis.showLabels = false;
			
			vis.xyAxes.yAxis.showLines = false;
			vis.xyAxes.yAxis.axisScale.max = fieldHeight;
			vis.xyAxes.yAxis.axisScale.min = 0;
			vis.xyAxes.yAxis.axisScale.flush = true;
			vis.xyAxes.yAxis.showLabels = false;

			// add filters
			vis.operators.add(new VisibilityFilter(theFilter));
//            vis.operators[3].immediate = true; // filter immediately!
            			
            vis.update();
		}
		
// Visability filter functions
		private function theFilter(d:DataSprite):Boolean
		{
			return gameFilter(d) && playerFilter(d) && goalFilter(d);
		}
		
		private function gameFilter(d:DataSprite):Boolean
		{
			//trace("gameFilter()");
			if(_gameType == "All") return true;
			else if(_gameType == "Home" && d.data.HomeAway == "Home") return true;
			else if(_gameType == "Away" && d.data.HomeAway == "Away") return true;
			else if(_gameType == "Single" && d.data.Round == _roundNo) return true;
			else return false;
		}
		
		private function playerFilter(d:DataSprite):Boolean
		{
			if(_playerArray == null) return true;
			else
			{
				for(var i:Number = 0; i < _playerArray.length; i++)
				{
					if(_playerArray[i] as Number == d.data.Player) return true;
				}
			}
			
			return false;
		}
		
		private function goalFilter(d:DataSprite):Boolean
		{
			if(_shotType == 0 && d.data.Goal == "y") return true;
			else if(_shotType == 1 && (d.data.Goal == "y" || d.data.ShotOnGoal == "y")) return true;
			else if(_shotType == 2) return true;
			else return false;
		}

// Visability value set functions
		public function gameType(gt:String):void
		{
			_gameType = gt; 		
			vis.update(new Transitioner(transTime)).play();

		}
		
		public function roundNo(rn:Number):void
		{
			_roundNo = rn;
			
			vis.update(new Transitioner(transTime)).play();
		}
		
		public function playerNo(pnArray:Array):void
		{
			_playerArray = pnArray;
			
			vis.update(new Transitioner(transTime)).play();
		}
		
		public function shotType(gt:Number):void
		{
			_shotType = gt;
			
			vis.update(new Transitioner(transTime)).play();
		}
	}

}