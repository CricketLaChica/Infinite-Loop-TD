package com.infinitelooptd.view
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.view.component.BasicCreepView;
	import com.infinitelooptd.view.component.BattleView;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BattleViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String						= 'BattleViewMediator';
		
		private var battleView:BattleView;
		
		public function BattleViewMediator(viewComponent:Object=null)
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
			battleView = new BattleView();
			viewComponent.addChild( battleView );
			trace('[BattleViewMediator] Created a new BattleView.');
			
			facade.registerMediator( new CreepViewMediator( viewComponent ) );
			facade.registerMediator( new TowerViewMediator( viewComponent ) );
			
			viewComponent.addEventListener( Event.ENTER_FRAME, doGameLoop );
		}
		
		protected function doGameLoop(event:Event):void
		{
			sendNotification( ApplicationFacade.GAMELOOP );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				BattleView.SHOW,
				BattleView.HIDE,
				BattleView.UPDATE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch ( name )
			{
				case BattleView.SHOW:
					battleView.show();
					
					break;
				
				case BattleView.HIDE:
					battleView.hide();
					
					break;
				
				case BattleView.UPDATE:
					battleView.update( body.percent );
					
					break;
			}
		}
	}
}