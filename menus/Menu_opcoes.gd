extends Control

onready var audio_geral = AudioServer.get_bus_index("Master")
onready var audio_musica = AudioServer.get_bus_index("Musica")
onready var audio_efeitos_sonoros = AudioServer.get_bus_index("Efeitos sonoros")
onready var min_value = $Slider_geral.min_value
onready var save_path = "user://opcoes.dat"


func _ready():
	# Coleta as informações das opções salvas e aplica nos nodes do menu de opções.
	var file = File.new()
	
	if file.file_exists(save_path):
		file.open(save_path, File.READ)
		var opcoes = file.get_var()
		
		$Slider_geral.value = opcoes.volume_geral
		$Slider_musica.value = opcoes.volume_musica
		$Slider_efeitos_sonoros.value = opcoes.volume_efeitos_sonoros
		
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

func _on_Btn_fechar_pressed():
	salvar_novas_opcoes_e_fechar()


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
		"volume_efeitos_sonoros" : $Slider_efeitos_sonoros.value
	})
	file.close()
	
	queue_free()
