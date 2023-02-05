extends Node2D

signal newDay

func _ready():
	$Tween.interpolate_property($NewDay, "rect_position:x", -363, 550, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.interpolate_property($OldDay, "rect_position:x", 550, 1300, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.start()
	


func _on_Tween_tween_all_completed():
	yield(get_tree().create_timer(1), "timeout")
	hide()
	yield(get_tree().create_timer(180), "timeout")
	show()
	Global.day_counter += 1
	$OldDay.text = "Day " + str(Global.day_counter - 1)
	$NewDay.text = "Day " + str(Global.day_counter) 
	$Tween.interpolate_property($NewDay, "rect_position:x", -363, 550, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.interpolate_property($OldDay, "rect_position:x", 550, 1300, 3, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.start()
