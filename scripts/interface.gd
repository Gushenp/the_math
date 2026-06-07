extends Control

@onready var campoDeEntrada = $main/VBoxContainer/HBoxContainer2/VBoxContainer/LineEdit
@onready var campo1View = $main/VBoxContainer/HBoxContainer/Campo1
@onready var campo2View = $main/VBoxContainer/HBoxContainer/Campo2
@onready var OperacaoView = $main/VBoxContainer/HBoxContainer/Operacao
@onready var quantidade = Dados.quantidade
@onready var main = $main
@onready var numberintro = $numberAnimation
@onready var intro = $AnimacaoContagem/AnimationPlayer
@onready var audioTecla = $key
@onready var correctAudio = $correct

var IDCampo1 = Dados.campo1ID
var IDcampo2 = Dados.campo2ID
var IDoperacao = Dados.operacaoID
func _ready() -> void:
	start()

	pass
	
func _process(delta: float) -> void:
	calcularAcerto()
	
func start():
	main.visible = false
	intro.play("intro")
	campoDeEntrada.grab_focus()
	cacularResultadoEsperado()
	await get_tree().create_timer(3.1).timeout
	main.visible = true
	numberintro.play("introNumber")

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
var contador = 0
func cacularResultadoEsperado():
	var numeroMax1 = retornarQuantidadeCasaMax(IDCampo1)
	var numeroMax2 = retornarQuantidadeCasaMax(IDcampo2)
	var numeroMin1 = retornarQuantidadeCasaMin(IDCampo1)
	var numeroMin2 = retornarQuantidadeCasaMin(IDcampo2)
	
	var numero1 = randi_range(numeroMin1, numeroMax1)
	var numero2 = randi_range(numeroMin2, numeroMax2)
	
	atualizarVisual(numero1, numero2)
	
	if (IDoperacao == 0):
		resultado = numero1 + numero2
		
	if (IDoperacao == 1):
		resultado = numero1 - numero2
	
	if (IDoperacao == 2):
		resultado = numero1 * numero2

func calcularAcerto():
	var entradaUsuario = campoDeEntrada.text
	
	if entradaUsuario.is_valid_int():
		var numeroUsuario = entradaUsuario.to_int()
		if numeroUsuario == resultado and contador !=  quantidade:
			numberintro.play("correctNumber")
			correctAudio.play()
			await get_tree().create_timer(0.2).timeout
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
	numberintro.play("introNumber")
	numberintro.play("resetNumberColor")
	campo1View.text = str(numero1)
	campo2View.text = str(numero2)
	
	if (IDoperacao == 0):
		OperacaoView.text = "+"
	
	if (IDoperacao == 1):
		OperacaoView.text = "-"
		
	if (IDoperacao == 2):
		OperacaoView.text = "*"
