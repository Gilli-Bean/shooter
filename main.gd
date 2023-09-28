extends Node2D

@export var enemy: PackedScene

@export var villain: PackedScene

func _ready():
	spawn_enemies()
	spawn_villains()

func spawn_enemies():
	for x in 9:
		for y in 3:
			var e = enemy.instantiate()
			var pos = Vector2(x * (16 + 8) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.start(pos)

func spawn_villains():
	for x in 9:
		for y in 3:
			var v = villain.instantiate()
			var pos = Vector2(x * (16 + 8) + 24, 16 * 4 + y * 16)
			add_child(v)
			v.start(pos)		
