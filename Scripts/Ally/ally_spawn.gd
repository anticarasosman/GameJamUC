extends Marker2D

enum Direction {UP, DOWN, LEFT, RIGHT}
@export var spawn_direction: Direction = Direction.UP
@export var ally_scene: PackedScene

func spawnAlly():
	print("SPAWNEAMOS ALIADO CON DIRECCION: ", spawn_direction)
	var ally = ally_scene.instantiate()
	ally.global_position = self.global_position
	ally.direction = spawn_direction
	add_child(ally)
