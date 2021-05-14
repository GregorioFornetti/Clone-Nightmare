extends Control

onready var PAG_MAX = get_node("Lista_paginas_fases").get_child_count() - 1
onready var paginas = get_node("Lista_paginas_fases").get_children()
onready var botao_prox = $Btn_prox
onready var botao_ant = $Btn_ant
var pagina_atual = 0

func _ready():
	# Criar os 20 botoes de fases.
	var fase_atual = 1
	var ultima_fase_liberada = SaveStats.ultima_fase_liberada
	for pagina in get_node("Lista_paginas_fases").get_children():
		for botao_fase in pagina.get_children():
			botao_fase.connect('pressed', self, '_on_Botao_pressionado', [fase_atual])
			if fase_atual > ultima_fase_liberada:
				botao_fase.desabilitar()
			fase_atual += 1

func _input(event):
	if event.get_action_strength("ui_right"):
		ir_para_prox_pagina()
	elif event.get_action_strength("ui_left"):
		ir_para_pagina_ant()


func ir_para_prox_pagina():
	if pagina_atual != PAG_MAX:
		paginas[pagina_atual].visible = false
		pagina_atual += 1
		paginas[pagina_atual].visible = true
		
		botao_ant.visible = true
		if pagina_atual == PAG_MAX:
			botao_prox.visible = false

func ir_para_pagina_ant():
	if pagina_atual != 0:
		paginas[pagina_atual].visible = false
		pagina_atual -= 1
		paginas[pagina_atual].visible = true
		
		botao_prox.visible = true
		if pagina_atual == 0:
			botao_ant.visible = false


func _on_Botao_pressionado(fase):  # Algum botão de fase foi selecionado (carregar tal fase)]
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(fase)
	
	get_tree().change_scene("res://Fases/fase" + str(fase) + ".tscn")

func _on_Btn_voltar_pressed():
	get_tree().change_scene("res://menus/Menu_saves.tscn")

func _on_Btn_tutorial_pressed():
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(1)
	get_tree().change_scene("res://Tutorial/Tutorial.tscn")

func _on_Btn_dialogos_pressed():
	get_tree().change_scene("res://Dialogos/Menu_dialogos.tscn")

func _on_Btn_prox_pressed():
	ir_para_prox_pagina()

func _on_Btn_ant_pressed():
	ir_para_pagina_ant()
