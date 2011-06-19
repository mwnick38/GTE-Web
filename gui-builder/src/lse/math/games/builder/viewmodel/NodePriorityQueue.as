package lse.math.games.builder.viewmodel 
{	
	import lse.math.games.builder.model.Node;
	
	/**
	 * NodePriorityQueue	 
	 * 
	 * @author Mark Egesdal
	 * 
	 * Sorts the nodes from front to back in a priority queue
	 * Deeper nodes and nodes to the right are toward the end
	 * 
	 * In keeping consistent with the Array class:
	 * 
	 * push(value:Node)		adds an item to the queue
	 * remove(value:Node)	removes an item from the queue
	 * shift():Node			remove/return the front of the queue
	 * pop():Node			remove/return the back of the queue 
	 * 
	 * front and back properties can be used to peak
	 * length property will iterate the queue to find a count
	 * 
	 * push() and remove() return position Node was inserted/removed, 
	 * which allows for a measure of algorithm efficieny
	 */
	public class NodePriorityQueue
	{
		private var _front:NodeWrapper = null;
		private var _back:NodeWrapper = null;
		
		public function NodePriorityQueue() {}
		
		public function get front():Node {
			return _front.node;
		}
		
		public function get back():Node {
			return _front.node;
		}
		
		public function get isEmpty():Boolean {
			return _front == null;
		}
		
		public function get length():int {
			var count:int = 0;
			for (var i:NodeWrapper = _front; i != null; i = i.next) {
				++count;
			}
			return count;
		}
		
		public function push(node:Node):int
		{		
			var idx:int = 0;
			var toAdd:NodeWrapper = new NodeWrapper(node);
			if (isEmpty) {				
				_front = _back = toAdd;				
			} else if (belongsBefore(_front, toAdd)) {
				insertBefore(_front, toAdd);
			} else {			
				for (var enqueued:NodeWrapper = _front; enqueued != null; enqueued = enqueued.next) {
					++idx;					
					if (belongsBefore(enqueued.next, toAdd)) {
						insertAfter(enqueued, toAdd);
						break;
					}					
				}
			}
			return idx;
		}
		
		public function remove(toRemove:Node):int
		{
			var idx:int = -1;
			if (!isEmpty) {			
				for (var enqueued:NodeWrapper = _front; enqueued != null; enqueued = enqueued.next) {
					++idx;
					if (enqueued.node == toRemove) {
						if (enqueued.next != null) enqueued.next.prev = enqueued.prev;
						if (enqueued.prev != null) enqueued.prev.next = enqueued.next;
						if (_front == enqueued) _front = enqueued.next;
						if (_back == enqueued) _back = enqueued.prev;
						break;						
					}					
				}
			}
			return idx;	
		}
		
		public function shift():Node
		{
			var rv:Node = null;
			if (_front != null) {
				rv = _front.node;
				_front = _front.next;
				if (_front == null) {
					_back = null;
				}
			}
			return rv;
		}
		
		public function pop():Node
		{
			var rv:Node = null;
			if (_back != null) {
				rv = _back.node;
				_back = _back.prev;
				if (_back == null) {
					_front = null;
				}
			}
			return rv;
		}
		
		public function contains(toCheck:Node):Boolean
		{
			var found:Boolean = false;
			if (!isEmpty) {
				for (var enqueued:NodeWrapper = _front; enqueued != null; enqueued = enqueued.next) {					
					if (enqueued.node == toCheck) {
						found = true;
						break;
					}
				}
			}
			return found;
		}
				
		private function insertBefore(enqueued:NodeWrapper, toAdd:NodeWrapper):void
		{			
			toAdd.next = enqueued;
			
			toAdd.prev = enqueued.prev;			
			if (toAdd.prev != null) toAdd.prev.next = toAdd;
			enqueued.prev = toAdd;
						
			if (enqueued == _front) {
				_front = toAdd;
			}
		}
				
		private function insertAfter(enqueued:NodeWrapper, toAdd:NodeWrapper):void
		{			
			toAdd.prev = enqueued;
			
			toAdd.next = enqueued.next;
			if (toAdd.next != null) toAdd.next.prev = toAdd;
			enqueued.next = toAdd;			
			
			if (enqueued == _back) {
				_back = toAdd;
			}
		}
		
		private function belongsBefore(enqueued:NodeWrapper, toAdd:NodeWrapper):Boolean
		{
			return (enqueued == null) || 
				(enqueued.node.depth > toAdd.node.depth) ||
				(enqueued.node.depth == toAdd.node.depth && enqueued.node.isRightOf(toAdd.node));
		}
	}
}
import lse.math.games.builder.model.Node;
class NodeWrapper
{
	public var node:Node;
	public var next:NodeWrapper = null;
	public var prev:NodeWrapper = null;
	function NodeWrapper(node:Node) { this.node = node; }
}