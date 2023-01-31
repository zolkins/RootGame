extends Node2D

var item_name = "PotatoSeeds" #TESTING
var item_quantity = randi()%255 #TESTING

func _ready():
	$ItemImg.texture = load("res://resources/img/%s.png" % item_name)
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	$Amount.text = str(item_quantity)

func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Amount.text = str(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Amount.text = str(item_quantity)
