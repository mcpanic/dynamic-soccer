package cs448b.as3.ui
{
	import flash.display.Sprite;
	
	public class SoccerField extends Sprite
	{
		private var fieldWidth:Number = 385;
		private var fieldHeight:Number = 265;
		private var offset:Number = 5;
		
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
		}
		
		/**
		 * Builds sprite
		 */
		public function buildSprite():void
		{
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
			this.addChild(outLine);
			
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
			this.addChild(centerCircle);
			
			// draw left penalty box
			var leftPBox:Sprite = new Sprite();
			leftPBox.graphics.lineStyle(1, 0xffffff); 
			leftPBox.graphics.drawRect(offset, offset+52, 67, 161);
			this.addChild(leftPBox);
			
			// draw right penalty box
			var rightPBox:Sprite = new Sprite();
			rightPBox.graphics.lineStyle(1, 0xffffff); 
			rightPBox.graphics.drawRect(offset+fieldWidth-67, offset+52, 67, 161);
			this.addChild(rightPBox);
			
			// draw left small box
			var leftSBox:Sprite = new Sprite();
			leftSBox.graphics.lineStyle(1, 0xffffff); 
			leftSBox.graphics.drawRect(offset, offset+95, 23, 75);
			this.addChild(leftSBox);
			
			// draw right small box
			var rightSBox:Sprite = new Sprite();
			rightSBox.graphics.lineStyle(1, 0xffffff); 
			rightSBox.graphics.drawRect(offset+fieldWidth-23, offset+95, 23, 75);
			this.addChild(rightSBox);
			
			// draw left PK area
			var leftPKLine:Sprite = new Sprite();
			leftPKLine.graphics.lineStyle(1, 0xffffff); 
			leftPKLine.graphics.moveTo(offset+67+1, offset+103);
			leftPKLine.graphics.curveTo(offset+67+20+1, offset+103+59/2, offset+67+1, offset+103+59);
			this.addChild(leftPKLine);
			
			// draw right PK area
			var rightPKLine:Sprite = new Sprite();
			rightPKLine.graphics.lineStyle(1, 0xffffff); 
			rightPKLine.graphics.moveTo(offset+fieldWidth-67, offset+103);
			rightPKLine.graphics.curveTo(offset+fieldWidth-67-20, offset+103+59/2, offset+fieldWidth-67, offset+103+59);
			this.addChild(rightPKLine);
		}
	
		/**
		 * Draws the given points
		 */
		public function drawPoints():void
		{
			// TODO: draw points here
		}
	}
}