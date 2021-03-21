extends CanvasLayer

func _ready():
	get_tree().paused = true

func _input(event):
	if event.get_action_strength("ui_cancel"):
		get_tree().paused = true

func _on_Button_pressed():
	get_tree().change_scene("res://menus/Menu_fases.tscn")
