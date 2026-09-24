extends Node2D

@onready var level: Node2D = $Level
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	player.global_position = level.get_spawn_position()


func _physics_process(_delta: float) -> void:
	if player.global_position.y > level.get_fall_limit():
		player.respawn_at(level.get_spawn_position())
