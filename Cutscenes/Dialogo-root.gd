extends Control

const NOME_PLAYER = "Personagem"
const NOME_SILHUETA = "???????????"
const NOME_CONSCIENCIA = "Consciência"
const IMG_PERSONAGEM = "res://Sprites/Personagem/cientista-portrait.png"

const DIC_HUMORES = {
	"normal" : {
		"fonte" : preload("res://fontes/fonte_normal.tres"),
		"velocidade" : 20,
		"cor" : Color(0.9, 0.9, 0.9, 1),
		"som": "Dialogo_normal"
	},
	"raiva" : {
		"fonte" : preload("res://fontes/fonte_raiva.tres"),
		"velocidade" : 100,
		"cor" : Color(0.7, 0, 0, 1),
		"som": "Dialogo_raiva"
	}
}
var dialogo_atual = 0

onready var lb_nome = $"Box-dialogo/Lb_nome"
onready var sprite_box_dialogo = $"Box-dialogo/Sprite"
onready var lb_dialogo = $"Box-dialogo/Lb_dialogo"
onready var timer_letras = $"Timer_letras"
onready var btn_prox = $"Box-dialogo/Btn_prox"
onready var btn_ant = $"Box-dialogo/Btn_ant"
onready var personagem = $Personagem
onready var silhueta = $Silhueta
onready var menu_pular = $Menu_pular

var dics_dialogos
var dic_humor

func _ready():
	dics_dialogos = retorna_dics_dialogos()
	atualizar_box_dialogo(dics_dialogos[0])

func retorna_dics_dialogos():
	# OBS: para editar os textos do dialogo, abra a pasta "Dialogos" em algum editor de código para acessar os arquivos JSON.
	var file = File.new()
	file.open("res://Cutscenes/Dialogos/dialogo" + str(SaveStats.num_dialogo_atual) + ".json", file.READ)
	return parse_json(file.get_as_text())

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		avancar_proximo()
	if Input.is_action_just_pressed("ui_cancel"):
		Sist_som.stop(dic_humor.som)
		menu_pular.visible = true
		get_tree().paused = true

func _on_Btn_prox_pressed():
	avancar_proximo()

func _on_Btn_ant_pressed():
	dialogo_atual -= 1
	Sist_som.stop(dic_humor.som)
	atualizar_box_dialogo(dics_dialogos[dialogo_atual])

func _on_Timer_letras_timeout():
	if lb_dialogo.percent_visible != 1:
		lb_dialogo.visible_characters += 1
	else:
		Sist_som.stop(dic_humor.som)
		btn_prox.text = 'Próximo'
		timer_letras.stop()


func avancar_proximo():
	# Avança para prox. dialogo se o dialogo atual já tiver carregado 100% ou avança para 100% do dialogo atual caso contrário.
	if lb_dialogo.percent_visible != 1:
		lb_dialogo.percent_visible = 1
	else:
		dialogo_atual += 1
		if dialogo_atual == len(dics_dialogos):
			mudar_menu()
		else:
			atualizar_box_dialogo(dics_dialogos[dialogo_atual])

func mudar_menu():
	if SaveStats.fase_atual == 0:  # Jogador está acessando pela galeria
		Sist_som.stop("Musica_cutscene")
		Sist_som.play("Musica_menu")
		get_tree().change_scene("res://Cutscenes/Menu_dialogos.tscn")
	else:  # Jogador está acessando pela cutscene automática após vitória
		get_tree().change_scene("res://menus/Menu_vitoria.tscn") # Acabou os dialogos, ir para o menu de vitória.

func atualizar_box_dialogo(dic_dialogo):
	# Atualizar textos/labels
	lb_dialogo.percent_visible = 0
	lb_dialogo.text = dic_dialogo.texto
	
	if dic_dialogo.nome == "player":
		lb_nome.text = NOME_PLAYER
	else:
		lb_nome.text = NOME_SILHUETA
		
	# Aplicar efeitos do humor:
	dic_humor = DIC_HUMORES[dic_dialogo['humor']]
	lb_dialogo.add_font_override("font", dic_humor.fonte)
	lb_dialogo.add_color_override("font_color", dic_humor.cor)
	timer_letras.wait_time = 1.0 / dic_humor.velocidade
	Sist_som.play(dic_humor.som)
	
	if dialogo_atual == 0:
		sprite_box_dialogo.frame = 1
		btn_ant.disabled = true
	else:
		sprite_box_dialogo.frame = 0
		btn_ant.disabled = false
	
	timer_letras.start()

