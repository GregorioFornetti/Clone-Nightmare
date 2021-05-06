extends Node

var lista_sons
const VOL_MAX = 0
const VOL_MEDIO = -30
const VOL_MIN = -60

func _ready():
	var save_path = "user://opcoes.dat"
	var file = File.new()
	var audio_geral = AudioServer.get_bus_index("Master")
	var audio_musica = AudioServer.get_bus_index("Musica")
	var audio_efeitos_sonoros = AudioServer.get_bus_index("Efeitos sonoros")
	
	if file.file_exists(save_path):
		file.open(save_path, File.READ)
		var opcoes = file.get_var()
		definir_vol_audio(audio_geral, opcoes.volume_geral)
		definir_vol_audio(audio_musica, opcoes.volume_musica)
		definir_vol_audio(audio_efeitos_sonoros, opcoes.volume_efeitos_sonoros)
	else:
		file.open(save_path, File.WRITE)
		file.store_var({
			"volume_geral" : VOL_MAX,
			"volume_musica" : VOL_MEDIO,
			"volume_efeitos_sonoros" : VOL_MEDIO
		})
		AudioServer.set_bus_volume_db(audio_geral, VOL_MAX)
		AudioServer.set_bus_volume_db(audio_musica, VOL_MEDIO)
		AudioServer.set_bus_volume_db(audio_efeitos_sonoros, VOL_MEDIO)
	file.close()
	
	play("Musica_menu")

func definir_vol_audio(audio, value):
	if value == VOL_MIN:
		AudioServer.set_bus_mute(audio, true)
	else:
		AudioServer.set_bus_volume_db(audio, value)

func play(nome_som):
	if has_node(nome_som):
		lista_sons = get_node(nome_som).get_children()
		lista_sons.shuffle()
		lista_sons[0].play()

func stop(nome_som):
	if has_node(nome_som):
		get_node(nome_som).get_child(0).stop()

func comecar_musica_fase(fase_atual):
	Sist_som.play("Musica_fases_1-5")
	#if fase_atual <= 5:
	#	Sist_som.play("Musica_fases_1-5")
	#elif fase_atual <= 10:
	#	Sist_som.play("Musica_fases_6-10")
	#elif fase_atual <= 15:
	#	Sist_som.play("Musica_fases_11-15")
	#else:
	#	Sist_som.play("Musica_fases_16-20")

func parar_musicas_fase():
	stop("Musica_fases_1-5")
	stop("Musica_fases_6-10")
	stop("Musica_fases_11-15")
	stop("Musica_fases_16-20")

func parar_sons_cutscene():
	stop("Musica_cutscene")
	stop("Dialogo_normal")
	stop("Dialogo_raiva")
