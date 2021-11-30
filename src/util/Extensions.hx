package util;

class Extensions {
	public static function int(reg:EReg, n:Int):Null<Int> {
		return Std.parseInt(reg.matched(n));
	}

	public static inline function splitToInt(s:String, delimiter:String):Array<Int> {
		return s.split(delimiter).map(Std.parseInt);
	}

	public static function sum(a:Array<Int>):Int {
		return a.fold((a, b) -> a + b, 0);
	}

	public static function product(a:Array<Int>):Int {
		return a.fold((a, b) -> a * b, 1);
	}

	public static function max<T>(a:Array<T>, f:T->Int) {
		var maxValue:Null<Int> = null;
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

	public static function min<T>(a:Array<T>, f:T->Int) {
		var minValue:Null<Int> = null;
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

	public static function tuples<T>(a:Array<T>):Array<{a:T, b:T}> {
		var result = [];
		for (e1 in a) {
			for (e2 in a) {
				if (e1 != e2) {
					result.push({a: e1, b: e2});
				}
			}
		}
		return result;
	}

	public static function permutations<T>(a:Array<T>):Array<Array<T>> {
		if (a.length == 2) {
			return [a, [a[1], a[0]]];
		} else {
			var list = [];
			for (item in a) {
				var copy = a.copy();
				copy.remove(item);
				for (permutation in permutations(copy)) {
					permutation.unshift(item);
					list.push(permutation);
				}
			}
			return list;
		}
	}

	public static function equals<T>(a1:Array<T>, a2:Array<T>):Bool {
		if (a1 == null && a2 == null)
			return true;
		if (a1 == null && a2 != null)
			return false;
		if (a1 != null && a2 == null)
			return false;
		if (a1.length != a2.length)
			return false;
		for (i in 0...a1.length)
			if (a1[i] != a2[i])
				return false;
		return true;
	}

	public static function filterDuplicates<T>(array:Array<T>, filter:(a:T, b:T) -> Bool):Array<T> {
		final unique:Array<T> = [];
		for (element in array) {
			var present = false;
			for (unique in unique)
				if (filter(unique, element))
					present = true;
			if (!present)
				unique.push(element);
		}
		return unique;
	}

	public static inline function unique<T>(array:Array<T>):Array<T> {
		return filterDuplicates(array, (e1, e2) -> e1 == e2);
	}

	public static function getOrDefault<K, V>(map:Map<K, V>, key:K, defaultValue:V):V {
		final value = map[key];
		return if (value == null) defaultValue else value;
	}

	public static inline function last<T>(array:Array<T>):T {
		return array[array.length - 1];
	}

	public static inline function isBitSet(value:Int, offset:Int):Bool {
		return value & (1 << offset) != 0;
	}

	public static inline function iterable<V>(iterator:Iterator<V>):Iterable<V> {
		return {iterator: () -> iterator};
	}

	public static inline function array<V>(iterator:Iterator<V>):Array<V> {
		return [for (i in iterator) i];
	}

	public static function intersection<T>(a:Array<T>, b:Array<T>):Array<T> {
		final result = [];
		for (e in a) {
			if (b.contains(e)) {
				result.push(e);
			}
		}
		return result;
	}

	public static inline function also<T>(t:T, f:T->Void):T {
		f(t);
		return t;
	}
}
