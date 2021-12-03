package days;

class Day03 {
	static function parse(input:String) {
		return input;
	}

	public static function calculatePowerConsumption(input:String):Int {
		final numbers = input.split("\n").map(line -> line.split("").map(Std.parseInt));
		final counts = numbers[0].map(_ -> 0);
		for (number in numbers) {
			for (i => bit in number) {
				if (bit == 1) {
					counts[i]++;
				}
			}
		}
		final gammaRate = counts.map(count -> if (count >= numbers.length / 2) 1 else 0);
		final epsilonRate = gammaRate.map(bit -> if (bit == 1) 0 else 1);

		function toNumber(bits:Array<Int>) {
			bits.reverse();
			return bits.foldi((bit, result, index) -> result + bit * Std.int(Math.pow(2, index)), 0);
		}
		return toNumber(gammaRate) * toNumber(epsilonRate);
	}
}
