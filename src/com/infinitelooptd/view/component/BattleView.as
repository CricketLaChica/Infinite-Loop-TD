package com.infinitelooptd.view.component
{
	import com.greensock.TweenLite;
	import com.infinitelooptd.ApplicationFacade;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BattleView extends Sprite
	{
		public static const NAME:String			= 'BattleView';
		
		public static const SHOW:String			= NAME + 'Show';
		public static const HIDE:String			= NAME + 'Hide';
		public static const UPDATE:String		= NAME + 'Update';
		public static const UPDATE_TIME:String	= NAME + 'Update Time';
		public static const ADD_GOLD:String		= NAME + 'Add Gold';
		public static const PAUSE:String		= NAME + 'Pause';
		
		public static const SHOW_MENU:String	= NAME + 'ShowMenu';
		public static const HIDE_MENU:String	= NAME + 'HideMenu';
		
		public static const CREATE_BASIC_CREEP:String		= NAME + 'CreateBasicCreep';
		
		public function BattleView()
		{
			init();
		}
		
		private function init():void
		{
			hud.mainMenu_btn.addEventListener( MouseEvent.CLICK, doGamePause );
		}
		
		protected function doGamePause(e:Event):void
		{
			ApplicationFacade.getInstance().sendNotification( PAUSE );
		}
		
		public function showGameMenu():void
		{
			// TweenLite.to( hud.game_menu, .5, { autoAlpha: 1 } );
			hud.game_menu.visible = true;
		}
		
		public function hideGameMenu():void
		{
			// TweenLite.to( hud.game_menu, .5, { autoAlpha: 0 } );
			hud.game_menu.visible = false;
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