package com.infinitelooptd.view.component
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class BulletView extends Sprite
	{
		private var speed:Number;
		private var speed_x: Number;
		private var speed_y:Number;
		private var _damage:int;
		
		public function BulletView(angle:Number) 
		{
			angle = angle + 180;
			speed = 10;
			damage = 25;
			speed_x = Math.cos(angle * Math.PI / 180) * speed;
			speed_y = Math.sin(angle * Math.PI / 180) * speed;
			draw();
		}
		
		private function draw():void 
		{
			var g:Graphics = this.graphics;
			
			g.lineStyle(1, 0xFF0000, 1);
			g.beginFill(0x000000,1); 
			g.drawCircle(0, 0, 5);
			g.endFill();
		}

		public function update():void 
		{
			x += speed_x;
			y += speed_y;
		}
		
		public function get damage():int
		{
			return _damage;
		}

		public function set damage(value:int):void
		{
			_damage = value;
		}
	}
}