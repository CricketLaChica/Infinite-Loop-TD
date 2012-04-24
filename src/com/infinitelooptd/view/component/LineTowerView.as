package com.infinitelooptd.view.component
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LineTowerView extends TowerView
	{
		public static const NAME:String			= 'LineTowerView';
		
		public static const CREATE:String		= NAME + 'Create';
		public static const MOVE:String			= NAME + 'Move';
		public static const TURN:String			= NAME + 'Turn';
		public static const DESTROY:String		= NAME + 'Destroy';
		
		private var bullets:Vector.<MovieClip>;
		private var bullet:MovieClip;
		
		public function LineTowerView()
		{
			super();
		}
		
		override public function specificInit():void
		{
			this.turret.rotation = this.turretRotation;

			bullets = new Vector.<MovieClip>();
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
					creep.beingHit = this.power;
					
					this.turretRotation = ( 
						Math.atan2(	creep.y - this.y,
							creep.x - this.x )
						/ Math.PI ) * 180 + 180;
					
					this.turret.rotation = this.turretRotation;
					
					bullet = getBullet();
					bullet.graphics.clear();
					bullet.graphics.lineStyle(2, 0xCCFF00, 100);
					bullet.graphics.moveTo( 0, 0 );
					bullet.graphics.lineTo( creep.x - this.x, creep.y - this.y );
				}
				else
				{
					bullet = getBullet();
					bullet.graphics.clear();
				}
			}
			else
			{
				bullet = getBullet();
				bullet.graphics.clear();
			}
		}
		
		private function getBullet():MovieClip
		{
			if (bullets.length < 1)
			{
				var bullet = new MovieClip();
				bullets.push( bullet );
				this.addChildAt( bullet, 0 );
				return bullet;
			}
			else
			{
				return bullets[0];
			}
		}
	}
}