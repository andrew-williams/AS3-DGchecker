package  {
	
	import flash.display.MovieClip;
	
	
	public class Button extends MovieClip {
		
		private const UNCHECK:int = 1;
		private const CHECK:int = 2;
		private var state:int = 1;
		public var floor:int = 0;
		
		public function Button() {
			// constructor code
			this.gotoAndStop(UNCHECK);
		}
		
		public function Click():int{
			switch (state){
				case UNCHECK:
					this.gotoAndStop(CHECK);
					state = CHECK;
					break;
				case CHECK:
					this.gotoAndStop(UNCHECK);
					state = UNCHECK;
					break;
			}
			return state;
		}
		
		public function LoadState(newState:int):void{
			this.gotoAndStop(newState);
			state = newState;
		}
		
		public function GetButtonData():Array{
			return [floor, state];
		}
	}
	
}
