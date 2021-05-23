extends CanvasLayer

onready var Btn_centralizar = $Control/Btn_centralizar
onready var Btn_portal = $Control/Btn_portal
onready var control = $Control

func _ready():
	var multiplicador = pow(0.9, (ComandosGerais.qnt_jogos_abertos - 1))
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	control.rect_scale = Vector2(multiplicador, multiplicador)
	control.rect_position = Vector2(width * (1 - multiplicador) / 2, height * (1 - multiplicador) / 2)

func atualizar_label_inimigo(quant_atual_inimigos):
	$Control/LabelInim.text = 'Inimigos vivos: ' + str(quant_atual_inimigos)

func atualizar_label_bullets(quant_atual_bullets):
	$Control/LabelBullets.text = 'Munição restante: ' + str(quant_atual_bullets)

func atualizar_label_tempo(segundos):
	$Control/LabelTempo.text = "Tempo:  " + ComandosGerais.formatar_tempo(segundos)

func _on_camera_atualizar_botao_cam():
	Btn_centralizar.pressed = not Btn_centralizar.pressed

func _on_Btn_portal_pressed():
	Btn_portal.pressed = not Btn_portal.pressed
