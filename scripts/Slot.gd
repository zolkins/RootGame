extends Panel

var ItemClass = preload("res://scenes/invent_item.tscn")
var item = null

func _ready():
	item = ItemClass.instance()
	add_child(item)
	item.move_local_x(2)
	item.move_local_y(2)
	
func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Hotbar")
	inventoryNode.add_child(item)
	item = null
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Hotbar")
	inventoryNode.remove_child(item)
	add_child(item)
	item.move_local_x(2)
	item.move_local_y(2)
