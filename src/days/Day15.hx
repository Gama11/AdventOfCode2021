package days;

class Day15 {
	public static function findLowestRiskPath(input:String, scale:Int):Int {
		final grid = Util.parseGrid(input, Std.parseInt);
		final originalMap = grid.map.copy();
		final map = grid.map;
		for (x in 0...scale) {
			for (y in 0...scale) {
				for (pos => risk in originalMap) {
					risk = risk + x + y;
					if (risk > 9) {
						risk -= 9;
					}
					map[new Point(pos.x + grid.width * x, pos.y + grid.height * y)] = risk;
				}
			}
		}
		final goal = new Point((grid.width * scale) - 1, (grid.height * scale) - 1);
		return AStar.search([new SearchState(new Point(0, 0))], s -> s.pos == goal, s -> s.pos.distanceTo(goal), function(state) {
			return Direction.horizontals.map(dir -> state.pos + dir).filter(pos -> map.exists(pos)).map(pos -> {
				state: new SearchState(pos),
				cost: map[pos]
			});
		}).score;
	}
}

private class SearchState {
	public final pos:Point;

	public function new(pos) {
		this.pos = pos;
	}

	public function hash():String {
		return pos.toString();
	}
}
