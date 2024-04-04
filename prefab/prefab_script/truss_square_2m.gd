extends Node3D

var material

var select = false

func _ready():
	var mesh_instance = $"Sketchfab_model/Collada visual scene group/Truss/defaultMaterial"
	var mesh = mesh_instance.mesh
	if mesh:
		material = mesh.surface_get_material(0)

func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !select:
			material.albedo_color = Color(0, 0, 1)
			select = true
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed and select:
			material.albedo_color = Color(0.1,0.1,0.1)
			select = false


func destroy():
	queue_free()
