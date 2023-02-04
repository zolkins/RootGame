extends Node
onready var languge = "uk"
onready var zoom_speed = Vector2(.05,.05)
onready var coins = 1000
onready var is_phone = false
onready var is_near = false
onready var music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
onready var potato_price = 10
onready var carrot_price = 50
onready var burak_price = 100
onready var potato_counter = 0
onready var carrot_counter = 0
onready var burak_counter = 0


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 50)
	TranslationServer.set_locale(languge)
	

