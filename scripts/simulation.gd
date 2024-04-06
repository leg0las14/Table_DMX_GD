extends Node3D

var new_menu
var new_menu_instance
func _input(event):
	if event.is_action_pressed("new_spot") and !Venv.isMenu:
		#Create.CreateSpot(Vector3(0,0,0), Create.truss_square_2m)
		new_menu = load("res://menu/create_menu.tscn")
		new_menu_instance = new_menu.instantiate()
		add_child(new_menu_instance)
