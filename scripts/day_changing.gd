extends Node2D

signal newDay

func _ready():
	$Tween.interpolate_property($NewDay, "rect_position:x", -363, 550, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.interpolate_property($OldDay, "rect_position:x", 550, 1300, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.start()
	


func _on_Tween_tween_all_completed():
	Global.potato_new_price = Global.potato_min_price + randi() % 4
	Global.carrot_new_price = Global.carrot_min_price + randi() % 20
	Global.burak_new_price = Global.burak_min_price + randi() % 40
	yield(get_tree().create_timer(1), "timeout")
	hide()
	yield(get_tree().create_timer(100), "timeout")
	Global.potato_price = Global.potato_new_price 
	Global.carrot_price = Global.carrot_new_price
	Global.burak_price = Global.burak_new_price
	show() 
	Global.day_counter += 1
	$OldDay.text = "Day " + str(Global.day_counter - 1)
	$NewDay.text = "Day " + str(Global.day_counter) 
	$Tween.interpolate_property($NewDay, "rect_position:x", -363, 550, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.interpolate_property($OldDay, "rect_position:x", 550, 1300, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.start()
