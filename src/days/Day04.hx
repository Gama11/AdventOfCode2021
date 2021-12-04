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

	public static function solve(input:String):Int {
		final parsed = parse(input);
		for (calledNumber in parsed.numbers) {
			for (board in parsed.boards) {
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
					return unmarkedSum * calledNumber;
				}
			}
		}
		throw "no winners";
	}
}
