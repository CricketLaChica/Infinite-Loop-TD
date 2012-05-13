package com.infinitelooptd.controller
{
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.component.BasicCreepView;
	import com.infinitelooptd.view.component.BasicTowerView;
	import com.infinitelooptd.view.component.BattleView;
	import com.infinitelooptd.view.component.LineTowerView;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GameLoopCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{	
			if (!proxy.vo.paused)
			{
				sendNotification( BasicCreepView.MOVE );
				sendNotification( BasicTowerView.MOVE );
				sendNotification( LineTowerView.MOVE );
				sendNotification( BattleView.UPDATE_TIME );
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}