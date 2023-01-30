extends Node
onready var languge = "uk"

func _ready():
	TranslationServer.set_locale(languge)
	

