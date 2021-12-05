package days;

class Day05 {
	public static function countOverlappingPoints(input:String):Int {
		final lines = input.split("\n").map(function(line) {
			final parts = line.split(" -> ").map(function(point) {
				final parts = point.splitToInt(",");
				return new Point(parts[0], parts[1]);
			});
			return {a: parts[0], b: parts[1]};
		});
		final grid = new HashMap<Point, Int>();
		for (line in lines) {
			final a = line.a;
			final b = line.b;
			final horizontal = a.x == b.x;
			final vertical = a.y == b.y;
			if (horizontal || vertical) {
				var current = a;
				var dir = b - a;
				dir = new Point(dir.x.sign(), dir.y.sign());
				while (true) {
					grid[current] = grid.getOrDefault(current, 0) + 1;
					if (current == b) {
						break;
					}
					current += dir;
				}
			}
		}
		return grid.array().count(c -> c > 1);
	}
}
