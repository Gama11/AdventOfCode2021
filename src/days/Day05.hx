package days;

class Day05 {
	public static function countOverlappingPoints(input:String, includeDiagonals:Bool):Int {
		var lines = input.split("\n").map(function(line) {
			final parts = line.split(" -> ").map(function(point) {
				final parts = point.splitToInt(",");
				return new Point(parts[0], parts[1]);
			});
			return {a: parts[0], b: parts[1]};
		});
		if (!includeDiagonals) {
			lines = lines.filter(l -> l.a.x == l.b.x || l.a.y == l.b.y);
		}
		final grid = new HashMap<Point, Int>();
		for (line in lines) {
			var current = line.a;
			var dir = line.b - line.a;
			dir = new Point(dir.x.sign(), dir.y.sign());
			while (true) {
				grid[current] = grid.getOrDefault(current, 0) + 1;
				if (current == line.b) {
					break;
				}
				current += dir;
			}
		}
		return grid.array().count(c -> c > 1);
	}
}
