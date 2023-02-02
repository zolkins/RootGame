extends Node2D

const SlotClass = preload("res://scripts/Slot.gd")
onready var inventory_slots = $Items/Texture/ScrollContainer/GridContainer
var holding_item = null

func _ready():
	$Items.set_visible(false)
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot]) 
	
func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					holding_item = null
					
				else:	
						var temp_item = slot.item
						temp_item.global_position = event.global_position
						holding_item = temp_item
						holding_item.queue_free()
						holding_item = null
			
			elif slot.item:
				holding_item = slot.item
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()


func _on_Button_pressed():
	$Items.set_visible(!$Items.is_visible())
	pass # Replace with function body.
