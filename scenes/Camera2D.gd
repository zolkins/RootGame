extends Camera2D

var zoom_min = Vector2(.3, .3)
var zoom_max = Vector2(1.5, 1.5)
var zoom_speed = Global.zoom_speed
var des_zoom = zoom

func _process(delta):
	if !Global.is_phone:
		zoom = lerp(zoom, des_zoom, .2)

func _input(event):
	if event is InputEventMouseButton and !Global.is_phone:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if des_zoom > zoom_min:
					des_zoom -= zoom_speed
			if event.button_index == BUTTON_WHEEL_DOWN:
				if des_zoom < zoom_max:
					des_zoom += zoom_speed

# for phone
var min_zoom = .1
var max_zoom = 1.5
var zoom_sensitivity = 10
var zoom_speed_p = 0.02
var events = {}
var last_drag_distance = 0


func _unhandled_input(event):
	if Global.is_phone:
		if event is InputEventScreenTouch:
			if event.pressed:
				events[event.index] = event
			else:
				events.erase(event.index)
	if Global.is_phone:
		if event is InputEventScreenDrag:
			events[event.index] = event
			if events.size() == 2:
				var keys = events.keys()
				var key1 = keys[0]
				var key2 = keys[1]
				var touch1 = events[key1].position
				var touch2 = events[key2].position
				var drag_distance = touch1.distance_to(touch2)
				if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
					var new_zoom = (1 + zoom_speed_p) if drag_distance < last_drag_distance else (1 - zoom_speed_p)
					new_zoom = clamp(zoom.x * new_zoom, min_zoom, max_zoom)
					zoom = Vector2.ONE * new_zoom
					last_drag_distance = drag_distance
