package com.infinitelooptd.view.component
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.BattleViewMediator;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TowerView extends MovieClip
	{
		public static const NAME:String			= 'TowerView';
		
		protected var _turretRotation:Number;
		protected var _allowMove:Boolean;
		
		protected var _power:Number 			= 1;
		
		public function TowerView()
		{
		
		}
		
		public function init( posX:Number = 0, posY:Number = 0, rotation:Number = 0 ):void
		{
			this.x = posX;
			this.y = posY;
			this.turretRotation = rotation;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, enableMove);
			this.addEventListener(MouseEvent.MOUSE_UP, disableMove);
			this.addEventListener(MouseEvent.MOUSE_MOVE, moveTower);
		}
		
		public function move():void
		{
			specificMove();
		}
		
		protected function specificMove():void
		{
			
		}
		
		protected function enableMove(event:MouseEvent):void
		{
			this.allowMove = true;
			this.power+=1;

			ApplicationFacade.getInstance().retrieveMediator(BattleViewMediator.NAME).getViewComponent().addChildAt(proxy.vo.grid, ApplicationFacade.getInstance().retrieveMediator(BattleViewMediator.NAME).getViewComponent().getChildIndex(this));
		}
		
		protected function disableMove(event:MouseEvent):void
		{
			this.allowMove = false;
			this.x = proxy.vo.grid.x + 48;
			this.y = proxy.vo.grid.y + 48;
			ApplicationFacade.getInstance().retrieveMediator(BattleViewMediator.NAME).getViewComponent().removeChild(proxy.vo.grid);
		}
		
		protected function moveTower(event:MouseEvent):void
		{
			if (this.allowMove)
			{
				this.x = event.stageX;
				this.y = event.stageY;
				
				event.updateAfterEvent();
			}
		}
		
		protected function get proxy():GameProxy
		{
			return ApplicationFacade.getInstance().retrieveProxy( GameProxy.NAME ) as GameProxy;
		}

		public function get turretRotation():Number
		{
			return _turretRotation;
		}

		public function set turretRotation(value:Number):void
		{
			_turretRotation = value;
		}

		public function get allowMove():Boolean
		{
			return _allowMove;
		}

		public function set allowMove(value:Boolean):void
		{
			_allowMove = value;
		}

		public function get power():Number
		{
			return _power;
		}

		public function set power(value:Number):void
		{
			_power = value;
		}

	}
}