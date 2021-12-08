package days;

class Day08 {
	static function parse(input:String) {
		return input.split("\n").map(function(line) {
			final parts = line.split(" | ");
			return {
				patterns: parts[0].split(" "),
				output: parts[1].split(" "),
			};
		});
	}

	public static function countUniqueSegmentOutputs(input:String):Int {
		function isUniqueDigit(digit:String) {
			final l = digit.length;
			return l == 2 || l == 4 || l == 3 || l == 7;
		}
		return parse(input).map(display -> display.output.count(isUniqueDigit)).sum();
	}
}
