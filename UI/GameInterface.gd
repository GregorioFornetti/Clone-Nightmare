extends CanvasLayer

onready var Btn_centralizar = $Control/Btn_centralizar
onready var Btn_portal = $Control/Btn_portal

func atualizar_label_inimigo(quant_atual_inimigos):
	$Control/LabelInim.text = 'Inimigos vivos: ' + str(quant_atual_inimigos)

func atualizar_label_bullets(quant_atual_bullets):
	$Control/LabelBullets.text = 'Munição restante: ' + str(quant_atual_bullets)


func _on_camera_atualizar_botao_cam():
	Btn_centralizar.pressed = not Btn_centralizar.pressed

func _on_Btn_portal_pressed():
	Btn_portal.pressed = not Btn_portal.pressed
