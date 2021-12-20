package days;

import util.Direction.*;

private enum abstract Pixel(String) from String {
	final Light = "#";
	final Dark = ".";
}

class Day20 {
	public static function countPixelsAfterEnhancements(input:String, enhancements:Int):Int {
		final parts = input.split("\n\n");
		final algorithm:Array<Pixel> = parts[0].split("");
		final region = [Up + Left, Up, Up + Right, Left, None, Right, Down + Left, Down, Down + Right];
		var image = Util.parseGrid(parts[1], s -> (s : Pixel)).map;
		var emptySpace = Dark;
		for (_ in 0...enhancements) {
			final output = new HashMap<Point, Pixel>();
			final bounds = Util.findBounds(image.keys().iterable());
			final expansion = 2;
			for (x in bounds.min.x - expansion...bounds.max.x + expansion) {
				for (y in bounds.min.y - expansion...bounds.max.y + expansion) {
					final pos = new Point(x, y);
					final index = new Bits(region.map(dir -> if (image.getOrDefault(pos + dir, emptySpace) == Light) 1 else 0)).toInt();
					output[pos] = algorithm[index];
				}
			}
			emptySpace = if (emptySpace == Dark) algorithm[0] else algorithm.last();
			image = output;
		}
		return image.count(pixel -> pixel == Light);
	}
}
