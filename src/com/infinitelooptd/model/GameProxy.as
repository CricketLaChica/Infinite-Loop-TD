package com.infinitelooptd.model
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import com.infinitelooptd.model.vo.GameVO;
	
	public class GameProxy extends Proxy implements IProxy
	{
		public static const NAME:String		= 'GameProxy';
		
		public function GameProxy(data:Object=null)
		{
			super( NAME, new GameVO() );
		}
		
		public function get vo():GameVO
		{
			return data as GameVO;
		}
	}
}