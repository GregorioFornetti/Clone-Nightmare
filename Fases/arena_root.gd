extends Node2D

var posicoes_linhas

func _process(_delta):
	update()

func _draw():
	print('oi')
	if posicoes_linhas:
		for resultado in posicoes_linhas:
			print('pintando')
			draw_line(resultado.posic_inicial, resultado.alvo, ColorN("green"))
