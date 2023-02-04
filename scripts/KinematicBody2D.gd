extends KinematicBody2D

export (int) var speed = 200
#onready var _animated_sprite = $animated_sprite
var velocity = Vector2()
onready var fss = $Foot_step
var map_pos = null

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
	if Global.is_phone:
		$CanvasLayer2.show()
	else:
		$CanvasLayer2.hide()
		move()

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


func _on_go_to_settings_pressed():
	Global.coins -= 15


func _on_Shop_dig():
	var map_position = $"../Sajanie".world_to_map(get_global_mouse_position())
	var tileid = $"../Sajanie".tile_set.find_tile_by_name("Dirt")
	if Global.is_near:
		if !($"../Sajanie".get_cell(map_position.x, map_position.y) == tileid):
			$"../Sajanie".set_cell(map_position.x, map_position.y, tileid)
		elif $"../Rost".get_cell(map_position.x, map_position.y) == -1:
			$"../Sajanie".set_cell(map_position.x, map_position.y, -1)
		
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
	var map_position = $"../Rost".world_to_map(get_global_mouse_position())
	var tileid = $"../Sajanie".tile_set.find_tile_by_name("Dirt")
	if $"../Sajanie".get_cell(map_position.x, map_position.y) == tileid:
		$"../../DirtShop".set_visible(!$"../../DirtShop".is_visible())
		$"../../DirtShop".set_position(get_global_mouse_position())
		map_pos = map_position

func _on_Area2D_mouse_entered():
	Global.is_near = true

func _on_Area2D_mouse_exited():
	Global.is_near = false


func _on_DirtShop_PotatoPlant():
	$"../../DirtShop".set_visible(false)
	var plant_type = "potato"
	var rostok = 4
	print(map_pos)
	$"../Rost".set_cell(map_pos.x, map_pos.y, rostok)

func _on_DirtShop_CarrotPlant():
	pass

func _on_DirtShop_BurakPlant():
	pass
