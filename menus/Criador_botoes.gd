extends Control

func criar_botoes(texto_botoes, ultimo_liberado):
	# Cria 20 botões (4 linhas com 5 botões)
	var y = 150
	for i in range(4):
		var x = 275
		for j in range(1, 6):
			var botao = Button.new()
			var valor_atual = i * 5 + j
			botao.text = texto_botoes + ' ' + str(valor_atual)
			botao.rect_position = Vector2(x, y)
			botao.connect('pressed', self, '_on_Botao_pressionado', [valor_atual])
			
			if ultimo_liberado < valor_atual:
				botao.disabled = true
			add_child(botao)
			
			x += 100
		y += 50
