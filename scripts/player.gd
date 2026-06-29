# player.gd
# ----------------------------------------------------------------------------
# Script do PERSONAGEM PRINCIPAL: um vampiro ágil que pode virar morcego.
#
# A movimentação foi pensada para PARKOUR fluido (pular entre telhados):
#   - Aceleração/atrito suaves (nada de parar/arrancar "seco").
#   - Pulo duplo, wall slide (deslizar na parede) e wall jump (pulo de parede).
#   - Coyote time (pular um instante depois de sair da borda) e
#     jump buffer (registrar o pulo um instante antes de aterrissar).
#   - Pulo variável (segura = mais alto; solta = mais baixo).
#   - Gravidade assimétrica (cai mais rápido do que sobe — sensação melhor).
#   - "FOV kick": o campo de visão abre um pouco em alta velocidade.
#
# Na forma de morcego, voa por tempo limitado (recarrega ao tocar o chão).
# ----------------------------------------------------------------------------

extends CharacterBody3D


# ============================================================================
# CONFIGURAÇÕES (ajuste à vontade para mudar a "sensação")
# ============================================================================

# --- Movimento no chão / ar (forma vampiro) ---
const VELOCIDADE_ANDAR := 5.0
const VELOCIDADE_CORRER := 9.5
const ACEL_CHAO := 60.0      # quão rápido atinge a velocidade desejada no chão
const ATRITO_CHAO := 75.0    # quão rápido freia ao soltar as teclas
const ACEL_AR := 28.0        # controle no ar (importante para o parkour)

# --- Pulo ---
const FORCA_PULO := 9.0
const FORCA_PULO_DUPLO := 8.0
const GRAV_SUBINDO := 18.0   # gravidade enquanto sobe
const GRAV_CAINDO := 26.0    # gravidade ao cair (maior = queda mais "gostosa")
const CORTE_PULO := 0.45     # ao soltar o botão subindo, corta a subida
const TEMPO_COIOTE := 0.12   # janela para pular após sair de uma borda
const BUFFER_PULO := 0.12    # janela para "guardar" o pulo antes de aterrissar

# --- Parede (deslizar e pular da parede) ---
const FATOR_DESLIZE_PAREDE := 0.35  # (referência) o quanto a parede segura a queda
const VEL_MAX_DESLIZE := 4.0        # velocidade máxima de queda ao deslizar
const FORCA_PULO_PAREDE := 9.0      # parte vertical do pulo de parede
const IMPULSO_PAREDE := 8.0         # empurrão para LONGE da parede
const LOCKOUT_PAREDE := 0.12        # breve trava de controle após o wall jump

# --- Voo (forma morcego) ---
const VELOCIDADE_VOO := 12.0
const ACEL_VOO := 30.0
const VELOCIDADE_SUBIDA := 7.0
const TEMPO_MAXIMO_VOO := 5.0
const QUEDA_PLANANDO := 0.25

# --- Câmera ---
const SENSIBILIDADE_MOUSE := 0.0028
const FOV_BASE := 75.0
const FOV_VELOCIDADE := 90.0  # abertura da câmera em alta velocidade


# ============================================================================
# ESTADO INTERNO
# ============================================================================

enum Forma { VAMPIRO, MORCEGO }
var forma_atual: int = Forma.VAMPIRO
var tempo_voo_restante: float = TEMPO_MAXIMO_VOO

# Temporizadores e flags do parkour.
var coiote: float = 0.0          # tempo restante de "coyote time"
var buffer: float = 0.0          # tempo restante do pulo "guardado"
var lockout: float = 0.0         # trava de controle horizontal (após wall jump)
var pulo_duplo_ok: bool = true   # ainda tem o segundo pulo disponível?


# ============================================================================
# REFERÊNCIAS A OUTROS NÓS
# ============================================================================

@onready var pivo_camera: Node3D = $PivoCamera
@onready var camera: Camera3D = $PivoCamera/Camera3D
@onready var modelo_vampiro: Node3D = $ModeloVampiro
@onready var modelo_morcego: Node3D = $ModeloMorcego


# ============================================================================
# FUNÇÕES DO GODOT
# ============================================================================

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.fov = FOV_BASE
	_atualizar_visual()


func _unhandled_input(event: InputEvent) -> void:
	# Girar a câmera com o mouse.
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSIBILIDADE_MOUSE)
		pivo_camera.rotate_x(-event.relative.y * SENSIBILIDADE_MOUSE)
		pivo_camera.rotation.x = clamp(pivo_camera.rotation.x, deg_to_rad(-65), deg_to_rad(40))

	# ESC: solta/prende o mouse (útil para testar).
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# T: transformar.
	if event.is_action_pressed("transformar"):
		_alternar_forma()


func _physics_process(delta: float) -> void:
	if forma_atual == Forma.VAMPIRO:
		_mover_como_vampiro(delta)
	else:
		_mover_como_morcego(delta)

	move_and_slide()

	# Recarrega o voo ao tocar o chão.
	if is_on_floor():
		tempo_voo_restante = TEMPO_MAXIMO_VOO

	_atualizar_fov(delta)


# ============================================================================
# MOVIMENTO: FORMA VAMPIRO (parkour)
# ============================================================================

func _mover_como_vampiro(delta: float) -> void:
	var no_chao := is_on_floor()
	var na_parede := is_on_wall_only()  # encostando na parede e NÃO no chão

	# --- Atualiza os temporizadores ---
	if no_chao:
		coiote = TEMPO_COIOTE
		pulo_duplo_ok = true
	else:
		coiote = maxf(coiote - delta, 0.0)

	if Input.is_action_just_pressed("pular"):
		buffer = BUFFER_PULO
	else:
		buffer = maxf(buffer - delta, 0.0)

	lockout = maxf(lockout - delta, 0.0)

	# --- Direção desejada (relativa a para onde o personagem olha) ---
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	var direcao := (transform.basis * Vector3(entrada.x, 0.0, entrada.y)).normalized()
	var correndo := Input.is_action_pressed("correr")
	var velocidade_alvo := VELOCIDADE_CORRER if correndo else VELOCIDADE_ANDAR

	# --- Gravidade (assimétrica) + deslizar na parede ---
	var deslizando := na_parede and not no_chao and velocity.y < 0.0 and direcao != Vector3.ZERO
	if not no_chao:
		var g := GRAV_SUBINDO if velocity.y > 0.0 else GRAV_CAINDO
		velocity.y -= g * delta
		if deslizando:
			# Segura a queda: desliza devagar pela parede.
			velocity.y = maxf(velocity.y, -VEL_MAX_DESLIZE)

	# --- Movimento horizontal com aceleração/atrito ---
	# (Pulado logo após um wall jump, para o impulso "viajar".)
	if lockout == 0.0:
		var alvo := direcao * velocidade_alvo
		var taxa: float
		if direcao != Vector3.ZERO:
			taxa = ACEL_CHAO if no_chao else ACEL_AR
		else:
			taxa = ATRITO_CHAO if no_chao else ACEL_AR
		velocity.x = move_toward(velocity.x, alvo.x, taxa * delta)
		velocity.z = move_toward(velocity.z, alvo.z, taxa * delta)

	# --- Pulos (usando o pulo guardado no buffer) ---
	if buffer > 0.0:
		if coiote > 0.0:
			# Pulo normal (no chão ou logo após sair da borda).
			velocity.y = FORCA_PULO
			buffer = 0.0
			coiote = 0.0
		elif na_parede:
			# Wall jump: empurra para longe da parede e para cima.
			var normal := get_wall_normal()
			velocity.x = normal.x * IMPULSO_PAREDE
			velocity.z = normal.z * IMPULSO_PAREDE
			velocity.y = FORCA_PULO_PAREDE
			buffer = 0.0
			lockout = LOCKOUT_PAREDE
			pulo_duplo_ok = true  # ganha o pulo duplo de volta após wall jump
		elif pulo_duplo_ok:
			# Pulo duplo no ar.
			velocity.y = FORCA_PULO_DUPLO
			pulo_duplo_ok = false
			buffer = 0.0

	# --- Pulo variável: soltar o botão subindo encurta o pulo ---
	if Input.is_action_just_released("pular") and velocity.y > 0.0:
		velocity.y *= CORTE_PULO


# ============================================================================
# MOVIMENTO: FORMA MORCEGO (voo fluido por tempo limitado)
# ============================================================================

func _mover_como_morcego(delta: float) -> void:
	# Movimento horizontal com aceleração (vira/acelera de forma suave).
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	var direcao := (transform.basis * Vector3(entrada.x, 0.0, entrada.y)).normalized()
	var alvo := direcao * VELOCIDADE_VOO
	velocity.x = move_toward(velocity.x, alvo.x, ACEL_VOO * delta)
	velocity.z = move_toward(velocity.z, alvo.z, ACEL_VOO * delta)

	# Segurar "pular" sobe enquanto houver tempo de voo; senão plana.
	var batendo_asas := Input.is_action_pressed("pular") and tempo_voo_restante > 0.0
	if batendo_asas:
		velocity.y = move_toward(velocity.y, VELOCIDADE_SUBIDA, ACEL_VOO * delta)
		tempo_voo_restante -= delta
	else:
		velocity.y -= (GRAV_CAINDO * QUEDA_PLANANDO) * delta


# ============================================================================
# CÂMERA: abrir o FOV em alta velocidade (sensação de velocidade)
# ============================================================================

func _atualizar_fov(delta: float) -> void:
	var vel_horizontal := Vector2(velocity.x, velocity.z).length()
	var t := clampf(vel_horizontal / VELOCIDADE_CORRER, 0.0, 1.3)
	var alvo := lerpf(FOV_BASE, FOV_VELOCIDADE, t)
	camera.fov = lerpf(camera.fov, alvo, delta * 6.0)


# ============================================================================
# TRANSFORMAÇÃO
# ============================================================================

func _alternar_forma() -> void:
	if forma_atual == Forma.VAMPIRO:
		forma_atual = Forma.MORCEGO
	else:
		forma_atual = Forma.VAMPIRO
		# Ao voltar a vampiro no ar, deixa o pulo duplo disponível.
		pulo_duplo_ok = true
	_atualizar_visual()


func _atualizar_visual() -> void:
	modelo_vampiro.visible = (forma_atual == Forma.VAMPIRO)
	modelo_morcego.visible = (forma_atual == Forma.MORCEGO)
