class_name SceneWorld
extends Node


# Services #
@onready var service_scene: ServiceScene = %ServiceScene


# Virtual Functions #
func _ready() -> void:
	service_scene.change_scene("res://scenes/world/scene_overworld.tscn")
