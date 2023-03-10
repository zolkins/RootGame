extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()
onready var fss = $Foot_step
var map_pos = null
var plant_map = {}
var m_in_zabor = false
var toggle = false
var rand_m:int


func _ready():
	$CanvasLayer/Pause_menu/music_slider.value = Global.music_volume
	randomize()
	_on_Music_finished()


# Ходьба
func move():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.set_flip_h(false)
		velocity.x += 1
		$AnimatedSprite.play("right")
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.set_flip_h(true)
		$AnimatedSprite.play("right")
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.play("down")
	if Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("up")
		velocity.y -= 1
	if velocity.length() == 0:
		$AnimatedSprite.play("idle")
	else:
		if $Timer.time_left <=0:
			fss.pitch_scale = rand_range(0.8, 1.2)
			fss.play()
			$Timer.start(0.3)
		
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)


func _process(_delta):
	$CanvasLayer/Pause_menu/music_label.text = (str(Global.music_volume*100) + "%")
	if Global.is_phone:
		$CanvasLayer2.show()
	else:
		$CanvasLayer2.hide()
		move()
	if velocity:
		$"../../DirtShop".set_visible(false)


func _on_CanvasLayer2_use_move_vector(move_vector):
	velocity = move_vector.normalized()*speed
	move_and_slide(velocity)
	if velocity.x > 0:
		$AnimatedSprite.set_flip_h(false)
		$AnimatedSprite.play("right")
	elif velocity.x < 0:
		$AnimatedSprite.set_flip_h(true)
		$AnimatedSprite.play("right")
	elif velocity.y > 0:
		$AnimatedSprite.play("down")
	elif velocity.y < 0:
		$AnimatedSprite.play("up")
	if $Timer.time_left <=0:
		fss.pitch_scale = rand_range(0.8, 1.2)
		fss.play()
		$Timer.start(0.3)


func _on_CanvasLayer2_not_move():
	$AnimatedSprite.play("idle")
	velocity = 0
	
func write1(map_posit, tile_typ):
	Global.t_map_1[map_posit] = tile_typ 


func _on_Shop_dig():
	var map_position = $"../Sajanie".world_to_map(get_global_mouse_position())
	var tileid = $"../Sajanie".tile_set.find_tile_by_name("Dirt")
	if Global.is_near and m_in_zabor:
			if !($"../Sajanie".get_cell(map_position.x, map_position.y) == tileid or $"../Sajanie".get_cell(map_position.x, map_position.y) == $"../Sajanie".tile_set.find_tile_by_name("wetDirt")):
				$"../Sajanie".set_cell(map_position.x, map_position.y, tileid)
				$"../Alert".set_cell(map_position.x, map_position.y, 0)
				write1(map_position, tileid)
				Global.usable["Shovel1x1"] -= 1
			elif $"../Rost".get_cell(map_position.x, map_position.y) == -1:
				$"../Sajanie".set_cell(map_position.x, map_position.y, -1)
				$"../Alert".set_cell(map_position.x, map_position.y, -1)
				write1(map_position, -1)


func _on_Shop_selec():
	if Global.is_near:
		$"../../Select".set_visible(true)
		var map_position = $"../../Select".world_to_map(get_global_mouse_position())
		var tileid = $"../../Select".tile_set.find_tile_by_name("1")
		$"../../Select".clear()
		$"../../Select".set_cell(map_position.x, map_position.y, tileid)


func _on_Shop_del():
	$"../../Select".set_visible(false)


func _on_Shop_touch():
	if Global.is_near:
		var map_position = $"../Sajanie".world_to_map(get_global_mouse_position())
		var tileid = $"../Sajanie".tile_set.find_tile_by_name("Dirt")
		var plant = $"../Rost".get_cell(map_position.x, map_position.y)
		if ($"../Sajanie".get_cell(map_position.x, map_position.y) == tileid or $"../Sajanie".get_cell(map_position.x, map_position.y) == $"../Sajanie".tile_set.find_tile_by_name("wetDirt")) and !$"../../DirtShop".is_visible() and $"../Rost".get_cell(map_position.x, map_position.y) == -1:
			map_pos = map_position
			$"../../DirtShop".set_visible(!$"../../DirtShop".is_visible())
			$"../../DirtShop".set_position(get_global_mouse_position())
			$"../../Select".set_visible(true)
			tileid = $"../../Select".tile_set.find_tile_by_name("1")
			$"../../Select".clear()
			$"../../Select".set_cell(map_position.x, map_position.y, tileid)
		if(plant == 1 or plant == 3 or plant == 7):
			if plant == 1:
				Global.burak_counter += 1
			elif plant == 3:
				Global.carrot_counter += 1
			elif plant == 7:
				Global.potato_counter += 1
			$"../Rost".set_cell(map_position.x, map_position.y, -1)
			write2(map_position, -1)
			$"../Alert".set_cell(map_position.x, map_position.y, 0)


func _on_Shop_water():
	var map_position = $"../Sajanie".world_to_map(get_global_mouse_position())
	var tileid = $"../Sajanie".tile_set.find_tile_by_name("Dirt")
	if Global.is_near:
		if $"../Sajanie".get_cell(map_position.x, map_position.y) == tileid:
			Global.usable["Can1x1"] -= 1
			$"../Sajanie".set_cell(map_position.x, map_position.y, $"../Sajanie".tile_set.find_tile_by_name("wetDirt"))
			write1(map_position, $"../Sajanie".tile_set.find_tile_by_name("wetDirt"))
			yield(get_tree().create_timer(60), "timeout")
			if $"../Sajanie".get_cell(map_position.x, map_position.y) == $"../Sajanie".tile_set.find_tile_by_name("wetDirt"):
				$"../Sajanie".set_cell(map_position.x, map_position.y, tileid)
				write1(map_position, tileid)


func _on_Area2D_mouse_entered():
	Global.is_near = true


func _on_Area2D_mouse_exited():
	Global.is_near = false


func _on_Music_finished():
	rand_m = rand_range(0,9)
	if rand_m == 0:
		$Music.stream = preload("res://resources/mp3/music/Space Jazz.mp3")
	elif rand_m == 1:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/Going Up.ogg")
	elif rand_m == 2:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/arcade.ogg")
	elif rand_m == 3:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/chibi-robot-b.ogg")
	elif rand_m == 4:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/dark-happy-world.ogg")
	elif rand_m == 5:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/exploration.ogg")
	elif rand_m == 6:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/fantasy Dragon.ogg")
	elif rand_m == 7:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/happywalking.ogg")
	elif rand_m == 8:
		$Music.stream = preload("res://resources/mp3/music/Adventure pack 1 ogg/hurry_up_and_run.ogg")
	$Music.play()


func write2(map_posit, tile_typ):
	Global.t_map_2[map_posit] = str(tile_typ) 


func _on_DirtShop_PotatoPlant():
	if Global.coins - Global.potato_seeds_price >= 0:
		$"../Alert".set_cell(map_pos.x, map_pos.y, -1)
		$"../../DirtShop".set_visible(false)
		var plant_type = "potato"
		var rostok = 4
		$"../Rost".set_cell(map_pos.x, map_pos.y, rostok)
		write2(map_pos, "potato")
		Global.coins -= Global.potato_seeds_price
		$"../../Select".set_visible(false)
		if $"../Sajanie".get_cell(map_pos.x, map_pos.y) == $"../Sajanie".tile_set.find_tile_by_name("Dirt"):
			grow(map_pos, plant_type, 1)
		else:
			grow(map_pos, plant_type, 1.5)


func _on_DirtShop_CarrotPlant():
	if Global.coins - Global.carrot_seeds_price >= 0:
		$"../Alert".set_cell(map_pos.x, map_pos.y, -1)
		$"../../DirtShop".set_visible(false)
		var plant_type = "carrot"
		var rostok = 4
		write2(map_pos, "carrot")
		$"../Rost".set_cell(map_pos.x, map_pos.y, rostok)
		Global.coins -= Global.carrot_seeds_price
		$"../../Select".set_visible(false)
		if $"../Sajanie".get_cell(map_pos.x, map_pos.y) == $"../Sajanie".tile_set.find_tile_by_name("Dirt"):
			grow(map_pos, plant_type, 1)
		else:
			grow(map_pos, plant_type, 1.5)


func _on_DirtShop_BurakPlant():
	if Global.coins - Global.burak_seeds_price >= 0:
		$"../Alert".set_cell(map_pos.x, map_pos.y, -1)
		$"../../DirtShop".set_visible(false)
		var plant_type = "burak"
		var rostok = 4
		write2(map_pos, "burak")
		$"../Rost".set_cell(map_pos.x, map_pos.y, rostok)
		Global.coins -= Global.burak_seeds_price
		$"../../Select".set_visible(false)
		if $"../Sajanie".get_cell(map_pos.x, map_pos.y) == $"../Sajanie".tile_set.find_tile_by_name("Dirt"):
			grow(map_pos, plant_type, 1)
		else:
			grow(map_pos, plant_type, 1.5)


func _input(event):
	if Input.is_action_pressed("pause"):
		toggle = !toggle
		$sfx.stream = preload("res://resources/mp3/sfx/any_in_settings.mp3")
		$sfx.play()
		$CanvasLayer/Pause_menu.set_visible(toggle)


func _on_go_to_settings_toggled(toggle):
	$sfx.stream = preload("res://resources/mp3/sfx/any_in_settings.mp3")
	$sfx.play()
	$CanvasLayer/Pause_menu.set_visible(toggle)


func grow(plant_pos, plant_type, coef):
	if plant_type == "potato":
		yield(get_tree().create_timer(5 + randi() % 6), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 5)
		yield(get_tree().create_timer(10/coef), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 6)
		write2(plant_pos, 6)
		yield(get_tree().create_timer(10/coef), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 7)
		write2(plant_pos, 7)
	if plant_type == "carrot":
		yield(get_tree().create_timer(5 + randi() % 6), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 5)
		yield(get_tree().create_timer(15/coef), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 2)
		write2(plant_pos, 2)
		yield(get_tree().create_timer(15/coef), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 3)
		write2(plant_pos, 3)
	if plant_type == "burak":
		yield(get_tree().create_timer(5 + randi() % 6), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 5)
		yield(get_tree().create_timer(20/coef), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 0)
		write2(plant_pos, 0)
		yield(get_tree().create_timer(20/coef), "timeout")
		$"../Rost".set_cell(plant_pos.x, plant_pos.y, 1)
		write2(plant_pos, 1)


func _on_music_slider_value_changed(value):
	Global.music_volume = value


func _on_Port_body_entered(body):
	if body.name == "player":
		$CanvasLayer/portShop.set_visible(true)


func _on_Port_body_exited(body):
	if body.name == "player":
		$CanvasLayer/portShop.set_visible(false)

func _on_go_menu_pressed():
	$sfx.stream = preload("res://resources/mp3/sfx/go_settings.wav")
	$sfx.play()
	get_tree().change_scene("res://scenes/main_menu.tscn")


func _on_Zabor_mouse_entered():
	m_in_zabor = true


func _on_Zabor_mouse_exited():
	m_in_zabor = false


func _on_Well_body_entered(_body):
	Global.usable["Can1x1"] = 5


func _on_Node2D_rost(vect, ty):
	grow(vect, ty, 1)
