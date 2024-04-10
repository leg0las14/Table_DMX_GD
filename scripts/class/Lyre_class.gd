class_name Lyre

extends Node

var path
var parent
var pos
var instance


func create(path_, pos_, parent_, x, y, z):
	path = path_
	parent = parent_
	pos = pos_
	var spot = load(path)
	instance = spot.instantiate()
	instance.transform.origin = pos
	instance.rotate_x(x)
	instance.rotate_y(y)
	instance.rotate_z(z)
	parent.add_child(instance)
	print('parent du spot :', instance.get_parent())
	print('root : ', get_parent_())

func get_pos_():
	return instance.global_transform.origin
func get_parent_():
	return parent
func get_path_():
	return path
func set_pos_(x,y,z):
	instance.transform.origin = Vector3(x,y,z)
