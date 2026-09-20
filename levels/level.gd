extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn


## Where the Player should be placed when this level starts.
func get_spawn_position() -> Vector2:
	return player_spawn.global_position
