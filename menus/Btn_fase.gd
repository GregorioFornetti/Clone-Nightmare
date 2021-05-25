extends TextureButton

func desabilitar():
	$Trancar.visible = true
	disabled = true

func _on_Btn_fase_mouse_entered():
	Sist_som.play("Btn_hover")

func _on_Btn_fase_pressed():
	Sist_som.play("Btn_click")
