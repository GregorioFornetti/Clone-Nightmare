extends KinematicBody2D

export var MAX_VELOCIDADE = 400
onready var GameStats = get_parent().get_node("GameStats")
var alvo
var vetor_velocidade
var municao_ja_acabou = false
signal bullet_acabou()

func _ready():
	connect("bullet_acabou", GameStats, "on_Bala_em_jogo_acabou")
	vetor_velocidade = global_position.direction_to(alvo).normalized()

func _physics_process(delta):
	move_and_collide(vetor_velocidade * MAX_VELOCIDADE * delta * GameStats.multiplicador_vel)


func _on_Area2D_body_entered(_body):
	acabar_com_bala()

func acabar_com_bala():
	# A bala colidiu com algo, avisar que ela acabou.
	if not municao_ja_acabou:  # Verificação para evitar dupla colisão e erro na contagem.
		Sist_som.play("Tiro_parede")
		emit_signal("bullet_acabou")
		queue_free()
		municao_ja_acabou = true
