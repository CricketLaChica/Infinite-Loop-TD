package com.infinitelooptd.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class Time extends Sprite
	{
		static private var _instance:Time = new Time();
		static private var _currentTime:int;
		static private var _previousTime:int;
		
		public function Time() 
		{
			if (_instance) throw new Error("The Time class cannot be instantiated.");
			addEventListener(Event.ENTER_FRAME, updateTime, false, 0, true);
			_currentTime = getTimer();
		}
		
		private function updateTime(e:Event):void 
		{
			_previousTime = _currentTime;
			_currentTime = getTimer();
		}
		
		static public function get deltaTime():Number 
		{
			return (_currentTime - _previousTime) / 1000;
		} 
	}
}