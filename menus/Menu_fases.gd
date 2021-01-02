extends Control

onready var Botao_fase = preload('res://menus/Botao_fase.tscn')


func _ready():
	# Criar os 20 botoes de fases.
	var current_y = 150
	for i in range(4):
		var current_x = 275
		for j in range(1, 6):
			var botao = Botao_fase.instance()
			botao.text = 'Fase' + str(i * 5 + j)
			botao.rect_position = Vector2(current_x, current_y)
			botao.connect('pressed', self, '_on_Botao_fase_pressionado', [botao.text])
			add_child(botao)
			
			current_x += 100
		current_y += 50
			

func _on_Botao_fase_pressionado(fase):
	print(fase)
