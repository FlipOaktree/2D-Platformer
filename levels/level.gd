extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var fall_limit: Marker2D = $FallLimit


## Where the Player should be placed when this level starts.
func get_spawn_position() -> Vector2:
	return player_spawn.global_position


## How far down the Player may go before it counts as having left.
func get_fall_limit() -> float:
	return fall_limit.global_position.y
