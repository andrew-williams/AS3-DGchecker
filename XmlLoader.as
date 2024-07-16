package  {
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class XmlLoader {

		private var loader:URLLoader;
		private var request:URLRequest = new URLRequest("CustomLevel.xml");
		private var oldXmlSource:XML;
		private var xmlSource:XML;
		
		private var refreshTimer:Timer;
		private var gameData;

		public function XmlLoader(gameData):void{
			this.gameData = gameData;
			//LoadXML();
			//refreshTimer = new Timer(1000,1);
			//refreshTimer.addEventListener(TimerEvent.TIMER_COMPLETE,RefreshXML,false,0,true);
			//refreshTimer.start();
		}
		
		//private function RefreshXML(e:TimerEvent):void{
			//trace("Refreshing xml");
			//LoadXML();
			//refreshTimer.start();
		//}

		public function LoadXML(url:String):void{
			//var url:String = "CustomLevel.xml"; 
			var appendString = url + ".xml";
			var req:URLRequest = new URLRequest(appendString);
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(Event.COMPLETE, LoadComplete,false,0,true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, LoadError,false,0,true);		
			
		}
		
		private function LoadComplete(e:Event):void{
			//var data:XML = new XML(loader.data);
			var xmlData:XML = new XML((e.target as URLLoader).data);
			if (xmlSource == null){
				//gameData.cc.PushMessage("Load Complete: Brand new xml data");
				trace("Load Complete: Brand new xml data");
				xmlSource = XML(e.target.data);
				oldXmlSource = xmlSource;
				//gameData.levelData = oldXmlSource;
				//gameData.tileGeneration = new TileGeneration(gameData);
				gameData.xmlData = oldXmlSource;
			}
			else{
				oldXmlSource = xmlSource;
				xmlSource = XML(e.target.data);
	    	    //If feed is different, update UI
		        if( oldXmlSource != xmlSource ){
	 				trace("Conflict Detected, updating xml");
					//gameData.cc.PushMessage("XML Data has been updated.");
	            //Do the UI or Application update here
	 				//gameData.levelData = xmlSource;
					gameData.xmlData = xmlSource;
					//gameData.tileGeneration = new TileGeneration(gameData);
		        }
			}
			gameData.UpdateButtons();
			
		}
		
		private function LoadError(e:IOErrorEvent):void{
			trace("XmlLoader.as: Error reading file.");
		}

		public function GetXMLData():XML{
			return xmlSource;
		}

	}
	
}
