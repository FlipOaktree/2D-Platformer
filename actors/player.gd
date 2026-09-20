extends CharacterBody2D

## Maximum horizontal movement speed in pixels per second.
@export_range(0.0, 1000.0, 10.0)
var speed: float = 450.0

## How quickly horizontal speed increases toward its target.
@export_range(100.0, 5000.0, 100.0)
var acceleration: float = 1800.0

## How quickly horizontal speed decreases after input is released.
@export_range(100.0, 5000.0, 100.0)
var deceleration: float = 2700.0

## Downward acceleration in pixels per second squared.
@export_range(0.0, 3000.0, 10.0)
var gravity: float = 2400.0

## Upward velocity applied when a grounded jump begins.
@export_range(-1500.0, 0.0, 10.0)
var jump_velocity: float = -1200.0

## Seconds after leaving a ledge during which jumping remains allowed.
@export_range(0.0, 0.5, 0.01)
var coyote_time: float = 0.1

## Seconds before landing during which a jump press is remembered.
@export_range(0.0, 0.5, 0.01)
var jump_buffer_time: float = 0.1

## Portion of upward speed kept when the jump action is released early.
@export_range(0.0, 1.0, 0.05)
var jump_release_multiplier: float = 0.5

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0



func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer = move_toward(coyote_timer, 0.0, delta)

	var jump_requested: bool = Input.is_action_just_pressed("jump")
	if jump_requested:
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer = move_toward(jump_buffer_timer, 0.0, delta)

	var can_jump: bool = is_on_floor() or coyote_timer > 0.0
	var has_jump_request: bool = jump_requested or jump_buffer_timer > 0.0

	# Skip gravity while the Player is grounded.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Start a jump when a request and permission overlap.
	if has_jump_request and can_jump:
		velocity.y = jump_velocity
		coyote_timer = 0.0
		jump_buffer_timer = 0.0

	# Shorten the jump when the action is released while the Player is rising.
	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= jump_release_multiplier

	var direction: float = Input.get_axis("move_left", "move_right")
	var target_speed: float = direction * speed

	if direction != 0.0:
		velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)

	move_and_slide()
