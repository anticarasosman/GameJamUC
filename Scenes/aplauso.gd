extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $clap_hitbox/CollisionShape2D

func _ready():
	collision_shape_2d.disabled = true

func _process(delta):
	look_at(get_global_mouse_position())

func _on_clap_hitbox_area_entered(area):
	if area.name == "InteractArea":
		area.die = true
