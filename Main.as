package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class Main extends MovieClip {
		
		private const MAX_FLOORS:int = 60;
		private var buttonArray:Array = new Array();
		private var xmlLoader:XmlLoader;
		public var xmlData:XML;
		private var xmlToSave:String;
		
		private var allowSend:Boolean = false;
		
		public function Main() {
			var column:int = 0;
			var columnchecker:int = 9;
			xmlLoader = new XmlLoader(this);
			txtEnterData.restrict = "a-z0-9";
			txtEnterData.maxChars = 12;
			for (var i:int = 0; i < MAX_FLOORS; i++){
				var newbtn:Button = new Button();
				var newtxt:TextBox = new TextBox();
				newtxt.x = 70 * column;
				newtxt.y = (i * 34)- (340 * column);
				newtxt._tf.text = (i+1).toString();
				newbtn.x = 70 * column + 32;
				newbtn.y = (i * 34) - (340 * column);
				btnContainer.addChild(newtxt);
				btnContainer.addChild(newbtn);
				if (columnchecker != 0){
					columnchecker--;
				}
				else{
					columnchecker = 9;
					column++;
				}
				newbtn.addEventListener(MouseEvent.CLICK, ButtonClicked);
				newbtn.floor = (i+1);
				buttonArray.push(newbtn);
				trace("Added Button For Floor:"+buttonArray[i].floor);
			}
			btnLoad.addEventListener(MouseEvent.CLICK, LoadClicked);
			btnSave.addEventListener(MouseEvent.CLICK, SaveClicked);
		}
		
		public function ButtonClicked(e:MouseEvent){
			e.currentTarget.Click();
		}
		
		public function LoadClicked(e:MouseEvent){
			trace("Load button clicked");
			if (txtEnterData.text.length > 0){
				//var appendString = txtEnterData.text + ".xml";
				xmlLoader.LoadXML(txtEnterData.text);
			}
		}
		
		public function UpdateButtons():void {
			trace("Attempting to update buttons");
			//trace(xmlData.children().length());
			var dataLength:int = xmlData.children().length();
			for (var i:int = 0; i < dataLength; i++){
				//trace(xmlData.data[i]);
				buttonArray[i].LoadState(xmlData.floor[i].@state);
			}
			txtLoadedData.text = txtEnterData.text;
			//trace(xmlData.floor[0].@state);
		}
		public function SaveClicked(e:MouseEvent){
			trace("Save button clicked");
			if (txtEnterData.text.length > 0){
				var newXml:XML;
				var i:int;
				xmlToSave = null;
				xmlToSave = "<data>\n";
				//xmlToSave = xmlToSave + "\t<floors>\n";
				var buttonData:Array;
				for (i = 0; i < buttonArray.length; i++){
					buttonData = buttonArray[i].GetButtonData();
					allowSend = true; // this means theres actually data to send.
					xmlToSave = xmlToSave + "\t<floor floor=\""+buttonData[0]+"\" state=\""+buttonData[1]+"\"></floor>\n";
				}
				//xmlToSave = xmlToSave + "\t</floors>\n";
				xmlToSave = xmlToSave + "</data>\n";
				if (allowSend){
					newXml = new XML(xmlToSave);
					// pass string to php routine which saves the data, using POST method
					var SERVER_PATH:String = "";
					var foldername:String = "../Games/DungeoneeringData/";
					var	filename = txtEnterData.text + ".xml";
					var dataPass:URLVariables = new URLVariables;
					var urlLoader:URLLoader = new URLLoader;
					var previewRequest:URLRequest = new URLRequest("http://www.andrew-williams-page.com/php/SaveXML.php");
					previewRequest.method = URLRequestMethod.POST;
					dataPass.filename = filename;
					dataPass.xmlcontents = newXml;//appendedXml;
					dataPass.foldername = foldername;
					previewRequest.data = dataPass;
					urlLoader.load(previewRequest);
				}
				allowSend = false;
			}
			else{
				trace("no characters..");
			}
		}
		
		
	}
	
}
