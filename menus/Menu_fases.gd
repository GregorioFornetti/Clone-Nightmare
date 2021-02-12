extends Control

onready var Botao_fase = preload('res://menus/Botao_fase.tscn')


func _ready():
	# Criar os 20 botoes de fases.
	var y = 150
	for i in range(4):
		var x = 275
		for j in range(1, 6):
			var botao = Botao_fase.instance()
			var fase_atual = i * 5 + j
			botao.text = 'Fase ' + str(fase_atual)
			botao.rect_position = Vector2(x, y)
			botao.connect('pressed', self, '_on_Botao_fase_pressionado', [fase_atual])
			
			if SaveStats.ultima_fase_liberada < fase_atual:
				botao.disabled = true
			add_child(botao)
			
			x += 100
		y += 50
			

func _on_Botao_fase_pressionado(fase):
	print(fase)
	get_tree().change_scene("res://Fases/fase" + str(fase) + ".tscn")


func _on_Voltar_pressed():
	get_tree().change_scene("res://menus/Menu_saves.tscn")
