package com.infinitelooptd.controller
{
	import com.infinitelooptd.model.DataProxy;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.component.BasicCreepView;
	import com.infinitelooptd.view.component.BattleView;
	import com.infinitelooptd.view.component.CreepView;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class KillCreepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{	
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			var creep:CreepView = body[0];
			var viewComponent:MovieClip = body[1];
			
			switch ( name )
			{
				case BasicCreepView.KILL:
					creep.die();
					viewComponent.removeChild( creep );
					proxy.vo.creeps.splice( proxy.vo.creeps.indexOf(creep), 1 ); // remove from the main Vector list
					trace('[CreepViewMediator] Killed a BasicCreepView.');
					break;
			}
			
			sendNotification( BattleView.ADD_GOLD, creep.goldValue );
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}