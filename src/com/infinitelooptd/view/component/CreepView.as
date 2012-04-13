package com.infinitelooptd.view.component
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.utils.Time;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class CreepView extends MovieClip
	{
		public static const NAME:String			= 'CreepView';

		protected var _direction:Number 		= 0;
		protected var _speed:Number 			= 100;
		
		protected var _minCoordinates:Point 	= new Point(0,0);
		protected var _maxCoordinates:Point 	= new Point(900,900);
		
		protected var _beingHit:Number			= 0;
		protected var _maxLife:Number			= 100;
		protected var _curLife:Number			= 100;
		
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
			}
			else if (this.x >= 912 + proxy.vo.margin.x && this.y < 624 + proxy.vo.margin.y)
			{
				this.direction = 90;
			}
			else if (this.x > 48 + proxy.vo.margin.x && this.y >= 624 + proxy.vo.margin.y)
			{
				this.direction = 180;
			}
			else if (this.x <= 48 + proxy.vo.margin.x && this.y > 48 + proxy.vo.margin.y)
			{
				this.direction = 270;
			}
			
			switch ( this.direction )
			{
				case 90:
					// Going down
					this.y += this.speed * Time.deltaTime;
					break;
				case 180:
					// Going left
					this.x -= this.speed * Time.deltaTime;
					break;
				case 270:
					// Going up
					this.y -= this.speed * Time.deltaTime;
					break;
				default:
					// Going right
					this.x += this.speed * Time.deltaTime;
					break;
			}
			
			specificMove();
		}
		
		protected function specificMove():void
		{
			
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
		
		public function die():void
		{
			dispose();
		}
		
		public function dispose():void
		{
			this.minCoordinates = null;
			this.maxCoordinates = null;
		}

		public function get beingHit()
		{
			return _beingHit;
		}

		public function set beingHit(value):void
		{
			_beingHit = value;
		}

		public function get maxLife():Number
		{
			return _maxLife;
		}

		public function set maxLife(value:Number):void
		{
			_maxLife = value;
		}

		public function get curLife():Number
		{
			return _curLife;
		}

		public function set curLife(value:Number):void
		{
			_curLife = value;
		}


	}
}