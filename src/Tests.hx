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
		7 == Day01.countIncreases(data("day01/example"));
		1692 == Day01.countIncreases(data("day01/input"));
	}
}
