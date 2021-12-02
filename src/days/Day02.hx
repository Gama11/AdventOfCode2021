package days;

class Day02 {
	private static function parse(input:String):Array<Instruction> {
		return input.split("\n").map(function(line):Instruction {
			final parts = line.split(" ");
			return {type: cast parts[0], amount: Std.parseInt(parts[1])};
		});
	}

	public static function pilotSubmarine(input:String):Int {
		var depth = 0;
		var horizontal = 0;
		for (instruction in parse(input)) {
			final amount = instruction.amount;
			switch instruction.type {
				case Forward:
					horizontal += amount;
				case Down:
					depth += amount;
				case Up:
					depth -= amount;
			}
		}
		return depth * horizontal;
	}

	
	public static function pilotSubmarineCorrectly(input:String):Int {
		var aim = 0;
		var depth = 0;
		var horizontal = 0;
		for (instruction in parse(input)) {
			final amount = instruction.amount;
			switch instruction.type {
				case Forward:
					horizontal += amount;
					depth += aim * amount;
				case Down:
					aim += amount;
				case Up:
					aim -= amount;
			}
		}
		return depth * horizontal;
	}
}

private typedef Instruction = {
	final type:InstructionType;
	final amount:Int;
}

private enum abstract InstructionType(String) {
	final Forward = "forward";
	final Up = "up";
	final Down = "down";
}
