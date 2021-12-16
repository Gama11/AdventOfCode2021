package days;

class Day03 {
	static function mostCommonBitness(numbers:Array<Bits>, index:Int):Int {
		return if (numbers.count(bits -> bits.isSet(index)) >= numbers.length / 2) 1 else 0;
	}

	public static function calculatePowerConsumption(input:String):Int {
		final numbers = input.split("\n").map(Bits.parse);
		final gammaRate = new Bits([for (i in 0...numbers[0].length) mostCommonBitness(numbers, i)]);
		final epsilonRate = gammaRate.inverted();
		return gammaRate.toInt() * epsilonRate.toInt();
	}

	public static function calculateLifeSupportRating(input:String):Int {
		final numbers = input.split("\n").map(Bits.parse);

		function filter(condition:(a:Int, b:Int) -> Bool):Bits {
			var filtered = numbers.copy();
			for (i in 0...numbers[0].length) {
				final mostCommon = mostCommonBitness(filtered, i);
				filtered = filtered.filter(n -> condition(n[i], mostCommon));
				if (filtered.length == 1) {
					return filtered[0];
				}
			}
			throw "never got down to one number";
		}
		final oxgenGeneratorRating = filter((a, b) -> a == b).toInt();
		final co2ScrubberRating = filter((a, b) -> a != b).toInt();
		return oxgenGeneratorRating * co2ScrubberRating;
	}
}
