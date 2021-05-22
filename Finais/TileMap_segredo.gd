extends TileMap

export (int) var nivel_loop_visivel

func _ready():
	if ComandosGerais.qnt_jogos_abertos != nivel_loop_visivel:
		visible = false
