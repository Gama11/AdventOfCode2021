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
					Regular(Std.parseInt(number));
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
		var alreadyExploded = false;
		function explode(number:Number, depth = 0) {
			return switch number {
				case Pair(Regular(left), Regular(right)) if (depth == 4 && !alreadyExploded):
					alreadyExploded = true;
					{number: Regular(0), explosion: {left: left, right: right}};

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

				case Regular(value):
					{number: Regular(value), explosion: null};
			}
		}
		return explode(number).number;
	}

	public static function calculateSumMagnitude(input:String):Int {
		final numbers = input.split("\n").map(parse);
		var sum = numbers[0];
		for (i in 1...numbers.length) {
			sum = Pair(sum, numbers[i]);
			break;
		}
		return 0;
	}
}
