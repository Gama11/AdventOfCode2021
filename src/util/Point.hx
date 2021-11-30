package util;

import polygonal.ds.Hashable;

@:forward
@:forward.new
abstract Point(PointImpl) from PointImpl to Hashable {
	@:op(A + B) inline function add(point:Point):Point {
		return new Point(this.x + point.x, this.y + point.y);
	}

	@:op(A - B) inline function subtract(point:Point):Point {
		return new Point(this.x - point.x, this.y - point.y);
	}

	@:op(A * B) inline function scale(n:Int):Point {
		return new Point(this.x * n, this.y * n);
	}

	@:op(A == B) inline function equals(point:Point):Bool {
		return this.x == point.x && this.y == point.y;
	}

	@:op(A != B) inline function notEquals(point:Point):Bool {
		return !equals(point);
	}

	public inline function invert():Point {
		return new Point(-this.x, -this.y);
	}
}

private class PointImpl implements Hashable {
	public final x:Int;
	public final y:Int;

	public var key(default, null):Int;

	public inline function new(x, y) {
		this.x = x;
		this.y = y;
		key = x + 10000 * y;
	}

	public function distanceTo(point:Point):Int {
		return Std.int(Math.abs(x - point.x) + Math.abs(y - point.y));
	}

	public function angleBetween(point:Point):Float {
		// from FlxPoint
		var x:Float = point.x - x;
		var y:Float = point.y - y;
		var angle:Float = 0;
		if (x != 0 || y != 0) {
			var c1:Float = Math.PI * 0.25;
			var c2:Float = 3 * c1;
			var ay:Float = (y < 0) ? -y : y;

			if (x >= 0) {
				angle = c1 - c1 * ((x - ay) / (x + ay));
			} else {
				angle = c2 - c1 * ((x + ay) / (ay - x));
			}
			angle = ((y < 0) ? -angle : angle) * (180 / Math.PI);

			if (angle > 90) {
				angle = angle - 270;
			} else {
				angle += 90;
			}
		}
		return angle;
	}

	public function shortString():String {
		return '$x,$y';
	}

	public function toString():String {
		return '($x, $y)';
	}
}
