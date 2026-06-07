extends Control

@onready var campoDeEntrada = $LineEdit
@onready var campo1View = $Campo1
@onready var campo2View = $Campo2
@onready var OperacaoView = $Operacao
@onready var audioTecla = $key
@onready var correctAudio = $correct

func _ready() -> void:
	campoDeEntrada.grab_focus()
	cacularResultadoEsperado()
	pass
	
func _process(delta: float) -> void:
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
var contador
func cacularResultadoEsperado():
	var numeroMax1 = retornarQuantidadeCasaMax(Dados.campo1ID)
	var numeroMax2 = retornarQuantidadeCasaMax(Dados.campo2ID)
	var numeroMin1 = retornarQuantidadeCasaMin(Dados.campo1ID)
	var numeroMin2 = retornarQuantidadeCasaMin(Dados.campo2ID)
	
	var numero1 = randi_range(numeroMin1, numeroMax1)
	var numero2 = randi_range(numeroMin2, numeroMax2)
	
	atualizarVisual(numero1, numero2)
	
	if (Dados.operacaoID == 0):
		resultado = numero1 + numero2
		
	if (Dados.operacaoID == 1):
		resultado = numero1 - numero2
	
	if (Dados.operacaoID == 2):
		resultado = numero1 * numero2
		
func calcularAcerto():
	var entradaUsuario = campoDeEntrada.text
	
	if entradaUsuario.is_valid_int():
		var numeroUsuario = entradaUsuario.to_int()
		
		if numeroUsuario == resultado and contador != 10:
			print("Acertou!")
			correctAudio.play()
			campoDeEntrada.clear()
			cacularResultadoEsperado()
		
		
		campoDeEntrada.grab_focus()
		
func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		tocarSomTecla()

func tocarSomTecla():
	audioTecla.pitch_scale = randf_range(0.9, 1.3)
	audioTecla.play()

func atualizarVisual(numero1, numero2):
	campo1View.text = str(numero1)
	campo2View.text = str(numero2)
	
	if (Dados.operacaoID == 0):
		OperacaoView.text = "+"
	
	if (Dados.operacaoID == 1):
		OperacaoView.text = "-"
		
	if (Dados.operacaoID == 2):
		OperacaoView.text = "*"
		
