extends Control

var pausado = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pausado = not pausado
		get_tree().paused = pausado
		visible = pausado
