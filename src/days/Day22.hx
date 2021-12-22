package days;

class Day22 {
	static function parseSteps(input:String) {
		return input.split("\n").map(function(line) {
			final r = ~/(on|off) x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)/;
			r.match(line);
			final min = new PointN([r.int(2), r.int(4), r.int(6)]);
			final max = new PointN([r.int(3), r.int(5), r.int(7)]);
			return new Cuboid(min, max, r.matched(1) == "on");
		});
	}

	public static function executeInitialization(input:String):Int {
		var steps = parseSteps(input);
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

	public static function executeReboot(input:String):Int64 {
		return parseSteps(input) //
			.fold(function(step, cuboids:Array<Cuboid>) {
				return cuboids.flatMap(function(cuboid) {
					return if (!cuboid.overlaps(step)) {
						[cuboid];
					} else {
						cuboid.cut(step);
					}
				}).concat([step]);
			}, [])
			.filter(it -> it.on)
			.map(it -> it.size())
			.sum();
	}
}

class Cuboid {
	public final min:PointN;
	public final max:PointN;
	public final on:Bool;

	public function new(min, max, on) {
		this.min = min;
		this.max = max;
		this.on = on;
	}

	public function cut(cuboid:Cuboid):Array<Cuboid> {
		function length(term:Int):Int {
			return Std.int(Math.max(term, 0));
		}
		final result = new Array<Cuboid>();

		var leftX = min.x + length(cuboid.min.x - min.x);
		var rightX = max.x - length(max.x - cuboid.max.x);
		result.push(new Cuboid(min, new PointN([leftX - 1, max.y, max.z]), on));
		result.push(new Cuboid(new PointN([rightX + 1, min.y, min.z]), max, on));

		final leftY = min.y + length(cuboid.min.y - min.y);
		final rightY = max.y - length(max.y - cuboid.max.y);
		result.push(new Cuboid(new PointN([leftX, min.y, min.z]), new PointN([rightX, leftY - 1, max.z]), on));
		result.push(new Cuboid(new PointN([leftX, rightY + 1, min.z]), new PointN([rightX, max.y, max.z]), on));

		final leftZ = min.z + length(cuboid.min.z - min.z);
		final rightZ = max.z - length(max.z - cuboid.max.z);
		result.push(new Cuboid(new PointN([leftX, leftY, min.z]), new PointN([rightX, rightY, leftZ - 1]), on));
		result.push(new Cuboid(new PointN([leftX, leftY, rightZ + 1]), new PointN([rightX, rightY, max.z]), on));

		return result.filter(it -> it.size() > 0);
	}

	public function size():Int64 {
		return [for (i in 0...min.coordinates.length) (max[i] + 1 : Int64) -min[i]].product();
	}

	public function overlaps(cuboid:Cuboid):Bool {
		return [for (i in 0...min.coordinates.length) i].foreach(function(i) {
			return max[i] + 1 > cuboid.min[i] && min[i] < cuboid.max[i] + 1;
		});
	}
}
