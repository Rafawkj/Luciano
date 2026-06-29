# player.gd
# ----------------------------------------------------------------------------
# Script do PERSONAGEM PRINCIPAL: um vampiro que pode virar morcego.
#
# Este script controla:
#   - Movimento em 3ª pessoa (andar / correr / pular) na forma VAMPIRO.
#   - Câmera que segue o personagem (girando com o mouse).
#   - Transformação entre VAMPIRO e MORCEGO ao apertar uma tecla (T).
#   - Voo por tempo limitado na forma MORCEGO.
#
# Ele fica preso a um nó do tipo CharacterBody3D (corpo com física e colisão).
# ----------------------------------------------------------------------------

extends CharacterBody3D


# ============================================================================
# CONFIGURAÇÕES (você pode ajustar esses números para mudar a "sensação" do jogo)
# ============================================================================

# --- Movimento como VAMPIRO ---
const VELOCIDADE_ANDAR := 4.0      # velocidade andando
const VELOCIDADE_CORRER := 8.0     # velocidade segurando "correr" (Shift)
const FORCA_PULO := 6.0            # quão forte é o pulo

# --- Voo como MORCEGO ---
const VELOCIDADE_VOO := 10.0       # velocidade horizontal voando
const VELOCIDADE_SUBIDA := 6.0     # quão rápido sobe ao segurar "pular" (Espaço)
const TEMPO_MAXIMO_VOO := 5.0      # quantos segundos de voo cabem no "tanque"
const QUEDA_PLANANDO := 0.30       # fração da gravidade ao planar (0 = não cai)

# --- Câmera ---
const SENSIBILIDADE_MOUSE := 0.003 # quão rápido a câmera gira com o mouse


# ============================================================================
# ESTADO INTERNO (variáveis que mudam durante o jogo)
# ============================================================================

# As duas formas possíveis do personagem.
enum Forma { VAMPIRO, MORCEGO }

# Em qual forma o personagem está agora. Começa como VAMPIRO.
var forma_atual: int = Forma.VAMPIRO

# Quanto tempo de voo (em segundos) ainda resta. Recarrega ao tocar o chão.
var tempo_voo_restante: float = TEMPO_MAXIMO_VOO

# Gravidade lida das configurações do projeto (padrão 9.8).
var gravidade: float = ProjectSettings.get_setting("physics/3d/default_gravity")


# ============================================================================
# REFERÊNCIAS A OUTROS NÓS (filhos deste personagem na cena)
# O "@onready" pega o nó assim que a cena estiver pronta.
# ============================================================================

@onready var pivo_camera: Node3D = $PivoCamera        # gira a câmera para cima/baixo
@onready var modelo_vampiro: Node3D = $ModeloVampiro  # malha visível como vampiro
@onready var modelo_morcego: Node3D = $ModeloMorcego  # malha visível como morcego


# ============================================================================
# FUNÇÕES DO GODOT
# ============================================================================

func _ready() -> void:
	# Esconde o cursor e o prende na janela, para a câmera funcionar como em um
	# jogo em 3ª pessoa. (Aperte ESC durante o jogo para liberar o mouse.)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_atualizar_visual()


func _unhandled_input(event: InputEvent) -> void:
	# --- Girar a câmera com o mouse ---
	if event is InputEventMouseMotion:
		# Mover o mouse na horizontal gira o corpo inteiro (esquerda/direita).
		rotate_y(-event.relative.x * SENSIBILIDADE_MOUSE)
		# Mover na vertical inclina só a câmera (olhar para cima/baixo).
		pivo_camera.rotate_x(-event.relative.y * SENSIBILIDADE_MOUSE)
		# Trava o ângulo vertical para não dar "cambalhota".
		pivo_camera.rotation.x = clamp(pivo_camera.rotation.x, deg_to_rad(-70), deg_to_rad(45))

	# --- ESC: alterna entre prender e liberar o mouse (útil para testar) ---
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# --- T: transformar entre vampiro e morcego ---
	if event.is_action_pressed("transformar"):
		_alternar_forma()


func _physics_process(delta: float) -> void:
	# Decide qual lógica de movimento usar conforme a forma atual.
	if forma_atual == Forma.VAMPIRO:
		_mover_como_vampiro(delta)
	else:
		_mover_como_morcego(delta)

	# Aplica de fato o movimento e resolve as colisões com o terreno.
	move_and_slide()

	# Sempre que tocar o chão, recarrega o "tanque" de voo.
	if is_on_floor():
		tempo_voo_restante = TEMPO_MAXIMO_VOO


# ============================================================================
# MOVIMENTO: FORMA VAMPIRO (andar, correr, pular)
# ============================================================================

func _mover_como_vampiro(delta: float) -> void:
	# Gravidade: enquanto não está no chão, é puxado para baixo.
	if not is_on_floor():
		velocity.y -= gravidade * delta

	# Pulo: só funciona se estiver no chão.
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = FORCA_PULO

	# Lê as teclas WASD e transforma em uma direção no espaço 3D.
	# get_vector devolve um Vector2 já normalizado (esquerda/direita, frente/trás).
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	# Converte a direção para o referencial do personagem (para onde ele olha).
	var direcao := (transform.basis * Vector3(entrada.x, 0.0, entrada.y)).normalized()

	# Anda ou corre, dependendo se a tecla "correr" está pressionada.
	var velocidade := VELOCIDADE_CORRER if Input.is_action_pressed("correr") else VELOCIDADE_ANDAR

	if direcao != Vector3.ZERO:
		velocity.x = direcao.x * velocidade
		velocity.z = direcao.z * velocidade
	else:
		# Sem teclas: freia suavemente até parar.
		velocity.x = move_toward(velocity.x, 0.0, velocidade)
		velocity.z = move_toward(velocity.z, 0.0, velocidade)


# ============================================================================
# MOVIMENTO: FORMA MORCEGO (voar por tempo limitado)
# ============================================================================

func _mover_como_morcego(delta: float) -> void:
	# Segurar "pular" (Espaço) faz o morcego subir, enquanto houver tempo de voo.
	var batendo_asas := Input.is_action_pressed("pular") and tempo_voo_restante > 0.0

	if batendo_asas:
		velocity.y = VELOCIDADE_SUBIDA
		tempo_voo_restante -= delta  # gasta o "tanque" de voo
	else:
		# Sem bater asas (ou tanque vazio): plana, caindo bem devagar.
		velocity.y -= gravidade * QUEDA_PLANANDO * delta

	# Movimento horizontal, mais rápido que o do vampiro.
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	var direcao := (transform.basis * Vector3(entrada.x, 0.0, entrada.y)).normalized()

	if direcao != Vector3.ZERO:
		velocity.x = direcao.x * VELOCIDADE_VOO
		velocity.z = direcao.z * VELOCIDADE_VOO
	else:
		velocity.x = move_toward(velocity.x, 0.0, VELOCIDADE_VOO)
		velocity.z = move_toward(velocity.z, 0.0, VELOCIDADE_VOO)


# ============================================================================
# TRANSFORMAÇÃO
# ============================================================================

func _alternar_forma() -> void:
	# Troca de forma: vampiro vira morcego e vice-versa.
	if forma_atual == Forma.VAMPIRO:
		forma_atual = Forma.MORCEGO
	else:
		forma_atual = Forma.VAMPIRO
	_atualizar_visual()


func _atualizar_visual() -> void:
	# Mostra apenas a malha da forma atual e esconde a outra.
	modelo_vampiro.visible = (forma_atual == Forma.VAMPIRO)
	modelo_morcego.visible = (forma_atual == Forma.MORCEGO)
