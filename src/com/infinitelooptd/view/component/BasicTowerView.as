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

		override public function specificInit():void
		{
			this.turret.rotation = this.turretRotation;
			this.power = 10;

			bullets = new Vector.<Shape>();
		}
		
		override protected function specificMove():void
		{
			if (proxy.vo.creeps.length > 0 )
			{
				// Grab a target
				var creep:CreepView; // = proxy.vo.creeps[0];
				for (var i:int = 0; i < proxy.vo.creeps.length; i++) 
				{
					if (canShoot(proxy.vo.creeps[i]))
					{
						creep = proxy.vo.creeps[i];
						break;
					}
				}
				
				if (creep != null)
				{
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
				}
				else
				{
					bullet = getBullet();
					removeBullet(bullet);
				}
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