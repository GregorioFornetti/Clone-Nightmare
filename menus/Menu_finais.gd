extends Control


func _ready():
	if SaveStats.dados_save["fase final liberada"]:
		$Btn_fase_final.visible = true
	if SaveStats.dados_save["final bom liberado"]:
		$Btn_final_bom.visible = true
	if SaveStats.dados_save["final suicidio liberado"]:
		$Btn_final_suicidio.visible = true
	if SaveStats.dados_save["final ignorar liberado"]:
		$Btn_final_ignorar.visible = true
	if SaveStats.dados_save["final secreto liberado"]:
		$Btn_final_secreto.visible = true

func comecar_musica_final():
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(20)

func _on_Btn_fase_final_pressed():
	comecar_musica_final()
	# get_tree().change_scene("res://Finais/Final.tscn")
	ComandosGerais.carregar_nova_fase("res://Finais/Final.tscn", get_parent())

func _on_Btn_final_bom_pressed():
	comecar_musica_final()
	# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_bom.tscn")
	ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_bom.tscn", get_parent())

func _on_Btn_final_suicidio_pressed():
	comecar_musica_final()
	# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_suicidio.tscn")
	ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_suicidio.tscn", get_parent())

func _on_Btn_final_ignorar_pressed():
	comecar_musica_final()
	# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_ignorar.tscn")
	ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_ignorar.tscn", get_parent())

func _on_Btn_final_secreto_pressed():
	comecar_musica_final()
	# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_secreto.tscn")
	ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_secreto.tscn", get_parent())
