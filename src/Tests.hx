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

		288957 == Day10.findMiddleCompletionScore(data("day10/example"));
		2995077699 == Day10.findMiddleCompletionScore(data("day10/input"));
	}

	function specDay11() {
		1656 == Day11.countOctopusFlashes(data("day11/example"));
		1661 == Day11.countOctopusFlashes(data("day11/input"));

		195 == Day11.findFirstSyncrhonization(data("day11/example"));
		334 == Day11.findFirstSyncrhonization(data("day11/input"));
	}

	function specDay12() {
		10 == Day12.countPaths(data("day12/example1"), Day12.smallCavesOnce);
		19 == Day12.countPaths(data("day12/example2"), Day12.smallCavesOnce);
		226 == Day12.countPaths(data("day12/example3"), Day12.smallCavesOnce);
		4411 == Day12.countPaths(data("day12/input"), Day12.smallCavesOnce);

		36 == Day12.countPaths(data("day12/example1"), Day12.oneSmallCaveTwice);
		103 == Day12.countPaths(data("day12/example2"), Day12.oneSmallCaveTwice);
		3509 == Day12.countPaths(data("day12/example3"), Day12.oneSmallCaveTwice);
		136767 == Day12.countPaths(data("day12/input"), Day12.oneSmallCaveTwice);
	}

	function specDay13() {
		17 == Day13.fold(data("day13/example"), true);
		708 == Day13.fold(data("day13/input"), true);

		16 == Day13.fold(data("day13/example"), false);
		104 == Day13.fold(data("day13/input"), false);
	}

	function specDay14() {
		1588 == Day14.solve(data("day14/example"), 10);
		3831 == Day14.solve(data("day14/input"), 10);

		int64("2188189693529") == Day14.solve(data("day14/example"), 40);
		int64("5725739914282") == Day14.solve(data("day14/input"), 40);
	}

	function specDay15() {
		40 == Day15.findLowestRiskPath(data("day15/example"), 1);
		435 == Day15.findLowestRiskPath(data("day15/input"), 1);

		315 == Day15.findLowestRiskPath(data("day15/example"), 5);
		2842 == Day15.findLowestRiskPath(data("day15/input"), 5);
	}

	function specDay16() {
		6 == Day16.sumVersions("D2FE28");
		9 == Day16.sumVersions("38006F45291200");
		14 == Day16.sumVersions("EE00D40C823060");
		16 == Day16.sumVersions("8A004A801A8002F478");
		12 == Day16.sumVersions("620080001611562C8802118E34");
		23 == Day16.sumVersions("C0015000016115A2E0802F182340");
		31 == Day16.sumVersions("A0016C880162017C3686B18A3D4780");
		984 == Day16.sumVersions(data("day16/input"));

		3 == Day16.eval("C200B40A82");
		54 == Day16.eval("04005AC33890");
		7 == Day16.eval("880086C3E88112");
		9 == Day16.eval("CE00C43D881120");
		1 == Day16.eval("D8005AC2A8F0");
		0 == Day16.eval("F600BC2D8F");
		0 == Day16.eval("9C005AC2F8F0");
		1 == Day16.eval("9C0141080250320F1802104A08");
		int64("1015320896946") == Day16.eval(data("day16/input"));
	}

	function specDay17() {
		45 == Day17.findHighestYPosition("target area: x=20..30, y=-10..-5");
		2701 == Day17.findHighestYPosition("target area: x=281..311, y=-74..-54");
	}
}
