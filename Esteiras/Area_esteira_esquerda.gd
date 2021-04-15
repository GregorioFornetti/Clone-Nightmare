extends "res://Esteiras/Area_esteira_root.gd"

func _process(_delta):
	if Input.get_action_strength('ui_right'):
		aplicar_multiplicador_esteira(MULT_VEL_CONTRA)
	elif Input.get_action_strength('ui_left'):
		aplicar_multiplicador_esteira(MULT_VEL_A_FAVOR)
	else:
		aplicar_multiplicador_esteira(1)
