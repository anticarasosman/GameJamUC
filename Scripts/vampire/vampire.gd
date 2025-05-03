extends Node2D

var playerDetected = false
var doorDetected = false
var asking = false
var SPEED = 100
var direction: int
var current_player: Node2D
var tween = create_tween()

var KILL_TIME = 15.0
@onready var kill_timer: Label = $KillTime
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("walking")
	
func _process(_delta: float) -> void:
	match direction:
		0: position.y += SPEED * _delta; rotation = -80
		1: position.y -= SPEED * _delta; rotation = 80
		2: position.x -= SPEED * _delta; rotation = 110
		3: position.x += SPEED * _delta
	
	kill_timer.text = "%.2f" % KILL_TIME

	if doorDetected and not asking:
		KILL_TIME -= _delta

		if KILL_TIME <= 0:
			kill_player()
		

func _on_interact_door_area_entered(area: Area2D) -> void:
	if area.name == "Open_door":
		SPEED = 0
		doorDetected = true
		area.get_parent().animation_player.play("knock")
		area.get_parent().audio_stream_player_2d.play()

func _on_interact_player_area_entered(area: Area2D) -> void:
	if area.name == "Player_interaction":
		playerDetected = true
		asking = false
	if area is InteractArea:
		if area.interact_label == "InteractVampire":
			KILL_TIME -= 2
			
func receive_interaction():
	var player = get_tree().get_current_scene().find_child("Player", true, false)
	if player:
		player.show_dialog("ME DEJAS ENTRAR?")

func cancel_attack():
	Global.enemy_budget -= 1
	queue_free()
	
func kill_player():
	var player = get_tree().get_current_scene().find_child("Player", true, false)
	if player:
		player.game_over()

	queue_free()
