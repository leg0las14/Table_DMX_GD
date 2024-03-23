extends Node3D

class_name RtsCameraController

const RAY_DISTANCE: float = 100

@export var camera_move_speed: float = 10
@export var camera_rotate_speed: float = 0.5

@export var camera_zoom_speed: float = 10

@export var camera_zoom_steps: int = 5

@export var camera_zoom_min: float = 0.1
@export var camera_zoom_max: float = 6

@onready var camera = %MainCamera
@onready var camera_zoom_target: float = inverse_lerp(camera_zoom_min, camera_zoom_max, camera.position.z) * camera_zoom_steps

var mouse_pressed = false
var last_mouse_pos: Vector2

func _process(delta: float) -> void:
	_move(delta)
	_rotate(delta)
	_zoom(delta)

func _move(delta: float) -> void:
	var move_delta_z = Input.get_axis("camera_move_forward", "camera_move_backward")
	var move_delta_x = Input.get_axis("camera_move_left", "camera_move_right")
	var move_delta = transform.basis.z * move_delta_z + transform.basis.x * move_delta_x

	global_position += move_delta * delta * camera_move_speed

func _rotate(delta: float) -> void:
	if mouse_pressed:
		var mouse_delta = last_mouse_pos - get_viewport().get_mouse_position()
		rotate_y(mouse_delta.x * delta * camera_rotate_speed) # Rotation autour de l'axe Y (horizontal)
		rotate_x(mouse_delta.y * delta * camera_rotate_speed) # Rotation autour de l'axe X (vertical)
		rotation.z = 0  # Réinitialisation de la rotation autour de l'axe Z
	last_mouse_pos = get_viewport().get_mouse_position()



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_MIDDLE and mouse_event.pressed:
			mouse_pressed = true
			last_mouse_pos = get_viewport().get_mouse_position()
		elif mouse_event.button_index == MOUSE_BUTTON_MIDDLE and not mouse_event.pressed:
			mouse_pressed = false

	if event.is_action_pressed("camera_zoom_in"):
		camera_zoom_target -= 1
	if event.is_action_pressed("camera_zoom_out"):
		camera_zoom_target += 1
	camera_zoom_target = clamp(camera_zoom_target, 0, camera_zoom_steps)

func _zoom(delta: float) -> void:
	var zoom_dist = lerpf(camera_zoom_min, camera_zoom_max, camera_zoom_target / camera_zoom_steps)
	camera.position.z = lerpf(camera.position.z, zoom_dist, delta * camera_zoom_speed)

func raycast_from_camera() -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mouse_position)
	var rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * RAY_DISTANCE
	var params = PhysicsRayQueryParameters3D.new()
	params.set(rayOrigin, rayEnd)
	return space_state.intersect_ray(params)
