extends AnimatedSprite

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$Control/Label.text = 'tochno?'
		$Control.show()
		$Control/money.hide()



func _on_no_pressed():
	$Control.hide()
	$Control/money.hide()


func _on_yes_pressed():
	if Global.coins >= 2500:
		get_tree().change_scene("res://scenes/end.tscn")
	else:
		$Control/Label.text = 'not money'
		$Control/money.text = str(Global.coins)+'/2500'
		$Control/money.show()
		


func _on_Area2D_body_exited(body):
	if body.name == "player":
		$Control.hide()
		$Control/money.hide()
