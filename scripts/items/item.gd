extends Node2D

@export var interact_label: String = "item"
@export var interact_type: String = "item"
@export var interact_value: String = "none"

@onready var light: PointLight2D = $PointLight2D
@onready var name_label: Label = $ItemName
@onready var interact_area: InteractArea = $InteractArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_area.interact_label = interact_label
	interact_area.interact_type = interact_type
	interact_area.interact_value = interact_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interact_area_area_entered(area: Area2D) -> void:
	if area.name == "Player_interaction":
		light.show()
func _on_interact_area_area_exited(area: Area2D) -> void:
	if area.name == "Player_interaction":
		light.hide()
