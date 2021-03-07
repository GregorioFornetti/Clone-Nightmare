extends KinematicBody2D

const VELOCIDADE_MAX = 200

var vetor_velocidade = Vector2.ZERO
onready var Player = get_parent().get_node('Player')
onready var Tiro_inimigo = preload('res://Inimigos/enemy_bullet.tscn')
var rotation_fix = PI / 2
var tiro_inimigo

signal inimigo_morreu

func _ready():
	Player.connect("player_marcou", self, "_on_Player_marcou")
	Player.connect("player_desmarcou", self, "_on_Player_desmarcou")
	Player.connect("player_atirou", self, '_on_Player_shoot')
	connect("inimigo_morreu", Player, '_on_Enemy_death', [self])
	connect("inimigo_morreu", get_parent().get_node('GameStats'), '_on_Enemy_die')


func _physics_process(_delta):
	movimentation()
	rotacionar()

func rotacionar():
	if Player.alvo:
		rotation = position.angle_to_point(Player.position) - rotation_fix
	elif vetor_velocidade != Vector2.ZERO:
		rotation = vetor_velocidade.angle() + rotation_fix

func movimentation():
	vetor_velocidade = -Player.vetor_velocidade * VELOCIDADE_MAX
	move_and_slide(vetor_velocidade)


func _on_Hurtbox_area_entered(area):
	if area.get_parent() != tiro_inimigo:
		area.get_parent().queue_free()
		emit_signal("inimigo_morreu")
		queue_free()


func _on_Player_shoot(_bullet):
	# Inimigo só atira no player quando o player também atirar.
	tiro_inimigo = Tiro_inimigo.instance()
	tiro_inimigo.global_position = global_position
	tiro_inimigo.alvo = Player.global_position
	get_parent().call_deferred('add_child', tiro_inimigo)

func _on_Player_marcou():
	$Sprite.frame = 0

func _on_Player_desmarcou():
	$Sprite.frame = 1
