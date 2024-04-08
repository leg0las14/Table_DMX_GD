class_name Spot
extends Node

var path
var parent
var pos
var instance

func _ready():
	print("new spot create")
	
func create(path_, pos_, parent_):
	path = path_
	parent = parent_
	pos = pos_
	var spot = load(path)
	var spot_ = spot.instantiate()
	instance = spot_
	spot_.transform.origin = pos
	parent.add_child(spot_)

func get_pos_():
	return instance.global_transform.origin
func get_parent_():
	return parent
func get_path_():
	return path
func set_pos_(x,y,z):
	instance.transform.origin = Vector3(x,y,z)
