extends Camera2D

var zoom_min = Vector2(.3, .3)
var zoom_max = Vector2(1.5, 1.5)
var zoom_speed = Global.zoom_speed
var des_zoom = zoom

func _process(delta):
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
