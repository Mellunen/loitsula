class_name SceneWorld
extends Node


# Services #
var service_scene: ServiceScene


# Virtual Functions #
func _ready() -> void:
	initialize_services()


# Functions #
func initialize_services() -> void:
	service_scene = find_child("ServiceScene")
	service_scene.change_scene("res://scenes/world/scene_overworld.tscn")
