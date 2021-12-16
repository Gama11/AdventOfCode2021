package util;

@:forward(length)
abstract Bits(Array<Int>) {
	public static function parse(s:String) {
		return new Bits(s.split("").map(Std.parseInt));
	}

	public function new(bits:Array<Int>)
		this = bits;

	public function toInt()
		return this.foldi(function(bit, result, index) {
			return result + bit * Std.int(Math.pow(2, this.length - 1 - index));
		}, 0);

	public function isSet(i:Int)
		return this[i] == 1;

	public function inverted():Bits {
		return new Bits(this.map(bit -> if (bit == 1) 0 else 1));
	}

	@:arrayAccess function get(i:Int):Int
		return this[i];

	public function slice(pos, end):Bits {
		return new Bits(this.slice(pos, end));
	}

	public function concat(a:Bits):Bits {
		return new Bits(this.concat(cast a));
	}
}
