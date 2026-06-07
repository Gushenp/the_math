extends Control

@onready var campo1 = $Casa1
@onready var campo2 = $Casa2
@onready var operacao = $Operacao
@onready var quantidade = 0
@onready var counter = $AspectRatioContainer/counter


func _on_button_button_down() -> void:
	Dados.campo1ID = campo1.get_selected_id()
	Dados.campo2ID = campo2.get_selected_id()
	Dados.operacaoID = operacao.get_selected_id()
	get_tree().change_scene_to_file("res://objetos/Jogo.tscn")
	pass 


func _on_button_menos_pressed() -> void:
	quantidade -= 1
	counter.text = str(quantidade)
	pass


func _on_button_mais_pressed() -> void:
	quantidade += 1
	counter.text = str(quantidade)
	pass 
