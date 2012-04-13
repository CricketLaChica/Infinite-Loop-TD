package com.infinitelooptd.view
{
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.utils.Time;
	import com.infinitelooptd.view.component.BasicCreepView;
	import com.infinitelooptd.view.component.CreepView;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class CreepViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String		= 'CreepViewMediator';
		
		protected var _creepCreator:Timer;
		
		public function CreepViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			sendNotification( BasicCreepView.CREATE, viewComponent );
			
			_creepCreator = new Timer(1000);
			_creepCreator.addEventListener(TimerEvent.TIMER, addCreep);
			_creepCreator.start();
		}
		
		protected function addCreep(event:TimerEvent):void
		{
			sendNotification( BasicCreepView.CREATE, viewComponent );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				BasicCreepView.MOVE,
				BasicCreepView.DIE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch ( name )
			{
				case BasicCreepView.MOVE:
					for each (var item:CreepView in proxy.vo.creeps)
					{
						if (item is BasicCreepView)
						{
							item.move();
						}
					}
					break;
				case BasicCreepView.DIE:
					break;
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}