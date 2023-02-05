extends Node
onready var languge = "uk"
onready var zoom_speed = Vector2(.05,.05)
onready var coins = 100
onready var is_phone = false
onready var is_near = false
onready var music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
onready var potato_min_price = 11
onready var carrot_min_price = 56
onready var burak_min_price = 111
onready var potato_price = 13
onready var carrot_price = 65
onready var burak_price = 126
onready var potato_new_price = 13
onready var carrot_new_price = 65
onready var burak_new_price = 115
onready var potato_seeds_price = 10
onready var carrot_seeds_price = 50
onready var burak_seeds_price = 100
onready var potato_counter = 0
onready var carrot_counter = 0
onready var burak_counter = 0
onready var shovel_x1x1_price = 30
onready var can_x1x1_price = 300
onready var usable = {"Can1x1": 5, "Shovel1x1": 10, 
"Shovel2x2": -1, "Shovel3x3": -1, "Can2x2": -1, "Can3x3": -1}
onready var t_map_1 = {}
onready var t_map_2 = {}
onready var posle_shop:bool = false
onready var day_counter = 1


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 50)
	TranslationServer.set_locale(languge)
	for x in range(64):
		for y in range(64):
			t_map_1[Vector2(x, y)] = null
			t_map_2[Vector2(x, y)] = null
			 
	

