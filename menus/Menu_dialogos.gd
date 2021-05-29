extends Control

onready var Btn = preload("res://menus/Btn_jogo.tscn")
onready var dic_sprites_botoes = {}

func _ready():
	# Criar os 20 botoes de fases.
	Sist_som.parar_sons_cutscene()
	
	for i in range(1, 21):
		dic_sprites_botoes["dialogo" + str(i)] = load("res://Sprites/Buttons/dialogo-" + str(i) + ".png")
	if SaveStats.dados_save["fase final liberada"]:
		criar_botoes(SaveStats.dados_save["fase"])
	else:
		criar_botoes(SaveStats.dados_save["fase"] - 1)
	
	if SaveStats.dados_save["fase secreta concluida"]:
		$Btn_dialogo_secreto.visible = true

func _on_Botao_pressionado(fase):  # Algum botão de fase foi selecionado (carregar tal fase)
	SaveStats.fase_atual = 0
	SaveStats.num_dialogo_atual = fase
	
	Sist_som.stop("Musica_menu")
	Sist_som.play("Musica_cutscene")
	
	# get_tree().change_scene("res://Dialogos/Dialogo-root.tscn")
	ComandosGerais.carregar_nova_cena("res://Dialogos/Dialogo-root.tscn", get_parent())


func _on_Btn_voltar_pressed():
	# get_tree().change_scene("res://menus/Menu_fases.tscn")
	ComandosGerais.carregar_nova_cena("res://menus/Menu_fases.tscn", get_parent())


func criar_botoes(ultimo_liberado):
	# Cria 20 botões (4 linhas com 5 botões)
	var y = 50
	for i in range(4):
		var x = 30
		for j in range(1, 6):
			var botao = Btn.instance()
			var valor_atual = i * 5 + j
			botao.texture_normal = dic_sprites_botoes["dialogo" + str(valor_atual)]
			botao.rect_position = Vector2(x, y)
			botao.connect('pressed', self, '_on_Botao_pressionado', [valor_atual])
			
			if ultimo_liberado < valor_atual:
				botao.disabled = true
			add_child(botao)
			botao.rect_size = Vector2(0, 0)
			
			x += 200
		y += 100


func _on_Btn_dialogo_secreto_pressed():
	SaveStats.fase_atual = 0
	SaveStats.num_dialogo_atual = -1
	
	Sist_som.stop("Musica_menu")
	Sist_som.play("Musica_cutscene")
	
	ComandosGerais.carregar_nova_cena("res://Dialogos/Dialogo-root.tscn", get_parent())
