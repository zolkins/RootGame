extends Panel

var item = null

func _ready():
	if $'.'.get_child(0):
		item = $'.'.get_child(0)
		$'.'.get_child(1).text = item.name

func PlayerItem(PlayerImg):
	PlayerImg.set_visible(true)
	PlayerImg.set_texture(item.get_texture())
	
