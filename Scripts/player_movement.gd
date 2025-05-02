extends CharacterBody2D

const SPEED = 3000.0
const ACCEL = 2.0

var input: Vector2

func get_input():
	input.x = Input.get_action_strength("Move right") - Input.get_action_strength("Move left")
	input.y = Input.get_action_strength("Move down") - Input.get_action_strength("Move up")
	return input.normalized()
	
func _process(delta):
	var playerInput = get_input()
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	move_and_slide()
