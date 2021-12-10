package days;

class Day10 {
	public static function calculateSyntaxErrorScore(input:String):Int {
		return input.split("\n").map(function(line) {
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
							return switch char {
								case ")": 3;
								case "]": 57;
								case "}": 1197;
								case ">": 25137;
								case _: throw 'unexpected $char';
							}
						}
				}
			}
			return 0;
		}).sum();
	}
}
