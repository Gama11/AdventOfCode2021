package days;

class Day06 {
	public static function simulateFishPopulation(input:String, days:Int):Int {
		final population = input.splitToInt(",");
		for (_ in 0...days) {
			var newFish = 0;
			for (i => age in population) {
				population[i] = if (age == 0) {
					newFish++;
					6;
				} else {
					age - 1;
				}
			}
			for (_ in 0...newFish) {
				population.push(8);
			}
		}
		return population.length;
	}
}
