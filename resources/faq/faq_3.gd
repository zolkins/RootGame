extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$Faq.show()


func _on_Area2D_body_exited(body):
	if body.name == "player":
		$Faq.hide()
