import days.*;
import sys.io.File;
import utest.ITest;
import utest.UTest;
import haxe.Int64.parseString as int64;

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

	function specDay04() {
		4512 == Day04.findFirstWinner(data("day04/example"));
		49686 == Day04.findFirstWinner(data("day04/input"));

		1924 == Day04.findLastWinner(data("day04/example"));
		26878 == Day04.findLastWinner(data("day04/input"));
	}

	function specDay05() {
		5 == Day05.countOverlappingPoints(data("day05/example"), false);
		5169 == Day05.countOverlappingPoints(data("day05/input"), false);

		12 == Day05.countOverlappingPoints(data("day05/example"), true);
		22083 == Day05.countOverlappingPoints(data("day05/input"), true);
	}

	function specDay06() {
		26 == Day06.simulateFishPopulation(data("day06/example"), 18);
		5934 == Day06.simulateFishPopulation(data("day06/example"), 80);
		379414 == Day06.simulateFishPopulation(data("day06/input"), 80);

		int64("26984457539") == Day06.simulateFishPopulation(data("day06/example"), 256);
		int64("1705008653296") == Day06.simulateFishPopulation(data("day06/input"), 256);
	}

	function specDay07() {
		37 == Day07.findMinFuelCost(data("day07/example"), Day07.linear);
		352331 == Day07.findMinFuelCost(data("day07/input"), Day07.linear);

		168 == Day07.findMinFuelCost(data("day07/example"), Day07.increasing);
		99266250 == Day07.findMinFuelCost(data("day07/input"), Day07.increasing);
	}
	
	function specDay08() {
		26 == Day08.countUniqueSegmentOutputs(data("day08/example"));
		272 == Day08.countUniqueSegmentOutputs(data("day08/input"));

		61229 == Day08.sumOutputs(data("day08/example"));
		1007675 == Day08.sumOutputs(data("day08/input"));
	}

	function specDay09() {
		15 == Day09.sumLowPointRiskLevels(data("day09/example"));
		600 == Day09.sumLowPointRiskLevels(data("day09/input"));

		1134 == Day09.calculateBasinSizeProduct(data("day09/example"));
		987840 == Day09.calculateBasinSizeProduct(data("day09/input"));
	}

	function specDay10() {
		26397 == Day10.calculateSyntaxErrorScore(data("day10/example"));
		399153 == Day10.calculateSyntaxErrorScore(data("day10/input"));
	}
}
