extends CharacterBody2D

## Maximum horizontal movement speed in pixels per second.
@export_range(0.0, 1000.0, 10.0)
var speed: float = 300.0

## Downward acceleration in pixels per second squared.
@export_range(0.0, 3000.0, 10.0)
var gravity: float = 980.0

## Upward velocity applied when a grounded jump begins.
@export_range(-1000.0, 0.0, 10.0)
var jump_velocity: float = -400.0

func _physics_process(delta: float) -> void:
	# Prevent another jump from starting while the Player is airborne.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Skip gravity while the Player is grounded.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	move_and_slide()
