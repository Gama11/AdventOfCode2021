package days;

class Day21 {
	static function parsePositions(input:String) {
		return input.split("\n").map(function(line) {
			return Std.parseInt(line.split(" ").last()) - 1;
		});
	}

	public static function playTrainingGame(input:String):Int {
		final positions = parsePositions(input);
		final scores = [0, 0];
		var player = 0;
		var die = 0;
		var rolls = 0;
		while (!scores.exists(it -> it >= 1000)) {
			final distance = [
				for (_ in 0...3) {
					final roll = die + 1;
					die = (die + 1) % 100;
					rolls++;
					roll;
				}
			].sum();
			positions[player] = (positions[player] + distance) % 10;
			scores[player] += positions[player] + 1;
			player = (player + 1) % positions.length;
		}
		return rolls * scores.find(it -> it < 1000);
	}

	public static function playDiracDice(input:String) {
		final positions = parsePositions(input);
		final possibleRolls = [for (a in 1...4) for (b in 1...4) for (c in 1...4) a + b + c];
		final cache = new Map<String, Array<Int64>>();
		function play(score1:Int, score2:Int, pos1:Int, pos2:Int, roll:Int, turn:Bool):Array<Int64> {
			final hash = '$score1,$score2,$pos1,$pos2,$roll,$turn';
			if (cache.exists(hash)) {
				return cache[hash];
			}
			if (roll != 0) {
				if (turn) {
					pos1 = (pos1 + roll) % 10;
					score1 += pos1 + 1;
				} else {
					pos2 = (pos2 + roll) % 10;
					score2 += pos2 + 1;
				}
				turn = !turn;
			}
			final wins:Array<Int64> = if (score1 >= 21) {
				[1, 0];
			} else if (score2 >= 21) {
				[0, 1];
			} else {
				final wins:Array<Int64> = [0, 0];
				for (roll in possibleRolls) {
					final result = play(score1, score2, pos1, pos2, roll, turn);
					wins[0] += result[0];
					wins[1] += result[1];
				}
				wins;
			}
			cache[hash] = wins;
			return wins;
		}
		return play(0, 0, positions[0], positions[1], 0, true).max64(i -> i).value;
	}
}
