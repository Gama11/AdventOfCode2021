package util;

class Int64Extensions {
	public static function sum(a:Array<Int64>):Int64 {
		return a.fold((a, b) -> a + b, 0);
	}

	public static function product(a:Array<Int64>):Int64 {
		return a.fold((a, b) -> a * b, 1);
	}

	public static inline function clearBit(value:Int64, offset:Int):Int64 {
		return value & ~((1 : Int64) << offset);
	}

	public static inline function setBit(value:Int64, offset:Int):Int64 {
		return value | (1 : Int64) << offset;
	}
}
