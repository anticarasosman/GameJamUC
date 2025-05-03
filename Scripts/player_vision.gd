extends ShapeCast2D

func _process(delta):
	look_at(get_global_mouse_position())

func _physics_process(delta):
	force_shapecast_update()
	if is_colliding():
		var ghost = get_collider(0)
		if ghost:
			ghost.seen()
