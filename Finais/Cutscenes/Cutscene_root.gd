extends Control

onready var lista_historias
onready var timer_letras = $Timer_letras
var label_atual
var indice_atual = 0

func _ready():
	lista_historias = $Lista_nodes_historia.get_children()
	for node_hist in lista_historias:
		node_hist.visible = false
	lista_historias[0].visible = true
	label_atual = lista_historias[0].get_node("Label_historia")
	label_atual.percent_visible = 0
	timer_letras.start()

func _input(event):
	if event.get_action_strength("ui_accept"):
		if label_atual.percent_visible != 1:
			label_atual.percent_visible = 1
		elif indice_atual == len(lista_historias) - 1:
			Sist_som.parar_musicas_fase()
			Sist_som.play("Musica_menu")
			# get_tree().change_scene("res://menus/Menu_geral.tscn")
			ComandosGerais.carregar_nova_cena("res://menus/Menu_geral.tscn", self)
		else:
			comecar_novo_node_hist()


func comecar_novo_node_hist():
	lista_historias[indice_atual].visible = false
	indice_atual += 1
	lista_historias[indice_atual].visible = true
	label_atual = lista_historias[indice_atual].get_node("Label_historia")
	label_atual.percent_visible = 0
	timer_letras.start()


func _on_Timer_letras_timeout():
	if label_atual.percent_visible != 1:
		label_atual.visible_characters += 1
		timer_letras.start()
