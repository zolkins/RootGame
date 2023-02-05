extends Node2D




func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://scenes/map.tscn")


func _on_market_body_entered(body):
	if body.name == "player":
		$int_shop_menu.show()


func _on_market_body_exited(body):
	if body.name == "player":
		$int_shop_menu.hide()
