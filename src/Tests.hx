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

	/* function specDay01() {
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
		final example = Day17.testProbeShots("target area: x=20..30, y=-10..-5");
		45 == example.maxY;
		112 == example.hitCount;

		final input = Day17.testProbeShots("target area: x=281..311, y=-74..-54");
		2701 == input.maxY;
		1070 == input.hitCount;
	}

	function specDay18() {
		function explode(number:String) {
			return Day18.print(Day18.explode(Day18.parse(number)).number);
		}
		"[[[[0,9],2],3],4]" == explode("[[[[[9,8],1],2],3],4]");
		"[7,[6,[5,[7,0]]]]" == explode("[7,[6,[5,[4,[3,2]]]]]");
		"[[6,[5,[7,0]]],3]" == explode("[[6,[5,[4,[3,2]]]],1]");
		"[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]" == explode("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]");
		"[[3,[2,[8,0]]],[9,[5,[7,0]]]]" == explode("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]");

		function sum(input:String) {
			return Day18.print(Day18.sum(Day18.parseList(input)));
		}
		"[[[[0,7],4],[[7,8],[6,0]]],[8,1]]" == sum(data("day18/example0"));
		"[[[[1,1],[2,2]],[3,3]],[4,4]]" == sum(data("day18/example1"));
		"[[[[3,0],[5,3]],[4,4]],[5,5]]" == sum(data("day18/example2"));
		"[[[[5,0],[7,4]],[5,5]],[6,6]]" == sum(data("day18/example3"));
		"[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]" == sum(data("day18/example4"));

		function magnitude(number:String) {
			return Day18.magnitude(Day18.parse(number));
		}
		143 == magnitude("[[1,2],[[3,4],5]]");
		1384 == magnitude("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]");
		445 == magnitude("[[[[1,1],[2,2]],[3,3]],[4,4]]");
		791 == magnitude("[[[[3,0],[5,3]],[4,4]],[5,5]]");
		1137 == magnitude("[[[[5,0],[7,4]],[5,5]],[6,6]]");
		3488 == magnitude("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]");

		4140 == magnitude(sum(data("day18/example5")));
		3494 == magnitude(sum(data("day18/input")));

		3993 == Day18.findLargestSumMagnitude(data("day18/example5"));
		4712 == Day18.findLargestSumMagnitude(data("day18/input"));
	}

	function specDay19() {
		final example = Day19.analyzeReports(data("day19/example"));
		79 == example.beaconCount;
		3621 == example.maxScannerDistance;

		final input = Day19.analyzeReports(data("day19/input"));
		359 == input.beaconCount;
		12292 == input.maxScannerDistance;
	}

	function specDay20() {
		35 == Day20.countPixelsAfterEnhancements(data("day20/example"), 2);
		5354 == Day20.countPixelsAfterEnhancements(data("day20/input"), 2);

		3351 == Day20.countPixelsAfterEnhancements(data("day20/example"), 50);
		18269 == Day20.countPixelsAfterEnhancements(data("day20/input"), 50);
	}

	function specDay21() {
		739785 == Day21.playTrainingGame(data("day21/example"));
		605070 == Day21.playTrainingGame(data("day21/input"));

		int64("444356092776315") == Day21.playDiracDice(data("day21/example"));
		int64("218433063958910") == Day21.playDiracDice(data("day21/input"));
	}

	function specDay22() {
		39 == Day22.executeInitialization(data("day22/example1"));
		590784 == Day22.executeInitialization(data("day22/example2"));
		609563 == Day22.executeInitialization(data("day22/input"));

		39 == Day22.executeReboot(data("day22/example1"));
		int64("2758514936282235") == Day22.executeReboot(data("day22/example3"));
		int64("1234650223944734") == Day22.executeReboot(data("day22/input"));
	} */

	function specDay23() {
		12521 == Day23.findMinimumEnergy(data("day23/example"));
		18051 == Day23.findMinimumEnergy(data("day23/input"));
	}
}
