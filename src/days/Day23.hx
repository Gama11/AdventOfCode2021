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
		final amphipods = new HashMap<Point, Tile>();
		for (pos => tile in burrow) {
			if (tile != Empty && tile != Wall) {
				amphipods[pos] = tile; 
			}
		}
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
				final first = state.amphipods[goal[0]];
				final second = state.amphipods[goal[1]];
				if (first == null && second == amphipod) {
					moves.push({from: spot, to: goal[0]});
				} else if (first == null && second == null) {
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
					if (state.amphipods.exists(current)) {
						return false;
					}
				}
				return true;
			});
			return moves.map(function(move) {
				final newBurrow = state.amphipods.copy();
				final amphipod = newBurrow[move.from];
				newBurrow.remove(move.from);
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
	public final amphipods:HashMap<Point, Tile>;

	public function new(amphipods) {
		this.amphipods = amphipods;
	}

	public function hash():String {
		return Util.renderPointHash(amphipods, s -> s + "");
	}
}
