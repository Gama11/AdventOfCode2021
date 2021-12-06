package days;

class Day06 {
	public static function simulateFishPopulation(input:String, days:Int):Int64 {
		var countPerAge = [for (_ in 0...9) (0 : Int64)];
		final ages = input.splitToInt(",");
		for (age in ages) {
			countPerAge[age]++;
		}
		for (_ in 0...days) {
			final next = countPerAge.map(_ -> (0 : Int64));
			for (age => count in countPerAge) {
				final nextAge = if (age == 0) {
					next[8] += count;
					6;
				} else {
					age - 1;
				}
				next[nextAge] += count;
			}
			countPerAge = next;
		}
		return countPerAge.sum();
	}
}
