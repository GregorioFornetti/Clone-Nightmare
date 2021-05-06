extends Control

onready var audio_geral = AudioServer.get_bus_index("Master")
onready var audio_musica = AudioServer.get_bus_index("Musica")
onready var audio_efeitos_sonoros = AudioServer.get_bus_index("Efeitos sonoros")
onready var min_value = $Slider_geral.min_value
onready var dropdown_resolucao = $Dropdown_resolucao
onready var save_path = "user://opcoes.dat"


func _ready():
	# Coleta as informações das opções salvas e aplica nos nodes do menu de opções.
	var file = File.new()
	
	if file.file_exists(save_path):
		var lista_resolucoes = ["1664x988", "1344x798", "1024x608", "864x513", "704x418"]
		file.open(save_path, File.READ)
		var opcoes = file.get_var()
		# Configurando os sliders de audio:
		$Slider_geral.value = opcoes.volume_geral
		$Slider_musica.value = opcoes.volume_musica
		$Slider_efeitos_sonoros.value = opcoes.volume_efeitos_sonoros
		# Configurando o dropdown de resoluções:
		dropdown_resolucao.add_item("Tela cheia")
		dropdown_resolucao.add_separator()
		var resoluc_atual = str(opcoes.resolucao.x) + "x" + str(opcoes.resolucao.y)
		for resolucao in lista_resolucoes:
			dropdown_resolucao.add_item(resolucao)
			if resoluc_atual == resolucao:
				dropdown_resolucao.select(get_dropdown_item_by_name(resolucao))
			
	file.close()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		salvar_novas_opcoes_e_fechar()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		salvar_novas_opcoes_e_fechar()


func _on_Slider_geral_value_changed(value):
	AudioServer.set_bus_volume_db(audio_geral, value)
	mutar_no_min(audio_geral, value)

func _on_Slider_musica_value_changed(value):
	AudioServer.set_bus_volume_db(audio_musica, value)
	mutar_no_min(audio_musica, value)

func _on_Slider_efeitos_sonoros_value_changed(value):
	AudioServer.set_bus_volume_db(audio_efeitos_sonoros, value)
	mutar_no_min(audio_efeitos_sonoros, value)

func _on_Dropdown_resolucao_item_selected(id):
	var resolucao_selecionada = dropdown_resolucao.get_item_text(id)
	if resolucao_selecionada == "Tela cheia":
		OS.set_window_fullscreen(true)
	else:
		var tam_tela = resolucao_selecionada.split("x")
		OS.set_window_fullscreen(false)
		OS.set_window_size(Vector2(int(tam_tela[0]), int(tam_tela[1])))

func _on_Btn_fechar_pressed():
	salvar_novas_opcoes_e_fechar()


func get_dropdown_item_by_name(name):
	# Retorna o indice do item dropdown pelo seu nome(texto)
	for i in range(dropdown_resolucao.get_item_count()):
		if dropdown_resolucao.get_item_text(i) == name:
			return i

func mutar_no_min(audio, value):
	# Muta o canal de som caso chegue no valor mínimo.
	if value == min_value:
		AudioServer.set_bus_mute(audio, true)
	else:
		AudioServer.set_bus_mute(audio, false)

func salvar_novas_opcoes_e_fechar():
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_var({
		"volume_geral" : $Slider_geral.value,
		"volume_musica" : $Slider_musica.value,
		"volume_efeitos_sonoros" : $Slider_efeitos_sonoros.value,
		"resolucao" : retorna_dic_resolucao()
	})
	file.close()
	
	queue_free()

func retorna_dic_resolucao():
	var resolucao_atual = dropdown_resolucao.get_item_text(dropdown_resolucao.get_selected_id())
	if resolucao_atual == "Tela cheia":
		return {"tela_cheia" : true, "x" : 0, "y" : 0}
	else:
		resolucao_atual = resolucao_atual.split("x")
		return {"tela_cheia" : false, "x" : int(resolucao_atual[0]), "y" : int(resolucao_atual[1])}
	
