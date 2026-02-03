class_name NodeCameraController
extends Node3D


# Constants #
const MIN_ANGLE: float = 10.0
const MAX_ANGLE: float = 80.0
const MIN_ZOOM: float = 2.5
const MAX_ZOOM: float = 15.0
const SPEED: float = 2.0


# Properties #
@export var target: Node3D
@export var acceleration: float
@export var friction: float
@export var sensitivity: float
var zoom_speed: float
var rotation_speed: Vector2
var dragging: bool


# Nodes #
@onready var camera: Camera3D = $Camera


# Virtual Functions #
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		control_mouse(event)
	if event is InputEventMouseMotion:
		control_drag(event)


func _process(delta: float) -> void:
	control_keys()
	follow(delta)
	zoom(delta)
	turn(delta)


# Functions #
func control_mouse(mouse: InputEventMouseButton) -> void:
	if mouse.button_index == MOUSE_BUTTON_WHEEL_UP:
		zoom_speed -= acceleration
	if mouse.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		zoom_speed += acceleration
	if mouse.button_index == MOUSE_BUTTON_MIDDLE:
		dragging = mouse.pressed


func control_drag(mouse: InputEventMouseMotion) -> void:
	if dragging:
		rotation_speed.x -= mouse.relative.x * acceleration * sensitivity
		rotation_speed.y -= mouse.relative.y * acceleration * sensitivity


func control_keys() -> void:
	if Input.is_action_pressed("camera_up"):
		rotation_speed.y -= acceleration
	if Input.is_action_pressed("camera_down"):
		rotation_speed.y += acceleration
	if Input.is_action_pressed("camera_left"):
		rotation_speed.x -= acceleration
	if Input.is_action_pressed("camera_right"):
		rotation_speed.x += acceleration


func follow(delta: float) -> void:
	position = position.lerp(target.position, SPEED * delta)


func zoom(delta: float) -> void:
	zoom_speed *= friction
	camera.position.z += zoom_speed * delta
	camera.position.z = clamp(camera.position.z, MIN_ZOOM, MAX_ZOOM)


func turn(delta: float) -> void:
	rotation_speed *= friction
	var target_x: float = rotation_degrees.x + rotation_speed.y * delta
	var target_y: float = rotation_degrees.y + rotation_speed.x * delta
	var target_z: float = rotation_degrees.z
	rotation_degrees = Vector3(
		clamp(target_x, -MAX_ANGLE, -MIN_ANGLE),
		target_y,
		target_z
	)
