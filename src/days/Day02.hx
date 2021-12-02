package days;

class Day02 {
	public static function pilotSubmarine(input:String):Int {
		var depth = 0;
		var horizontal = 0;
		for (instruction in input.split("\n")) {
			final parts = instruction.split(" ");
			final amount = Std.parseInt(parts[1]);
			switch parts[0] {
				case "forward":
					horizontal += amount;
				case "down":
					depth += amount;
				case "up":
					depth -= amount;
			}
		}
		return depth * horizontal;
	}
}
