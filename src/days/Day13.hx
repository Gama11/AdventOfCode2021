package days;

private enum Fold {
	Horizontal(y:Int);
	Vertical(x:Int);
}

class Day13 {
	public static function fold(input:String, once:Bool):Int {
		final parts = input.split("\n\n");
		final points = parts[0].split("\n").map(function(line) {
			final coords = line.splitToInt(",");
			return new Point(coords[0], coords[1]);
		});
		var paper = new HashMap<Point, Bool>();
		for (point in points) {
			paper[point] = true;
		}
		final instructions = parts[1].split("\n").map(function(line) {
			final regex = ~/fold along (x|y)=(\d+)/;
			regex.match(line);
			final amount = regex.int(2);
			return if (regex.matched(1) == "y") Horizontal(amount) else Vertical(amount);
		});
		for (instruction in instructions) {
			final newPaper = new HashMap<Point, Bool>();
			for (point in paper.keys()) {
				function mirror(coord:Int, line:Int) {
					return coord - (coord - line) * 2;
				}
				final newPos = switch instruction {
					case Horizontal(y) if (point.y > y): new Point(point.x, mirror(point.y, y));
					case Vertical(x) if (point.x > x): new Point(mirror(point.x, x), point.y);
					case _: point;
				}
				newPaper[newPos] = true;
			}
			paper = newPaper;
			if (once) {
				break;
			}
		}
		// File.saveContent("paper.txt", Util.renderPointHash(paper, b -> if (b) "#" else "."));
		return paper.count();
	}
}
