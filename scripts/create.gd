extends Node

#liste des spots :

var spot_list ={
	"lyre": "res://prefab/lyre.tscn"
}
var structure_list ={
	"truss_square_2m": "res://prefab/truss_square_2m.tscn"	
}


func CreateSpot (pos, type):

	var spot = load(type)
	var spot_ = spot.instantiate()
	spot_.transform.origin = pos
	get_tree().get_root().add_child(spot_)
