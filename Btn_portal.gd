extends Button

func _input(event):
	if event.get_action_strength("linhas_portais"):
		pressed = not pressed
