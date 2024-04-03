extends Node3D

func _input(event):
	if event.is_action_pressed("new_spot"):
		Create.CreateSpot(Vector3(0,0,0), Create.truss_square_2m)
