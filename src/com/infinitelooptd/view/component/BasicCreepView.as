package com.infinitelooptd.view.component
{
	import com.infinitelooptd.ApplicationFacade;
	import com.infinitelooptd.model.GameProxy;
	import com.infinitelooptd.view.CreepViewMediator;
	
	import flash.events.Event;
	import flash.geom.Point;

	public class BasicCreepView extends CreepView
	{
		public static const NAME:String			= 'BasicCreepView';
		
		public static const CREATE:String		= NAME + 'Create';
		public static const MOVE:String			= NAME + 'Move';
		public static const TURN:String			= NAME + 'Turn';
		public static const KILL:String			= NAME + 'Kill';
		public static const DIE:String			= NAME + 'Die';
		
		public function BasicCreepView()
		{
			super();
		}
		
		override protected function specificMove():void
		{
			if (this.creep.rotation != this.direction) this.creep.rotation = this.direction;
			
			if (this.curLife < 1 || this.curLife <= beingHit)
			{
				ApplicationFacade.getInstance().sendNotification( KILL, new Array( this, ApplicationFacade.getInstance().retrieveMediator( CreepViewMediator.NAME ).getViewComponent() ) );
			}
			else
			{
				this.curLife -= beingHit;
				this.beingHit = 0;
				this.lifebar.life.width = 50 * this.curLife / this.maxLife;
			}
		}
	}
}