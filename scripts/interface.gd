extends Control

@onready var campoDeEntrada = $LineEdit

func _ready() -> void:
	cacularResultadoEsperado()
	pass
	
func _process(delta: float) -> void:
	#enterPressionado()
	calcularAcerto()

	
func enterPressionado():
	if Input.is_action_just_pressed("enter"):
		calcularAcerto()


func retornarQuantidadeCasaMax(value):
	if value == 1:
		return 9
		
	if value == 2:
		return 99
		
	if value == 3: 
		return 999
		
func retornarQuantidadeCasaMin(value):
	if value == 1:
		return 1
		
	if value == 2:
		return 10
		
	if value == 3: 
		return 100
	
var resultado
func cacularResultadoEsperado():
	var numeroMax1 = retornarQuantidadeCasaMax(Dados.campo1ID)
	var numeroMax2 = retornarQuantidadeCasaMax(Dados.campo2ID)
	var numeroMin1 = retornarQuantidadeCasaMin(Dados.campo1ID)
	var numeroMin2 = retornarQuantidadeCasaMin(Dados.campo2ID)
	
	var numero1 = randi_range(numeroMin1, numeroMax1)
	var numero2 = randi_range(numeroMin2, numeroMax2)
	
	if (Dados.operacaoID == 0):
		resultado = numero1 + numero2
		
	print(numero1, "+", numero2, "=", resultado)

func calcularAcerto():
	var entradaUsuario = campoDeEntrada.text
	
	if entradaUsuario.is_valid_int():
		var numeroUsuario = entradaUsuario.to_int()
		
		if numeroUsuario == resultado:
			print("Acertou!")
			campoDeEntrada.clear()
			cacularResultadoEsperado()
		
		campoDeEntrada.grab_focus()
