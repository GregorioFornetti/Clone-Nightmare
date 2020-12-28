extends KinematicBody2D

const VELOCIDADE_MAX = 200

var vetor_velocidade = Vector2.ZERO
onready var Player = get_parent().get_node('Player')
onready var Tiro_inimigo = preload('res://Inimigos/enemy_bullet.tscn')
var quant_mortes = 0

signal inimigo_morreu

func _ready():
	Player.connect("player_atirou", self, '_on_Player_shoot')
	connect("inimigo_morreu", get_parent().get_node('GameStats'), '_on_Enemy_die')


func _physics_process(_delta):
	movimentation()


func movimentation():
	move_and_slide(-Player.vetor_velocidade * VELOCIDADE_MAX)


func _on_Hurtbox_area_entered(area):
	area.get_parent().queue_free()
	quant_mortes += 1
	print('inimigo: ' + str(quant_mortes))
	emit_signal("inimigo_morreu")
	# queue_free()


func _on_Player_shoot(_bullet):
	# Inimigo só atira no player quando o player também atirar.
	var tiro_inimigo = Tiro_inimigo.instance()
	tiro_inimigo.global_position = global_position
	tiro_inimigo.alvo = Player.global_position
	get_parent().call_deferred('add_child', tiro_inimigo)

