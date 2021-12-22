package days;

class Day22 {
	public static function executeInitialization(input:String):Int {
		var steps = input.split("\n").map(function(line) {
			final r = ~/(on|off) x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)/;
			r.match(line);
			return {
				on: r.matched(1) == "on",
				min: new PointN([r.int(2), r.int(4), r.int(6)]),
				max: new PointN([r.int(3), r.int(5), r.int(7)])
			};
		});
		steps = steps.filter(s -> s.min.coordinates.foreach(c -> c >= -50) && s.max.coordinates.foreach(c -> c <= 50));
		final cubes = new Map<String, Bool>();
		for (step in steps) {
			final min = step.min;
			final max = step.max;
			for (x in min[0]...max[0] + 1) {
				for (y in min[1]...max[1] + 1) {
					for (z in min[2]...max[2] + 1) {
						cubes['$x,$y,$z'] = step.on;
					}
				}
			}
		}
		return cubes.count(it -> it == true);
	}
}
