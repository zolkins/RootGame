extends Control


func _process(_delta):
	$counter_burak_sprite3/count.text = str(Global.burak_counter)
	$counter_carrot_sprite2/count.text = str(Global.carrot_counter)
	$counter_potato_sprite/count.text = str(Global.potato_counter)
