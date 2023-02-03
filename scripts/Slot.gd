extends Panel

var item = null
onready var Select = $"../../Select"
onready var sfx = $"../../../sfx"

func _ready():
	if $'.'.get_child(0):
		item = $'.'.get_child(0)
		$'.'.get_child(1).text = $'.'.get_child(0).name
	
func Selected():
	sfx.stream = preload("res://resources/mp3/sfx/any_in_settings.mp3")
	sfx.play()
	Select.set_visible(true)
	Select.set_position($"..".get_position() + $'.'.get_position() + Vector2(19, 20))
