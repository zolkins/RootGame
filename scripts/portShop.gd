extends Node2D

func _process(_delta):
	$PotatoSlider.max_value = Global.potato_counter
	$CarrotSlider.max_value = Global.carrot_counter
	$BurakSlider.max_value = Global.burak_counter
	$PotatoPrice.text = "$"+str(Global.potato_price)
	$CarrotPrice.text = "$"+str(Global.carrot_price)
	$BurakPrice.text = "$"+str(Global.burak_price)


func _on_PotatoSlider_value_changed(value):
	$PotatoCounter.text = str($PotatoSlider.value) + "/$" + str($PotatoSlider.value*Global.potato_price)

func _on_CarrotSlider_value_changed(value):
	$CarrotCounter.text = str($CarrotSlider.value) + "/$" + str($CarrotSlider.value*Global.carrot_price)

func _on_BurakSlider_value_changed(value):
	$BurakCounter.text = str($BurakSlider.value) + "/$" + str($BurakSlider.value*Global.burak_price)

func _on_PotatoButton_pressed():
	$sfx.stream = preload("res://resources/mp3/sfx/cash.mp3")
	$sfx.play()
	Global.coins += $PotatoSlider.value*Global.potato_price 
	Global.potato_counter -= $PotatoSlider.value

func _on_CarrotButton_pressed():
	$sfx.stream = preload("res://resources/mp3/sfx/cash.mp3")
	$sfx.play()
	Global.coins += $CarrotSlider.value*Global.carrot_price
	Global.carrot_counter -=  $CarrotSlider.value

func _on_BurakButton_pressed():
	$sfx.stream = preload("res://resources/mp3/sfx/cash.mp3")
	$sfx.play()
	Global.coins += $BurakSlider.value*Global.burak_price
	Global.burak_counter -=  $BurakSlider.value
