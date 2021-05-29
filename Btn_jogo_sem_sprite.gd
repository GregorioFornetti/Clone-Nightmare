extends Button

func _on_Btn__pressed():
	Sist_som.play("Btn_click")

func _on_Btn__mouse_entered():
	Sist_som.play("Btn_hover")
