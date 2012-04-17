package com.infinitelooptd.utils
{
	public class GameUtil
	{
		public function GameUtil()
		{
		}
		
		static public function zeroIfNegative(num:Number):Number
		{
			return num < 0 ? 0 : num;
		}
		
		static public function constrainGridX(num:Number):Number
		{
			if (num < 96) return 96;
			if (num >= 864) return 768;
			return num;
		}
		
		static public function constrainGridY(num:Number):Number
		{
			if (num < 96) return 96;
			if (num >= 576) return 480;
			return num;
		}
		
		static public function zeroPad(number:String, width:int):String {
			if (number.length < width)
				return "0" + zeroPad(number, width-1);
			return number;
		}
	}
}