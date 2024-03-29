extends Control


func _ready():
	Sist_som.parar_sons_cutscene()
	Sist_som.play("Musica_menu")
	
	if SaveStats.fase_atual == -1:
		$Btn_prox.visible = false

func _on_Btn_prox_pressed():
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(SaveStats.fase_atual + 1)
	# get_tree().change_scene("res://Fases/fase" + str(SaveStats.fase_atual + 1) + ".tscn")
	ComandosGerais.carregar_nova_fase("res://Fases/fase" + str(SaveStats.fase_atual + 1) + ".tscn", self)


func _on_Btn_reiniciar_pressed():
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(SaveStats.fase_atual)
	# get_tree().change_scene("res://Fases/fase" + str(SaveStats.fase_atual) + ".tscn")
	if SaveStats.fase_atual > 0:
		ComandosGerais.carregar_nova_fase("res://Fases/fase" + str(SaveStats.fase_atual) + ".tscn", self)
	else:
		ComandosGerais.carregar_nova_fase("res://Fases/Fase_secreta.tscn", self)


func _on_Btn_voltar_pressed():
	# get_tree().change_scene("res://menus/Menu_geral.tscn")
	ComandosGerais.carregar_nova_cena("res://menus/Menu_geral.tscn", self)
