extends Control

var slot_number


func _on_Btn_sim_pressed():
	get_parent().get_node("SaveSlot" + str(slot_number)).apagar_slot()
	despausar()


func _on_Btn_nao_pressed():
	despausar()


func despausar():
	visible = false
	get_tree().paused = false
