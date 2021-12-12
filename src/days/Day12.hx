package days;

private abstract Cave(String) from String {
	public function isSmall()
		return this.toLowerCase() == this;
}

class Day12 {
	public static function countPaths(input:String):Int {
		final connections = new Map<Cave, Array<Cave>>();
		for (line in input.split("\n")) {
			final parts = line.split("-");
			final a = parts[0];
			final b = parts[1];
			connections[a] = connections.getOrDefault(a, []).concat([b]);
			connections[b] = connections.getOrDefault(b, []).concat([a]);
		}
		final visisted = new Map<String, Array<Cave>>();
		function walk(to:Cave, path:Array<Cave>) {
			if (to.isSmall() && path.contains(to)) {
				return;
			}
			path = path.concat([to]);
			final stringPath = path.join(",");
			if (visisted.exists(stringPath)) {
				return;
			}
			visisted[stringPath] = path;
			for (neighbor in connections[to]) {
				walk(neighbor, path);
			}
		}
		walk("start", []);
		return visisted.count(it -> it.last() == "end");
	}
}
