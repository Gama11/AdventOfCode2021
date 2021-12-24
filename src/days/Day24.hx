package days;

class Day24 {
	public static function compute(program:String, input:String):Int {
		final input = input.split("").map(Std.parseInt);
		final r = ["w" => 0, "x" => 0, "y" => 0, "z" => 0];
		function get(s:String) {
			return if (r.exists(s)) r[s] else Std.parseInt(s);
		}
		for (line in program.split("\n")) {
			switch line.split(" ") {
				case ["inp", a]:
					r[a] = input.shift();
				case ["add", a, b]:
					r[a] += get(b);
				case ["mul", a, b]:
					r[a] *= get(b);
				case ["div", a, b]:
					r[a] = Std.int(r[a] / get(b));
				case ["mod", a, b]:
					r[a] %= get(b);
				case ["eql", a, b]:
					r[a] = if (r[a] == get(b)) 1 else 0;
				case _:
					throw "unexpected";
			}
		}
		return r["z"];
	}

	static final steps = [
		{divZ: 1, addX: 15, addY: 9}, //
		{divZ: 1, addX: 11, addY: 1}, //
		{divZ: 1, addX: 10, addY: 11}, //
		{divZ: 1, addX: 12, addY: 3}, //
		{divZ: 26, addX: -11, addY: 10}, //
		{divZ: 1, addX: 11, addY: 5}, //
		{divZ: 1, addX: 14, addY: 0}, //
		{divZ: 26, addX: -6, addY: 7}, //
		{divZ: 1, addX: 10, addY: 9}, //
		{divZ: 26, addX: -6, addY: 15}, //
		{divZ: 26, addX: -6, addY: 4}, //
		{divZ: 26, addX: -16, addY: 10}, //
		{divZ: 26, addX: -4, addY: 4}, //
		{divZ: 26, addX: -2, addY: 9}, //
	];

	public static function run(input:Array<Int>) {
		var z = 0;
		for (index => step in steps) {
			final input = input[index];
			final x = (z % 26) + step.addX;
			z = Std.int(z / step.divZ);
			if (x != input) {
				z *= 26;
				z += input + step.addY;
			}
		}
		return z;
	}

	static function section1(n:Array<Int>) {
		var z = 0;
		z = (z * 26) + (9 + n[0]);
		z = (z * 26) + (1 + n[1]);
		z = (z * 26) + (11 + n[2]);
		z = (z * 26) + (3 + n[3]);
		if ((z % 26) - 11 == n[4]) {
			return Std.int(z / 26);
		}
		return null;
	}

	static function section2(n:Array<Int>) {
		var z = section1(n);
		z = (z * 26) + (5 + n[5]);
		z = (z * 26) + (0 + n[6]);
		if ((z % 26) - 6 == n[7]) {
			return Std.int(z / 26);
		}
		return null;
	}

	static function section3(n:Array<Int>) {
		var z = section2(n);
		z = (z * 26) + (9 + n[8]);
		if ((z % 26) - 6 == n[9]) {
			return Std.int(z / 26);
		}
		return null;
	}

	static function section4(n:Array<Int>) {
		var z = section3(n);
		if ((z % 26) - 6 == n[10]) {
			return Std.int(z / 26);
		}
		return null;
	}

	static function section5(n:Array<Int>) {
		var z = section4(n);
		if ((z % 26) - 16 == n[11]) {
			return Std.int(z / 26);
		}
		return null;
	}

	static function section6(n:Array<Int>) {
		var z = section5(n);
		if ((z % 26) - 4 == n[12]) {
			return Std.int(z / 26);
		}
		return null;
	}

	static function section7(n:Array<Int>) {
		var z = section6(n);
		if ((z % 26) - 2 == n[13]) {
			return Std.int(z / 26);
		}
		return null;
	}

	static function generateNumbers(length:Int, prefixes:Array<Array<Int>> = null) {
		var numbers = if (prefixes == null) [for (i in 1...10) [i]] else prefixes;
		while (numbers[0].length < length) {
			var newNumbers = [];
			for (i in 1...10) {
				newNumbers = newNumbers.concat(numbers.map(n -> n.concat([i])));
			}
			numbers = newNumbers;
		}
		numbers.reverse();
		return numbers;
	}

	public static function crackModelNumber() {
		var candidates = generateNumbers(5).filter(n -> section1(n) != null);
		candidates = generateNumbers(8, candidates).filter(n -> section2(n) != null);
		candidates = generateNumbers(10, candidates).filter(n -> section3(n) != null);
		candidates = generateNumbers(11, candidates).filter(n -> section4(n) != null);
		candidates = generateNumbers(12, candidates).filter(n -> section5(n) != null);
		candidates = generateNumbers(13, candidates).filter(n -> section6(n) != null);
		candidates = generateNumbers(14, candidates).filter(n -> section7(n) == 0);
		final numbers = candidates.map(n -> n.join(""));
		numbers.sort(Reflect.compare);
		return {
			smallest: numbers[0],
			largest: numbers.last()
		};
	}
}
