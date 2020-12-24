extends KinematicBody2D

const VELOCIDADE_MAX = 200

var vetor_velocidade = Vector2.ZERO
onready var player = get_parent().get_node('Player')
onready var Tiro_inimigo = preload('res://Inimigos/enemy_bullet.tscn')
var quant_mortes = 0

func _ready():
	pass 

func _physics_process(_delta):
	movimentation()
	verificar_atirar()
	

func movimentation():
	vetor_velocidade.x = Input.get_action_strength('ui_left') - Input.get_action_strength('ui_right')
	vetor_velocidade.y = Input.get_action_strength('ui_up') - Input.get_action_strength('ui_down')
	vetor_velocidade = vetor_velocidade.normalized()
	
	vetor_velocidade = move_and_slide(vetor_velocidade * VELOCIDADE_MAX)


func _on_Hurtbox_area_entered(area):
	area.get_parent().queue_free()
	quant_mortes += 1
	print('inimigo: ' + str(quant_mortes))
	# queue_free()


func verificar_atirar():
	# Só atirar se tiver apertado o botão de atirar e o player tiver marcado algum inimigo.
	if Input.is_action_just_pressed("ui_accept") and player.alvo:
		var tiro_inimigo = Tiro_inimigo.instance()
		tiro_inimigo.global_position = global_position
		tiro_inimigo.alvo = player.global_position
		get_parent().call_deferred('add_child', tiro_inimigo)
