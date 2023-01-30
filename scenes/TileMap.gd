extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#clear()
	for x in range(64):
		for y in range(64):
			set_cell(x, y, randi() % 4)
	for x in range(64):
		set_cell(x, 0, 3)
		set_cell(x, 1, 3)
		set_cell(x, 63, 3)
		set_cell(x, 64, 3)
		set_cell(0, x, 3)
		set_cell(1, x, 3)
		set_cell(63, x, 3)
		set_cell(64, x, 3)
	update_bitmask_region(Vector2(0, 0), Vector2(64, 64) )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
