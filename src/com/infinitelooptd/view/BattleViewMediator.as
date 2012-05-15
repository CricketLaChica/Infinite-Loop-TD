package com.infinitelooptd.view
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.utils.GameUtil;
	import com.infinitelooptd.view.component.BattleView;
	import com.infinitelooptd.view.component.GameMenuView;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BattleViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String						= 'BattleViewMediator';

		private var battleView:BattleView;
		private var gameMenuView:GameMenuView;
		private var _towerTerrain:Shape;

		[Bindable]
		[Embed(source="/assets/graphics/grass.jpg")]
		private var TerrainGrass:Class;
		
		[Bindable]
		[Embed(source="/assets/graphics/rock.jpg")]
		private var TerrainRock:Class;
		
		public function BattleViewMediator(viewComponent:Object=null)
		{
			super( NAME, viewComponent );
		}

		override public function onRegister():void
		{
			battleView = new BattleView();
			viewComponent.addChild( battleView );
			
			towerTerrain = createTowerTerrain();
			viewComponent.addChild( towerTerrain );

			proxy.vo.grid = createGrid();

			trace('[BattleViewMediator] Created a new BattleView.');
			
			facade.registerMediator( new CreepViewMediator( viewComponent ) );
			facade.registerMediator( new TowerViewMediator( viewComponent ) );
			
			viewComponent.addEventListener( Event.ENTER_FRAME, doGameLoop );
			viewComponent.addEventListener( MouseEvent.MOUSE_MOVE, doMouseGrid );
			
			gameMenuView = new GameMenuView();
			viewComponent.addChild( gameMenuView );
			
			// Reset timer
			proxy.vo.time_start = getTimer();
		}

		// Custom functions
		private function createGrid():Shape
		{
			var grid = new Shape();

			grid.graphics.lineStyle(3, 0xFF0000, 1); 
			grid.graphics.moveTo(0, 0);
			grid.graphics.lineTo(96,0);
			grid.graphics.lineTo(96,96);
			grid.graphics.lineTo(0,96);
			grid.graphics.lineTo(0,0);
			grid.x = proxy.vo.margin.x + 96;
			grid.y = proxy.vo.margin.y + 96;

			return grid;
		}
		
		private function createTowerTerrain():Shape
		{
			towerTerrain = new Shape();
			
			var theGrass:BitmapData = new TerrainGrass().bitmapData;
			var theRock:BitmapData  = new TerrainRock().bitmapData;
			
			towerTerrain.graphics.beginBitmapFill(theRock);
			towerTerrain.graphics.drawRect(0, 0, 96*10, 96*7);
			towerTerrain.graphics.endFill();
			
			towerTerrain.graphics.beginBitmapFill(theGrass);
			towerTerrain.graphics.drawRect(96, 96, 96*8, 96*5);
			towerTerrain.graphics.endFill();
			
			towerTerrain.graphics.lineStyle(4, 0x000000, 0.5);
			towerTerrain.graphics.moveTo(96, 96);
			towerTerrain.graphics.lineTo(96*9,96);
			towerTerrain.graphics.lineTo(96*9,96*6);
			towerTerrain.graphics.lineTo(96,96*6);
			towerTerrain.graphics.lineTo(96,96);
			
			towerTerrain.x = proxy.vo.margin.x;
			towerTerrain.y = proxy.vo.margin.y;
			
			return towerTerrain;
		}
		
		// Events
		protected function doGameLoop(event:Event):void
		{
			sendNotification( ApplicationFacade.GAMELOOP );
		}
		
		protected function doMouseGrid(event:MouseEvent):void
		{
			proxy.vo.grid.x = GameUtil.constrainGridX(Math.floor((event.stageX - proxy.vo.margin.x) / 96) * 96) + proxy.vo.margin.x;
			proxy.vo.grid.y = GameUtil.constrainGridY(Math.floor((event.stageY - proxy.vo.margin.y) / 96) * 96) + proxy.vo.margin.y;
		}
		
		// MVC stuff
		override public function listNotificationInterests():Array
		{
			return [
				BattleView.SHOW,
				BattleView.HIDE,
				BattleView.UPDATE,
				BattleView.UPDATE_TIME,
				BattleView.ADD_GOLD,
				BattleView.SHOW_MENU,
				BattleView.HIDE_MENU,
				GameMenuView.SHOW,
				GameMenuView.HIDE,
				GameMenuView.RESET,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch ( name )
			{
				case BattleView.UPDATE_TIME:
					var hr = Math.floor((getTimer() - proxy.vo.time_start) / 1000 / 60 / 60 );
					var min = Math.floor((getTimer() - proxy.vo.time_start) / 1000 / 60) % 60;
					var sec = Math.floor((getTimer() - proxy.vo.time_start) / 1000) % 60;
					battleView.hud.time.text = GameUtil.zeroPad(hr,2) + ":" + GameUtil.zeroPad(min,2) + ":" + GameUtil.zeroPad(sec,2);
					break;
				case BattleView.ADD_GOLD:
					proxy.vo.gold += body;
					battleView.hud.gold.text = proxy.vo.gold; 
					break;
				case BattleView.SHOW_MENU:
					battleView.showGameMenu();
					break;
				case BattleView.HIDE_MENU:
					battleView.hideGameMenu();
					break;
				case GameMenuView.SHOW:
					gameMenuView.show();
					break;
				case GameMenuView.HIDE:
					gameMenuView.hide();
					break;
				case GameMenuView.RESET:
					this.dispose();
					break;
			}
		}
		
		private function get proxy():GameProxy
		{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
		
		public function dispose():void
		{
			sendNotification( ApplicationFacade.RESET, viewComponent );
			viewComponent.removeChild( towerTerrain );
			viewComponent.removeChild( gameMenuView );
			viewComponent.removeChild( battleView );
			
			viewComponent.removeEventListener( Event.ENTER_FRAME, doGameLoop );
			viewComponent.removeEventListener( MouseEvent.MOUSE_MOVE, doMouseGrid );
			
			facade.removeMediator( CreepViewMediator.NAME );
			facade.removeMediator( TowerViewMediator.NAME );
			
			facade.removeMediator( NAME );
		}

		public function get towerTerrain():Shape
		{
			return _towerTerrain;
		}

		public function set towerTerrain(value:Shape):void
		{
			_towerTerrain = value;
		}

	}
}