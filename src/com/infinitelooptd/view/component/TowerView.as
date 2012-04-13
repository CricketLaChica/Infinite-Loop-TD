package com.infinitelooptd.view.component
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TowerView extends MovieClip
	{
		public static const NAME:String			= 'TowerView';
		
		protected var _turretRotation:Number;
		protected var _allowMove:Boolean;
		
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
			
		}
		
		protected function enableMove(event:MouseEvent):void
		{
			this.allowMove = true;
		}
		
		protected function disableMove(event:MouseEvent):void
		{
			this.allowMove = false;
		}
		
		protected function moveTower(event:MouseEvent):void
		{
			if (this.allowMove)
			{
				this.x = event.stageX;
				this.y = event.stageY;
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
	}
}