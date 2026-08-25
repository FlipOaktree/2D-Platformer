extends CharacterBody2D
var speed: float = 300.0
var gravity: float = 980.0

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	move_and_slide()
