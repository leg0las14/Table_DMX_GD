extends Camera3D

# Sensibilité de rotation de la caméra
var sensitivity = 0.01

# Vitesse de zoom
var zoom_speed = 0.5

# Vitesse de déplacement horizontal et vertical
var move_speed = 0.01

func _ready():
	set_process_input(true)

func _input(event):
	# Gérer le déplacement horizontal et vertical lorsque la molette est déplacée et que Shift est enfoncé
	if event is InputEventMouseMotion and Input.is_key_pressed(KEY_SHIFT):
		if Input.is_action_pressed("ui_molette"):
			move_camera(event.relative)

	# Gérer la rotation de la caméra lorsque le bouton de la molette est enfoncé
	elif event is InputEventMouseMotion:
		if Input.is_action_pressed("ui_molette"):
			rotate_camera(event.relative)

	# Gérer le zoom avant/arrière
	elif event is InputEventMouseButton:
		if event.is_action_pressed("ui_zoom_in"):
			translate_object_local(Vector3.FORWARD * zoom_speed)
		elif event.is_action_pressed("ui_zoom_out"):
			translate_object_local(Vector3.BACK * zoom_speed)

func rotate_camera(mouse_delta):
	# Appliquer la rotation horizontale à la caméra
	rotate_y(-mouse_delta.x * sensitivity)
	# Appliquer la rotation verticale à la caméra
	rotate_x(-mouse_delta.y * sensitivity)

func move_camera(mouse_delta):
	# Déplacer la caméra horizontalement et verticalement
	var horizontal_movement = -mouse_delta.x * move_speed
	var vertical_movement = -mouse_delta.y * move_speed
	translate_object_local(Vector3.RIGHT * horizontal_movement)
	translate_object_local(Vector3.UP * vertical_movement)
