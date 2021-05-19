extends Area2D

onready var pc = get_parent().get_node("CanvasLayer/Computador")
onready var label_pc = get_parent().get_node("CanvasLayer/Label_computador")
onready var main_node = get_parent()
var pc_no_range = false

func _input(event):
	if event.get_action_strength("ui_accept") and pc_no_range and not main_node.final_iniciado:
		label_pc.visible = false
		pc.visible = true
		get_tree().paused = true

func _on_Range_pc_body_entered(_body):
	pc_no_range = true

func _on_Range_pc_body_exited(_body):
	pc_no_range = false
