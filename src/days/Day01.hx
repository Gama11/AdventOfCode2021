package days;

class Day01 {
	public static function countIncreases(input:String):Int {
		var increases = 0;
		final measurements = input.splitToInt("\n");
		var prevDepth = measurements.shift();
		for (depth in measurements) {
			if (depth > prevDepth) {
				increases++;
			}
			prevDepth = depth;
		}
		return increases;
	}
}
