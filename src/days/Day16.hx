package days;

typedef Packet = {
	final version:Int;
	final typeId:PacketTypeId;
	final type:PacketType;
}

enum abstract PacketTypeId(Int) from Int {
	final Sum = 0;
	final Product = 1;
	final Minimum = 2;
	final Maximum = 3;
	final Literal = 4;
	final GreaterThan = 5;
	final LessThan = 6;
	final EqualTo = 7;
}

enum PacketType {
	Literal(number:Int64);
	Operator(subpackets:Array<Packet>);
}

enum abstract GroupPrefix(Int) from Int {
	final KeepReading = 1;
	final LastGroup = 0;
}

enum abstract LengthTypeId(Int) from Int {
	final FifteenBit = 0;
	final ElevenBit = 1;
}

class Day16 {
	static function readPacket(input:String):Packet {
		final bits = Bits.parse(input.split("").map(s -> switch s {
			case "0": "0000";
			case "1": "0001";
			case "2": "0010";
			case "3": "0011";
			case "4": "0100";
			case "5": "0101";
			case "6": "0110";
			case "7": "0111";
			case "8": "1000";
			case "9": "1001";
			case "A": "1010";
			case "B": "1011";
			case "C": "1100";
			case "D": "1101";
			case "E": "1110";
			case "F": "1111";
			case _: throw 'unexpected $s';
		}).join(""));

		var i:Int = 0;
		function readPacket():Packet {
			function read(length:Int):Bits {
				final result = bits.slice(i, i + length);
				i += length;
				if (i > bits.length) {
					throw 'eof: $i/${bits.length}';
				}
				return result;
			}
			final version = read(3).toInt();
			final typeId:PacketTypeId = read(3).toInt();
			final type = switch typeId {
				case Literal:
					var prefix:GroupPrefix;
					var number = new Bits([]);
					do {
						prefix = read(1).toInt();
						number = number.concat(read(4));
					} while (prefix == KeepReading);
					Literal(number.toInt64());

				case _:
					final typeLengthId:LengthTypeId = read(1).toInt();
					Operator(switch typeLengthId {
						case FifteenBit:
							final length = read(15).toInt();
							final subpacketEnd = i + length;
							[while (i < subpacketEnd) readPacket()];

						case ElevenBit:
							final length = read(11).toInt();
							[for (_ in 0...length) readPacket()];
					});
			}
			return {
				version: version,
				type: type,
				typeId: typeId,
			};
		}
		return readPacket();
	}

	public static function sumVersions(input:String):Int {
		function sum(packet:Packet):Int {
			return packet.version + switch packet.type {
				case Literal(_): 0;
				case Operator(subpackets): subpackets.map(sum).sum();
			}
		}
		return sum(readPacket(input));
	}

	public static function eval(input:String):Int64 {
		function eval(packet:Packet):Int64 {
			return switch packet.type {
				case Literal(number): number;
				case Operator(subpackets):
					final s = subpackets.map(eval);
					function bool(cond:(Int64, Int64) -> Bool) {
						if (s.length != 2) {
							throw 'boolean operation with ${s.length} subpackets';
						}
						return if (cond(s[0], s[1])) 1 else 0;
					}
					switch packet.typeId {
						case Sum: s.sum();
						case Product: s.product();
						case Minimum: s.min64(i -> i).value;
						case Maximum: s.max64(i -> i).value;
						case GreaterThan: bool((a, b) -> a > b);
						case LessThan: bool((a, b) -> a < b);
						case EqualTo: bool((a, b) -> a == b);

						case Literal: throw "unreachable";
					}
			}
		}
		return eval(readPacket(input));
	}
}
