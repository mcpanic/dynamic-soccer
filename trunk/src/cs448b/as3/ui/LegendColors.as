package cs448b.as3.ui
{
	import flare.util.palette.ColorPalette;
	
	public class LegendColors
	{
		public static var GOAL_COLOR:uint = 0xffd62728;//d62728;
		public static var SHOT_ON_GOAL_COLOR:uint = 0xff729ece;//ed665d;//99b1d2;//0xafaec7e8;
		public static var SHOT_COLOR:uint = 0xffaec7e8;//ff9896//aaaaaa;
		public static var CONTROL_COLOR:uint = 0xff888888; 
		public static var SHOT_PALETTE:ColorPalette =  new ColorPalette([GOAL_COLOR, SHOT_ON_GOAL_COLOR, SHOT_COLOR]);
		
		public function LegendColors(){}
	}
}