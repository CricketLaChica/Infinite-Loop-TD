package com.infinitelooptd.controller
{
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.component.CreepView;
	import com.infinitelooptd.view.component.TowerView;
	
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GameResetCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{	
			var name:String = notification.getName();
			var viewComponent:Object = notification.getBody();
			
			for (var i:int = 0; i < proxy.vo.creeps.length; i++) 
			{
				var creep = proxy.vo.creeps[i];
				creep.die();
				viewComponent.removeChild( creep );
			}
			
			for (var j:int = 0; j < proxy.vo.towers.length; j++) 
			{
				var tower = proxy.vo.towers[j];
				viewComponent.removeChild( tower );
			}
			
			proxy.vo.creeps = new Vector.<CreepView>();
			proxy.vo.towers = new Vector.<TowerView>();
			proxy.vo.timers = new Vector.<Timer>();
			
			proxy.vo.time_start = getTimer();
			proxy.vo.gold = 100;
			proxy.vo.paused = false;
			proxy.vo.gameSpeed = 1;
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}