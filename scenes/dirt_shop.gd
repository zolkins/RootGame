extends Node2D

const SlotClass = preload("res://scripts/PlayerSlot.gd")

var inventory_slots = $".".get_children()
var holding_item = null

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot]) 

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item == null:
				holding_item = slot.item.duplicate()
				add_child(holding_item)
				holding_item.global_position = event.global_position
				holding_item.global_position = get_global_mouse_position()
			else: 
				remove_child(holding_item)
				var temp_item = slot.item.duplicate()
				add_child(temp_item)
				temp_item.global_position = event.global_position
				holding_item = temp_item
				holding_item.global_position = get_global_mouse_position()
