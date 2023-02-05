extends Node2D


func _ready():
	$lop_price.text = str(Global.shovel_x1x1_price)
	$can_price.text = str(Global.can_x1x1_price)

func _on_lop_buy_pressed():
	if (Global.coins - Global.shovel_x1x1_price) > 0 && Global.usable["Shovel1x1"] < 30:
		$sfx.stream = preload("res://resources/mp3/sfx/cash.mp3")
		$sfx.play()
		Global.coins -= Global.shovel_x1x1_price
		Global.usable["Shovel1x1"] += 5
	else:
		$sfx.stream = preload("res://resources/mp3/sfx/remove.wav")
		$sfx.play()

func _on_can_buy_pressed():
	if (Global.coins - Global.can_x1x1_price) > 0:
		$sfx.stream = preload("res://resources/mp3/sfx/cash.mp3")
		$sfx.play()
		Global.coins -= Global.can_x1x1_price
	else:
		$sfx.stream = preload("res://resources/mp3/sfx/remove.wav")
		$sfx.play()
