package days;

class Day09 {
	static function findLowPoints(grid:HashMap<Point, Int>):Array<Point> {
		return grid.keys().array().filter(function(pos) {
			return Direction.horizontals.foreach(dir -> grid.getOrDefault(pos + dir, 10) > grid[pos]);
		});
	}

	public static function sumLowPointRiskLevels(input:String):Int {
		final grid = Util.parseGrid(input, Std.parseInt).map;
		return findLowPoints(grid).map(pos -> grid[pos] + 1).sum();
	}
}
