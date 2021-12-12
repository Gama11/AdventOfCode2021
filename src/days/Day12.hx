package days;

private enum abstract Cave(String) from String {
	final Start = "start";
	final End = "end";

	public function isSmall()
		return this.toLowerCase() == this;

	public function isBig()
		return this.toUpperCase() == this;
}

class Day12 {
	public static function smallCavesOnce(to:Cave, path:Array<Cave>) {
		return to.isBig() || !path.contains(to);
	}

	public static function oneSmallCaveTwice(to:Cave, path:Array<Cave>) {
		if (to.isBig()) {
			return true;
		}
		final alreadyVisited = path.contains(to);
		if (to == Start || to == End) {
			return !alreadyVisited;
		}
		if (!alreadyVisited) {
			return true;
		}
		final smallCaves = path.filter(it -> it.isSmall());
		return smallCaves.filterDuplicates().length == smallCaves.length;
	}

	public static function countPaths(input:String, canVisit:(to:Cave, path:Array<Cave>) -> Bool):Int {
		final connections = new Map<Cave, Array<Cave>>();
		for (line in input.split("\n")) {
			final parts = line.split("-");
			final a = parts[0];
			final b = parts[1];
			connections[a] = connections.getOrDefault(a, []).concat([b]);
			connections[b] = connections.getOrDefault(b, []).concat([a]);
		}
		final paths = new Map<String, Bool>();
		final visisted = new Map<String, Bool>();
		function walk(to:Cave, path:Array<Cave>) {
			if (!canVisit(to, path)) {
				return;
			}
			path = path.concat([to]);
			final hash = path.join(",");
			if (visisted.exists(hash)) {
				return;
			}
			visisted[hash] = true;
			if (to == End) {
				paths[hash] = true;
			} else {
				for (neighbor in connections[to]) {
					walk(neighbor, path);
				}
			}
		}
		walk(Start, []);
		return paths.count();
	}
}
