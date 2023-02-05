extends Node2D



func _on_tabl_body_entered(body):
	if body.name == "player":
		$Faq.show()


func _on_tabl_body_exited(body):
	if body.name == "player":
		$Faq.hide()
