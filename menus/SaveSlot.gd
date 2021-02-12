extends Control

export (int)var slot_number

var save_path
var fase_salva

onready var info_slot = get_node("Info_slot")
onready var titulo_slot = get_node("Titulo_slot")

onready var btn_comecar = get_node("Btn_comecar")
onready var btn_continuar = get_node("Btn_continuar")
onready var btn_apagar = get_node("Btn_apagar")

onready var menu_apagar = get_parent().get_node("Menu_apagar")


func _ready():
	get_node("Titulo_slot").text = "Slot " + str(slot_number)
	save_path = "user://save" + str(slot_number) + ".dat"
	var file = File.new()
	
	if file.file_exists(save_path):
		ajustar_slot_carregado()
	else:
		ajustar_slot_vazio()


func _on_Btn_comecar_pressed():
	var dados_save = {
		"fase" : 1
	}
	
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_var(dados_save)
	file.close()
	
	SaveStats.selected_save_path = save_path
	SaveStats.ultima_fase_liberada = 1

func _on_Btn_apagar_pressed():
	menu_apagar.slot_number = slot_number
	menu_apagar.visible = true
	get_tree().paused = true

func apagar_slot():
	var diretorio = Directory.new()
	diretorio.remove(save_path)
	ajustar_slot_vazio()

func _on_Btn_continuar_pressed():
	SaveStats.selected_save_path = save_path
	SaveStats.ultima_fase_liberada = fase_salva
	get_tree().change_scene("res://menus/Menu_fases.tscn")


func ajustar_slot_carregado():
	# Ajusta os labels e botões para um slot que possue "save"
	btn_continuar.visible = true
	btn_apagar.visible = true
	btn_comecar.visible = false
	
	var file = File.new()
	file.open(save_path, File.READ)
	var save_infos = file.get_var()
	fase_salva = save_infos.fase
	info_slot.text = "Fase " + str(fase_salva)
	file.close()

func ajustar_slot_vazio():
	# Ajusta os label e botões para um slot "vazio"
	btn_continuar.visible = false
	btn_apagar.visible = false
	btn_comecar.visible = true
	info_slot.text = "Vazio"
	
