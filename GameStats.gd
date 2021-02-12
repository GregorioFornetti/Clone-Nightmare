extends Node2D

export var QUANT_INICIAL_BULLETS = 0
export var QUANT_INICIAL_INIMIGOS = 0
export var FASE_ATUAL = 0
onready var quant_atual_inimigos = QUANT_INICIAL_INIMIGOS
onready var quant_atual_bullets = QUANT_INICIAL_BULLETS
onready var LabelInimigo = get_node("CanvasLayer").get_node("LabelInim")
onready var LabelBullets = get_node("CanvasLayer").get_node("LabelBullets")
var tiro_player_atual
var parar = false

signal acabou_municao()
signal acabou_inimigos()

func _ready():
	atualizar_label_bullets()
	atualizar_label_inimigo()

func _process(_delta):
	if quant_atual_bullets == 0 and not is_instance_valid(tiro_player_atual) and not parar:
		emit_signal("acabou_municao")
		parar = true

func _on_Player_player_atirou(bullet):
	quant_atual_bullets -= 1
	tiro_player_atual = bullet
	atualizar_label_bullets()

func _on_Enemy_die():
	quant_atual_inimigos -= 1
	if quant_atual_inimigos == 0:
		emit_signal("acabou_inimigos")
	atualizar_label_inimigo()


func atualizar_label_inimigo():
	LabelInimigo.text = 'Inimigos vivos: ' + str(quant_atual_inimigos)

func atualizar_label_bullets():
	LabelBullets.text = 'Munição restante: ' + str(quant_atual_bullets)
