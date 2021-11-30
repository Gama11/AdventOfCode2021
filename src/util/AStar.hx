package util;

import polygonal.ds.Prioritizable;
import polygonal.ds.PriorityQueue;

class AStar {
	public static function search<T:State>(starts:Array<T>, isGoal:T->Bool, score:T->Int, getMoves:T->Array<Move<T>>):Null<Result<T>> {
		var scores = new Map<String, Score>();
		for (start in starts) {
			scores[start.hashCode()] = {
				g: 0,
				f: score(start)
			};
		}
		var closedSet = new Map<String, Bool>();
		var openSet = new PriorityQueue(1, true, [for (start in starts) new PrioritizedItem(start, score(start))]);

		while (openSet.size > 0) {
			var current = openSet.dequeue().item;
			closedSet[current.hashCode()] = true;

			var currentScore = scores[current.hashCode()].g;
			if (isGoal(current)) {
				return {
					score: currentScore,
					state: current
				};
			}

			for (move in getMoves(current)) {
				if (closedSet.exists(move.state.hashCode())) {
					continue;
				}
				var node = scores[move.state.hashCode()];
				var scoreAfterMove = currentScore + move.cost;
				if (node == null || node.g > scoreAfterMove) {
					var score = {
						g: scoreAfterMove,
						f: scoreAfterMove + score(move.state)
					};
					scores[move.state.hashCode()] = score;
					openSet.enqueue(new PrioritizedItem(move.state, score.f));
				}
			}
		}

		return null;
	}
}

typedef Move<T> = {
	var cost:Int;
	var state:T;
}

typedef State = {
	function hashCode():String;
}

typedef Result<T> = {
	var score:Int;
	var state:T;
}

private typedef Score = {
	var g:Int;
	var f:Int;
}

class PrioritizedItem<T> implements Prioritizable {
	public final item:T;
	public var priority(default, null):Float = 0;
	public var position(default, null):Int;

	public function new(item:T, priority:Float) {
		this.item = item;
		this.priority = priority;
	}
}
