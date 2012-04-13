package com.infinitelooptd.controller
{
	import com.infinitelooptd.model.DataProxy;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.ApplicationMediator;
	import com.infinitelooptd.view.component.BasicTowerView;
	import com.infinitelooptd.view.component.CreepView;
	
	import flash.display.MovieClip;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class CreateTowerCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{	
			var name:String = notification.getName();
			var viewComponent:Object = notification.getBody();
			
			switch ( name )
			{
				case BasicTowerView.CREATE:
					var basicTowerView = new BasicTowerView();
					basicTowerView.init( 476,
										 300,
										 72 );
					
					viewComponent.addChild( basicTowerView );
					proxy.vo.towers.push( basicTowerView );
					
					trace('[CreepViewMediator] Created a new BasicTowerView.');
					break;
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}