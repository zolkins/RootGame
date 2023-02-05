extends Node2D

signal wat
signal rost
signal bur
signal car
signal pot

func _ready():
	if Global.posle_shop:
		$YSort/player.set_position(Vector2(1520,650))
	else:
		$YSort/player.set_position(Vector2(1080,1780))
	for x in range(64):
		for y in range(64):
			if Global.t_map_1[Vector2(x, y)] != null:
				if Global.t_map_1[Vector2(x, y)] == 0:
					$YSort/Sajanie.set_cell(x, y, 0)
				elif Global.t_map_1[Vector2(x, y)] == 1:
					$YSort/Sajanie.set_cell(x, y, 1)
					emit_signal("wat", x, y)
			if Global.t_map_2[Vector2(x, y)] != null:
				if Global.t_map_2[Vector2(x, y)] == "potato":
					$YSort/Rost.set_cell(x, y, 5)
					emit_signal("rost", Vector2(x, y), "potato")
				elif Global.t_map_2[Vector2(x, y)] == "carrot":
					$YSort/Rost.set_cell(x, y, 5)
					emit_signal("rost", Vector2(x, y), "carrot")
				elif Global.t_map_2[Vector2(x, y)] == "burak":
					$YSort/Rost.set_cell(x, y, 5)
					emit_signal("rost", Vector2(x, y), "burak")
				elif Global.t_map_2[Vector2(x, y)] == "0":
					$YSort/Rost.set_cell(x, y, 0)
					emit_signal("bur", Vector2(x, y))
				elif Global.t_map_2[Vector2(x, y)] == "2":
					$YSort/Rost.set_cell(x, y, 2)
					emit_signal("car", Vector2(x, y))
				elif Global.t_map_2[Vector2(x, y)] == "6":
					$YSort/Rost.set_cell(x, y, 6)
					emit_signal("pot", Vector2(x, y))
				elif Global.t_map_2[Vector2(x, y)] == "1":
					$YSort/Rost.set_cell(x, y, 1)
				elif Global.t_map_2[Vector2(x, y)] == "3":
					$YSort/Rost.set_cell(x, y, 3)
				elif Global.t_map_2[Vector2(x, y)] == "7":
					$YSort/Rost.set_cell(x, y, 7)
				elif Global.t_map_2[Vector2(x, y)] == "-1":
					$YSort/Rost.set_cell(x, y, -1)
func _on_Node2D_wat(x, y):
	yield(get_tree().create_timer(60), "timeout")
	if $YSort/Sajanie.get_cell(x, y) == 1:
		$YSort/Sajanie.set_cell(x, y, 0)


func _on_Node2D_bur(vec):
	yield(get_tree().create_timer(20), "timeout")
	$YSort/Rost.set_cell(vec.x, vec.y, 0)
	yield(get_tree().create_timer(20), "timeout")
	$YSort/Rost.set_cell(vec.x, vec.y, 1)


func _on_Node2D_car(vec):
	yield(get_tree().create_timer(15), "timeout")
	$YSort/Rost.set_cell(vec.x, vec.y, 2)
	yield(get_tree().create_timer(15), "timeout")
	$YSort/Rost.set_cell(vec.x, vec.y, 3)

func _on_Node2D_pot(vec):
	yield(get_tree().create_timer(10), "timeout")
	$YSort/Rost.set_cell(vec.x, vec.y, 6)
	yield(get_tree().create_timer(10), "timeout")
	$YSort/Rost.set_cell(vec.x, vec.y, 7)
