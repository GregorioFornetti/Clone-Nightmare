extends Control


func _ready():
	if SaveStats.dados_save["fase final liberada"]:
		$Btn_fase_final.disabled = false
	if SaveStats.dados_save["final bom liberado"]:
		$Btn_final_bom.disabled = false
	if SaveStats.dados_save["final suicidio liberado"]:
		$Btn_final_suicidio.disabled = false
	if SaveStats.dados_save["final ignorar liberado"]:
		$Btn_final_ignorar.disabled = false
	if SaveStats.dados_save["final secreto liberado"]:
		$Btn_final_secreto.disabled = false


func _on_Btn_fase_final_pressed():
	get_tree().change_scene("res://Finais/Final.tscn")

func _on_Btn_final_bom_pressed():
	get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_bom.tscn")

func _on_Btn_final_suicidio_pressed():
	get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_suicidio.tscn")

func _on_Btn_final_ignorar_pressed():
	get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_ignorar.tscn")

func _on_Btn_final_secreto_pressed():
	get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_secreto.tscn")
