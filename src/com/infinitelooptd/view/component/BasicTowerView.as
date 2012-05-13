package com.infinitelooptd.view.component
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.view.BattleViewMediator;
	
	import flash.display.Shape;
	import flash.geom.Point;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class BasicTowerView extends TowerView
	{
		public static const NAME:String			= 'BasicTowerView';
		
		public static const CREATE:String		= NAME + 'Create';
		public static const MOVE:String			= NAME + 'Move';
		public static const TURN:String			= NAME + 'Turn';
		public static const DESTROY:String		= NAME + 'Destroy';
		
		private var bullets:Vector.<BulletView>;
		private var bullet:BulletView;
		
		private var reloadTime:int 				= 15;
		private var localTime:Number;
		
		public function BasicTowerView()
		{
			super();
		}

		override public function specificInit():void
		{
			this.turret.rotation = this.turretRotation;
			this.power = 10;

			bullets = new Vector.<BulletView>();
			localTime = 301;
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
					
					if (localTime > reloadTime)
					{
						var localCreep = this.globalToLocal( new Point(creep.x, creep.y) );
						shoot(localCreep);
					}
				}
			}
			
			// Check bullets
			for each (bullet in bullets) 
			{
				var terrain:Shape = BattleViewMediator(ApplicationFacade.getInstance().retrieveMediator( BattleViewMediator.NAME )).towerTerrain;
				if ( !bullet.hitTestObject(terrain) ) {
					removeBullet(bullet);
					continue;
				}
				
				for (var k:int = 0; k < proxy.vo.creeps.length; k++) 
				{
					if (bullet.hitTestObject(proxy.vo.creeps[k]))
					{
						proxy.vo.creeps[k].hitBy(bullet.damage);
						removeBullet(bullet);
					}
				}
				
				bullet.update();
			}
			
			localTime++;
		}
		
		private function shoot(creep:Point):void 
		{
			var localPosition = this.globalToLocal( new Point( this.x, this.y ) );
			bullet = new BulletView(this.turretRotation);
			bullet.x = localPosition.x + Math.cos((this.turretRotation + 180) * Math.PI / 180) * 50;
			bullet.y = localPosition.y + Math.sin((this.turretRotation + 180) * Math.PI / 180) * 50;
			bullets.push(bullet);
			addChild(bullet);
			localTime = 0;
		}
		
		public function removeBullet(bullet:BulletView):void
		{
			bullets.splice( bullets.indexOf(bullet), 1 );
			this.removeChild(bullet);
			bullet = null;
		}
	}
}