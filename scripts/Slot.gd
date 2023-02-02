extends Panel

var item = null

func _ready():
	if $'.'.get_child(0):
		item = $'.'.get_child(0)
		$'.'.get_child(1).text = $'.'.get_child(0).name
	
#func putIntoSlot(new_item):
#	item = new_item
#	item.position = Vector2(0, 0)
#	var inventoryNode = find_parent("Shop")
#	inventoryNode.remove_child(item)
#	add_child(item)
#	item.move_local_x(18)
#	item.move_local_y(18)
