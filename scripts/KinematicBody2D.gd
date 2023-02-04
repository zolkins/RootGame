extends KinematicBody2D

export (int) var speed = 200
#onready var _animated_sprite = $animated_sprite
var velocity = Vector2()
onready var fss = $Foot_step

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
	var map_position = $"../predmeti".world_to_map(get_global_mouse_position())
	var tileid = $"../predmeti".tile_set.find_tile_by_name("Dirt")
	if Global.is_near:
		if !($"../predmeti".get_cell(map_position.x, map_position.y) == tileid):
			$"../predmeti".set_cell(map_position.x, map_position.y, tileid)
		else:
			$"../predmeti".set_cell(map_position.x, map_position.y, -1)
		
func _on_Shop_selec():
	if Global.is_near:
		$"../Select".set_visible(true)
		var map_position = $"../Select".world_to_map(get_global_mouse_position())
		var tileid = $"../Select".tile_set.find_tile_by_name("1")
		$"../Select".clear()
		$"../Select".set_cell(map_position.x, map_position.y, tileid)
	
func _on_Shop_del():
	$"../Select".set_visible(false)

func _on_Shop_touch():
	var map_position = $"../predmeti".world_to_map(get_global_mouse_position())
	var tileid = $"../predmeti".tile_set.find_tile_by_name("Dirt")
	print("aaa")
	if $"../predmeti".get_cell(map_position.x, map_position.y) == tileid:
			$CanvasLayer/DirtShop.set_position(get_global_mouse_position())

func _on_Area2D_mouse_entered():
	Global.is_near = true


func _on_Area2D_mouse_exited():
	Global.is_near = false



