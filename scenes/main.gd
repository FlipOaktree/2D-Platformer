extends Node2D

@onready var level: Node2D = $Level
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	player.global_position = level.get_spawn_position()
