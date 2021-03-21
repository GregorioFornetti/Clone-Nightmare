extends KinematicBody2D

const VELOCIDADE_MAX = 200
const LARGURA_BALA = 5

var vetor_velocidade = Vector2.ZERO
var alvo
var Tiro_player = preload('res://Jogador/player_bullet.tscn')
onready var GameStats = get_parent().get_node("GameStats")
onready var bullet_mask = pow(2, 7)
onready var PlayerSprite = $Sprite
onready var Draw_node = get_parent().get_node("Aim_line")
var mouse_position
var arma_carregada = true
var rotation_fix = PI / 2
var resultados
var posicoes_linhas

signal player_atirou(bullet)
signal player_marcou()
signal player_desmarcou()
signal player_morreu()

func _ready():
	bullet_mask += collision_mask
	ReloadTimer.connect('timeout', self, '_on_BulletReloadTimer_timeout')

func _physics_process(_delta):
	movimentacao()
	marcar_alvo()
	rotacionar()
	verificar_atirar()
	#criar_lista_linhas()
	if alvo:
		Draw_node.desenhar_intersec(position, alvo.position, self, bullet_mask, "Enemy")

func criar_lista_linhas():
	# Utiliza o intersect ray para verificar se há algo bloqueando o caminho da bala até o alvo
	# Nesse caso, 3 intersect rays são criados para verificar se a bala é bloqueada (nos cantos e pelo centro)
	if alvo:
		verificar_intersec(position, alvo.position, self)

func verificar_intersec(posicao, posicao_alvo, teste):
	if len(Draw_node.posicoes_linhas) >= 5:  # Limitar quantidade de linhas (para evitar loop infinito)
		return
	resultados = []
	var spacestate = get_world_2d().direct_space_state
	for i in range(-LARGURA_BALA, LARGURA_BALA + 1, LARGURA_BALA * 2):
		resultados.append(spacestate.intersect_ray(posicao + Vector2(i, 0).rotated(rotation), (posicao_alvo + Vector2(i, 0).rotated(rotation)), [teste], bullet_mask))
	ordenar_resultados(posicao, resultados)
	for resultado in resultados:
		if resultado:
			if "Portal" in resultado.collider.name:  # Tiro irá bater no portal, verificar rastro a partir do outro portal também
				var posic_portal_oposto = resultado.collider.retorna_portal_posic_oposto()
				Draw_node.posicoes_linhas.append({"posic_inicial": posicao, "alvo": resultado.position})
				verificar_intersec(posic_portal_oposto, posic_portal_oposto + ((posicao_alvo - posicao).normalized()) * 10000, resultado.collider.portal_oposto)
				return
			elif not "Enemy" in resultado.collider.name:  # Tiro irá bater na parede, parar por aqui
				Draw_node.posicoes_linhas.append({"posic_inicial": posicao, "alvo": resultado.position})
				return
	# Se chegar até aqui, o tiro conseguirá acertar o alvo
	Draw_node.posicoes_linhas.append({"posic_inicial": posicao, "alvo": posicao_alvo})


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

func movimentacao():
	vetor_velocidade.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	vetor_velocidade.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	vetor_velocidade = vetor_velocidade.normalized()
	
	move_and_slide(vetor_velocidade * VELOCIDADE_MAX)


func rotacionar():
	if alvo:
		rotation = position.angle_to_point(alvo.position) - rotation_fix
	elif vetor_velocidade != Vector2.ZERO:
		rotation = vetor_velocidade.angle() + rotation_fix

func marcar_alvo():
	# Verifica se o botão esquerdo do mouse foi clicado
	if Input.is_action_just_pressed("mouse_right_click"):
		var space_state = get_world_2d().direct_space_state
		var colisao = space_state.intersect_point(get_global_mouse_position())
		if colisao and colisao[0]['collider'].name.begins_with('Enemy'):
			# O jogador clicou em um inimigo.
			if alvo == colisao[0]['collider']:
				# Se ele clicou no mesmo inimigo que ele ja tinha clicado antes, desmarca-lo
				emit_signal("player_desmarcou")
				alvo.get_node('target').visible = false
				alvo = null
				PlayerSprite.frame = 0
				return
			
			emit_signal("player_marcou")
			if alvo and is_instance_valid(alvo):
				alvo.get_node('target').visible = false  # Desmarcar inimigo antigo que havia sido marcado,
			# Marcar novo inimigo
			alvo = colisao[0]['collider']
			alvo.get_node('target').visible = true
			PlayerSprite.frame = 1


func verificar_atirar():
	if Input.is_action_just_pressed("ui_accept") and alvo and arma_carregada and GameStats.quant_atual_bullets > 0:
		if is_instance_valid(alvo):
			var tiro_player = Tiro_player.instance()
			tiro_player.global_position = global_position
			tiro_player.rotation = rotation
			tiro_player.alvo = alvo.global_position
			get_parent().call_deferred('add_child', tiro_player)
			
			emit_signal("player_atirou", tiro_player)
			
			ReloadTimer.start()
			arma_carregada = false
		else:
			alvo = null


func _on_Hurtbox_area_entered(area):
	area.get_parent().acabar_com_bala()
	emit_signal("player_morreu")
	# queue_free()

func _on_BulletReloadTimer_timeout():
	arma_carregada = true

func _on_Enemy_death(inimigo):
	# desmarcar inimigo que morreu
	if inimigo == alvo:
		emit_signal("player_desmarcou")
		PlayerSprite.frame = 0
		alvo = null
