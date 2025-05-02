extends Marker2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !get_parent().ATTACKED:
		look_at(get_global_mouse_position())
