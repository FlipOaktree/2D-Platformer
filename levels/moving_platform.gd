extends AnimatableBody2D

## How far the platform travels from where it is placed, in pixels.
@export var travel: Vector2 = Vector2(256, 0)

## How fast the platform moves along its path, in pixels per second.
@export_range(0.0, 600.0, 10.0)
var speed: float = 150.0

var start_position: Vector2
var end_position: Vector2
var target: Vector2


func _ready() -> void:
	start_position = position
	end_position = start_position + travel
	target = end_position


func _physics_process(delta: float) -> void:
	position = position.move_toward(target, speed * delta)

	# Turn around on arrival.
	if position.is_equal_approx(target):
		if target == end_position:
			target = start_position
		else:
			target = end_position
