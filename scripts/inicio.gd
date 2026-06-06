extends Control

@onready var campo1 = $Casa1
@onready var campo2 = $Casa2


func _on_button_button_down() -> void:
	Dados.campo1ID = campo1.get_selected_id()
	Dados.campo2ID = campo2.get_selected_id()
	get_tree().change_scene_to_file("res://objetos/Jogo.tscn")
	pass 
