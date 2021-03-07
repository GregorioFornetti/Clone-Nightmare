extends KinematicBody2D

const VELOCIDADE_MAX = 200

var vetor_velocidade = Vector2.ZERO
var alvo
var Tiro_player = preload('res://Jogador/player_bullet.tscn')
onready var GameStats = get_parent().get_node("GameStats")
onready var PlayerSprite = $Sprite
var mouse_position
var arma_carregada = true
var rotation_fix = PI / 2

signal player_atirou(bullet)
signal player_marcou()
signal player_desmarcou()
signal player_morreu()

func _ready():
	ReloadTimer.connect('timeout', self, '_on_BulletReloadTimer_timeout')

func _physics_process(_delta):
	movimentacao()
	marcar_alvo()
	rotacionar()
	verificar_atirar()
	

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
			tiro_player.alvo = alvo.global_position
			get_parent().call_deferred('add_child', tiro_player)
			
			emit_signal("player_atirou", tiro_player)
			
			ReloadTimer.start()
			arma_carregada = false
		else:
			alvo = null


func _on_Hurtbox_area_entered(area):
	area.get_parent().queue_free()
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
