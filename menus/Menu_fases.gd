extends Control

onready var main = get_parent()
onready var PAG_MAX = get_child_count() - 3  # Menos os (botoes de transicao + 1) para indicar o ultimo indice
onready var paginas = get_children()
onready var botao_prox = $Btn_prox
onready var botao_ant = $Btn_ant
onready var btn_fase_secreta = $PagSecreta/Btn_fase_secreta
var pagina_atual = 0

func _ready():
	# Criar os 20 botoes de fases.
	var fase_atual = 1
	var ultima_fase_liberada = SaveStats.dados_save["fase"]
	for pagina in get_children():
		if "Pagina" in pagina.name:  # Garantir que é uma pagina e não um botao
			for botao_fase in pagina.get_children():
				botao_fase.connect('pressed', self, '_on_Botao_pressionado', [fase_atual])
				if fase_atual > ultima_fase_liberada:
					botao_fase.desabilitar()
				fase_atual += 1
	
	if not SaveStats.dados_save["fase secreta liberada"]:
		btn_fase_secreta.desabilitar()

func _input(event):
	if event.get_action_strength("ui_right") and main.menu_atual == main.MENU_FASES:
		if pagina_atual != PAG_MAX:
			Sist_som.play("Btn_click")
			ir_para_prox_pagina()
	elif event.get_action_strength("ui_left") and main.menu_atual == main.MENU_FASES:
		if pagina_atual != 0:
			Sist_som.play("Btn_click")
			ir_para_pagina_ant()


func _on_Botao_pressionado(fase):  # Algum botão de fase foi selecionado (carregar tal fase)]
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(fase)
	
	# get_tree().change_scene("res://Fases/fase" + str(fase) + ".tscn")
	ComandosGerais.carregar_nova_fase("res://Fases/fase" + str(fase) + ".tscn", get_parent())

func _on_Btn_fase_secreta_pressed():
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(20)
	
	get_tree().change_scene("res://Fases/Fase_secreta.tscn")
	
	

func _on_Btn_prox_pressed():
	ir_para_prox_pagina()

func _on_Btn_ant_pressed():
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


