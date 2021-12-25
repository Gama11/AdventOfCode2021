package days;

private enum abstract Tile(String) from String {
	final Empty = ".";
	final EastFacing = ">";
	final SouthFacing = "v";
}

class Day25 {
	public static function solve(input:String):Int {
		var grid = Util.parseGrid(input, s -> (s : Tile)).map;
		function move(target:Tile, direction:Direction, wrap:(Point) -> Point) {
			final moves = [];
			for (pos => tile in grid) {
				var next = pos + direction;
				if (!grid.exists(next)) {
					next = wrap(next);
				}
				if (tile == target && grid[next] == Empty) {
					moves.push({from: pos, to: next});
				}
			}
			for (move in moves) {
				grid[move.from] = Empty;
				grid[move.to] = target;
			}
			return moves.length > 0;
		}
		var step = 0;
		var anyMovement = true;
		while (anyMovement) {
			anyMovement = false;
			anyMovement = move(EastFacing, Direction.Right, p -> new Point(0, p.y));
			anyMovement = move(SouthFacing, Direction.Down, p -> new Point(p.x, 0)) || anyMovement;
			step++;
		}
		return step;
	}
}
