extends Panel

var item = null
onready var Select = $"../../Select"

func _ready():
	if $'.'.get_child(0):
		item = $'.'.get_child(0)
		$'.'.get_child(1).text = $'.'.get_child(0).name
	
func Selected():
	Select.set_position($"..".get_position() + $'.'.get_position() + Vector2(19, 20))
