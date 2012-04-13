package com.infinitelooptd.view.component
{
	import com.infinitelooptd.model.GameProxy;
	
	import flash.geom.Point;

	public class BasicCreepView extends CreepView
	{
		public static const NAME:String			= 'BasicCreepView';
		
		public static const CREATE:String		= NAME + 'Create';
		public static const MOVE:String			= NAME + 'Move';
		public static const TURN:String			= NAME + 'Turn';
		public static const DESTROY:String		= NAME + 'Destroy';
		
		public function BasicCreepView()
		{
			super();
		}
	}
}