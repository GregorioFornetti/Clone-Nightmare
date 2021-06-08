extends Control

onready var animation_player = $AnimationPlayer
onready var timer = $Timer_animacao
onready var background = $Background
onready var Menu_opcoes = preload("res://menus/Menu_opcoes.tscn")
const FRAME_BACKGROUND_PLAYER = 0
const FRAME_BACKGROUND_CONSCIENCIA = 3

func _ready():
	randomize()

func _on_Btn_jogar_pressed():
	# get_tree().change_scene("res://menus/Menu_saves.tscn")
	ComandosGerais.carregar_nova_cena("res://menus/Menu_saves.tscn", self)

func _on_Btn_sair_pressed():
	if ComandosGerais.qnt_jogos_abertos == 1:
		get_tree().quit()
	else:
		Sist_som.comecar_musica_fase(20)
		Sist_som.stop("Musica_menu")
		
		ComandosGerais.qnt_jogos_abertos -= 1
		ComandosGerais.nodes_salvar_fases.pop_back()
		ComandosGerais.nodes_salvar_menus.pop_back()
		
		SaveStats.selected_save_path = get_parent().get_parent().save_path
		
		queue_free()

func _on_Btn_creditos_pressed():
	ComandosGerais.carregar_nova_cena("res://menus/Menu_creditos.tscn", self)

func _on_Btn_opcoes_pressed():
	var menu_opcoes = Menu_opcoes.instance()
	add_child(menu_opcoes)


func _on_Timer_animacao_timeout():
	Sist_som.play("Trovao")
	if background.frame == FRAME_BACKGROUND_PLAYER:
		if rand_range(1, 100) <= 75:
			animation_player.play("TransicaoParaPlayer")
			timer.start(animation_player.current_animation_length + rand_range(5, 35))
		else:
			animation_player.play("TransicaoParaConsciencia")
			timer.start(animation_player.current_animation_length + rand_range(2, 6))
	else:
		animation_player.play("TransicaoParaPlayer")
		timer.start(animation_player.current_animation_length + rand_range(5, 35))
