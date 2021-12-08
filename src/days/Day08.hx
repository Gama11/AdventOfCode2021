package days;

using days.Day08;

private typedef Pattern = Array<String>;

class Day08 {
	static function parse(input:String) {
		return input.split("\n").map(function(line) {
			final parts = line.split(" | ");
			return {
				patterns: parts[0].split(" ").map(s -> s.split("")),
				output: parts[1].split(" ").map(s -> s.split("")),
			};
		});
	}

	public static function countUniqueSegmentOutputs(input:String):Int {
		function isUniqueDigit(pattern:Pattern) {
			final l = pattern.length;
			return l == 2 || l == 4 || l == 3 || l == 7;
		}
		return parse(input).map(display -> display.output.count(isUniqueDigit)).sum();
	}

	static function containsAllOf(a:Pattern, b:Pattern) {
		return b.foreach(it -> a.contains(it));
	}

	static function removeIf<T>(a:Array<T>, predicate:(T) -> Bool):T {
		final result = a.find(predicate);
		a.remove(result);
		return result;
	}

	public static function sumOutputs(input:String):Int {
		final displays = parse(input);
		return displays.map(function(display) {
			final patternsPerLength = new Map<Int, Array<Pattern>>();
			for (pattern in display.patterns) {
				patternsPerLength[pattern.length] = patternsPerLength.getOrDefault(pattern.length, []).concat([pattern]);
			}
			final numbers = [];
			numbers[1] = patternsPerLength[2][0];
			numbers[4] = patternsPerLength[4][0];
			numbers[7] = patternsPerLength[3][0];
			numbers[8] = patternsPerLength[7][0];

			final sixes = patternsPerLength[6];
			numbers[9] = sixes.removeIf(it -> it.containsAllOf(numbers[4]));
			numbers[0] = sixes.removeIf(it -> it.containsAllOf(numbers[1]));
			numbers[6] = sixes[0];

			final fives = patternsPerLength[5];
			numbers[3] = fives.removeIf(it -> it.containsAllOf(numbers[1]));
			numbers[5] = fives.removeIf(it -> numbers[6].containsAllOf(it));
			numbers[2] = fives[0];

			function normalize(pattern:Pattern) {
				pattern.sort(Reflect.compare);
				return pattern.join("");
			}
			final normalizedNumbers = numbers.map(normalize);
			final output = display.output.map(normalize);
			return Std.parseInt(output.fold((p1, acc:String) -> acc + normalizedNumbers.findIndex(p2 -> p1 == p2), ""));
		}).sum();
	}
}
