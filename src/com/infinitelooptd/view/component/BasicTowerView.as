package com.infinitelooptd.view.component
{
	import flash.events.MouseEvent;

	public class BasicTowerView extends TowerView
	{
		public static const NAME:String			= 'BasicTowerView';
		
		public static const CREATE:String		= NAME + 'Create';
		public static const MOVE:String			= NAME + 'Move';
		public static const TURN:String			= NAME + 'Turn';
		public static const DESTROY:String		= NAME + 'Destroy';
		
		public function BasicTowerView()
		{
			super();
		}
		
		override public function init( posX:Number = 0, posY:Number = 0, rotation:Number = 0 ):void
		{
			this.x = posX;
			this.y = posY;
			this.turretRotation = rotation;
			
			this.turret.rotation = rotation;
			this.addEventListener(MouseEvent.MOUSE_DOWN, enableMove);
			this.addEventListener(MouseEvent.MOUSE_UP, disableMove);
			this.addEventListener(MouseEvent.MOUSE_MOVE, moveTower);
		}
		
		override public function move():void
		{
			if (proxy.vo.creeps.length > 0 )
			{
				// Grab a target
				var creep = proxy.vo.creeps[0];
				
				this.turretRotation = ( 
					Math.atan2(	creep.y - this.y,
						creep.x - this.x )
					/ Math.PI ) * 180 + 180;
				
				this.turret.rotation = this.turretRotation;
			}			
		}
	}
}