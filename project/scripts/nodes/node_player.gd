class_name NodePlayer
extends CharacterBody3D


# Constants #
const VELOCITY_SPEED: float = 2.5
const ROTATION_SPEED: float = 5.0


# Services #
@onready var service_state: ServiceState = %ServiceState
@onready var service_action: ServiceAction = %ServiceAction


# Nodes #
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent


# Virtual Functions #
func _ready() -> void:
	connect_services()


func _process(delta: float) -> void:
	if not service_state.paused:
		move()
		turn(delta)


# Functions #
func connect_services() -> void:
	service_action.connect("move_to", set_target_position)


func move() -> void:
	if not navigation_agent.is_navigation_finished():
		var next_position: Vector3 = navigation_agent.get_next_path_position()
		var direction: Vector3 = global_position.direction_to(next_position)
		velocity = direction * VELOCITY_SPEED
		move_and_slide()


func turn(delta: float) -> void:
	if velocity.length() > 0:
		var angle: float = atan2(-velocity.x, -velocity.z)
		rotation.y = lerp_angle(rotation.y, angle, ROTATION_SPEED * delta)


# Get / Set #
func set_target_position(value: Vector3) -> void:
	navigation_agent.target_position = value
