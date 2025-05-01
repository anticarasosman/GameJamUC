extends CharacterBody2D

const SPEED = 360.0
const ACCEL = 8.0

var input: Vector2
var ATTACKED = false

func get_input():
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if !ATTACKED:
		return input.normalized()
	else:
		return Vector2(0, 0)
	
func _process(delta):
	var playerInput = get_input()
	
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	
	move_and_slide()
