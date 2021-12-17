package days;

class Day17 {
	public static function findHighestYPosition(input:String):Int {
		final regex = ~/target area: x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)/;
		regex.match(input);
		final minX = regex.int(1);
		final maxX = regex.int(2);
		final minY = regex.int(3);
		final maxY = regex.int(4);
		function shootProbe(velocity:Point) {
			var pos = new Point(0, 0);
			var bestY = 0;
			while (true) {
				pos += velocity;
				if (pos.y > bestY) {
					bestY = pos.y;
				}
				if (pos.x >= minX && pos.x <= maxX && pos.y >= minY && pos.y <= maxY) {
					return bestY;
				}
				if (pos.x >= maxX || pos.y < minY) {
					return null;
				}
				velocity = new Point(Std.int(Math.max(velocity.x - 1, 0)), velocity.y - 1);
			}
		}
		var maxY = 0;
		for (x in 0...100) {
			for (y in -100...100) {
				final probeMaxY = shootProbe(new Point(x, y));
				if (probeMaxY > maxY) {
					maxY = probeMaxY;
				}
			}
		}
		return maxY;
	}
}
