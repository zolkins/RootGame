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

func _process(delta):
	$Potato/Price.text = "$"+str(Global.potato_seeds_price)
	$Carrot/Price.text = "$"+str(Global.carrot_seeds_price)
	$Burak/Price.text = "$"+str(Global.burak_seeds_price)
