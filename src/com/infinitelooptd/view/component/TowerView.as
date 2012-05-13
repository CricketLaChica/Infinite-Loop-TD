package com.infinitelooptd.view.component
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.BattleViewMediator;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TowerView extends MovieClip
	{
		public static const NAME:String			= 'TowerView';
		
		protected var _turretRotation:Number;
		protected var _allowMove:Boolean;
		
		protected var _power:Number 			= 1;
		protected var _range:Number				= 1;
		
		private var _rangeShape:Sprite;
		
		public function TowerView()
		{
		
		}
		
		public function init( posX:Number = 0, posY:Number = 0, rotation:Number = 0 ):void
		{
			this.x = posX;
			this.y = posY;
			this.turretRotation = rotation;
			
			// Create range shape
			_rangeShape = new Sprite();
			_rangeShape.graphics.lineStyle(2, 0x000000, 1);
			_rangeShape.graphics.beginFill(0x000000, 0.2);
			_rangeShape.graphics.drawCircle(0, 0, (range * proxy.vo.gridSize) + (proxy.vo.gridSize / 2) );
			_rangeShape.graphics.endFill();
			_rangeShape.mouseEnabled = false;
			_rangeShape.mouseChildren = false;
			 _rangeShape.visible = false;
			this.addChildAt(_rangeShape, 0);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, enableMove);
			this.addEventListener(MouseEvent.MOUSE_UP, disableMove);
			this.addEventListener(MouseEvent.MOUSE_MOVE, moveTower);
			this.addEventListener(MouseEvent.MOUSE_OVER, showRange);
			this.addEventListener(MouseEvent.MOUSE_OUT, hideRange);
			
			specificInit();
		}
		
		public function specificInit():void
		{
			
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
			// this.power+=1;

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
		
		protected function showRange(event:MouseEvent):void
		{
			_rangeShape.visible = true;
		}
		
		protected function hideRange(event:MouseEvent):void
		{
			_rangeShape.visible = false;
		}
		
		protected function canShoot(creep:CreepView):Boolean {
			var dx:Number = creep.x - x;
			var dy:Number = creep.y - y;
			if (Math.sqrt(dx * dx + dy * dy) <= (range * proxy.vo.gridSize) + (proxy.vo.gridSize / 2)) return true;
			else return false;
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

		public function get range():Number
		{
			return _range;
		}

		public function set range(value:Number):void
		{
			_range = value;
		}


	}
}