extends Control

@onready var campoDeEntrada = $main/VBoxContainer/HBoxContainer2/VBoxContainer/LineEdit
@onready var campo1View = $main/VBoxContainer/HBoxContainer/Campo1
@onready var campo2View = $main/VBoxContainer/HBoxContainer/Campo2
@onready var OperacaoView = $main/VBoxContainer/HBoxContainer/Operacao
@onready var counter = $head/MarginContainer/AspectRatioContainer/MarginContainer/counter
@onready var timer = $head/MarginContainer/AspectRatioContainer2/timer
@onready var timerNum = $head/MarginContainer/AspectRatioContainer2/timerNumber
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


var startTimer;
func _process(delta: float) -> void:
	calcularAcerto()
	if startTimer:
		var tempo_total = Time.get_ticks_msec() / 1000.0 - temp_inicio_sessao 
		timer.text = "%.2f" % tempo_total
		
		
		var tempo_numero = Time.get_ticks_msec() / 1000.0 - temp_inicio
		timerNum.text = "%.2f" % tempo_numero
	
var temp_inicio = 0.0
var temp_inicio_sessao = 0.0
func start():
	main.visible = false
	intro.play("intro")
	campoDeEntrada.grab_focus()
	cacularResultadoEsperado()
	await get_tree().create_timer(3.1).timeout
	counter.text = str(contador) + "/" + str(quantidade)
	main.visible = true
	startTimer = true
	temp_inicio_sessao = Time.get_ticks_msec() / 1000.0
	temp_inicio = Time.get_ticks_msec() / 1000.0
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
var tempos = []
func cacularResultadoEsperado():
	temp_inicio = Time.get_ticks_msec() / 1000.0
	
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

var respondendo = false
func calcularAcerto():
	var entradaUsuario = campoDeEntrada.text
	
	if entradaUsuario.is_valid_int():
		
		if respondendo:
			return
		
		var numeroUsuario = entradaUsuario.to_int()
		if numeroUsuario == resultado and contador !=  quantidade:
			respondendo = true
			
			#tempo 
			var tempo_gasto = Time.get_ticks_msec() / 1000.0 - temp_inicio
			tempos.append(tempo_gasto)
			print("%.2f" % tempo_gasto)
			
			numberintro.play("correctNumber")
			correctAudio.play()
			print("correto")
			timerCounter()
			print(contador)
			campoDeEntrada.clear()
			cacularResultadoEsperado()
			respondendo = false
			
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
		
func timerCounter():
	contador += 1
	counter.text = str(contador) + "/" + str(quantidade)
