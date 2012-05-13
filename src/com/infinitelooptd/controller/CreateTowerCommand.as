package com.infinitelooptd.controller
{
	import com.infinitelooptd.model.DataProxy;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.ApplicationMediator;
	import com.infinitelooptd.view.TowerViewMediator;
	import com.infinitelooptd.view.component.BasicTowerView;
	import com.infinitelooptd.view.component.CreepView;
	import com.infinitelooptd.view.component.LineTowerView;
	import com.infinitelooptd.view.component.TowerView;
	
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
			var type:String = notification.getType();
			
			switch ( name )
			{
				case BasicTowerView.CREATE:
					var basicTowerView = new BasicTowerView();
					basicTowerView.init( 174,
										 174,
										 72 );
					
					viewComponent.addChild( basicTowerView );
					proxy.vo.towers.push( basicTowerView );
					
					trace('[CreepViewMediator] Created a new BasicTowerView.');
					break;
				case LineTowerView.CREATE:
					var towerView = new LineTowerView();
					if (type == TowerViewMediator.SUPER)
					{
						towerView.init( 174,
							558,
							72 );
						TowerView(towerView).power = 20;
					}
					else
					{
						towerView.init( 846,
							174,
							72 );
					}
					
					viewComponent.addChild( towerView );
					proxy.vo.towers.push( towerView );
					
					trace('[CreepViewMediator] Created a new LineTowerView.');
					break;
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}