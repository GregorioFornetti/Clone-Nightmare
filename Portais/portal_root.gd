extends Node2D

onready var Portal1 = $Portal1
onready var Portal2 = $Portal2
onready var Linha_interligacao = $Linha_interligacao
onready var GameInterface = get_parent().get_node("GameInterface")
# Listas com os player/inimigos/munições que acabaram de entrar em um portal e ainda não sairam de dentro do outro portal
var lista_corpos_portal1 = []
var lista_corpos_portal2 = []

signal atualizar_btn_portal()

func _ready():
	# Interligar os portais
	Linha_interligacao.points[0] = Portal1.position
	Linha_interligacao.points[1] = Portal2.position
	# Conectando sinais
	GameInterface.Btn_portal.connect("pressed", self, "_on_Botao_portal_pressed")

func _input(event):
	if event.get_action_strength("linhas_portais"):
		emit_signal("atualizar_btn_portal")
		trocar_visibilidade_linhas()

func _on_Portal1_body_entered(body):
	# Corpo acabou de entrar no portal1. Teleportar para portal2 se esse corpo não tiver acabado de entrar no portal2.
	if not body in lista_corpos_portal2:
		body.global_position = Portal2.global_position
		lista_corpos_portal1.append(body)

func _on_Portal1_body_exited(body):
	# Corpo saiu do portal1, se ele estava no portal2 antes, agora ele poderá usar esse portal.
	if body in lista_corpos_portal2:
		lista_corpos_portal2.erase(body)

func _on_Portal2_body_entered(body):
	if not body in lista_corpos_portal1:
		body.global_position = Portal1.global_position
		lista_corpos_portal2.append(body)

func _on_Portal2_body_exited(body):
	if body in lista_corpos_portal1:
		lista_corpos_portal1.erase(body)

func _on_Botao_portal_pressed():
	trocar_visibilidade_linhas()

func trocar_visibilidade_linhas():
	Linha_interligacao.visible = not Linha_interligacao.visible
