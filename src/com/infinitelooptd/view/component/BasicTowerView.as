package com.infinitelooptd.view.component
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class BasicTowerView extends TowerView
	{
		public static const NAME:String			= 'BasicTowerView';
		
		public static const CREATE:String		= NAME + 'Create';
		public static const MOVE:String			= NAME + 'Move';
		public static const TURN:String			= NAME + 'Turn';
		public static const DESTROY:String		= NAME + 'Destroy';
		
		private var bullets:Vector.<Shape>;
		private var bullet:Shape;
		
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
			this.power = 10;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, enableMove);
			this.addEventListener(MouseEvent.MOUSE_UP, disableMove);
			this.addEventListener(MouseEvent.MOUSE_MOVE, moveTower);

			bullets = new Vector.<Shape>();
		}
		
		override protected function specificMove():void
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
				
				var localCreep = this.globalToLocal( new Point(creep.x, creep.y) );
				
				bullet = getBullet(localCreep);
				TweenMax.to( bullet, 1, {x: localCreep.x, y: localCreep.y} );
				
				if (bullet.hitTestObject(creep))
				{
					creep.hitBy(this.power);
					removeBullet(bullet);
				}
//				trace("going to: " + (localCreep.x) + ", " + (localCreep.y));
			}
			else
			{
				bullet = getBullet();
				bullet.graphics.clear();
			}
		}
		
		private function getBullet(localCreep:Point = null):Shape
		{
			if (bullets.length < 1)
			{
				var bullet = new Shape();
				this.addChildAt( bullet, 0 );
				
				bullet.graphics.lineStyle(1, 0xFF0000, 1);
				bullet.graphics.beginFill(0x000000,1); 
				bullet.graphics.drawCircle(0, 0, 5);
				bullet.graphics.endFill();
				
				bullets.push( bullet );
				
				TweenMax.to( bullet, 0.5, {x: localCreep.x, y: localCreep.y, ease: Sine.easeIn, onComplete:removeBullet, onCompleteParams:[bullet]} );
				
				return bullet;
			}
			else
			{
				return bullets[0];
			}
		}
		
		public function removeBullet(bullet:Shape):void
		{
			trace("removing bullet");
			bullets.splice( bullets.indexOf(bullet), 1 );
			this.removeChild(bullet);
			bullet = null;
		}
	}
}