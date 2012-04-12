package com.infinitelooptd.model
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import com.infinitelooptd.model.vo.DataVO;
	
	public class DataProxy extends Proxy implements IProxy
	{
		public static const NAME:String		= 'DataProxy';
		
		public function DataProxy(data:Object=null)
		{
			super( NAME, new DataVO() );
		}
		
		public function get vo():DataVO
		{
			return data as DataVO;
		}
	}
}