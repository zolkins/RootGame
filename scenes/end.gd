extends Node2D

func _ready():
	$Label.text = 'Total days: '+str(Global.day_counter)
	yield(get_tree().create_timer(5), "timeout")
	$EndLodkaSolo.hide()
	$EndLodka.show()
