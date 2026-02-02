class_name ServiceScene
extends Node


# Properties #
var active_scene: Node


# Functions #
func unload_scene() -> void:
	if active_scene:
		active_scene.queue_free()


func load_scene(path: String) -> void:
	var packed_scene: PackedScene = load(path)
	active_scene = packed_scene.instantiate()
	add_child(active_scene)


func change_scene(path: String) -> void:
	unload_scene()
	load_scene(path)


func add_child_to_scene(child: Node) -> void:
	active_scene.add_child(child)


func find_children_in_scene(pattern: String, type: String) -> void:
	return active_scene.find_children(pattern, type)
