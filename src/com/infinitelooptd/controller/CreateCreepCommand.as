package com.infinitelooptd.controller
{
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.utils.Time;
	import com.infinitelooptd.view.component.BasicCreepView;
	
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class CreateCreepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{	
			var name:String = notification.getName();
			var viewComponent:Object = notification.getBody();
			
			switch ( name )
			{
				case BasicCreepView.CREATE:
					var basicCreepView = new BasicCreepView();
					basicCreepView.init( 48 + proxy.vo.margin.x,
										 48 + proxy.vo.margin.y,
										 new Point(48 + proxy.vo.margin.x, 48 + proxy.vo.margin.y),
										 new Point(912 + proxy.vo.margin.x, 624 + proxy.vo.margin.y) );
					
					viewComponent.addChild( basicCreepView );
					proxy.vo.creeps.push( basicCreepView );
					
					trace('[CreepViewMediator] Created a new BasicCreepView!');
					break;
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
	}
}