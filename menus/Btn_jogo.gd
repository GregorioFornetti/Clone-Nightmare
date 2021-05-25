extends TextureButton



func _on_Btn_jogo_mouse_entered():
	Sist_som.play("Btn_hover")

func _on_Btn_jogo_pressed():
	Sist_som.play("Btn_click")
