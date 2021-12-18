package days;

private enum Number {
	Pair(left:Number, right:Number);
	Regular(value:Int);
}

class Day18 {
	public static function parse(input:String):Number {
		final input = input.split("");
		function next() {
			return input.shift();
		}
		function assert(char:String) {
			if (next() != char) {
				throw 'expected $char';
			}
		}
		function parse():Number {
			return switch next() {
				case "[":
					final left = parse();
					assert(",");
					final right = parse();
					assert("]");
					Pair(left, right);

				case number:
					final value = Std.parseInt(number);
					if (value == null) {
						throw "expected a number but got " + number;
					}
					Regular(value);
			}
		}
		return parse();
	}

	public static function print(number:Number) {
		return switch number {
			case Pair(left, right): "[" + print(left) + "," + print(right) + "]";
			case Regular(value): Std.string(value);
		}
	}

	public static function explode(number:Number) {
		var explosions = 0;
		function explode(number:Number, depth = 0) {
			return switch number {
				case Pair(Regular(left), Regular(right)) if (depth == 4):
					explosions++;
					if (explosions == 1) {
						{number: Regular(0), explosion: {left: left, right: right}};
					} else {
						{number: number, explosion: null};
					}

				case Pair(left, right):
					final leftResult = explode(left, depth + 1);
					final rightResult = explode(right, depth + 1);
					var leftNumber = leftResult.number;
					var rightNumber = rightResult.number;

					final explosion = if (rightResult.explosion != null && rightResult.explosion.left != null) {
						function addToRightmost(number:Number) {
							return switch number {
								case Pair(left, right): Pair(left, addToRightmost(right));
								case Regular(value): Regular(value + rightResult.explosion.left);
							}
						}
						leftNumber = addToRightmost(left);
						{left: null, right: rightResult.explosion.right};
					} else if (leftResult.explosion != null && leftResult.explosion.right != null) {
						function addToLeftmost(number:Number) {
							return switch number {
								case Pair(left, right): Pair(addToLeftmost(left), right);
								case Regular(value): Regular(value + leftResult.explosion.right);
							}
						}
						rightNumber = addToLeftmost(right);
						{left: leftResult.explosion.left, right: null};
					} else if (leftResult.explosion != null) {
						leftResult.explosion;
					} else {
						rightResult.explosion;
					}
					{number: Pair(leftNumber, rightNumber), explosion: explosion};

				case Regular(_):
					{number: number, explosion: null};
			}
		}
		return {number: explode(number).number, done: explosions == 0};
	}

	static function split(number:Number) {
		var splits = 0;
		function split(number:Number) {
			return switch number {
				case Pair(left, right):
					Pair(split(left), split(right));

				case Regular(value):
					if (value >= 10) {
						splits++;
						if (splits == 1) {
							Pair(Regular(Math.floor(value / 2)), Regular(Math.ceil(value / 2)));
						} else {
							number;
						}
					} else {
						number;
					}
			}
		}
		return {number: split(number), done: splits == 0};
	}

	public static function magnitude(number:Number) {
		return switch number {
			case Pair(left, right): 3 * magnitude(left) + 2 * magnitude(right);
			case Regular(value): value;
		}
	}

	public static function reduce(number:Number) {
		final actions = [explode, split];
		var index = 0;
		while (true) {
			final result = actions[index](number);
			number = result.number;
			if (result.done) {
				index++;
			} else {
				index = 0;
			}
			if (index >= actions.length) {
				return number;
			}
		}
	}

	public static function sum(input:String) {
		final numbers = input.split("\n").map(parse);
		var sum = numbers[0];
		for (i in 1...numbers.length) {
			sum = reduce(Pair(sum, numbers[i]));
		}
		return sum;
	}
}
