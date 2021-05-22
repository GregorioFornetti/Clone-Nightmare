extends Control

onready var save_path = SaveStats.selected_save_path
onready var node_salvar_fases = get_parent().get_parent().get_node("Fases")  # As fases precisam ser colocadas fora do canvas layer
onready var dentro = $Dentro
onready var main_node = get_parent().get_parent()
onready var Senha_registros = preload("res://Finais/Computador/Senha_registros.tscn")
onready var Txt_enigma_senha = preload("res://Finais/Computador/Txt_enigma_senha.tscn")
onready var Novo_jogo = preload("res://menus/Menu_principal.tscn")
onready var Fase_final = preload("res://Finais/Fase_final.tscn")

func _ready():
	var multiplicador = pow(0.9, (ComandosGerais.qnt_jogos_abertos - 1))
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	rect_scale = Vector2(multiplicador, multiplicador)
	rect_position = Vector2(width * (1 - multiplicador) / 2, height * (1 - multiplicador) / 2)


func _on_Btn_desligar_pressed():
	visible = false
	var fase_final = Fase_final.instance()
	main_node.add_child(fase_final)
	main_node.possivel_fechar = true

func _on_Btn_registros_pressed():
	var senha_registros = Senha_registros.instance()
	dentro.add_child(senha_registros)

func _on_Btn_senha_pressed():
	var txt_senha = Txt_enigma_senha.instance()
	dentro.add_child(txt_senha)

func _on_Btn_jogo_clone_pressed():
	ComandosGerais.qnt_jogos_abertos += 1
	ComandosGerais.nodes_salvar_fases.append(node_salvar_fases)
	ComandosGerais.nodes_salvar_menus.append(dentro)
	var novo_jogo = Novo_jogo.instance()
	dentro.add_child(novo_jogo)
