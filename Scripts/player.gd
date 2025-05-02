extends CharacterBody2D

const SPEED = 360.0
const ACCEL = 8.0

var input: Vector2
var ATTACKED = false
@onready var shape_cast_2d = $ShapeCast2D

func get_input():
	input.x = Input.get_action_strength("Move right") - Input.get_action_strength("Move left")
	input.y = Input.get_action_strength("Move down") - Input.get_action_strength("Move up")
	return input.normalized()
	
func _process(delta):
	var playerInput = get_input()
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	move_and_slide()

func _on_player_interaction_area_entered(area):
	if area.name == "Ask_player":
		ATTACKED = true

func _on_player_interaction_area_exited(area):
	pass
