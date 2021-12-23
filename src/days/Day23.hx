package days;

private enum abstract Tile(String) from String {
	final Wall = "#";
	final Empty = ".";
	final Amber = "A";
	final Bronze = "B";
	final Copper = "C";
	final Desert = "D";
}

class Day23 {
	public static function findMinimumEnergy(input:String):Int {
		input = input.replace(" ", "#");
		final burrow = Util.parseGrid(input, s -> (s : Tile)).map;
		final goals = [
			Amber => [new Point(3, 2), new Point(3, 3)],
			Bronze => [new Point(5, 2), new Point(5, 3)],
			Copper => [new Point(7, 2), new Point(7, 3)],
			Desert => [new Point(9, 2), new Point(9, 3)],
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
		return AStar.search([new SearchState(burrow)], function(state) {
			for (pos => tile in state.burrow) {
				if (tile == Empty || tile == Wall) {
					continue;
				}
				if (!goals[tile].exists(goal -> pos == goal)) {
					return false;
				}
			}
			return true;
		}, state -> 0, function(state) {
			var moves = [];
			final movables = [
				for (positions in goals) {
					final pos = positions.find(pos -> state.burrow[pos] != Empty);
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
				final tile = state.burrow[spot];
				if (tile == Empty) {
					continue;
				}
				final goal = goals[tile];
				final first = state.burrow[goal[0]];
				final second = state.burrow[goal[1]];
				if (first == Empty && second == tile) {
					moves.push({from: spot, to: goal[0]});
				} else if (first == Empty && second == Empty) {
					moves.push({from: spot, to: goal[1]});
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
					if (state.burrow[current] != Empty) {
						return false;
					}
				}
				return true;
			});
			return moves.map(function(move) {
				final newBurrow = state.burrow.copy();
				final amphipod = newBurrow[move.from];
				newBurrow[move.from] = Empty;
				newBurrow[move.to] = amphipod;
				return {
					state: new SearchState(newBurrow),
					cost: (switch amphipod {
						case Amber: 1;
						case Bronze: 10;
						case Copper: 100;
						case Desert: 1000;
						case _: throw "unreachable";
					}) * move.from.distanceTo(move.to),
				};
			});
		}).score;
	}
}

private class SearchState {
	public final burrow:HashMap<Point, Tile>;

	public function new(burrow) {
		this.burrow = burrow;
	}

	public function hash():String {
		return Util.renderPointHash(burrow, s -> s + "");
	}
}
