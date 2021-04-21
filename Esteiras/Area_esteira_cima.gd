extends "res://Esteiras/Area_esteira_root.gd"

func coletar_valor_a_ser_verificado(entidade):
	return -entidade.vetor_velocidade.y
