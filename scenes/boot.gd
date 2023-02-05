extends Node2D


func _ready():
	$Tween.interpolate_property($Slider, "position", $Slider.position, Vector2(608, 1200), 12, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()


func _on_Tween_tween_all_completed():
	get_tree().change_scene("res://scenes/main_menu.tscn")
