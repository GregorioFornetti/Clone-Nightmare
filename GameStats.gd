extends Node2D

export var QUANT_INICIAL_BULLETS = 0
export var QUANT_INICIAL_INIMIGOS = 0
export var FASE_ATUAL = 0
onready var quant_atual_inimigos = QUANT_INICIAL_INIMIGOS
onready var quant_atual_bullets = QUANT_INICIAL_BULLETS
onready var GameInterface = get_parent().get_node("GameInterface")
var quant_balas_em_jogo = 0
var jogo_acabou = false

signal acabou_municao()
signal acabou_inimigos()

func _ready():
	SaveStats.fase_atual = FASE_ATUAL
	SaveStats.num_dialogo_atual = FASE_ATUAL
	GameInterface.atualizar_label_bullets(QUANT_INICIAL_BULLETS)
	GameInterface.atualizar_label_inimigo(QUANT_INICIAL_INIMIGOS)

func _process(_delta):
	if quant_atual_bullets == 0 and quant_balas_em_jogo == 0 and not jogo_acabou:
		emit_signal("acabou_municao")
		jogo_acabou = true

func _on_Player_player_atirou(_bullet):
	quant_atual_bullets -= 1
	quant_balas_em_jogo += quant_atual_inimigos + 1  # Considerando que todos os inimigos irão atirar e o player também.
	GameInterface.atualizar_label_bullets(quant_atual_bullets)

func _on_Enemy_die():
	quant_atual_inimigos -= 1
	if quant_atual_inimigos == 0:
		emit_signal("acabou_inimigos")
	GameInterface.atualizar_label_inimigo(quant_atual_inimigos)

func on_Bala_em_jogo_acabou():
	quant_balas_em_jogo -= 1

