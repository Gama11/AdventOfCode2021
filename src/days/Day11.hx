package days;

class Day11 {
	public static function countOctopusFlashes(input:String):Int {
		final grid = Util.parseGrid(input, Std.parseInt).map;
		var flashes = 0;
		for (_ in 0...100) {
			final flashed = new HashMap<Point, Bool>();
			function increaseEnergy(pos:Point) {
				if (flashed.exists(pos)) {
					return;
				}
				grid[pos]++;

				if (grid[pos] > 9) {
					grid[pos] = 0;
					flashed[pos] = true;
					for (dir in Direction.all) {
						final neighbor = pos + dir;
						if (grid.exists(neighbor)) {
							increaseEnergy(neighbor);
						}
					}
				}
			}
			for (pos in grid.keys()) {
				increaseEnergy(pos);
			}
			flashes += flashed.count();
		}
		return flashes;
	}
}
