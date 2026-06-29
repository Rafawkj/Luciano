# audio_ambiente.gd
# ----------------------------------------------------------------------------
# Som ambiente GERADO POR CÓDIGO (sem precisar de arquivos de áudio):
#   - Vento contínuo (ruído grave e suave, em loop).
#   - Um sino distante que toca de tempos em tempos.
#   - Um piano solitário no salão de baile do castelo (áudio 3D: só se ouve
#     quando você está por perto).
#
# Como funciona: a gente preenche um vetor de amostras (-1 a 1), converte para
# PCM 16 bits e monta um AudioStreamWAV. Para usar sons REAIS no futuro, basta
# atribuir um arquivo .ogg/.wav ao .stream de cada player e apagar a geração.
# ----------------------------------------------------------------------------

extends Node

const SR := 22050  # taxa de amostragem (amostras por segundo)

# Intervalos (em semitons) de uma escala menor — dão o tom melancólico ao piano.
const SEMITONS := [0, 3, 5, 7, 10, 12]

var player_vento: AudioStreamPlayer
var player_sino: AudioStreamPlayer
var player_piano: AudioStreamPlayer3D


func _ready() -> void:
	_criar_vento()
	_criar_sino()
	_criar_piano()


# ============================================================================
# VENTO (contínuo, em loop)
# ============================================================================

func _criar_vento() -> void:
	player_vento = AudioStreamPlayer.new()
	player_vento.stream = _wav(_gerar_vento(), true)
	player_vento.volume_db = -16.0
	add_child(player_vento)
	player_vento.play()


func _gerar_vento() -> PackedFloat32Array:
	var n := int(SR * 4.0)
	var a := PackedFloat32Array()
	a.resize(n)
	var p1 := 0.0
	var p2 := 0.0
	for i in n:
		var branco := randf() * 2.0 - 1.0
		# Dois filtros passa-baixa em sequência: deixa o ruído grave (vento).
		p1 = lerpf(p1, branco, 0.04)
		p2 = lerpf(p2, p1, 0.08)
		a[i] = p2 * 0.7
	return a


# ============================================================================
# SINO DISTANTE (toca a cada 25-55 s)
# ============================================================================

func _criar_sino() -> void:
	player_sino = AudioStreamPlayer.new()
	player_sino.stream = _wav(_gerar_sino(), false)
	player_sino.volume_db = -9.0
	add_child(player_sino)

	var t := Timer.new()
	t.wait_time = randf_range(25.0, 45.0)
	t.timeout.connect(_tocar_sino.bind(t))
	add_child(t)
	t.start()


func _tocar_sino(t: Timer) -> void:
	player_sino.play()
	t.wait_time = randf_range(30.0, 55.0)  # próximo toque


func _gerar_sino() -> PackedFloat32Array:
	var n := int(SR * 3.2)
	var a := PackedFloat32Array()
	a.resize(n)
	var f := 246.94  # nota Si grave
	# Parciais "inarmônicos" + decaimento exponencial = timbre de sino.
	var parciais := [1.0, 2.0, 2.76, 5.4]
	var amps := [1.0, 0.55, 0.35, 0.15]
	for i in n:
		var t := float(i) / SR
		var env := exp(-t * 1.7)
		var s := 0.0
		for k in parciais.size():
			s += amps[k] * sin(TAU * f * parciais[k] * t)
		a[i] = s * env * 0.16
	return a


# ============================================================================
# PIANO NO SALÃO DE BAILE (áudio 3D, posicional)
# ============================================================================

func _criar_piano() -> void:
	player_piano = AudioStreamPlayer3D.new()
	player_piano.stream = _wav(_gerar_piano(), false)
	player_piano.volume_db = -2.0
	player_piano.max_distance = 45.0
	player_piano.unit_size = 12.0
	player_piano.position = Vector3(0, 3, -46)  # dentro do salão do castelo
	add_child(player_piano)

	var t := Timer.new()
	t.wait_time = randf_range(5.0, 11.0)
	t.timeout.connect(_tocar_piano.bind(t))
	add_child(t)
	t.start()


func _tocar_piano(t: Timer) -> void:
	# Escolhe uma nota da escala menor mudando a altura (pitch) da amostra.
	var semis: int = SEMITONS[randi() % SEMITONS.size()]
	player_piano.pitch_scale = pow(2.0, float(semis) / 12.0)
	player_piano.play()
	t.wait_time = randf_range(4.0, 10.0)


func _gerar_piano() -> PackedFloat32Array:
	var n := int(SR * 1.8)
	var a := PackedFloat32Array()
	a.resize(n)
	var f := 261.63  # Dó central
	for i in n:
		var t := float(i) / SR
		var ataque := clampf(t / 0.01, 0.0, 1.0)       # ataque rápido
		var env := ataque * exp(-t * 2.3)              # decaimento suave
		var s := sin(TAU * f * t) + 0.4 * sin(TAU * f * 2.0 * t) + 0.2 * sin(TAU * f * 3.0 * t)
		a[i] = s * env * 0.15
	return a


# ============================================================================
# AJUDANTE: converte amostras (-1..1) em um AudioStreamWAV (PCM 16 bits)
# ============================================================================

func _wav(amostras: PackedFloat32Array, loop: bool) -> AudioStreamWAV:
	var n := amostras.size()
	var bytes := PackedByteArray()
	bytes.resize(n * 2)
	for i in n:
		var v := int(clampf(amostras[i], -1.0, 1.0) * 32767.0)
		bytes.encode_s16(i * 2, v)

	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = SR
	wav.stereo = false
	wav.data = bytes
	if loop:
		wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
		wav.loop_begin = 0
		wav.loop_end = n
	return wav
