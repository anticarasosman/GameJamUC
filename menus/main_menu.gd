extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_guille.tscn")

func _on_salir_button_pressed() -> void:
	get_tree().quit()


func _on_info_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/how_to_play_menu.tscn")
