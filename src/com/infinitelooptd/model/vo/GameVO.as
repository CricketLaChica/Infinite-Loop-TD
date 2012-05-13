package com.infinitelooptd.model.vo
{
	import com.infinitelooptd.view.component.CreepView;
	import com.infinitelooptd.view.component.TowerView;
	
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class GameVO
	{
		// Global Game Settings
		public var margin:Point = new Point(32, 32);
		public var gameSpeed:Number = 1;
		public var gridSize:uint	= 96;
		
		// Game Objects
		public var creeps:Vector.<CreepView> = new Vector.<CreepView>();
		public var towers:Vector.<TowerView> = new Vector.<TowerView>();
		public var grid:Shape;
		public var timers:Vector.<Timer> = new Vector.<Timer>();
		
		// Game stats
		public var time_start:int = getTimer();
		public var gold:uint = 100;
		public var paused:Boolean = false;
	}
}