extends CharacterBody2D
var speed: float = 300.0

func _physics_process(_delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	move_and_slide()
