package days;

private enum Type {
	Corrupted;
	Incomplete;
}

class Day10 {
	static function calculateScoresFor(input:String, type:Type) {
		return input.split("\n")
			.map(function(line) {
				final stack = [];
				for (char in line.split("")) {
					switch char {
						case "(":
							stack.push(")");
						case "[":
							stack.push("]");
						case "<":
							stack.push(">");
						case "{":
							stack.push("}");
						case _:
							if (stack.pop() != char) {
								return {
									type: Corrupted,
									score: switch char {
										case ")": 3;
										case "]": 57;
										case "}": 1197;
										case ">": 25137;
										case _: throw 'unexpected $char';
									}
								};
							}
					}
				}
				return {
					type: Incomplete,
					score: [while (stack.length > 0) stack.pop()].fold((char, acc) -> acc * 5 + switch char {
						case ")": 1;
						case "]": 2;
						case "}": 3;
						case ">": 4;
						case _: throw 'unexpected $char';
					}, 0)
				};
			})
			.filter(it -> it.type == type)
			.map(it -> it.score);
	}

	public static function calculateSyntaxErrorScore(input:String):Int {
		return calculateScoresFor(input, Corrupted).sum();
	}

	public static function findMiddleCompletionScore(input:String):Int {
		final scores = calculateScoresFor(input, Incomplete);
		scores.sort(Reflect.compare);
		return scores[Std.int(scores.length / 2)];
	}
}
