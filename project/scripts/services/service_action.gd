class_name ServiceAction
extends Node3D


# Signals #
signal reset
signal activate(id: int)
signal move_to(target_position: Vector3)


# Constants #
const RAY_LENGTH: float = 100.0


# Virtual Functions #
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse: InputEventMouseButton = event
		if mouse.pressed and mouse.button_index == MOUSE_BUTTON_LEFT:
			var results: Dictionary = raycast(mouse)
			click(results)


# Functions #
func click(results: Dictionary) -> void:
	if results:
		var target_position: Vector3 = results["position"]
		var collider: Node3D = results["collider"]
		action(target_position, collider)


func action(target_position: Vector3, collider: Node3D) -> void:
	reset.emit()
	move_to.emit(target_position)
	if collider.has_node("ModuleAction"):
		activate.emit(collider.get_instance_id())


func raycast(mouse: InputEventMouseButton) -> Dictionary:
	var camera: Camera3D = get_viewport().get_camera_3d()
	var from: Vector3 = camera.project_ray_origin(mouse.global_position)
	var to: Vector3 = from + camera.project_ray_normal(mouse.global_position) * RAY_LENGTH
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(from, to)
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var ray: Dictionary = space_state.intersect_ray(query)
	return ray
