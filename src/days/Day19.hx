package days;

class Day19 {
	static function parseReport(input:String):Array<Array<PointN>> {
		return input.split("\n\n").map(function(section) {
			final beacons = section.split("\n");
			beacons.shift();
			return beacons.map(function(line) {
				return new PointN(line.splitToInt(","));
			});
		});
	}

	static final rotations = [
		[[1, 0, 0], [0, 1, 0], [0, 0, 1]],
		[[1, 0, 0], [0, 0, -1], [0, 1, 0]],
		[[1, 0, 0], [0, -1, 0], [0, 0, -1]],
		[[1, 0, 0], [0, 0, 1], [0, -1, 0]],
		//
		[[0, -1, 0], [1, 0, 0], [0, 0, 1]],
		[[0, 0, 1], [1, 0, 0], [0, 1, 0]],
		[[0, 1, 0], [1, 0, 0], [0, 0, -1]],
		[[0, 0, -1], [1, 0, 0], [0, -1, 0]],
		//
		[[-1, 0, 0], [0, -1, 0], [0, 0, 1]],
		[[-1, 0, 0], [0, 0, -1], [0, -1, 0]],
		[[-1, 0, 0], [0, 1, 0], [0, 0, -1]],
		[[-1, 0, 0], [0, 0, 1], [0, 1, 0]],
		//
		[[0, 1, 0], [-1, 0, 0], [0, 0, 1]],
		[[0, 0, 1], [-1, 0, 0], [0, -1, 0]],
		[[0, -1, 0], [-1, 0, 0], [0, 0, -1]],
		[[0, 0, -1], [-1, 0, 0], [0, 1, 0]],
		//
		[[0, 0, -1], [0, 1, 0], [1, 0, 0]],
		[[0, 1, 0], [0, 0, 1], [1, 0, 0]],
		[[0, 0, 1], [0, -1, 0], [1, 0, 0]],
		[[0, -1, 0], [0, 0, -1], [1, 0, 0]],
		//
		[[0, 0, -1], [0, -1, 0], [-1, 0, 0]],
		[[0, -1, 0], [0, 0, 1], [-1, 0, 0]],
		[[0, 0, 1], [0, 1, 0], [-1, 0, 0]],
		[[0, 1, 0], [0, 0, -1], [-1, 0, 0]],
	].map(RotationMatrix.new);

	static function findOverlap(a:Array<PointN>, b:Array<PointN>) {
		for (rotation in rotations) {
			final rotated = b.map(p -> rotation.applyTo(p));
			final counts = new HashMap<PointN, Int>();
			for (b1 in a) {
				for (b2 in rotated) {
					final offset = b1 - b2;
					final newCount = counts.getOrDefault(offset, 0) + 1;
					if (newCount >= 12) {
						return {rotation: rotation, offset: offset};
					}
					counts[offset] = newCount;
				}
			}
		}
		return null;
	}

	public static function countBeacons(input:String):Int {
		final report = parseReport(input);
		final overlaps = new Map();
		for (i1 => scan1 in report) {
			for (i2 => scan2 in report) {
				if (i1 == i2) {
					continue;
				}
				final overlap = findOverlap(scan1, scan2);
				if (overlap != null) {
					overlaps[i1] = overlaps.getOrDefault(i1, []).concat([{overlap: overlap, with: i2}]);
				}
			}
		}

		final grid = new HashMap<PointN, Bool>();
		for (index => scan in report) {
			function findPath(path:Array<Int>, next:Int) {
				if (path.contains(next)) {
					return null;
				}
				path = path.concat([next]);
				if (next == 0) {
					return path;
				}
				return overlaps[next].map(it -> findPath(path, it.with)).find(it -> it != null);
			}
			final path = findPath([], index);
			var prev = path.shift();
			for (step in path) {
				final overlap = overlaps[step].find(it -> it.with == prev).overlap;
				scan = scan.map(p -> overlap.rotation.applyTo(p) + overlap.offset);
				prev = step;
			}
			for (beacon in scan) {
				grid[beacon] = true;
			}
		}
		return grid.count();
	}
}

private abstract RotationMatrix(Array<Array<Int>>) {
	public function new(matrix) {
		this = matrix;
	}

	public function applyTo(point:PointN):PointN {
		final result = [for (_ in 0...3) 0];
		for (i in 0...this.length) {
			for (j in 0...this[0].length) {
				result[i] += this[i][j] * point[j];
			}
		}
		return new PointN(result);
	}
}
