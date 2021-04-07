extends Button

func _input(event):
	if event.get_action_strength("camera_center"):
		pressed = not pressed
