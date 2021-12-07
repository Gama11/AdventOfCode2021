package days;

class Day07 {
	static final cache = new Map<Int, Int>();

	public static function increasing(distance:Int) {
		if (cache.exists(distance)) {
			return cache[distance];
		}
		return cache[distance] = if (distance == 0) 0 else increasing(distance - 1) + distance;
	}

	public static function linear(distance:Int)
		return distance;

	public static function findMinFuelCost(input:String, cost:(distance:Int) -> Int):Int {
		final crabPositions = input.splitToInt(",");
		crabPositions.sort(Reflect.compare);
		final min = crabPositions[0];
		final max = crabPositions.last();
		return [for (i in min...max) i].min(function(target) {
			return crabPositions.fold((pos, acc) -> acc + cost(Std.int(Math.abs(target - pos))), 0);
		}).value;
	}
}
