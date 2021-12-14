package days;

class Day14 {
	public static function solve(input:String):Int {
		final parts = input.split("\n\n");
		var polymer = parts[0].split("");
		final rules = [
			for (rule in parts[1].split("\n")) {
				final parts = rule.split(" -> ");
				parts[0] => parts[1];
			}
		];
		for (_ in 0...10) {
			var prev = polymer[0];
			final insertions = [];
			for (i in 1...polymer.length) {
				final c = polymer[i];
				final element = rules[prev + c];
				if (element != null) {
					insertions[i] = element;
				}
				prev = c;
			}
			var i = insertions.length;
			while (i-- > 0) {
				final element = insertions[i];
				if (element != null) {
					polymer.insert(i, element);
				}
			}
		}
		final counts = new Map<String, Int>();
		for (element in polymer) {
			counts[element] = counts.getOrDefault(element, 0) + 1;
		}
		final counts = counts.array().sorted();
		return counts.last() - counts[0];
	}
}
