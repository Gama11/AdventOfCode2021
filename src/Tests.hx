import days.*;
import sys.io.File;
import utest.ITest;
import utest.UTest;

class Tests implements ITest {
	static function main() {
		UTest.run([new Tests()]);
	}

	function new() {}

	function data(name:String):String {
		return File.getContent('data/$name.txt').replace("\r", "");
	}

	function specDay01() {
		final example = data("day01/example").splitToInt("\n");
		final input = data("day01/input").splitToInt("\n");

		7 == Day01.countIncreases(example);
		1692 == Day01.countIncreases(input);

		5 == Day01.countIncreasesWindowed(example);
		1724 == Day01.countIncreasesWindowed(input);
	}

	function specDay02() {
		150 == Day02.pilotSubmarine(data("day02/example"));
		1427868 == Day02.pilotSubmarine(data("day02/input"));

		900 == Day02.pilotSubmarineCorrectly(data("day02/example"));
		1568138742 == Day02.pilotSubmarineCorrectly(data("day02/input"));
	}

	function specDay03() {
		198 == Day03.calculatePowerConsumption(data("day03/example"));
		3633500 == Day03.calculatePowerConsumption(data("day03/input"));

		230 == Day03.calculateLifeSupportRating(data("day03/example"));
		4550283 == Day03.calculateLifeSupportRating(data("day03/input"));
	}
}
