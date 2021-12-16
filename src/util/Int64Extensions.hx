package util;

class Int64Extensions {
	public static function sum(a:Array<Int64>):Int64 {
		return a.fold((a, b) -> a + b, 0);
	}

	public static function product(a:Array<Int64>):Int64 {
		return a.fold((a, b) -> a * b, 1);
	}

	public static function max64<T>(a:Array<T>, f:T->Int64) {
		var maxValue:Null<Int64> = null;
		var list = [];
		for (e in a) {
			var value = f(e);
			if (maxValue == null || value > maxValue) {
				maxValue = value;
				list = [e];
			} else if (value == maxValue) {
				list.push(e);
			}
		}
		return {list: list, value: maxValue};
	}

	public static function min64<T>(a:Array<T>, f:T->Int64) {
		var minValue:Null<Int64> = null;
		var list = [];
		for (e in a) {
			var value = f(e);
			if (minValue == null || value < minValue) {
				minValue = value;
				list = [e];
			} else if (value == minValue) {
				list.push(e);
			}
		}
		return {list: list, value: minValue};
	}

	public static inline function clearBit(value:Int64, offset:Int):Int64 {
		return value & ~((1 : Int64) << offset);
	}

	public static inline function setBit(value:Int64, offset:Int):Int64 {
		return value | (1 : Int64) << offset;
	}
}
