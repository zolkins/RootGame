extends TextureButton

var item = null

func PlayerItem(PlayerImg):
	PlayerImg.set_visible(true)
	PlayerImg.set_texture(item.get_texture())
	

