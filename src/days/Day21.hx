package days;

class Day21 {
	public static function playDiracDice(input:String):Int {
		final positions = input.split("\n").map(function(line) {
			return Std.parseInt(line.split(" ").last()) - 1;
		});
		final scores = [0, 0];
		var player = 0;
		var die = 0;
		var rolls = 0;
		while (!scores.exists(it -> it >= 1000)) {
			final distance = [for (_ in 0...3) {
				final roll = die + 1;
				die = (die + 1) % 100;
				rolls++;
				roll;
			}].sum();
			positions[player] = (positions[player] + distance) % 10;
			scores[player] += positions[player] + 1;
			player = (player + 1) % positions.length;
		}
		return rolls * scores.find(it -> it < 1000);
	}
}
