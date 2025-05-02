extends ShapeCast2D

@export var player: Node2D

func _process(delta):
	look_at(get_global_mouse_position())

func _physics_process(delta):
	force_shapecast_update()
	if is_colliding():
		var ghost = get_collider(0).get_parent()
		if ghost && player.lightIsOn && player.power > 0:
			ghost.seen()
