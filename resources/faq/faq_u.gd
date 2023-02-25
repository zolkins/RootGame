extends Node2D

export var text = 'faq_3'

func _ready():
	$Control/Label.text = text

func _on_Area2D_body_entered(body):
	if body.name == "player":
		$Control.show()

func _on_Area2D_body_exited(body):
	if body.name == "player":
		$Control.hide()
