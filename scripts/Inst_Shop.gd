extends Node2D

onready var shop_in = "res://scenes/shop_in.tscn"

func _on_door_body_entered(body):
	if body.name == "player":
		Global.posle_shop = true
		get_tree().change_scene(shop_in)

