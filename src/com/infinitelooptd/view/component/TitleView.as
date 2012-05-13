package com.infinitelooptd.view.component
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.infinitelooptd.ApplicationFacade;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	public class TitleView extends Sprite
	{
		public static const NAME:String			= 'TitleView';
		
		public static const SHOW:String			= NAME + 'Show';
		public static const HIDE:String			= NAME + 'Hide';
		public static const UPDATE:String		= NAME + 'Update';
		public static const NEW_GAME:String		= NAME + 'NewGame';
		public static const QUIT_GAME:String	= NAME + 'QuitGame';
		
		public function TitleView()
		{
			init();
		}
		
		private function init():void
		{
			btn_newGame.addEventListener( MouseEvent.CLICK, doNewGame );
			TweenPlugin.activate([AutoAlphaPlugin]);
		}
		
		
		protected function doNewGame(event:Event):void
		{
			trace("[TitleView] Starting game...");
			ApplicationFacade.getInstance().sendNotification( NEW_GAME );
		}
		
		public function show():void
		{
			trace('[TitleView] Show');

			TweenLite.to( this, .5, { autoAlpha: 1 } );
		}
		
		public function hide():void
		{
			trace('[TitleView] Hide');
			
			TweenLite.to( this, .5, { autoAlpha: 0 } );
		}
		
		public function update(percent:Number):void
		{
			trace('[TitleView] Update');
		}
	}
}