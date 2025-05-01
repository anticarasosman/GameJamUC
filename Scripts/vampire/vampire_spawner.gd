extends Marker2D

enum Direction {UP, DOWN, LEFT, RIGHT}
@export var spawn_direction: Direction = Direction.UP
@export var vampire_scene: PackedScene

func spawnVampire():
	print("SPAWNEAMOS VAMPIRO CON DIRECCION: ", spawn_direction)
	var vampire = vampire_scene.instantiate()
	vampire.global_position = self.global_position
	vampire.direction = spawn_direction
	add_child(vampire)
