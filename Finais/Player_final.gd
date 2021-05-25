extends KinematicBody2D

const VELOCIDADE_MAX = 200
const lista_entidades_interagiveis = ["Player", "Maquina de clones"]
var vetor_velocidade = Vector2.ZERO
var rotation_fix = PI / 2
var pode_mirar = true
onready var main_node = get_parent().get_parent()
onready var label_sair = get_parent().get_parent().get_node("CanvasLayer/Label_sair")
onready var label_pc = get_parent().get_parent().get_node("CanvasLayer/Label_computador")
var alvo

signal alvo_marcado(nome_alvo)
signal alvo_desmarcado()


func _ready():
	connect("alvo_desmarcado", main_node, "_on_Player_alvo_desmarcado")
	connect("alvo_marcado", main_node, "_on_Player_alvo_marcado")
	
func _process(_delta):
	movimentacao()
	rotacionar()

func _input(event):
	if event.get_action_strength("mouse_right_click"):
		marcar_alvo()


func marcar_alvo():
	# Verifica se o botão esquerdo do mouse foi clicado
	if pode_mirar and not main_node.final_iniciado:
		var space_state = get_world_2d().direct_space_state
		var colisao = space_state.intersect_point(get_global_mouse_position())
		if colisao and colisao[0]['collider'].name in lista_entidades_interagiveis:
			$Sprite.frame = 1
			# O jogador clicou em um interagivel:
			if alvo == colisao[0]['collider']:
				# Se ele clicou no mesmo interagivel que ele ja tinha clicado antes, desmarca-lo
				desmarcar_alvo()
				return
			
			if alvo:
				alvo.get_node('target').visible = false  # Desmarcar interagivel antigo que havia sido marcado
			if colisao[0]['collider'].name == "Player":
				$Sprite.frame = 2  # Sprite suicidio
			# Marcar nova entidade
			emit_signal("alvo_marcado", colisao[0]['collider'].name)
			alvo = colisao[0]['collider']
			alvo.get_node('target').visible = true

func movimentacao():
	vetor_velocidade.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	vetor_velocidade.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	vetor_velocidade = vetor_velocidade.normalized()
	
	move_and_slide(vetor_velocidade * VELOCIDADE_MAX)

func rotacionar():
	if alvo and alvo != self:
		rotation = position.angle_to_point(alvo.position) - rotation_fix
	else:
		rotation = position.angle_to_point(get_global_mouse_position()) - rotation_fix

func desmarcar_alvo():
	if alvo:
		emit_signal("alvo_desmarcado")
		alvo.get_node('target').visible = false
		$Sprite.frame = 1
		alvo = null
	
func _on_Saida_body_entered(_body):
	desmarcar_alvo()
	pode_mirar = false
	emit_signal("alvo_marcado", "Saida")
	label_sair.visible = true

func _on_Saida_body_exited(_body):
	emit_signal("alvo_desmarcado")
	pode_mirar = true
	label_sair.visible = false


func _on_Range_pc_body_entered(_body):
	desmarcar_alvo()
	pode_mirar = false
	label_pc.visible = true
	
func _on_Range_pc_body_exited(body):
	pode_mirar = true
	label_pc.visible = false
