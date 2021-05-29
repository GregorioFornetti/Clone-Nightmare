extends Control

const FRAME_BACKGROUND_NORMAL = 2
const FRAME_BACKGROUND_MAQUINA = 0

onready var PAG_MAX = get_node("Menu_fases").get_child_count() - 1
onready var paginas = get_node("Menu_fases").get_children()
onready var animation_player = get_node("AnimationPlayer")
onready var timer = get_node("Timer_anim")
onready var background = get_node("Background")
var pagina_atual = 0

enum {MENU_FASES, MENU_DIALOGOS, MENU_ESTATISTICAS, MENU_FINAIS}
var menu_atual = SaveStats.ultimo_menu_selecionado
onready var dados_menus = [
	{"menu" : MENU_FASES, "botao": $Btn_fases, "node": $Menu_fases},
	{"menu" : MENU_DIALOGOS, "botao": $Btn_dialogos, "node": $Menu_dialogos},
	{"menu" : MENU_ESTATISTICAS, "botao": $Btn_estatisticas, "node": $Menu_estatisticas},
	{"menu" : MENU_FINAIS, "botao": $Btn_finais, "node": $Menu_finais}
]

func _ready():
	randomize()
	timer.start(rand_range(5, 35))
	mudar_menu_atual()

func _on_Btn_voltar_pressed():
	SaveStats.ultimo_menu_selecionado = MENU_FASES
	# get_tree().change_scene("res://menus/Menu_saves.tscn")
	ComandosGerais.carregar_nova_cena("res://menus/Menu_saves.tscn", self)

func _on_Btn_fases_pressed():
	menu_atual = MENU_FASES
	mudar_menu_atual()

func _on_Btn_dialogos_pressed():
	menu_atual = MENU_DIALOGOS
	mudar_menu_atual()

func _on_Btn_estatisticas_pressed():
	menu_atual = MENU_ESTATISTICAS
	mudar_menu_atual()

func _on_Btn_finais_pressed():
	menu_atual = MENU_FINAIS
	mudar_menu_atual()

func _on_Btn_tutorial_pressed():
	Sist_som.stop("Musica_menu")
	if ComandosGerais.qnt_jogos_abertos != 5:
		Sist_som.comecar_musica_fase(1)
		# get_tree().change_scene("res://Tutorial/Tutorial.tscn")
		ComandosGerais.carregar_nova_fase("res://Tutorial/Tutorial.tscn", self)
	else:
		ComandosGerais.qnt_jogos_abertos = 1
		Sist_som.comecar_musica_fase(20)
		SaveStats.liberar_fase_secreta()
		get_tree().change_scene("res://Fases/Fase_secreta.tscn")

func _on_Timer_anim_timeout(): 
	if background.frame == FRAME_BACKGROUND_NORMAL:
		if rand_range(1, 100) <= 75:
			animation_player.play("Transic_normal")
			timer.start(animation_player.current_animation_length + rand_range(5, 35))
		else:
			animation_player.play("Transic_maquina")
			timer.start(animation_player.current_animation_length + rand_range(2, 6))
	else:
		animation_player.play("Transic_normal")
		timer.start(animation_player.current_animation_length + rand_range(5, 35))


func mudar_menu_atual():
	SaveStats.ultimo_menu_selecionado = menu_atual
	for dados_menu in dados_menus:
		if dados_menu["menu"] == menu_atual:
			dados_menu["botao"].disabled = true
			dados_menu["node"].visible = true
		else:
			dados_menu["botao"].disabled = false
			dados_menu["node"].visible = false

