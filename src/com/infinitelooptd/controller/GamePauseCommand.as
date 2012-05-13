package com.infinitelooptd.controller
{
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.component.GameMenuView;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GamePauseCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{	
			proxy.vo.paused = !proxy.vo.paused;
			if (proxy.vo.paused)
			{
				sendNotification( GameMenuView.SHOW );
				for (var i:int = 0; i < proxy.vo.timers.length; i++) 
				{
					proxy.vo.timers[i].stop();
				}
			}
			else
			{
				sendNotification( GameMenuView.HIDE );
				for (var j:int = 0; j < proxy.vo.timers.length; j++) 
				{
					proxy.vo.timers[j].start();
				}
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}