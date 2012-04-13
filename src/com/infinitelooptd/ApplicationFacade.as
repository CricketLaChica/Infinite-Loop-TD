package com.infinitelooptd
{
	import com.infinitelooptd.controller.CreateCreepCommand;
	import com.infinitelooptd.controller.CreateTowerCommand;
	import com.infinitelooptd.controller.GameLoopCommand;
	import com.infinitelooptd.controller.StartupCommand;
	import com.infinitelooptd.view.component.BasicCreepView;
	import com.infinitelooptd.view.component.BasicTowerView;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const NAME:String			= 'ApplicationFacade';
		public static const STARTUP:String		= NAME + 'StartUp';
		public static const GAMELOOP:String			= NAME + 'GameLoop';
		
		public static function getInstance():ApplicationFacade
		{
			return (instance ? instance : new ApplicationFacade()) as ApplicationFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			// Game
			registerCommand( STARTUP, StartupCommand );
			registerCommand( GAMELOOP, GameLoopCommand );
			
			// Creeps
			registerCommand( BasicCreepView.CREATE, CreateCreepCommand );
			
			// Towers
			registerCommand( BasicTowerView.CREATE, CreateTowerCommand );
		}
		
		public function startup(stage:Object):void
		{
			sendNotification( STARTUP, stage );
		}
		
		override public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
//			trace( 'Sent ' + notificationName );
			
			notifyObservers( new Notification( notificationName, body, type ) );
		}
	}
}