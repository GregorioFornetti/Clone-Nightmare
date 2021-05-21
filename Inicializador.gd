extends Node

# Node para criar arquivos iniciais, controlar comandos que devem funcionar em todo jogo e
# aplicar as configurações iniciais do jogo
# Ex: comando F11 deve colocar a tela cheia a qualquer momento

func _ready():
	var VOL_MAX = 0
	var VOL_MEDIO = -30
	var save_path = "user://opcoes.dat"
	var file = File.new()
	var audio_geral = AudioServer.get_bus_index("Master")
	var audio_musica = AudioServer.get_bus_index("Musica")
	var audio_efeitos_sonoros = AudioServer.get_bus_index("Efeitos sonoros")
	var diretorio = Directory.new()
	
	if file.file_exists(save_path):
		file.open(save_path, File.READ)
		var opcoes = file.get_var()
		# Aplicar configurações de volume:
		aplicar_vol_audio(audio_geral, opcoes.volume_geral)
		aplicar_vol_audio(audio_musica, opcoes.volume_musica)
		aplicar_vol_audio(audio_efeitos_sonoros, opcoes.volume_efeitos_sonoros)
		# Aplicar configurações de resolução:
		aplicar_resolucao(opcoes.resolucao)
	else:
		file.open(save_path, File.WRITE)
		file.store_var({
			"volume_geral" : VOL_MAX,
			"volume_musica" : VOL_MEDIO,
			"volume_efeitos_sonoros" : VOL_MEDIO,
			"resolucao" : {"tela_cheia" : false, "x" : 1024, "y" : 608}
		})
		# Aplicar configurações padrões de volume:
		AudioServer.set_bus_volume_db(audio_geral, VOL_MAX)
		AudioServer.set_bus_volume_db(audio_musica, VOL_MEDIO)
		AudioServer.set_bus_volume_db(audio_efeitos_sonoros, VOL_MEDIO)
	
	file.close()

func _input(event):
	if event.is_action_pressed("tela_cheia"):
		OS.set_window_fullscreen(not OS.window_fullscreen)

func apagar_arquivo(slot_number, path):
	var dir = Directory.new()
	#teste = dir.remove(str(slot_number) + ".dat")
	var teste = dir.remove(path)
	print(teste)

func aplicar_vol_audio(audio, value):
	var VOL_MIN = -60
	if value == VOL_MIN:
		AudioServer.set_bus_mute(audio, true)
	else:
		AudioServer.set_bus_volume_db(audio, value)

func aplicar_resolucao(resolucao):
	if not resolucao.tela_cheia:
		OS.set_window_size(Vector2(resolucao.x, resolucao.y))
	else:
		OS.set_window_fullscreen(true)