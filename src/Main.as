package 
{
	import com.infinitelooptd.ApplicationFacade;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Main extends Sprite
	{
		private var mainStage:MovieClip;
		
		public function Main(aStage:MovieClip)
		{
			this.mainStage = aStage;
			init();
		}
		
		private function init():void
		{
			trace('[Main] Game started.');
			
			ApplicationFacade.getInstance().startup( mainStage );
		}
	}
}