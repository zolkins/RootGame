extends Node
onready var languge = "uk"
onready var zoom_speed = Vector2(.05,.05)
onready var coins = 1

func _ready():
	TranslationServer.set_locale(languge)
	

