package com.infinitelooptd.view.component
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class CreepView extends MovieClip
	{
		public static const NAME:String			= 'CreepView';

		protected var _direction:Number 		= 0;
		protected var _speed:Number 			= 5;
		
		protected var _minCoordinates:Point 	= new Point(0,0);
		protected var _maxCoordinates:Point 	= new Point(900,900);
		
		public function CreepView()
		{

		}
		
		public function init( posX:Number = 0, posY:Number = 0, minCoordinates:Point = null, maxCoordinates:Point = null ):void
		{
			this.minCoordinates = minCoordinates;
			this.maxCoordinates = maxCoordinates;
			this.x = posX;
			this.y = posY;
		}
		
		public function move():void
		{
			// Temporarily place this here. But this should grab the direction based on the current path tile it's entering
			if (this.x < 912 + proxy.vo.margin.x && this.y <= 50 + proxy.vo.margin.y)
			{
				this.direction = 0;
				this.rotation = this.direction;
			}
			else if (this.x >= 912 + proxy.vo.margin.x && this.y < 624 + proxy.vo.margin.y)
			{
				this.direction = 90;
				this.rotation = this.direction;
			}
			else if (this.x > 48 + proxy.vo.margin.x && this.y >= 624 + proxy.vo.margin.y)
			{
				this.direction = 180;
				this.rotation = this.direction;
			}
			else if (this.x <= 48 + proxy.vo.margin.x && this.y > 48 + proxy.vo.margin.y)
			{
				this.direction = 270;
				this.rotation = this.direction;
			}
			
			switch ( this.direction )
			{
				case 90:
					// Going down
					this.y += this.speed;
					break;
				case 180:
					// Going left
					this.x -= this.speed;
					break;
				case 270:
					// Going up
					this.y -= this.speed;
					break;
				default:
					// Going right
					this.x += this.speed;
					break;
			}
		}

		protected function get proxy():GameProxy
		{
			return ApplicationFacade.getInstance().retrieveProxy( GameProxy.NAME ) as GameProxy;
		}
		
		public function get direction():Number
		{
			return _direction;
		}

		public function set direction(value:Number):void
		{
			_direction = value;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}

		public function get minCoordinates():Point
		{
			return _minCoordinates;
		}

		public function set minCoordinates(value:Point):void
		{
			_minCoordinates = value;
		}

		public function get maxCoordinates():Point
		{
			return _maxCoordinates;
		}

		public function set maxCoordinates(value:Point):void
		{
			_maxCoordinates = value;
		}
	}
}