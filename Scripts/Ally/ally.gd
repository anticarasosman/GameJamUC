extends Node2D

var playerDetected = false
var doorDetected = false
var asked = false
var SPEED = 100
var DEATH_TIME = 1.0
var direction:int
var current_player: Node2D

@export var fairy_scene: PackedScene
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("walking")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if direction == 0:
		position.y += SPEED * _delta; rotation = -80
	elif direction == 1:
		position.y -= SPEED * _delta; rotation = 80
	elif direction == 2:
		position.x -= SPEED * _delta; rotation = 110
	elif direction == 3:
		position.x += SPEED * _delta
	
	if asked:
		DEATH_TIME -= _delta
	if DEATH_TIME < 0:
		if Global.current_enemies < Global.enemy_budget:
			spawn_fairy()
		cancel_attack()

func _on_interact_door_area_entered(area: Area2D) -> void:
	if area.name == "Open_door" && !asked:
		SPEED = 0
		doorDetected = true
		area.get_parent().animation_player.play("knock")
		area.get_parent().audio_stream_player_2d.play()

func _on_interact_player_area_entered(area: Area2D) -> void:
	if area.name == "Player_interaction":
		playerDetected = true
	if area is InteractArea:
		if area.interact_label == "InteractPlayer":
			cancel_attack()

func receive_interaction():
	var player = get_tree().get_current_scene().find_child("Player", true, false)
	if player:
		player.show_dialog("Me dejas entrar?")

func spawn_fairy():
	Global.current_enemies += 1
	var fairy = fairy_scene.instantiate()
	fairy.position = self.position
	print(fairy.global_position)
	get_parent().add_child(fairy)

func cancel_attack():
	var player = get_tree().get_current_scene().find_child("Player", true, false)
	if player:
		player.hide_dialogue()
	queue_free()
