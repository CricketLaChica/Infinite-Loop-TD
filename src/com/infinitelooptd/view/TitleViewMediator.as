package com.infinitelooptd.view
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.utils.GameUtil;
	import com.infinitelooptd.view.component.BattleView;
	import com.infinitelooptd.view.component.TitleView;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String						= 'TitleViewMediator';

		private var titleView:TitleView;
		
		public function TitleViewMediator(viewComponent:Object=null)
		{
			super( NAME, viewComponent );
		}

		override public function onRegister():void
		{
			titleView = new TitleView();
			viewComponent.addChild( titleView );

			trace('[TitleViewMediator] Created a new TitleView.');
		}

//		protected function doGameLoop(event:Event):void
//		{
//			sendNotification( ApplicationFacade.GAMELOOP );
//		}
//		
//		protected function doMouseGrid(event:MouseEvent):void
//		{
//			proxy.vo.grid.x = GameUtil.constrainGridX(Math.floor((event.stageX - proxy.vo.margin.x) / 96) * 96) + proxy.vo.margin.x;
//			proxy.vo.grid.y = GameUtil.constrainGridY(Math.floor((event.stageY - proxy.vo.margin.y) / 96) * 96) + proxy.vo.margin.y;
//		}
		
		// MVC stuff
		override public function listNotificationInterests():Array
		{
			return [
				TitleView.SHOW,
				TitleView.HIDE,
				TitleView.UPDATE,
				TitleView.NEW_GAME,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();

			switch ( name )
			{
				case TitleView.NEW_GAME:
					facade.registerMediator( new BattleViewMediator( viewComponent ) );
					titleView.hide();
					break;
				case TitleView.SHOW:
					titleView.show();
					break;
				case TitleView.HIDE:
					titleView.hide();
					break;
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}