package days;

class Day15 {
	public static function findLowestRiskPath(input:String):Int {
		final grid = Util.parseGrid(input, Std.parseInt);
		final map = grid.map;
		final goal = new Point(grid.width - 1, grid.height - 1);
		return AStar.search([new SearchState(new Point(0, 0))], s -> s.pos == goal, s -> s.pos.distanceTo(goal), function(state) {
			return Direction.horizontals.map(dir -> state.pos + dir).filter(function(pos) {
				return map.exists(pos) && state.pos.distanceTo(goal) > pos.distanceTo(goal);
			}).map(function(pos) {
				final cost = map[pos];
				final newState = new SearchState(pos);
				return {
					state: newState,
					cost: cost
				}
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
