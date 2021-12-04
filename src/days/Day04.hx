package days;

class Day04 {
	static function parse(input:String) {
		final sections = input.split("\n\n");
		final numbers = sections.shift().splitToInt(",");
		final boards = sections.map(grid -> Util.parseGrid(grid, s -> {
			value: Std.parseInt(s),
			marked: false
		}, ~/\s+/g));
		return {numbers: numbers, boards: boards};
	}

	static function simulateBingo(input:String):Array<Int> {
		final parsed = parse(input);
		var boards = parsed.boards;
		final scores = [];
		for (calledNumber in parsed.numbers) {
			boards = boards.filter(function(board) {
				for (cell in board.map) {
					if (cell.value == calledNumber) {
						cell.marked = true;
					}
				}
				function line(horizontal:Bool) {
					return [
						for (x in 0...board.width) [
							for (y in 0...board.height) {
								var pos = if (horizontal) new Point(y, x) else new Point(x, y);
								board.map[pos];
							}
						]
					];
				}
				final hasWinningLine = line(true).concat(line(false)).exists(line -> line.foreach(cell -> cell.marked));
				if (hasWinningLine) {
					final unmarkedSum = board.map.array().filter(cell -> !cell.marked).map(cell -> cell.value).sum();
					scores.push(unmarkedSum * calledNumber);
				}
				return !hasWinningLine;
			});
		}
		return scores;
	}

	public static function findFirstWinner(input:String):Int {
		return simulateBingo(input)[0];
	}

	public static function findLastWinner(input:String):Int {
		return simulateBingo(input).last();
	}
}
