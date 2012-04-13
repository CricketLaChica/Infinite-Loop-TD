package com.infinitelooptd.model.vo
{
	import com.infinitelooptd.view.component.CreepView;
	import com.infinitelooptd.view.component.TowerView;
	
	import flash.geom.Point;

	public class GameVO
	{
		// Global Game Settings
		public var margin:Point = new Point(32, 32);
		public var gameSpeed:Number = 1;
		
		// Game Objects
		public var creeps:Vector.<CreepView> = new Vector.<CreepView>();
		public var towers:Vector.<TowerView> = new Vector.<TowerView>();
	}
}