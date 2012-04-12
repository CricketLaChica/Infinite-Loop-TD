package com.infinitelooptd.view
{
	import com.infinitelooptd.view.component.BattleView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.INotification;
	
	public class BattleViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String		= 'BattleViewMediator';
		
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