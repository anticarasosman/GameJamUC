extends Node2D

var direction:int
var SPEED = 600

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == 0:
		position.y += SPEED * delta
	elif direction == 1:
		position.y -= SPEED * delta
	elif direction == 2:
		position.x -= SPEED * delta
	elif direction == 3:
		position.x += SPEED * delta

func _on_area_2d_area_entered(area):
	SPEED = 0
