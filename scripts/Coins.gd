extends Label


func _process(delta):
	text = str(Global.coins)
	$"../ColorRect".set_size(Vector2($".".get_size().x+65,45))
