package util;

import polygonal.ds.Hashable;
import polygonal.ds.HashTable;

@:forward(keys, iterator)
abstract HashMap<K:Hashable, V>(HashTable<K, V>) to Iterable<V> {
	public inline function new() {
		this = new HashTable(16);
	}

	@:arrayAccess inline function get(key:K):V {
		return this.get(key);
	}

	@:arrayAccess inline function set(key:K, value:V) {
		this.unset(key);
		this.set(key, value);
		if (this.loadFactor > 0.7) {
			this.rehash(this.slotCount * 2);
		}
	}

	public inline function exists(key:K):Bool {
		return this.hasKey(key);
	}

	public function getOrDefault(key:K, defaultValue:V):V {
		return if (exists(key)) get(key) else defaultValue;
	}

	public inline function keyValueIterator():HashMapKeyValueIterator<K, V> {
		return new HashMapKeyValueIterator<K, V>(cast this);
	}
}

private class HashMapKeyValueIterator<K:Hashable, V> {
	final map:HashMap<K, V>;
	final iterator:Iterator<K>;

	public inline function new(map) {
		this.map = map;
		this.iterator = map.keys();
	}

	public inline function hasNext():Bool {
		return iterator.hasNext();
	}

	public inline function next():{key:K, value:V} {
		final key = iterator.next();
		return {key: key, value: map[key]}
	}
}
