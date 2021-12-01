package days;

import haxe.ds.ReadOnlyArray;

class Day01 {
	public static function countIncreases(depths:Array<Int>):Int {
		return windows(depths, 2).count(window -> window[1] > window[0]);
	}

	public static function countIncreasesWindowed(depths:Array<Int>):Int {
		return countIncreases(windows(depths, 3).map(window -> window.sum()));
	}

	private static function windows(numbers:ReadOnlyArray<Int>, size:Int):Array<Array<Int>> {
		final windows = [];
		final window = [for (i in 0...size) numbers[i]];
		for (i in size...numbers.length) {
			windows.push(window.copy());
			window.shift();
			window.push(numbers[i]);
		}
		windows.push(window);
		return windows;
	}
}
