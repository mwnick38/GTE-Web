package lse.math.games.builder.viewmodel
{
	import flash.text.engine.TextLine;
	import flash.text.engine.FontWeight;
	import flash.text.engine.FontPosture;
	import lse.math.games.builder.model.Rational;
	
	import lse.math.games.builder.view.AbstractPainter;	
	import lse.math.games.builder.view.IGraphics;
	
	import lse.math.games.builder.model.Iset;
	import lse.math.games.builder.model.Node;
	import lse.math.games.builder.model.Outcome;
	import lse.math.games.builder.model.Player;
	
	/**	 
	 * @author Mark Egesdal
	 */
	public class TreeGridPainter extends AbstractPainter
	{
		private static const pbuffx:Number = 4;      //correction required to display payoff
		private static const pbuffy:Number = 2;     //correction required to display payoff
		
		private var marginTop:Number = 0;
		private var marginBottom:Number = 0;
		private var marginLeft:Number = 0;
		private var marginRight:Number = 0;

		private var styleOutcome:Object = new Object();
		private var styleNode:Object = new Object();
		
		private var _leafCount:int;
		private var _minDepth:Number;
		private var _minBreadth:Number;
		
		private var _grid:TreeGrid;
		
		public function TreeGridPainter() 
		{
			super(this);
			
			styleNode["fontWeight"] = FontWeight.BOLD;
			styleNode["fontStyle"] = FontPosture.ITALIC;
			styleNode["fontSize"] = 15.0;
						
			styleOutcome["fontWeight"] = FontWeight.NORMAL;
			styleOutcome["fontStyle"] = FontPosture.NORMAL;
			styleOutcome["fontSize"] = 15.0;
		}
		
		public function set grid(value:TreeGrid):void {
			_grid = value;
		}
		
		override public function get drawWidth():Number {
			return ((_grid.rotate == 0 || _grid.rotate == 2) ? _minBreadth : _minDepth) + this.scale * TreeGrid.MIN_MARGIN_LEFT + this.scale * TreeGrid.MIN_MARGIN_RIGHT;
		}
		
		override public function get drawHeight():Number {
			return ((_grid.rotate == 0 || _grid.rotate == 2) ? _minDepth : _minBreadth) + this.scale * TreeGrid.MIN_MARGIN_TOP + this.scale * TreeGrid.MIN_MARGIN_BOTTOM;
		}
		
		override public function measureCanvas():void
		{
			_leafCount = _grid.numberLeaves();
			if (_leafCount < 1) {
				_minBreadth = 0;
			} else {
				//TODO: calculate based on leaf label height/widths
				_minBreadth = this.scale * ((_leafCount + 1) * TreeGrid.ISET_DIAM + _leafCount * TreeGrid.NODE_DIAM + 2 * _grid.ovallinewidth);
			}
			
			var maxdepth:int = _grid.maxDepth();
			//TODO: calculate leveldistance dynamically based on label height/width
			_minDepth = this.scale * (maxdepth * _grid.leveldistance + TreeGrid.ISET_DIAM  + 2 * _grid.ovallinewidth);
		}
		
		override public function paint(g:IGraphics, width:Number, height:Number):void
		{
			paintGrid(g, width, height, _grid);
		}
		
		override public function assignLabels():void
		{
			this.clearLabels();
			recAssignNodeLabels(_grid.root, _grid);			
		}
		
		private function paintGrid(g:IGraphics, width:Number, height:Number, grid:TreeGrid):void
		{
			setCanvasSize(width, height, grid);
			
			g.color = 0xFFFFFF;
			g.fillRect(0, 0, width, height);
			
			paintTree(g, grid);			
		}
		
		private function setCanvasSize(width:Number, height:Number, grid:TreeGrid):void
		{			
			marginTop = this.scale * TreeGrid.MIN_MARGIN_TOP;
			marginBottom = this.scale * TreeGrid.MIN_MARGIN_BOTTOM;
			marginLeft = this.scale * TreeGrid.MIN_MARGIN_LEFT;
			marginRight = this.scale * TreeGrid.MIN_MARGIN_RIGHT;
			
			//TODO: account for the outcome labels depending on rotation?
			if (grid.rotate == 0 || grid.rotate == 2) {
				var marginAdjustTB:Number = (height - _minDepth - this.scale * TreeGrid.MIN_MARGIN_TOP - this.scale * TreeGrid.MIN_MARGIN_BOTTOM) / 2;
				marginTop += marginAdjustTB;
				marginBottom += marginAdjustTB;
			} else if (grid.rotate == 1 || grid.rotate == 3) {
				var marginAdjustLR:Number = (width - _minDepth - this.scale * TreeGrid.MIN_MARGIN_LEFT - this.scale * TreeGrid.MIN_MARGIN_RIGHT) / 2;
				marginLeft += marginAdjustLR;
				marginRight += marginAdjustLR;
			}			
						
			var leafDistance:Number = (( -_leafCount * this.scale * TreeGrid.ISET_DIAM) + 
				(grid.rotate == 0 || grid.rotate == 2 ? width - marginLeft - marginRight : height - marginTop - marginBottom)) 
					/ (_leafCount + 1);
								
			recPositionTree(grid.root as TreeGridNode, 0, grid, width, height, leafDistance);		
			positionLabels(grid);
		}
		

		// Graphics painting
		private function paintTree(g:IGraphics, grid:TreeGrid):void
		{
			g.stroke = this.scale * grid.linewidth;
			recPaintTree(g, grid, grid.root as TreeGridNode);
		}
		
		// return a boolean is a selected node is in the subtree
		private function recPaintTree(g:IGraphics, grid:TreeGrid, n:TreeGridNode):Boolean
		{			
			var selectionFound:Boolean = false;
			var child:TreeGridNode = n.firstChild as TreeGridNode;
			
			if (n.isLeaf) {
				selectionFound = (n.number == grid.selectedNodeId);
			} else {
				while (child != null) {
					if (recPaintTree(g, grid, child)) {
						selectionFound = true;
					}
					child = child.sibling as TreeGridNode;
				}
			}
			
			var father:TreeGridNode = n.parent as TreeGridNode;
			if (father != null) {  // draw line to father
				g.color = selectionFound ? 0xFFD700 : 0x000000; //black
				g.drawLine(n.xpos, n.ypos, father.xpos, father.ypos) ;
			}
			
			if (n.outcome == null) {
				g.color = getNodeColor(n, grid, selectionFound);
				if (n.iset.player == Player.CHANCE) {	
					g.fillRect(n.xpos - this.scale * TreeGrid.NODE_DIAM/2, n.ypos - scale * TreeGrid.NODE_DIAM/2, scale * TreeGrid.NODE_DIAM, scale * TreeGrid.NODE_DIAM);
				} else {	
					g.fillCircle(n.xpos, n.ypos, this.scale * TreeGrid.NODE_DIAM / 2);
				}
			}
						
			return selectionFound;
		}		
		
		private function getNodeColor(n:Node, grid:TreeGrid, isSelected:Boolean):uint
		{
			var color:uint = isSelected ? 0xFFD700 : 0x000000;
			if (!isSelected && n.iset != null && n.iset.player != Player.CHANCE) {
				color = (grid.firstPlayer == n.iset.player ? grid.player1Color : grid.player2Color);
				if (n.iset == grid.mergeBase) { 
					color ^= 0xFFFFFF; // complement
					color &= 0x7FFF7F; // not too bright, and greenish
				}
			}
			return color;
		}		
		
		// Label assignment/registration		
		private function recAssignNodeLabels(n:Node, grid:TreeGrid):Boolean
		{
			var selected:Boolean = n.number == grid.selectedNodeId;
			for (var child:Node = n.firstChild; child != null; child = child.sibling) {
				if (recAssignNodeLabels(child, grid)) {
					selected = true;
				}
			}
			
			var father:Node = n.parent;
			if(father != null && n.reachedby != null) {
				var color:uint = selected ? 0xFFD700 : father.iset.player == Player.CHANCE ? 0x000000 : father.iset.player == grid.firstPlayer ? grid.player1Color : grid.player2Color;
				var text:String = n.reachedby.label;			
				//var text:String = n.number.toString();		//for debugging
				var key:String = getMoveLabelKey(n);
				registerLabel(key, text, color, grid.fontFamily, styleNode);
			}
			assignOutcomeLabel(n, grid);
			
			return selected;
		}
		
		private function assignOutcomeLabel(node:Node, grid:TreeGrid):void
		{		
			if (node.outcome != null) {
				var p1:Player = grid.firstPlayer;
				var p2:Player = grid.firstPlayer.nextPlayer;
				var pay1:Rational = node.outcome.pay(p1);
				var pay2:Rational = node.outcome.pay(p2);
				var pay1Str:String = pay1.isNaN ? "?" : pay1.toString();
				var pay2Str:String = pay2.isNaN ? "?" : pay2.toString();
				registerLabel(getOutcomeLabelKey(node, p1), pay1Str, grid.player1Color, grid.fontFamily, styleOutcome);
				registerLabel(getOutcomeLabelKey(node, p2), pay2Str, grid.player2Color, grid.fontFamily, styleOutcome);
			}
		}
		
		private function getMoveLabelKey(n:Node):String
		{
			return "move_" + n.number;
		}
		
		private function getOutcomeLabelKey(n:Node, pl:Player):String
		{
			return "outcome_" + n.number + ":" + pl.name;
		}		
		
		// Coord setting/Label positioning
		private function positionLabels(grid:TreeGrid):void
		{
			recPositionNodeLabels(grid.root as TreeGridNode, grid);
		}
		
		private function recPositionNodeLabels(n:TreeGridNode, grid:TreeGrid):void
		{			
			if (n.reachedby != null) 
			{
				var label:TextLine = this.labels[getMoveLabelKey(n)] as TextLine;						
				positionMoveLabel(n, grid, label);
			}

			if (n.outcome != null) 
			{
				var payoffLabel1:TextLine = this.labels[getOutcomeLabelKey(n, grid.firstPlayer)] as TextLine;				 
				var payoffLabel2:TextLine = this.labels[getOutcomeLabelKey(n, grid.firstPlayer.nextPlayer)] as TextLine;									
				positionOutcomeLabels(n, grid, payoffLabel1, payoffLabel2);
			}			
			
			var child:TreeGridNode = n.firstChild as TreeGridNode;
			while (child != null) {
				recPositionNodeLabels(child, grid);
				child = child.sibling as TreeGridNode;
			}
		}
		
		private function positionMoveLabel(n:TreeGridNode, grid:TreeGrid, label:TextLine):void
		{
			var parent:TreeGridNode = n.parent as TreeGridNode;
			var startx:Number = parent.xpos;
			var starty:Number = parent.ypos;
			var endx:Number = n.xpos;
			var endy:Number = n.ypos;
			
			var slope:Number = (n.ypos - starty) / (n.xpos - startx);
			//if (!isFinite(slope)) trace("divide by zero! less than zero: " + (slope < 0) + ", 1/m equal zero: " + (1/slope == 0));
			var delta:Number = (n.depth - parent.depth - 1) * this.scale * grid.leveldistance;
			
			if (grid.rotate == 2 || grid.rotate == 3) {
				delta = -delta;
			}
						
			if (grid.rotate == 0 || grid.rotate == 2) {					
				//startx += delta / slope;				
				//starty += delta;	
				endx -= delta / slope;
				endy -= delta;
			} else {					
				//startx += delta;
				//starty += slope * delta;					
				endx -= delta;
				endy -= slope * delta;
			}
			
			var labelxpos:Number = (endx + startx) / 2; //midx
			var labelypos:Number = (endy + starty) / 2;  //midy
						
			// This is the only place where an infinite slope is possible AND can get us into trouble
			var deltax:Number = 0;
			var deltay:Number = 0;
			if (isFinite(slope) && slope != 0) {
				if (slope > 0 && (grid.rotate == 0 || grid.rotate == 3)) {
					deltax = (-label.width + label.ascent * slope);
				} else if (slope < 0 && (grid.rotate == 0 || grid.rotate == 1)) {
					deltax = (label.width + label.ascent * slope);
				} else if (slope < 0 && (grid.rotate == 2 || grid.rotate == 3)) {
					deltax = (-label.width - label.ascent * slope); 
				}  else /* if (slope > 0 && (grid.rotate == 1 || grid.rotate == 2))*/ {
					deltax = (label.width - label.ascent * slope);
				}
				deltax /= (2 * (1 + slope * slope));
				deltay = deltax * slope;
			} else if (!isFinite(slope)) {
				deltax = 0;
				if (grid.rotate == 3 || grid.rotate == 0) {
					deltay = label.ascent / 2;
				} else /*if (grid.rotate == 1 || grid.rotate == 2)*/ {
					deltay = -label.ascent / 2;
				}
			} else /*if (slope == 0)*/ {
				deltay = 0;
				if (grid.rotate == 0 || grid.rotate == 1) {
					deltax = label.width / 2;
				} else /*if (grid.rotate == 2 || grid.rotate == 3)*/ {
					deltax = -label.width / 2;
				}
			}			
			
			labelxpos += deltax;
			labelypos += deltay;
						
			var buffer:Number = 1.5;
			switch (grid.rotate) {
				case 0: {
					labelxpos += (slope < 0) ? - (label.width + buffer) : buffer;
					labelypos += -buffer;					
					break;
				}
				case 1: {						
					labelxpos += -(label.width + buffer);	
					labelypos += (slope < 0) ? -buffer: label.ascent + buffer;
					break;
				}
				case 2: {
					labelxpos += (slope < 0) ? buffer: -label.width - buffer;
					labelypos += label.ascent + buffer;
					break;
				}	
				case 3: {						
					labelxpos += buffer;
					labelypos += (slope < 0) ? label.ascent + buffer: /*- label.descent*/ -buffer;
					break;						
				}
			}
			this.moveLabel(label, labelxpos, labelypos);			
		}
		
		private function positionOutcomeLabels(n:TreeGridNode, grid:TreeGrid, first:TextLine, second:TextLine):void
		{									
			var width1:Number = first.width;
			var height1:Number = first.height;
			var width2:Number = second.width;
			var height2:Number = second.height;
			
			var xpos1:Number;
			var ypos1:Number;
			var xpos2:Number;
			var ypos2:Number;
			
			var ascent1:Number = first.ascent;
			var ascent2:Number = second.ascent;
			
			if (grid.rotate == 0) {
				xpos1 = n.xpos - width1 / 2;
				xpos2 = n.xpos + width1 / 2 - width2;
				ypos1 = n.ypos + ascent1 + pbuffy;
				ypos2 = n.ypos + ascent2 + height1 + 2*pbuffy;
			} else if(grid.rotate == 1) {
				xpos1 = n.xpos + pbuffx;
				xpos2 = n.xpos + width1 + 2* pbuffx;
				ypos1 = n.ypos + ascent1 - height1 / 2;
				ypos2 = n.ypos + ascent2 - height2 / 2;							
			} else if(grid.rotate == 2) {
				xpos1 = n.xpos - width1 / 2;
				xpos2 = n.xpos + width1 / 2 - width2;
				ypos1 = n.ypos + ascent1 - height1 - pbuffy;
				ypos2 = n.ypos + ascent2 - height1 - height2 - 2*pbuffy;	
			} else {
				xpos1 = n.xpos - width1 - pbuffx;
				xpos2 = n.xpos - width1 - width2 - 2*pbuffx;
				ypos1 = n.ypos + ascent1 - height1 / 2;
				ypos2 = n.ypos + ascent2 - height2 / 2;
			}
			this.moveLabel(first, xpos1, ypos1);
			this.moveLabel(second, xpos2, ypos2);			
		}		
		
		private function recPositionTree(n:TreeGridNode, drawnumber:int, grid:TreeGrid, width:Number, height:Number, leafdistance:Number):int
		{
			positionNodeDepth(n, grid, width, height);

			if (n.isLeaf) 
			{
				var breadthPos:Number = (drawnumber + 1) * leafdistance + 
					this.scale * TreeGrid.ISET_DIAM * (drawnumber + 0.5);
					
				if (grid.rotate == 0 || grid.rotate == 2) {
					n.xpos = breadthPos + marginLeft;
				} else {
					n.ypos = breadthPos + marginTop;
				}
				return drawnumber + 1;				
			} else {
				for (var child:Node = n.firstChild; child != null; child = child.sibling) {
					drawnumber = recPositionTree(child as TreeGridNode, drawnumber, grid, width, height, leafdistance);										
				}
				
				//equal slopes of extreme nodes parent positioning
				var first:TreeGridNode = n.firstChild as TreeGridNode;
				var last:TreeGridNode = n.lastChild as TreeGridNode;				
				if (grid.rotate == 0 || grid.rotate == 2) 
				{		
					var deltaHeight1:Number = first.ypos - n.ypos;
					var deltaHeight2:Number = last.ypos - n.ypos;				
					n.xpos = (first.xpos*deltaHeight2 + last.xpos*deltaHeight1) / (deltaHeight1 + deltaHeight2);
				} else 
				{
					var deltaWidth1:Number = first.xpos - n.xpos;
					var deltaWidth2:Number = last.xpos - n.xpos;					
					n.ypos = (first.ypos*deltaWidth2 + last.ypos*deltaWidth1) / (deltaWidth1 + deltaWidth2);					
				}
				return drawnumber;				
			}	
		}		
		
		private function positionNodeDepth(n:TreeGridNode, grid:TreeGrid, width:Number, height:Number):void
		{
			var depthPos:Number = this.scale * (n.depth * grid.leveldistance + TreeGrid.ISET_DIAM / 2);		
			if (grid.rotate == 0) {
				n.ypos = depthPos + marginTop;
			} else if (grid.rotate == 1) {
				n.xpos = depthPos + marginLeft;
			} else if (grid.rotate == 2) {
				n.ypos = height - depthPos - marginBottom;
			} else {
				n.xpos = width - depthPos - marginRight;
			}
		}
	}
}