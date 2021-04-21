extends Area2D

const MULT_VEL_A_FAVOR = 1.5
const MULT_VEL_CONTRA = 0.5

var corpos_na_esteira = []

func _process(_delta):
	for entidade in corpos_na_esteira:
		if is_instance_valid(entidade):
			aplicar_multiplicador_esteira(entidade, coletar_valor_a_ser_verificado(entidade))
		else:
			corpos_na_esteira.erase(entidade)


func coletar_valor_a_ser_verificado(entidade):
	pass

func aplicar_multiplicador_esteira(entidade, val_a_verificar):
	if val_a_verificar > 0:
		entidade.mult_esteira = MULT_VEL_A_FAVOR
	elif val_a_verificar < 0:
		entidade.mult_esteira = MULT_VEL_CONTRA
	else:
		entidade.mult_esteira = 1


func _on_Area_esteira_root_body_entered(body):
	corpos_na_esteira.append(body)

func _on_Area_esteira_root_body_exited(body):
	body.mult_esteira = 1
	corpos_na_esteira.erase(body)
