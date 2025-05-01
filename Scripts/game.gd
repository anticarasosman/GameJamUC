extends Node2D

@onready var scene_transition_animation = $scene_transition_animation/AnimationPlayer

var current_wave: int = 0
@export var ally_scene: PackedScene
@export var vampire_scene: PackedScene
@export var banshee_scene: PackedScene
@export var ghost_scene: PackedScene

var rng = RandomNumberGenerator.new()
var starting_allies: int = 0
var saved_allies: int = 0
var wave_ended: bool = false
