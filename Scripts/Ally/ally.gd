extends Node2D

var playerDetected = false
var doorDetected = false
var asking = false
var SPEED = 600
var direction:int
var current_player: Node2D

@onready var label = $Label
@onready var line_edit = $Label/LineEdit

@export var fairy_scene: PackedScene

func _ready():
	label.hide()
	line_edit.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if direction == 0:
		position.y += SPEED * _delta
	elif direction == 1:
		position.y -= SPEED * _delta
	elif direction == 2:
		position.x -= SPEED * _delta
	elif direction == 3:
		position.x += SPEED * _delta
	if playerDetected && doorDetected:
		if not asking:
			label.text = "ME DEJAS ENTRAR?"
			label.show()
			line_edit.text = ""
			line_edit.show()
			line_edit.grab_focus()
			asking = true
	else:
		die()

func _on_area_2d_area_entered(area):
	if area.name == "Player_interaction":
		playerDetected = true
		asking = false
		current_player = area
		current_player.get_parent().ATTACKED = true
	if area.name == "Open_door":
		SPEED = 0
		doorDetected = true

func _on_ResponseInput_text_submitted(new_text: String) -> void:
	print("Texto ingresado:", new_text)

	if new_text.strip_edges().to_upper() == "SI":
		if randi_range(0, 100) >= 30:
			spawn_fairy()
		print("Respuesta correcta detectada")
		label.text = ""
		line_edit.hide()
		playerDetected = false
		asking = false
		if current_player:
			current_player.ATTACKED = false
		# Mueve al vampiro a otro lugar
		position = Vector2(randf_range(100, 900), randf_range(100, 700))
	else:
		label.text = "..."
		die()

func spawn_fairy():
	var fairy = fairy_scene.instantiate()
	add_child(fairy)

func die():
	print("ME MORI")
