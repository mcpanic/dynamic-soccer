package cs448b.as3.ui
{
	public interface ControlListener
	{
		function gameType(gt:String):void;
		
		function roundNo(rn:Number):void;
		
		function playerNo(pnArray:Array):void;
		
		function shotType(gt:Number):void;
		
		function timeCurrent(tc:Number):void;
		
		function get immediate():Boolean;
		function set immediate(b:Boolean):void;
	}
}