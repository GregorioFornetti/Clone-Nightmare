extends Button

func _input(event):
	if event.get_action_strength("botao_vel"):
		pressed = not pressed
