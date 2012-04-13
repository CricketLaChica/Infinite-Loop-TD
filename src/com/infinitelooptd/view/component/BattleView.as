package com.infinitelooptd.view.component
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	
	public class BattleView extends Sprite
	{
		public static const NAME:String			= 'BattleView';
		
		public static const SHOW:String			= NAME + 'Show';
		public static const HIDE:String			= NAME + 'Hide';
		public static const UPDATE:String		= NAME + 'Update';
		
		public static const CREATE_BASIC_CREEP:String		= NAME + 'CreateBasicCreep';
		
		public function BattleView()
		{
			init();
		}
		
		private function init():void
		{
			
		}
		
		public function show():void
		{
			trace('[BattleView] Show');

			TweenLite.to( this, .5, { autoAlpha: 1 } );
		}
		
		public function hide():void
		{
			trace('[BattleView] Hide');
			
			TweenLite.to( this, .5, { autoAlpha: 0 } );
		}
		
		public function update(percent:Number):void
		{
			trace('[BattleView] Update');
		}
	}
}