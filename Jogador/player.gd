extends KinematicBody2D

const VELOCIDADE_MAX = 300

var vetor_velocidade = Vector2.ZERO
var alvo
var Tiro_player = preload('res://Jogador/player_bullet.tscn')
var mouse_position

func _ready():
	pass 

func _physics_process(_delta):
	movimentacao()
	marcar_alvo()
	verificar_atirar()
	

func movimentacao():
	vetor_velocidade.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	vetor_velocidade.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	vetor_velocidade = vetor_velocidade.normalized()
	
	vetor_velocidade = move_and_slide(vetor_velocidade * VELOCIDADE_MAX)


func marcar_alvo():
	# Verifica se o botão esquerdo do mouse foi clicado
	if Input.is_action_just_pressed("mouse_right_click"):
		var space_state = get_world_2d().direct_space_state
		var colisao = space_state.intersect_point(get_global_mouse_position())
		if colisao and colisao[0]['collider'].name.begins_with('Enemy'):
			# O jogador clicou em um inimigo.
			if alvo == colisao[0]['collider']:
				# Se ele clicou no mesmo inimigo que le ja tinga clicado antes, desmarca-lo
				alvo.get_node('target').visible = false
				alvo = null
				return
			
			if alvo and is_instance_valid(alvo):
				alvo.get_node('target').visible = false  # Desmarcar inimigo antigo que havia sido marcado,
			# Marcar novo inimigo
			alvo = colisao[0]['collider']
			alvo.get_node('target').visible = true


func verificar_atirar():
	if Input.is_action_just_pressed("ui_accept") and alvo:
		if is_instance_valid(alvo):
			var tiro_player = Tiro_player.instance()
			tiro_player.global_position = global_position
			tiro_player.alvo = alvo.global_position
			get_parent().call_deferred('add_child', tiro_player)
		else:
			alvo = null


func _on_Hurtbox_area_entered(_area):
	print('game_over')
