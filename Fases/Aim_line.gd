extends Node2D

const LARGURA_BALA = 5

var posicoes_linhas
var posicoes_linhas_atual = []
var resultados


func desenhar_intersec(posicao, posicao_alvo, entidade_atual, bullet_mask, nome_alvo):
	if len(posicoes_linhas_atual) >= 5:  # Limitar quantidade de linhas (para evitar loop infinito)
		posicoes_linhas.append(posicoes_linhas_atual.duplicate())
		posicoes_linhas_atual = []
		return
	resultados = []
	var spacestate = get_world_2d().direct_space_state
	for i in range(-LARGURA_BALA, LARGURA_BALA + 1, LARGURA_BALA * 2):
		resultados.append(spacestate.intersect_ray(posicao + Vector2(i, 0).rotated(entidade_atual.rotation), (posicao_alvo + Vector2(i, 0).rotated(entidade_atual.rotation)), [entidade_atual], bullet_mask))
	ordenar_resultados(posicao, resultados)
	for resultado in resultados:
		if resultado:
			if "Portal" in resultado.collider.name:  # Tiro irá bater no portal, verificar rastro a partir do outro portal também
				var posic_portal_oposto = resultado.collider.retorna_portal_posic_oposto()
				posicoes_linhas_atual.append({"posic_inicial": posicao, "alvo": resultado.position, "nome_alvo": nome_alvo})
				desenhar_intersec(posic_portal_oposto, posic_portal_oposto + ((posicao_alvo - posicao).normalized()) * 10000, resultado.collider.portal_oposto, bullet_mask, nome_alvo)
				return
			elif not nome_alvo in resultado.collider.name:  # Tiro irá bater na parede, parar por aqui
				posicoes_linhas_atual.append({"posic_inicial": posicao, "alvo": resultado.position, "nome_alvo": nome_alvo})
				posicoes_linhas.append(posicoes_linhas_atual.duplicate())
				posicoes_linhas_atual = []
				return
	# Se chegar até aqui, o tiro conseguirá acertar o alvo
	posicoes_linhas_atual.append({"posic_inicial": posicao, "alvo": posicao_alvo, "nome_alvo": nome_alvo})
	posicoes_linhas.append(posicoes_linhas_atual.duplicate())
	posicoes_linhas_atual = []


func ordenar_resultados(posicao_atual, resultados):
	# Ordena os resultados do intersect ray. As linhas que tiverem menor tamanho terão prioridade.
	if resultados[0] and resultados[1]:
		var dist1 = abs(resultados[0].position.x - posicao_atual.x) + abs(resultados[0].position.y - posicao_atual.y)
		var dist2 = abs(resultados[1].position.x - posicao_atual.x) + abs(resultados[1].position.y - posicao_atual.y)
		if dist1 > dist2:
			swap(resultados, 0)

func swap(resultados, indice):
	var temp = resultados[indice]
	resultados[indice] = resultados[indice + 1]
	resultados[indice + 1] = temp

func _process(_delta):
	update()

func _draw():
	if posicoes_linhas:
		for resultados in posicoes_linhas:
			for resultado in resultados:
				if resultado.nome_alvo == "Player":  # Mira dos inimigos
					draw_line(resultado.posic_inicial, resultado.alvo, ColorN("red"))
				else:  # Mira do player
					draw_line(resultado.posic_inicial, resultado.alvo, ColorN("green"))
	posicoes_linhas = []