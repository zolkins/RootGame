extends Panel

var item = null

func _ready():
	if $'.'.get_child(0):
		item = $'.'.get_child(0)
	
func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Shop")
	inventoryNode.add_child(item)
	item = null
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Shop")
	inventoryNode.remove_child(item)
	add_child(item)
	item.move_local_x(2)
	item.move_local_y(2)
