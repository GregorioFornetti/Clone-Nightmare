extends KinematicBody2D

const VELOCIDADE_MAX = 200

var vetor_velocidade = Vector2.ZERO
onready var Player = get_parent().get_node('Player')
onready var Tiro_inimigo = preload('res://Inimigos/enemy_bullet.tscn')
onready var Draw_node = get_parent().get_node("Aim_line")
onready var bullet_mask = pow(2, 7)
onready var arma = $Position2D
var rotation_fix = PI / 2
var tiro_inimigo
var morto = false

signal inimigo_morreu

func _ready():
	bullet_mask += collision_mask
	Player.connect("player_atirou", self, '_on_Player_shoot')
	connect("inimigo_morreu", Player, '_on_Enemy_death', [self])
	connect("inimigo_morreu", get_parent().get_node('GameStats'), '_on_Enemy_die')


func _physics_process(_delta):
	movimentation()
	rotacionar()
	if Player.alvo:
		Draw_node.desenhar_intersec(global_position, arma.global_position, Player.position, self, bullet_mask, "Player")

func rotacionar():
	rotation = position.angle_to_point(Player.position) - rotation_fix

func movimentation():
	pass


func _on_Hurtbox_area_entered(area):
	# A variavel morto evita que o inimigo "morra duas vezes". Isso pode acontecer se não apagar ele a tempo e ele tomar outro tiro.
	if area.get_parent() != tiro_inimigo and not morto:
		morto = true
		Sist_som.play("Morte_inimigo")
		area.get_parent().acabar_com_bala()
		emit_signal("inimigo_morreu")
		queue_free()


func _on_Player_shoot(_bullet):
	# Inimigo só atira no player quando o player também atirar.
	tiro_inimigo = Tiro_inimigo.instance()
	tiro_inimigo.global_position = arma.global_position
	tiro_inimigo.rotation = rotation
	tiro_inimigo.alvo = Player.global_position
	get_parent().call_deferred('add_child', tiro_inimigo)

