package days;

class Day03 {
	private static function mostCommonBitness(numbers:Array<Bits>, index:Int):Int {
		return if (numbers.count(bits -> bits.isSet(index)) >= numbers.length / 2) 1 else 0;
	}

	public static function calculatePowerConsumption(input:String):Int {
		final numbers = input.split("\n").map(Bits.parse);
		final gammaRate = new Bits([for (i in 0...numbers[0].length) mostCommonBitness(numbers, i)]);
		final epsilonRate = gammaRate.inverted();
		return gammaRate.toNumber() * epsilonRate.toNumber();
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
		final oxgenGeneratorRating = filter((a, b) -> a == b).toNumber();
		final co2ScrubberRating = filter((a, b) -> a != b).toNumber();
		return oxgenGeneratorRating * co2ScrubberRating;
	}
}

@:forward(length)
private abstract Bits(Array<Int>) {
	public static function parse(s:String)
		return new Bits(s.split("").map(Std.parseInt));

	public function new(bits:Array<Int>)
		this = bits;

	public function toNumber()
		return this.foldi(function(bit, result, index) {
			return result + bit * Std.int(Math.pow(2, this.length - 1 - index));
		}, 0);

	public function isSet(i:Int)
		return this[i] == 1;

	public function inverted():Bits
		return new Bits(this.map(bit -> if (bit == 1) 0 else 1));

	@:arrayAccess function get(i:Int):Int
		return this[i];
}
