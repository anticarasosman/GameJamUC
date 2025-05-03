extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _ready():
	animation_player.play("idle")
