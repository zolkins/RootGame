extends Node2D

const SlotClass = preload("res://scripts/Slot.gd")
onready var inventory_slots = $Items/GridContainer
onready var sfx = $sfx
var holding_item = null
var i = 0

signal dig
signal del
signal selec

func _ready():
	$Items.set_visible(false)
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
			slot.Selected()
			slot.PlayerItem($"../../AnimatedSprite/PlayerItem")
			
			
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
		emit_signal("selec")
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item:
				if holding_item.name == "Shovel1x1":
					emit_signal("dig")

func _process(delta):
	if $Items/Select.is_visible():
		if 	i == 0:
			yield(get_tree().create_timer(0.5), "timeout")
			$Items/Select.set_scale(Vector2(2, 2))
			i = 1
		else:
			yield(get_tree().create_timer(0.5), "timeout")
			$Items/Select.set_scale(Vector2(1.75, 1.75))
			i = 0

func _on_Button_pressed():
	$Items.set_visible(!$Items.is_visible())
	if !$Items.is_visible():
		$Slider.set_position(Vector2(-3, 300))
	else:
		$Slider.set_position(Vector2(120, 300))
	pass # Replace with function body.



func _on_Delete_pressed():
	sfx.stream = preload("res://resources/mp3/sfx/remove.wav")
	sfx.play()
	remove_child(holding_item)
	holding_item = null
	$"../../AnimatedSprite/PlayerItem".set_visible(false)
	$Items/Select.set_visible(false)
	emit_signal("del")
	pass # Replace with function body.


func _on_Slider_pressed():
	sfx.stream = preload("res://resources/mp3/sfx/any_in_settings.mp3")
	sfx.play()
	$Items.set_visible(!$Items.is_visible())
	if !$Items.is_visible():
		$Slider.set_position(Vector2(-3, 300))
		$Slider.set_flip_h(false)
	else:
		$Slider.set_position(Vector2(105, 300))
		$Slider.set_flip_h(true)
