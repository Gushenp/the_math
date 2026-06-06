extends Control

@onready var campoDeEntrada = $LineEdit

func _ready() -> void:
	pass
	
func _on_button_pressed() -> void:
	cacularResultadoEsperado()
			
#func calcularAcerto():
#	var entradaUsuario = campoDeEntrada.text
#	
#	if entradaUsuario.is_valid_int():
#		var numero = entradaUsuario.to_int()

func retornarQuantidadeCasaMax(campo):
	if campo == 1:
		return 9
		
	if campo == 2:
		return 99
		
	if campo == 3: 
		return 999
		
func retornarQuantidadeCasaMin(campo):
	if campo == 1:
		return 1
		
	if campo == 2:
		return 10
		
	if campo == 3: 
		return 100
	
func cacularResultadoEsperado():
	var numeroMax1 = retornarQuantidadeCasaMax(Dados.campo1ID)
	var numeroMax2 = retornarQuantidadeCasaMax(Dados.campo2ID)
	var numeroMin1 = retornarQuantidadeCasaMin(Dados.campo1ID)
	var numeroMin2 = retornarQuantidadeCasaMin(Dados.campo2ID)
	
	var numero1 = randi_range(numeroMin1, numeroMax1)
	var numero2 = randi_range(numeroMin2, numeroMax2)
	
	print(numero1)
	print(numero2)
