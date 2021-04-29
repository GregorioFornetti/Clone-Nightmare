extends "res://menus/Criador_botoes.gd"

func _ready():
	# Criar os 20 botoes de fases.
	criar_botoes("Fase", SaveStats.ultima_fase_liberada)

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
	get_tree().change_scene("res://Cutscenes/Menu_dialogos.tscn")
