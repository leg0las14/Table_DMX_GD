extends Node3D

var material
var materialS

var select = false

var initial_mouse_y = -1
var initial_object_y = 0

var mouse_enter1 = false
var mouse_enter2 = false
var mouse_enter3 = false
var mouse_enter4 = false

var spot = {}


func _ready():
	var mesh_instance = $"Sketchfab_model/Collada visual scene group/Truss/defaultMaterial"
	var mesh = mesh_instance.mesh
	if mesh:
		material = mesh.surface_get_material(0)
	
	$tube1.visible = false
	$tube2.visible = false
	$tube3.visible = false
	$tube4.visible = false

func _input(event):
	if mouse_enter1 or mouse_enter2 or mouse_enter3 or mouse_enter4:
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				print("okk")

func global_input_event(camera, event, position, normal, shape_idx):
	pass
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !select:
#			material.albedo_color = Color(0, 0, 1)
#			select = true
#		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed and select:
#			material.albedo_color = Color(0.1,0.1,0.1)
#			select = false

func destroy():
	queue_free()

func _on_tube_1_mouse_entered():
	if Venv.isCreatingSpot:
		$tube1.visible = true
		mouse_enter1 = true

func _on_tube_1_mouse_exited():
	$tube1.visible = false
	mouse_enter1 = false

func _on_tube_2_mouse_entered():
	if Venv.isCreatingSpot:
		$tube2.visible = true
		mouse_enter2 = true

func _on_tube_2_mouse_exited():
	$tube2.visible = false
	mouse_enter2 = false

func _on_tube_3_mouse_entered():
	if Venv.isCreatingSpot:
		$tube3.visible = true
		mouse_enter3 = true

func _on_tube_3_mouse_exited():
	$tube3.visible = false
	mouse_enter3 = false

func _on_tube_4_mouse_entered():
	if Venv.isCreatingSpot:
		$tube4.visible = true
		mouse_enter4 = true

func _on_tube_4_mouse_exited():
	$tube4.visible = false
	mouse_enter4 = false
