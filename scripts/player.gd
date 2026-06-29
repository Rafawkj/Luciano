# player.gd
# ----------------------------------------------------------------------------
# Script do PERSONAGEM PRINCIPAL: um vampiro ágil que pode virar morcego.
#
# Movimentação para PARKOUR fluido (pular entre telhados):
#   - Aceleração/atrito suaves, pulo duplo, wall slide e wall jump.
#   - Coyote time, jump buffer, pulo variável e gravidade assimétrica.
#
# "FEEL & JUICE" (deixar a movimentação gostosa de ver e sentir):
#   - Câmera com SpringArm3D (não atravessa telhados/paredes).
#   - Squash & stretch: o corpo estica ao pular e achata ao aterrissar.
#   - Poeira ao aterrissar e um "flash" de partículas + luz ao transformar.
#   - O modelo vira na direção do movimento; o morcego bate as asas.
#   - "FOV kick": o campo de visão abre um pouco em alta velocidade.
# ----------------------------------------------------------------------------

extends CharacterBody3D


# ============================================================================
# CONFIGURAÇÕES (ajuste à vontade para mudar a "sensação")
# ============================================================================

# --- Movimento no chão / ar (forma vampiro) ---
const VELOCIDADE_ANDAR := 5.0
const VELOCIDADE_CORRER := 9.5
const ACEL_CHAO := 60.0
const ATRITO_CHAO := 75.0
const ACEL_AR := 28.0

# --- Pulo ---
const FORCA_PULO := 9.0
const FORCA_PULO_DUPLO := 8.0
const GRAV_SUBINDO := 18.0
const GRAV_CAINDO := 26.0
const CORTE_PULO := 0.45
const TEMPO_COIOTE := 0.12
const BUFFER_PULO := 0.12

# --- Parede (deslizar e pular da parede) ---
const VEL_MAX_DESLIZE := 4.0
const FORCA_PULO_PAREDE := 9.0
const IMPULSO_PAREDE := 8.0
const LOCKOUT_PAREDE := 0.12

# --- Voo (forma morcego) ---
const VELOCIDADE_VOO := 12.0
const ACEL_VOO := 30.0
const VELOCIDADE_SUBIDA := 7.0
const TEMPO_MAXIMO_VOO := 5.0
const QUEDA_PLANANDO := 0.25

# --- Câmera ---
const SENSIBILIDADE_MOUSE := 0.0028
const FOV_BASE := 75.0
const FOV_VELOCIDADE := 90.0


# ============================================================================
# ESTADO INTERNO
# ============================================================================

enum Forma { VAMPIRO, MORCEGO }
var forma_atual: int = Forma.VAMPIRO
var tempo_voo_restante: float = TEMPO_MAXIMO_VOO

# Parkour
var coiote: float = 0.0
var buffer: float = 0.0
var lockout: float = 0.0
var pulo_duplo_ok: bool = true
var estava_no_chao: bool = false

# Juice (efeitos visuais)
var escala_modelo: Vector3 = Vector3.ONE  # squash & stretch (lerp de volta ao normal)
var tempo_asa: float = 0.0                # contador para bater as asas

# Nós criados por código (partículas e luz do flash)
var poeira: CPUParticles3D
var transform_fx: CPUParticles3D
var luz_flash: OmniLight3D


# ============================================================================
# REFERÊNCIAS A OUTROS NÓS
# ============================================================================

@onready var pivo_camera: Node3D = $PivoCamera
@onready var braco_camera: SpringArm3D = $PivoCamera/SpringArm3D
@onready var camera: Camera3D = $PivoCamera/SpringArm3D/Camera3D
@onready var modelo_vampiro: Node3D = $ModeloVampiro
@onready var modelo_morcego: Node3D = $ModeloMorcego
@onready var asa_esq: Node3D = $ModeloMorcego/PivoAsaEsq
@onready var asa_dir: Node3D = $ModeloMorcego/PivoAsaDir


# ============================================================================
# FUNÇÕES DO GODOT
# ============================================================================

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.fov = FOV_BASE
	# O braço da câmera não deve colidir com o próprio corpo do jogador.
	braco_camera.add_excluded_object(get_rid())
	_criar_efeitos()
	_atualizar_visual()


func _unhandled_input(event: InputEvent) -> void:
	# Girar a câmera com o mouse.
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSIBILIDADE_MOUSE)
		pivo_camera.rotate_x(-event.relative.y * SENSIBILIDADE_MOUSE)
		pivo_camera.rotation.x = clamp(pivo_camera.rotation.x, deg_to_rad(-65), deg_to_rad(40))

	# ESC: solta/prende o mouse.
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# T: transformar.
	if event.is_action_pressed("transformar"):
		_alternar_forma()


func _physics_process(delta: float) -> void:
	# Guarda a velocidade vertical ANTES de mover, para medir o impacto da queda.
	var vel_y_antes := velocity.y

	if forma_atual == Forma.VAMPIRO:
		_mover_como_vampiro(delta)
	else:
		_mover_como_morcego(delta)

	move_and_slide()

	# Detecta a aterrissagem (estava no ar e agora tocou o chão).
	var no_chao := is_on_floor()
	if no_chao and not estava_no_chao and vel_y_antes < -3.0:
		_ao_aterrissar(vel_y_antes)
	estava_no_chao = no_chao

	# Recarrega o voo ao tocar o chão.
	if no_chao:
		tempo_voo_restante = TEMPO_MAXIMO_VOO

	_atualizar_fov(delta)


func _process(delta: float) -> void:
	# --- Squash & stretch: volta suavemente à escala normal ---
	escala_modelo = escala_modelo.lerp(Vector3.ONE, clampf(delta * 12.0, 0.0, 1.0))
	modelo_vampiro.scale = escala_modelo
	modelo_morcego.scale = escala_modelo

	# --- Flash da transformação: a luz some aos poucos ---
	luz_flash.light_energy = move_toward(luz_flash.light_energy, 0.0, delta * 18.0)

	# --- Morcego batendo as asas ---
	if forma_atual == Forma.MORCEGO:
		tempo_asa += delta * 16.0
		var angulo := sin(tempo_asa) * 0.6
		asa_esq.rotation.z = angulo
		asa_dir.rotation.z = -angulo

	# --- O modelo vira para a direção em que está se movendo ---
	_orientar_modelo(delta)


# ============================================================================
# MOVIMENTO: FORMA VAMPIRO (parkour)
# ============================================================================

func _mover_como_vampiro(delta: float) -> void:
	var no_chao := is_on_floor()
	var na_parede := is_on_wall_only()

	# Temporizadores.
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

	# Direção desejada.
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	var direcao := (transform.basis * Vector3(entrada.x, 0.0, entrada.y)).normalized()
	var correndo := Input.is_action_pressed("correr")
	var velocidade_alvo := VELOCIDADE_CORRER if correndo else VELOCIDADE_ANDAR

	# Gravidade assimétrica + deslizar na parede.
	var deslizando := na_parede and not no_chao and velocity.y < 0.0 and direcao != Vector3.ZERO
	if not no_chao:
		var g := GRAV_SUBINDO if velocity.y > 0.0 else GRAV_CAINDO
		velocity.y -= g * delta
		if deslizando:
			velocity.y = maxf(velocity.y, -VEL_MAX_DESLIZE)

	# Movimento horizontal com aceleração/atrito.
	if lockout == 0.0:
		var alvo := direcao * velocidade_alvo
		var taxa: float
		if direcao != Vector3.ZERO:
			taxa = ACEL_CHAO if no_chao else ACEL_AR
		else:
			taxa = ATRITO_CHAO if no_chao else ACEL_AR
		velocity.x = move_toward(velocity.x, alvo.x, taxa * delta)
		velocity.z = move_toward(velocity.z, alvo.z, taxa * delta)

	# Pulos (usando o buffer).
	if buffer > 0.0:
		if coiote > 0.0:
			velocity.y = FORCA_PULO
			buffer = 0.0
			coiote = 0.0
			_esticar_pulo()
		elif na_parede:
			var normal := get_wall_normal()
			velocity.x = normal.x * IMPULSO_PAREDE
			velocity.z = normal.z * IMPULSO_PAREDE
			velocity.y = FORCA_PULO_PAREDE
			buffer = 0.0
			lockout = LOCKOUT_PAREDE
			pulo_duplo_ok = true
			_esticar_pulo()
		elif pulo_duplo_ok:
			velocity.y = FORCA_PULO_DUPLO
			pulo_duplo_ok = false
			buffer = 0.0
			_esticar_pulo()

	# Pulo variável: soltar o botão subindo encurta o pulo.
	if Input.is_action_just_released("pular") and velocity.y > 0.0:
		velocity.y *= CORTE_PULO


# ============================================================================
# MOVIMENTO: FORMA MORCEGO (voo fluido por tempo limitado)
# ============================================================================

func _mover_como_morcego(delta: float) -> void:
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	var direcao := (transform.basis * Vector3(entrada.x, 0.0, entrada.y)).normalized()
	var alvo := direcao * VELOCIDADE_VOO
	velocity.x = move_toward(velocity.x, alvo.x, ACEL_VOO * delta)
	velocity.z = move_toward(velocity.z, alvo.z, ACEL_VOO * delta)

	var batendo_asas := Input.is_action_pressed("pular") and tempo_voo_restante > 0.0
	if batendo_asas:
		velocity.y = move_toward(velocity.y, VELOCIDADE_SUBIDA, ACEL_VOO * delta)
		tempo_voo_restante -= delta
	else:
		velocity.y -= (GRAV_CAINDO * QUEDA_PLANANDO) * delta


# ============================================================================
# JUICE: efeitos visuais
# ============================================================================

func _criar_efeitos() -> void:
	# Poeira que fica no mundo (não acompanha o corpo) ao aterrissar.
	poeira = _criar_particulas(Color(0.55, 0.55, 0.6), 14, 0.5, 2.6, 95.0)
	poeira.local_coords = false
	poeira.gravity = Vector3(0, -5, 0)
	poeira.position = Vector3(0, 0.1, 0)

	# Faíscas escuras/roxas no momento da transformação (acompanham o corpo).
	transform_fx = _criar_particulas(Color(0.55, 0.25, 0.7), 24, 0.6, 4.0, 70.0)
	transform_fx.position = Vector3(0, 1.0, 0)

	# Luz que pisca rapidamente ao transformar.
	luz_flash = OmniLight3D.new()
	luz_flash.position = Vector3(0, 1.2, 0)
	luz_flash.light_color = Color(0.7, 0.4, 1.0)
	luz_flash.omni_range = 6.0
	luz_flash.light_energy = 0.0
	add_child(luz_flash)


func _criar_particulas(cor: Color, qtd: int, vida: float, vel: float, espalhar: float) -> CPUParticles3D:
	var p := CPUParticles3D.new()
	p.emitting = false
	p.one_shot = true
	p.explosiveness = 0.9
	p.amount = qtd
	p.lifetime = vida
	p.direction = Vector3(0, 1, 0)
	p.spread = espalhar
	p.initial_velocity_min = vel * 0.5
	p.initial_velocity_max = vel
	p.gravity = Vector3(0, -2, 0)
	p.scale_amount_min = 0.6
	p.scale_amount_max = 1.3
	p.mesh = _mesh_particula(cor)
	# Faz as partículas desaparecerem (alpha vai a zero) ao longo da vida.
	var grad := Gradient.new()
	grad.set_color(0, Color(cor.r, cor.g, cor.b, 0.85))
	grad.set_color(1, Color(cor.r, cor.g, cor.b, 0.0))
	p.color_ramp = grad
	add_child(p)
	return p


func _mesh_particula(cor: Color) -> QuadMesh:
	var q := QuadMesh.new()
	q.size = Vector2(0.2, 0.2)
	var m := StandardMaterial3D.new()
	m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	m.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED
	m.vertex_color_use_as_albedo = true
	m.albedo_color = cor
	q.material = m
	return q


func _ao_aterrissar(vel_y: float) -> void:
	# Quanto mais forte a queda, mais o corpo "achata" e mais poeira sai.
	var intensidade := clampf(absf(vel_y) / 12.0, 0.25, 1.0)
	escala_modelo = Vector3(1.0 + 0.25 * intensidade, 1.0 - 0.3 * intensidade, 1.0 + 0.25 * intensidade)
	poeira.restart()


func _esticar_pulo() -> void:
	# Ao pular, o corpo se estica para cima.
	escala_modelo = Vector3(0.8, 1.25, 0.8)


func _atualizar_fov(delta: float) -> void:
	var vel_horizontal := Vector2(velocity.x, velocity.z).length()
	var t := clampf(vel_horizontal / VELOCIDADE_CORRER, 0.0, 1.3)
	var alvo := lerpf(FOV_BASE, FOV_VELOCIDADE, t)
	camera.fov = lerpf(camera.fov, alvo, delta * 6.0)


func _orientar_modelo(delta: float) -> void:
	# Vira o modelo visível para a direção horizontal do movimento (suavemente).
	var h := Vector3(velocity.x, 0.0, velocity.z)
	if h.length() < 1.0:
		return
	var alvo := atan2(-h.x, -h.z) - rotation.y
	var modelo := modelo_vampiro if forma_atual == Forma.VAMPIRO else modelo_morcego
	modelo.rotation.y = lerp_angle(modelo.rotation.y, alvo, clampf(delta * 10.0, 0.0, 1.0))


# ============================================================================
# TRANSFORMAÇÃO
# ============================================================================

func _alternar_forma() -> void:
	if forma_atual == Forma.VAMPIRO:
		forma_atual = Forma.MORCEGO
	else:
		forma_atual = Forma.VAMPIRO
		pulo_duplo_ok = true

	_atualizar_visual()

	# Efeitos de transformação (faíscas, flash de luz e um "pop" na escala).
	escala_modelo = Vector3(1.3, 1.3, 1.3)
	transform_fx.restart()
	luz_flash.light_energy = 5.0


func _atualizar_visual() -> void:
	modelo_vampiro.visible = (forma_atual == Forma.VAMPIRO)
	modelo_morcego.visible = (forma_atual == Forma.MORCEGO)


# ============================================================================
# CONSULTAS PARA O HUD (lê o estado do jogador sem expor variáveis cruas)
# ============================================================================

func eh_morcego() -> bool:
	return forma_atual == Forma.MORCEGO

func fracao_voo() -> float:
	# Quanto resta do "tanque" de voo, de 0.0 a 1.0.
	return clampf(tempo_voo_restante / TEMPO_MAXIMO_VOO, 0.0, 1.0)

func pulo_duplo_disponivel() -> bool:
	# Verdadeiro só quando está no ar e ainda tem o segundo pulo.
	return pulo_duplo_ok and not is_on_floor()
