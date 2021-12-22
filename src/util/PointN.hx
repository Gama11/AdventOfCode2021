package util;

import haxe.ds.ReadOnlyArray;
import polygonal.ds.Hashable;

@:forward(dimensions)
@:forward.new
abstract PointN(PointNImpl) from PointNImpl to Hashable {
	public static function neighbors(dimensions:Int):Array<PointN> {
		function recurse(dimensions:Int):Array<Array<Int>> {
			if (dimensions == 0) {
				return [[]];
			}
			final neighbors = [];
			for (i in -1...2) {
				final lowerDimensionsNeighbors = recurse(dimensions - 1);
				for (lower in lowerDimensionsNeighbors) {
					lower.push(i);
					neighbors.push(lower);
				}
			}
			return neighbors;
		}
		return recurse(dimensions).filter(a -> a.exists(i -> i != 0)).map(a -> new PointN(a));
	}

	public var coordinates(get, never):ReadOnlyArray<Int>;

	function get_coordinates() {
		return this.coordinates;
	}

	public var x(get, never):Int;

	function get_x()
		return get(0);

	public var y(get, never):Int;

	function get_y()
		return get(1);

	public var z(get, never):Int;

	function get_z()
		return get(2);

	@:op(A + B) function add(point:PointN):PointN {
		return new PointN([for (i in 0...this.dimensions) (this : PointN) [i] + point[i]]);
	}

	@:op(A - B) function subtract(point:PointN):PointN {
		return new PointN([for (i in 0...this.dimensions) (this : PointN) [i] - point[i]]);
	}

	@:op(A == B) function equals(point:PointN):Bool {
		return this.coordinates.equals((cast point : PointNImpl).coordinates);
	}

	@:op(A != B) inline function notEquals(point:PointN):Bool {
		return !equals(point);
	}

	@:arrayAccess inline function get(i:Int):Int {
		return this.coordinates[i];
	}

	public function distanceTo(point:PointN) {
		final result:PointNImpl = cast subtract(point);
		return result.coordinates.map(i -> Std.int(Math.abs(i))).sum();
	}
}

private class PointNImpl implements Hashable {
	public final coordinates:Array<Int>;

	public var dimensions(get, never):Int;

	inline function get_dimensions()
		return coordinates.length;

	public var key(default, null):Int;

	public function new(coordinates) {
		this.coordinates = coordinates;
		key = Util.hashCode(coordinates);
	}

	public function toString():String {
		return '(${coordinates.join(", ")})';
	}

	public function equals(other:PointNImpl):Bool {
		return coordinates.equals(other.coordinates);
	}
}
