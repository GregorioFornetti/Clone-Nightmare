extends Node2D

var selected_save_path
var fase_atual
var num_dialogo_atual
var dados_save
var ultimo_menu_selecionado = 0

func salvar_nova_info():
	var file = File.new()
	file.open(selected_save_path, File.WRITE)
	file.store_var(dados_save)
	file.close()

func passar_fase():
	if fase_atual == dados_save["fase"]:
		# Jogador acabou de passar uma nova fase
		if fase_atual != 20:
			dados_save["fase"] += 1
		else:
			dados_save["fase final liberada"] = true
		salvar_nova_info()

func liberar_final_bom():
	dados_save["final bom liberado"] = true
	salvar_nova_info()

func liberar_final_suicidio():
	dados_save["final suicidio liberado"] = true
	salvar_nova_info()

func liberar_final_ignorar():
	dados_save["final ignorar liberado"] = true
	salvar_nova_info()

func liberar_final_secreto():
	dados_save["final secreto liberado"] = true
	salvar_nova_info()
