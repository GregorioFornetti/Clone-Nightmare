extends Node2D

onready var Portal1 = $Portal1
onready var Portal2 = $Portal2
onready var Linha_interligacao = $Linha_interligacao
onready var GameInterface = get_parent().get_node("GameInterface")
# Listas com os player/inimigos/munições que acabaram de entrar em um portal e ainda não sairam de dentro do outro portal
var lista_corpos_portal1 = []
var lista_corpos_portal2 = []

signal atualizar_btn_portal()

func _ready():
	# Interligar os portais
	Linha_interligacao.points[0] = Portal1.position
	Linha_interligacao.points[1] = Portal2.position
	# Conectando sinais
	GameInterface.Btn_portal.connect("pressed", self, "_on_Botao_portal_pressed")

func _process(_delta):
	limpar_lista(lista_corpos_portal1)
	limpar_lista(lista_corpos_portal2)
	update()

func _draw():
	if lista_corpos_portal1:
		draw_circle_arc(Portal2.position, $Portal1/Portal1_exit/CollisionShape2D.shape.radius, 0, 360, ColorN("Red"))
	if lista_corpos_portal2:
		draw_circle_arc(Portal1.position, $Portal2/Portal2_exit/CollisionShape2D.shape.radius, 0, 360, ColorN("Red"))

func _input(event):
	if event.get_action_strength("linhas_portais"):
		emit_signal("atualizar_btn_portal")
		trocar_visibilidade_linhas()


func _on_Portal1_enter_body_entered(body):
	# Corpo acabou de entrar no portal1. Teleportar para portal2 se esse corpo não tiver acabado de entrar no portal2.
	if not body in lista_corpos_portal2:
		Sist_som.play("Portal")
		body.global_position = Portal2.global_position
		lista_corpos_portal1.append(body)

func _on_Portal1_exit_body_exited(body):
	# Corpo saiu do portal1, se ele estava no portal2 antes, agora ele poderá usar esse portal.
	if body in lista_corpos_portal2:
		lista_corpos_portal2.erase(body)

func _on_Portal2_enter_body_entered(body):
	if not body in lista_corpos_portal1:
		Sist_som.play("Portal")
		body.global_position = Portal1.global_position
		lista_corpos_portal2.append(body)

func _on_Portal2_exit_body_exited(body):
	if body in lista_corpos_portal1:
		lista_corpos_portal1.erase(body)


func _on_Botao_portal_pressed():
	trocar_visibilidade_linhas()

func trocar_visibilidade_linhas():
	Linha_interligacao.visible = not Linha_interligacao.visible


func draw_circle_arc(center, radius, angle_from, angle_to, color):
	# Função da documentação: https://docs.godotengine.org/en/stable/tutorials/2d/custom_drawing_in_2d.html
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, 2.0)

func limpar_lista(lista_corpos_portal):
	# Remove inimigos/balas que já acabaram das listas.
	for corpo in lista_corpos_portal:
		if not is_instance_valid(corpo):
			lista_corpos_portal.erase(corpo)


