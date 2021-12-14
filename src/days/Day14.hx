package days;

class Day14 {
	public static function solve(input:String, maxDepth:Int):Int64 {
		final parts = input.split("\n\n");
		var polymer = parts[0].split("");
		final rules = [
			for (rule in parts[1].split("\n")) {
				final parts = rule.split(" -> ");
				parts[0] => parts[1];
			}
		];
		final cache = new Map<String, ElementCounts>();
		function expand(a:Element, b:Element, depth:Int) {
			if (depth >= maxDepth) {
				return new ElementCounts();
			}
			final hash = '$a,$b,$depth';
			if (cache.exists(hash)) {
				return cache[hash];
			}
			final counts = new ElementCounts();
			final c = rules[a + b];
			counts.mergeInto(expand(a, c, depth + 1));
			counts.mergeInto(expand(c, b, depth + 1));
			counts.increment(c);
			cache[hash] = counts;
			return counts;
		}
		final counts = new ElementCounts();
		var previous = polymer[0];
		counts.increment(previous);
		for (i in 1...polymer.length) {
			final current = polymer[i];
			counts.increment(current);
			counts.mergeInto(expand(previous, current, 0));
			previous = current;
		}
		return counts.calculateDifference();
	}
}

private typedef Element = String;

@:forward(keyValueIterator)
private abstract ElementCounts(Map<Element, Int64>) {
	public function new()
		this = [];

	public function increment(element:Element) {
		this[element] = this.getOrDefault(element, 0) + 1;
	}

	public function mergeInto(counts:ElementCounts) {
		for (element => count in counts) {
			this[element] = this.getOrDefault(element, 0) + count;
		}
	}

	public function calculateDifference() {
		final sorted = this.array().sorted(function(a, b) {
			return if (a < b) -1 else if (a > b) 1 else 0;
		});
		return sorted.last() - sorted[0];
	}
}
