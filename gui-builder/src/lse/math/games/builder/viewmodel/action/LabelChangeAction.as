package lse.math.games.builder.viewmodel.action 
{
	import lse.math.games.builder.model.Move;
	import lse.math.games.builder.model.Node;
	import lse.math.games.builder.presenter.IAction;
	import lse.math.games.builder.viewmodel.TreeGrid;
	
	/**	
	 * @author Mark
	 */
	public class LabelChangeAction implements IAction
	{
		private var _nodeId:int;
		private var _label:String;
		
		public function LabelChangeAction(nodeId:int, label:String) 
		{
			_nodeId = nodeId;
			_label = label;
		}
		
		public function doAction(grid:TreeGrid):void
		{
			var node:Node = grid.getNodeById(_nodeId);
			if (node != null) {
				var move:Move = node.reachedby;
				if (move != null) {
					move.label = _label;
				}
			}
		}
				
		public function get changesData():Boolean {
			return true;
		}
		
		public function get changesSize():Boolean {
			return false; //TODO: if measurements are done by label widths, this will need to change
		}
		
		public function get changesDisplay():Boolean {
			return true;
		}
	}
}