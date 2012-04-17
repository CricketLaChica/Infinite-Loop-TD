package com.infinitelooptd.view
{
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.component.BasicTowerView;
	import com.infinitelooptd.view.component.LineTowerView;
	import com.infinitelooptd.view.component.TowerView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TowerViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String		= 'TowerViewMediator';
		
		private var towers:Vector.<TowerView>;
		
		public function TowerViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			towers = new Vector.<TowerView>();
			
			sendNotification( BasicTowerView.CREATE, viewComponent );
			sendNotification( LineTowerView.CREATE, viewComponent );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				BasicTowerView.MOVE,
				LineTowerView.MOVE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			var item:TowerView;
			
			switch ( name )
			{
				case BasicTowerView.MOVE:
					for each (item in proxy.vo.towers)
					{
						if (item is BasicTowerView)
						{
							item.move();
						}
					}
					break;
				case LineTowerView.MOVE:
					for each (item in proxy.vo.towers)
					{
						if (item is LineTowerView)
						{
							item.move();
						}
					}
					break;
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}