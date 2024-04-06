extends Control

var spot_button
var structure_button
var decoration_button
var list_items

var items

enum MenuStatus {spot, structure, decoration}
var menu_status

func _ready():
	Venv.isMenu = true
	spot_button = $ColorRect/MarginContainer/HBoxContainer/spot_button
	structure_button = $ColorRect/MarginContainer/HBoxContainer/structure_button
	decoration_button = $ColorRect/MarginContainer/HBoxContainer/decoration_button
	list_items = $ColorRect/list_items
	
	spot_button.modulate = Color(1, 0, 0, 1)
	structure_button.modulate = Color(0, 1, 0, 1)
	decoration_button.modulate = Color(0, 1, 0, 1)
	
	list_items.clear()
	items = Create.spot_list
	for i in items:
		list_items.add_item(i)
	menu_status = MenuStatus.spot

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Venv.isMenu = false;
		queue_free()
	if event.is_action_pressed("ui_accept"):
		valider()
		
func _on_spot_button_pressed():
	spot_button.modulate = Color(1, 0, 0, 1)
	structure_button.modulate = Color(0, 1, 0, 1)
	decoration_button.modulate = Color(0, 1, 0, 1)
	
	items = Create.spot_list
	list_items.clear()
	for i in items:
		list_items.add_item(i)
	menu_status = MenuStatus.spot
	
func _on_structure_button_pressed():
	spot_button.modulate = Color(0, 1, 0, 1)
	structure_button.modulate = Color(1, 0, 0, 1)
	decoration_button.modulate = Color(0, 1, 0, 1)
	
	items = Create.structure_list
	list_items.clear()
	for i in items:
		list_items.add_item(i)
	menu_status = MenuStatus.structure

func _on_decoration_button_pressed():
	spot_button.modulate = Color(0, 1, 0, 1)
	structure_button.modulate = Color(0, 1, 0, 1)
	decoration_button.modulate = Color(1, 0, 0, 1)
	
	items = Create.decoration_list
	list_items.clear()
	for i in items:
		list_items.add_item(i)
	menu_status = MenuStatus.decoration


func _on_exit_button_pressed():
	Venv.isMenu=false
	queue_free()


func _on_valid_button_pressed():
	valider()

func valider():
	if list_items.is_anything_selected():
		var item_title = list_items.get_item_text(list_items.get_selected_items()[0])
		match menu_status:
			MenuStatus.spot:
				Venv.isCreatingSpot = true
				Venv.spot = Create.spot_list[item_title]
				Create.CreateNew(Vector3(0,0,0), Create.spot_list[item_title])
			MenuStatus.structure:
				Venv.isCreatingStructure = true
				Venv.spot = Create.structure_list[item_title]
				Create.CreateNew(Vector3(0,0,0), Create.structure_list[item_title])
			MenuStatus.decoration:
				Venv.spot = Create.decoration_list[item_title]
				Create.CreateNew(Vector3(0,0,0), Create.decoration_list[item_title])
		Venv.isMenu=false
		queue_free()
