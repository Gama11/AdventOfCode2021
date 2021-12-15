package days;

class Day09 {
	static function findLowPoints(grid:HashMap<Point, Int>):Array<Point> {
		return grid.keys().array().filter(function(pos) {
			return Direction.horizontals.foreach(dir -> grid.getOrDefault(pos + dir, 10) > grid.getOrDefault(pos, 0));
		});
	}

	public static function sumLowPointRiskLevels(input:String):Int {
		final grid = Util.parseGrid(input, Std.parseInt).map;
		return findLowPoints(grid).map(pos -> grid[pos] + 1).sum();
	}

	public static function calculateBasinSizeProduct(input:String):Int {
		final grid = Util.parseGrid(input, Std.parseInt).map;

		function findBasin(lowPoint:Point) {
			final basin = new HashMap<Point, Bool>();
			function expand(point:Point) {
				if (!grid.exists(point) || basin.exists(point) || grid[point] == 9) {
					return;
				}
				basin[point] = true;
				for (dir in Direction.horizontals) {
					expand(point + dir);
				}
			}
			expand(lowPoint);
			return basin.keys().array();
		}

		final basinSizes = findLowPoints(grid).map(lowPoint -> findBasin(lowPoint).count());
		basinSizes.sort((a, b) -> b - a);
		return basinSizes[0] * basinSizes[1] * basinSizes[2];
	}
}
