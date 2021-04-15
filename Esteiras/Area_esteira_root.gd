extends Area2D

const MULT_VEL_A_FAVOR = 1.5
const MULT_VEL_CONTRA = 0.5

var corpos_na_esteira = []


func aplicar_multiplicador_esteira(valor_multiplicador):
	for entidade in corpos_na_esteira:
		if is_instance_valid(entidade):
			entidade.mult_esteira = valor_multiplicador
		else:
			corpos_na_esteira.erase(entidade)


func _on_Area_esteira_root_body_entered(body):
	corpos_na_esteira.append(body)

func _on_Area_esteira_root_body_exited(body):
	body.mult_esteira = 1
	corpos_na_esteira.erase(body)
