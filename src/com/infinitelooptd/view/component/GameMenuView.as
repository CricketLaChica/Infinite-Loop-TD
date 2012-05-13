package com.infinitelooptd.view.component
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.infinitelooptd.ApplicationFacade;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GameMenuView extends Sprite
	{
		public static const NAME:String			= 'GameMenuView';
		
		public static const SHOW:String			= NAME + 'Show';
		public static const HIDE:String			= NAME + 'Hide';
		public static const UPDATE:String		= NAME + 'Update';
		
		public static const RESET:String		= NAME + 'Reset';
		
		public function GameMenuView()
		{
			init();
		}
		
		private function init():void
		{
			this.btn_resume.addEventListener( MouseEvent.CLICK, doGamePause );
			this.btn_quit.addEventListener( MouseEvent.CLICK, doGameReset );
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenLite.to( this, 0, { autoAlpha: 0 } );
		}
		
		protected function doGamePause(e:Event):void
		{
			ApplicationFacade.getInstance().sendNotification( BattleView.PAUSE );
		}
		
		protected function doGameReset(e:Event):void
		{
			ApplicationFacade.getInstance().sendNotification( RESET );
		}
		
		public function show():void
		{
			trace('[GameMenuView] Show');

			TweenLite.to( this, .5, { autoAlpha: 1 } );
//			this.visible = true;
		}
		
		public function hide():void
		{
			trace('[GameMenuView] Hide');
			
			TweenLite.to( this, .5, { autoAlpha: 0 } );
//			this.visible = false;
		}
		
		public function update(percent:Number):void
		{
			trace('[GameMenuView] Update');
		}
	}
}