extends "res://menus/Criador_botoes.gd"

func _ready():
	# Criar os 20 botoes de fases.
	Sist_som.parar_sons_cutscene()
	criar_botoes("Dialogo", SaveStats.ultima_fase_liberada - 1)

func _on_Botao_pressionado(fase):  # Algum botão de fase foi selecionado (carregar tal fase)
	SaveStats.fase_atual = 0
	SaveStats.num_dialogo_atual = fase
	
	Sist_som.stop("Musica_menu")
	Sist_som.play("Musica_cutscene")
	
	get_tree().change_scene("res://Cutscenes/Dialogo-root.tscn")


func _on_Btn_voltar_pressed():
	get_tree().change_scene("res://menus/Menu_fases.tscn")
