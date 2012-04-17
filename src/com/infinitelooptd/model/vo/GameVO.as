package com.infinitelooptd.model.vo
{
	import com.infinitelooptd.view.component.CreepView;
	import com.infinitelooptd.view.component.TowerView;
	
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.utils.getTimer;

	public class GameVO
	{
		// Global Game Settings
		public var margin:Point = new Point(32, 32);
		public var gameSpeed:Number = 1;
		
		// Game Objects
		public var creeps:Vector.<CreepView> = new Vector.<CreepView>();
		public var towers:Vector.<TowerView> = new Vector.<TowerView>();
		public var grid:Shape;
		
		// Game stats
		public var time_start = getTimer();
		public var gold = 100;
	}
}