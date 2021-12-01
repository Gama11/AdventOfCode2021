package days;

import haxe.ds.ReadOnlyArray;

class Day01 {
	public static function countIncreases(input:Array<Int>):Int {
		var increases = 0;
		slidingWindow(input, 2, function(window) {
			if (window[1] > window[0]) {
				increases++;
			}
		});
		return increases;
	}

	public static function countIncreasesWindowed(input:Array<Int>):Int {
		final sums = [];
		slidingWindow(input, 3, function(window) {
			sums.push(window.sum());
		});
		return countIncreases(sums);
	}

	private static function slidingWindow(numbers:ReadOnlyArray<Int>, size:Int, f:(window:Array<Int>) -> Void) {
		final window = [for (i in 0...size) numbers[i]];
		for (i in size...numbers.length) {
			f(window);
			window.shift();
			window.push(numbers[i]);
		}
		f(window);
	}
}
