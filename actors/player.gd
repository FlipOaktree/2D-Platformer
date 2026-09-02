extends CharacterBody2D

## Maximum horizontal movement speed in pixels per second.
@export_range(0.0, 1000.0, 10.0)
var speed: float = 300.0

## How quickly horizontal speed increases toward its target.
@export_range(100.0, 5000.0, 100.0)
var acceleration: float = 1200.0

## How quickly horizontal speed decreases after input is released.
@export_range(100.0, 5000.0, 100.0)
var deceleration: float = 1800.0

## Downward acceleration in pixels per second squared.
@export_range(0.0, 3000.0, 10.0)
var gravity: float = 980.0

## Upward velocity applied when a grounded jump begins.
@export_range(-1000.0, 0.0, 10.0)
var jump_velocity: float = -400.0

## Seconds after leaving a ledge during which jumping remains allowed.
@export_range(0.0, 0.5, 0.01)
var coyote_time: float = 0.1

var coyote_timer: float = 0.0

func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer = move_toward(coyote_timer, 0.0, delta)

	var can_jump: bool = is_on_floor() or coyote_timer > 0.0

	# Skip gravity while the Player is grounded.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Allow one jump from the floor or during the grace period.
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = jump_velocity
		coyote_timer = 0.0

	var direction: float = Input.get_axis("move_left", "move_right")
	var target_speed: float = direction * speed

	if direction != 0.0:
		velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)

	move_and_slide()
