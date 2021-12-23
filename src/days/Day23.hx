package days;

private enum abstract Amphipod(String) from String {
	final Amber = "A";
	final Bronze = "B";
	final Copper = "C";
	final Desert = "D";
}

class Day23 {
	public static function findMinimumEnergy(input:String, unfolded:Bool):Int {
		if (unfolded) {
			final lines = input.split("\n");
			lines.insert(3, "  #D#B#A#C#");
			lines.insert(3, "  #D#C#B#A#");
			input = lines.join("\n");
		}
		input = input.replace(" ", "#");
		final burrow = Util.parseGrid(input, s -> s).map;
		final amphipods = new HashMap<Point, Amphipod>();
		for (pos => tile in burrow) {
			if (tile == Amber || tile == Bronze || tile == Copper || tile == Desert) {
				amphipods[pos] = tile;
			}
		}
		final goalDepth = if (unfolded) 4 else 2;
		function goalPoints(x:Int) {
			return [for (offset in 0...goalDepth) new Point(x, 2 + offset)];
		}
		final goals = [
			Amber => goalPoints(3),
			Bronze => goalPoints(5),
			Copper => goalPoints(7),
			Desert => goalPoints(9),
		];
		final hallwaySpots = [
			new Point(1, 1),
			new Point(2, 1),
			new Point(4, 1),
			new Point(6, 1),
			new Point(8, 1),
			new Point(10, 1),
			new Point(11, 1),
		];
		return AStar.search([new SearchState(amphipods)], function(state) {
			for (pos => tile in state.amphipods) {
				if (!goals[tile].exists(goal -> pos == goal)) {
					return false;
				}
			}
			return true;
		}, state -> 0, function(state) {
			var moves = [];
			final movables = [
				for (positions in goals) {
					final pos = positions.find(pos -> state.amphipods.exists(pos));
					if (pos == null) {
						continue;
					}
					pos;
				}
			];
			for (movable in movables) {
				for (spot in hallwaySpots) {
					moves.push({from: movable, to: spot});
				}
			}
			for (spot in hallwaySpots) {
				final amphipod = state.amphipods[spot];
				if (amphipod == null) {
					continue;
				}
				final goal = goals[amphipod];
				var lastValid = null;
				for (pos in goal) {
					final occupant = state.amphipods[pos];
					if (occupant == null) {
						lastValid = pos;
					} else if (occupant != amphipod) {
						lastValid = null;
						break;
					}
				}
				if (lastValid != null) {
					moves.push({from: spot, to: lastValid});
				}
			}
			moves = moves.filter(function(move) {
				var current = move.from;
				while (current != move.to) {
					final next = if (current.y > move.to.y) {
						Direction.Up;
					} else if (current.x > move.to.x) {
						Direction.Left;
					} else if (current.x < move.to.x) {
						Direction.Right;
					} else {
						Direction.Down;
					}
					current += next;
					if (state.amphipods.exists(current)) {
						return false;
					}
				}
				return true;
			});
			return moves.map(function(move) {
				final newAmphipods = state.amphipods.copy();
				final amphipod = newAmphipods[move.from];
				newAmphipods.remove(move.from);
				newAmphipods[move.to] = amphipod;
				return {
					state: new SearchState(newAmphipods),
					cost: (switch amphipod {
						case Amber: 1;
						case Bronze: 10;
						case Copper: 100;
						case Desert: 1000;
					}) * move.from.distanceTo(move.to),
				};
			});
		}).score;
	}
}

private class SearchState {
	public final amphipods:HashMap<Point, Amphipod>;

	var hashed:String;

	public function new(amphipods) {
		this.amphipods = amphipods;
	}

	public function hash():String {
		if (hashed == null) {
			hashed = Util.renderPointHash(amphipods, s -> s + "");
		}
		return hashed;
	}
}
