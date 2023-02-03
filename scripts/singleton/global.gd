extends Node
onready var languge = "uk"
onready var zoom_speed = Vector2(.05,.05)
onready var coins = 100
onready var is_phone = false
onready var is_near = false

func _ready():
	TranslationServer.set_locale(languge)
	

