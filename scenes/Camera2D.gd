extends Camera2D

var zoom_min = Vector2(.35, .35)
var zoom_max = Vector2(.6, .6)
var zoom_speed = Global.zoom_speed
var des_zoom = zoom

func _process(delta):
	print(des_zoom)
	zoom = lerp(zoom, des_zoom, .2)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if des_zoom > zoom_min:
					des_zoom -= zoom_speed
			if event.button_index == BUTTON_WHEEL_DOWN:
				if des_zoom < zoom_max:
					des_zoom += zoom_speed
	pass
