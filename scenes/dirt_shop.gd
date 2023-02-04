extends Node2D

signal PotatoPlant
signal CarrotPlant
signal BurakPlant

func _on_Potato_pressed():
	emit_signal("PotatoPlant")
	pass # Replace with function body.


func _on_Carrot_pressed():
	emit_signal("CarrotPlant")
	pass # Replace with function body.


func _on_Burak_pressed():
	emit_signal("BurakPlant")
	pass # Replace with function body.
