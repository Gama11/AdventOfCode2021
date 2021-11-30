package util;

import polygonal.ds.Hashable;

@:forward(x, y)
abstract Direction(Point) to Point to Hashable {
	public static final Left = new Direction(-1, 0);
	public static final Up = new Direction(0, -1);
	public static final Down = new Direction(0, 1);
	public static final Right = new Direction(1, 0);

	public static final None = new Direction(0, 0);

	public static final horizontals = [Left, Up, Right, Down];
	public static final diagonals = [Left + Up, Right + Up, Left + Down, Right + Down];
	public static final all = horizontals.concat(diagonals);

	private inline function new(x:Int, y:Int) {
		this = new Point(x, y);
	}

	public function rotate(by:Int):Direction {
		var i = horizontals.indexOf((cast this : Direction)) + by;
		return horizontals[Util.mod(i, horizontals.length)];
	}

	public function toString() {
		return switch (this) {
			case Left: "Left";
			case Up: "Up";
			case Down: "Down";
			case Right: "Right";
			case _: "unknown direction";
		}
	}

	@:op(A + B) inline function add(dir:Direction):Direction {
		return new Direction(this.x + dir.x, this.y + dir.y);
	}

	@:op(A * B) inline function scale(n:Int):Direction {
		return new Direction(this.x * n, this.y * n);
	}
}
