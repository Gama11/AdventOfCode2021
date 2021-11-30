package util;

class Util {
	public static function mod(a:Int, b:Int) {
		var r = a % b;
		return r < 0 ? r + b : r;
	}

	public static function mod64(a:Int64, b:Int64) {
		var r = a % b;
		return r < 0 ? r + b : r;
	}

	public static function bitCount(x:Int):Int {
		x = x - ((x >> 1) & 0x55555555);
		x = (x & 0x33333333) + ((x >> 2) & 0x33333333);
		x = (x + (x >> 4)) & 0x0F0F0F0F;
		x = x + (x >> 8);
		x = x + (x >> 16);
		return x & 0x0000003F;
	}

	public static function findBounds(points:Iterable<Point>) {
		final n = 9999999;
		var maxX = -n;
		var maxY = -n;
		var minX = n;
		var minY = n;
		for (pos in points) {
			maxX = Std.int(Math.max(maxX, pos.x));
			maxY = Std.int(Math.max(maxY, pos.y));
			minX = Std.int(Math.min(minX, pos.x));
			minY = Std.int(Math.min(minY, pos.y));
		}
		return {
			min: new Point(minX, minY),
			max: new Point(maxX, maxY)
		};
	}

	public static function renderPointGrid(points:Array<Point>, render:Point->String, empty = " "):String {
		var bounds = findBounds(points);
		var min = bounds.min;
		var max = bounds.max;

		var grid = [for (_ in 0...max.y - min.y + 1) [for (_ in 0...max.x - min.x + 1) empty]];
		for (pos in points) {
			grid[pos.y - min.y][pos.x - min.x] = render(pos);
		}
		return grid.map(row -> row.join("")).join("\n") + "\n";
	}

	public static function renderPointHash<T>(map:HashMap<Point, T>, render:T->String, empty = " "):String {
		return renderPointGrid([for (p in map.keys()) p], p -> render(map[p]), empty);
	}

	public static function parseGrid<T>(input:String, convert:String->T):Grid<T> {
		var grid = input.split("\n").map(line -> line.split(""));
		var result = new HashMap<Point, T>();
		for (y in 0...grid.length) {
			for (x in 0...grid[y].length) {
				result[new Point(x, y)] = convert(grid[y][x]);
			}
		}
		return {
			map: result,
			width: grid[0].length,
			height: grid.length
		};
	}

	public static function hashCode(a:Array<Int>):Int {
		var result = 17;
		for (n in a) {
			result  = 31 * result + n;
		}
		return result;
	}
}

typedef Grid<T> = {
	final map:HashMap<Point, T>;
	final width:Int;
	final height:Int;
}
