extends Control

onready var PAG_MAX = get_node("Menu_fases").get_child_count() - 1
onready var paginas = get_node("Menu_fases").get_children()
var pagina_atual = 0

enum {MENU_FASES, MENU_DIALOGOS, MENU_FINAIS}
var menu_atual = SaveStats.ultimo_menu_selecionado
onready var dados_menus = [
	{"menu" : MENU_FASES, "botao": $Btn_fases, "node": $Menu_fases},
	{"menu" : MENU_DIALOGOS, "botao": $Btn_dialogos, "node": $Menu_dialogos},
	{"menu" : MENU_FINAIS, "botao": $Btn_finais, "node": $Menu_finais}
]

func _ready():
	mudar_menu_atual()

func _on_Btn_voltar_pressed():
	SaveStats.ultimo_menu_selecionado = MENU_FASES
	get_tree().change_scene("res://menus/Menu_saves.tscn")

func _on_Btn_fases_pressed():
	menu_atual = MENU_FASES
	mudar_menu_atual()

func _on_Btn_dialogos_pressed():
	menu_atual = MENU_DIALOGOS
	mudar_menu_atual()

func _on_Btn_finais_pressed():
	menu_atual = MENU_FINAIS
	mudar_menu_atual()

func _on_Btn_tutorial_pressed():
	Sist_som.stop("Musica_menu")
	Sist_som.comecar_musica_fase(1)
	get_tree().change_scene("res://Tutorial/Tutorial.tscn")


func mudar_menu_atual():
	SaveStats.ultimo_menu_selecionado = menu_atual
	for dados_menu in dados_menus:
		if dados_menu["menu"] == menu_atual:
			dados_menu["botao"].disabled = true
			dados_menu["node"].visible = true
		else:
			dados_menu["botao"].disabled = false
			dados_menu["node"].visible = false
