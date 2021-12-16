package days;

typedef Packet = {
	final version:Int;
	final type:PacketType;
}

enum abstract PacketTypeId(Int) from Int {
	final Literal = 4;
}

enum PacketType {
	Literal(number:Int);
	Operator(children:Array<Packet>);
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
					Literal(number.toInt());

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
			};
		}
		return readPacket();
	}

	public static function sumVersions(input:String):Int {
		function sum(packet:Packet):Int {
			return packet.version + switch packet.type {
				case Literal(_): 0;
				case Operator(children): children.map(sum).sum();
			}
		}
		return sum(readPacket(input));
	}
}
