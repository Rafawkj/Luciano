# village_builder.gd
# ----------------------------------------------------------------------------
# CONSTRUTOR DA VILA (procedural = montado por código ao iniciar o jogo).
#
# Em vez de posicionar dezenas de objetos à mão no editor, este script cria
# tudo a partir de LISTAS DE POSIÇÕES. Para deixar a vila maior, basta adicionar
# mais coordenadas nas listas dentro de _ready(). Cada "peça" (casa, tocha,
# túmulo, árvore morta, poço, capela) tem sua própria função, bem separada.
#
# O foco do jogo é EXPLORAÇÃO e a VIBE dark fantasy, então espalhamos tochas
# (luz quente que tremula) e pontos de interesse com textos de lore.
# ----------------------------------------------------------------------------

extends Node3D

# Scripts reutilizados pelas peças que criamos.
const ScriptTocha := preload("res://scripts/tocha.gd")
const ScriptPontoInteresse := preload("res://scripts/ponto_de_interesse.gd")

# --- Materiais (criados uma única vez em _criar_materiais) ---
var mat_parede: StandardMaterial3D    # reboco claro das casas
var mat_madeira: StandardMaterial3D   # madeira escura (portas, postes)
var mat_telhado: StandardMaterial3D   # telhado vermelho escuro
var mat_pedra: StandardMaterial3D     # pedra (poço, túmulos, capela)
var mat_janela: StandardMaterial3D    # janela/chama iluminada (emissiva)
var mat_tronco: StandardMaterial3D    # árvores mortas
var mat_marmore: StandardMaterial3D   # mármore pálido (estátua, salão, colunas)
var mat_flor: StandardMaterial3D      # flores brancas que brilham fracamente
var mat_agua_escura: StandardMaterial3D  # lágrimas e poça de água escura
var mat_nevoa: StandardMaterial3D     # névoa do rio e feixe de luar (translúcida)
var mats_livros: Array = []           # cores variadas dos livros da biblioteca


func _ready() -> void:
	_criar_materiais()
	_construir_casas()
	_construir_parkour()
	_construir_parkour_aereo()
	_construir_praca_e_portao()
	_construir_cemiterio()
	_espalhar_arvores_mortas()
	# --- Lugares de "beleza triste" (este mundo já foi lindo) ---
	_construir_jardim_e_estatua()
	_construir_biblioteca()
	_construir_castelo_e_salao()
	_construir_rio_e_ponte()
	_criar_pontos_de_interesse()


# ============================================================================
# MATERIAIS
# ============================================================================

func _criar_materiais() -> void:
	mat_parede = _novo_material(Color(0.5, 0.45, 0.38))
	mat_madeira = _novo_material(Color(0.18, 0.12, 0.08))
	mat_telhado = _novo_material(Color(0.3, 0.1, 0.1))
	mat_pedra = _novo_material(Color(0.4, 0.4, 0.44))
	mat_tronco = _novo_material(Color(0.12, 0.1, 0.09))
	# Janela/chama: material que EMITE luz própria (brilha no escuro).
	mat_janela = _novo_material(Color(1.0, 0.78, 0.4), 0.6, true, 3.0)

	# Mármore pálido e liso (estátua, colunas e piso do salão de baile).
	mat_marmore = _novo_material(Color(0.82, 0.82, 0.86), 0.25)
	# Flores brancas que captam o luar e brilham de leve.
	mat_flor = _novo_material(Color(0.95, 0.96, 1.0), 0.5, true, 1.2)
	# Água escura: lisa, quase preta, com um leve brilho frio para se ver à noite.
	mat_agua_escura = _novo_material(Color(0.02, 0.02, 0.05), 0.05, true, 0.4)
	# Névoa translúcida e luminosa (rio de névoa e feixe de luar).
	mat_nevoa = StandardMaterial3D.new()
	mat_nevoa.albedo_color = Color(0.7, 0.73, 0.85, 0.18)
	mat_nevoa.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_nevoa.emission_enabled = true
	mat_nevoa.emission = Color(0.4, 0.42, 0.55)
	mat_nevoa.emission_energy_multiplier = 0.6
	mat_nevoa.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	# Cores sóbrias para as lombadas dos livros da biblioteca.
	mats_livros = [
		_novo_material(Color(0.35, 0.12, 0.12)),
		_novo_material(Color(0.15, 0.2, 0.28)),
		_novo_material(Color(0.2, 0.18, 0.1)),
		_novo_material(Color(0.12, 0.22, 0.16)),
		_novo_material(Color(0.25, 0.2, 0.28)),
	]


func _novo_material(cor: Color, rugosidade := 0.95, emissivo := false, energia := 1.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = cor
	m.roughness = rugosidade
	if emissivo:
		m.emission_enabled = true
		m.emission = cor
		m.emission_energy_multiplier = energia
	return m


# ============================================================================
# AJUDANTES DE GEOMETRIA (criam caixas, malhas e colisões)
# ============================================================================

func _malha_caixa(tamanho: Vector3, material: Material) -> BoxMesh:
	var m := BoxMesh.new()
	m.size = tamanho
	m.material = material
	return m


# Adiciona uma caixa SÓLIDA (com colisão) a um corpo estático.
func _caixa_solida(corpo: StaticBody3D, tamanho: Vector3, pos: Vector3, material: Material) -> void:
	var visual := MeshInstance3D.new()
	visual.mesh = _malha_caixa(tamanho, material)
	visual.position = pos
	corpo.add_child(visual)

	var colisao := CollisionShape3D.new()
	var forma := BoxShape3D.new()
	forma.size = tamanho
	colisao.shape = forma
	colisao.position = pos
	corpo.add_child(colisao)


# Adiciona uma malha apenas VISUAL (sem colisão) a qualquer nó.
func _malha(pai: Node3D, malha: Mesh, pos: Vector3, rot_graus := Vector3.ZERO) -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	mi.mesh = malha
	mi.position = pos
	mi.rotation_degrees = rot_graus
	pai.add_child(mi)
	return mi


# ============================================================================
# CASAS
# ============================================================================

func _construir_casas() -> void:
	# Cada item é [posição, rotação em graus]. As casas formam ruas em volta
	# do ponto de partida, deixando o caminho até a torre (ao norte) livre.
	var casas := [
		# Rua de entrada (ao sul), dos dois lados
		[Vector3(9, 0, 22), -90.0], [Vector3(-9, 0, 22), 90.0],
		[Vector3(9, 0, 15), -90.0], [Vector3(-9, 0, 15), 90.0],
		[Vector3(12, 0, 7), -90.0], [Vector3(-12, 0, 7), 90.0],
		# Casas mais próximas da praça/torre
		[Vector3(13, 0, -3), -90.0], [Vector3(-13, 0, -3), 90.0],
		[Vector3(10, 0, -12), -75.0], [Vector3(-10, 0, -12), 75.0],
		# Bairro a leste
		[Vector3(22, 0, 3), -90.0], [Vector3(22, 0, -7), -90.0],
		# --- Ampliação da vila ---
		# Casas que emolduram a entrada (mais telhados para o parkour)
		[Vector3(16, 0, 24), -90.0], [Vector3(-16, 0, 24), 90.0],
		[Vector3(-14, 0, 28), 90.0],
		# Bairro oeste
		[Vector3(-22, 0, 4), 100.0], [Vector3(-25, 0, 10), 80.0],
		[Vector3(-26, 0, 18), 70.0], [Vector3(-20, 0, 22), 95.0],
		# Casas ao norte (em direção à torre)
		[Vector3(16, 0, -14), -100.0], [Vector3(-16, 0, -15), 100.0],
	]
	for casa in casas:
		_criar_casa(casa[0], casa[1])

	# Tochas iluminando as ruas e a praça (luz quente que tremula).
	var tochas := [
		Vector3(4, 0, 21), Vector3(-4, 0, 21),
		Vector3(4, 0, 12), Vector3(-4, 0, 12),
		Vector3(5, 0, 2), Vector3(-5, 0, 2),
		Vector3(4, 0, -9), Vector3(-4, 0, -9),
		Vector3(3, 0, -15), Vector3(-3, 0, -15),
		Vector3(18, 0, -2), Vector3(-18, 0, 0),
		Vector3(13, 0, 26), Vector3(-13, 0, 26),
		Vector3(-23, 0, 14), Vector3(-23, 0, 20),
	]
	for pos in tochas:
		_criar_tocha(pos)


func _criar_casa(pos: Vector3, graus: float) -> void:
	var casa := StaticBody3D.new()
	casa.position = pos
	casa.rotation_degrees = Vector3(0, graus, 0)
	add_child(casa)

	# Paredes (caixa sólida). Beiral em y=3.0, baixo o bastante para subir
	# com pulo duplo / wall jump (parkour).
	_caixa_solida(casa, Vector3(5, 3.0, 5), Vector3(0, 1.5, 0), mat_parede)

	# Telhado em forma de prisma — COM colisão, para poder andar sobre ele.
	# A inclinação (~37°) é menor que o ângulo máximo de chão, então é "pisável".
	var telhado := PrismMesh.new()
	telhado.size = Vector3(5.8, 2.2, 5.8)
	telhado.material = mat_telhado
	_malha(casa, telhado, Vector3(0, 4.1, 0))
	var colisao_telhado := CollisionShape3D.new()
	colisao_telhado.shape = telhado.create_convex_shape()
	colisao_telhado.position = Vector3(0, 4.1, 0)
	casa.add_child(colisao_telhado)

	# Porta escura e duas janelas iluminadas na frente (face +Z local).
	_malha(casa, _malha_caixa(Vector3(1.2, 2.0, 0.15), mat_madeira), Vector3(0, 1.0, 2.55))
	_malha(casa, _malha_caixa(Vector3(0.9, 0.9, 0.15), mat_janela), Vector3(1.5, 1.9, 2.55))
	_malha(casa, _malha_caixa(Vector3(0.9, 0.9, 0.15), mat_janela), Vector3(-1.5, 1.9, 2.55))


func _criar_tocha(pos: Vector3) -> void:
	var base := Node3D.new()
	base.position = pos
	add_child(base)

	# Poste de madeira.
	var poste := CylinderMesh.new()
	poste.top_radius = 0.08
	poste.bottom_radius = 0.12
	poste.height = 2.2
	poste.material = mat_madeira
	_malha(base, poste, Vector3(0, 1.1, 0))

	# "Chama" emissiva no topo.
	var chama := SphereMesh.new()
	chama.radius = 0.18
	chama.height = 0.36
	chama.material = mat_janela
	_malha(base, chama, Vector3(0, 2.35, 0))

	# Luz pontual quente que tremula (script tocha.gd).
	var luz := OmniLight3D.new()
	luz.position = Vector3(0, 2.35, 0)
	luz.light_color = Color(1.0, 0.6, 0.25)
	luz.omni_range = 10.0
	luz.set_script(ScriptTocha)
	base.add_child(luz)


# ============================================================================
# CIRCUITO DE PARKOUR (caixotes, toldos e passarela entre os telhados)
# ============================================================================

func _construir_parkour() -> void:
	# Degraus de caixotes para subir da rua até o telhado da casa do leste.
	_criar_caixote(Vector3(5.5, 0.0, 18.0), 1.4)
	_criar_caixote(Vector3(6.7, 0.0, 16.7), 1.4)
	_criar_caixote(Vector3(6.7, 1.4, 16.7), 1.2)  # empilhado sobre o anterior

	# Um "toldo" de madeira ao lado da casa, logo abaixo do beiral (3.0).
	_criar_plataforma(Vector3(8.2, 2.5, 16.0), Vector3(3, 0.3, 3))

	# Passarela ligando os telhados dos dois lados da rua de entrada.
	_criar_plataforma(Vector3(0, 3.3, 18.5), Vector3(20, 0.3, 1.4))

	# Caixotes soltos espalhados, como apoios extras pela vila.
	_criar_caixote(Vector3(-6.0, 0.0, 12.0), 1.3)
	_criar_caixote(Vector3(15.5, 0.0, -1.0), 1.4)
	_criar_caixote(Vector3(15.5, 1.4, -1.0), 1.1)
	_criar_caixote(Vector3(-15.5, 0.0, 1.0), 1.4)

	# Mais passarelas/vigas ligando telhados, deixando a vila bem "parkourável".
	_criar_plataforma(Vector3(-9, 3.3, 18.5), Vector3(0.9, 0.25, 7))   # entre casas oeste
	_criar_plataforma(Vector3(10.5, 3.3, 11), Vector3(0.9, 0.25, 8))   # liga rua leste
	_criar_plataforma(Vector3(-13, 3.3, 26), Vector3(0.9, 0.25, 6))    # casas do sudoeste
	_criar_caixote(Vector3(-24, 0.0, 14), 1.4)                          # apoio bairro oeste
	_criar_caixote(Vector3(18.5, 0.0, -11), 1.4)                        # apoio ao norte


func _criar_caixote(pos: Vector3, lado: float) -> void:
	# Um caixote cúbico de madeira. "pos" é a base (o caixote sobe a partir dela).
	var caixote := StaticBody3D.new()
	caixote.position = pos
	caixote.rotation_degrees = Vector3(0, randf_range(-12.0, 12.0), 0)  # leve giro
	add_child(caixote)
	_caixa_solida(caixote, Vector3(lado, lado, lado), Vector3(0, lado * 0.5, 0), mat_madeira)


func _criar_plataforma(pos: Vector3, tamanho: Vector3) -> void:
	# Uma plataforma/passarela de madeira (centro no "pos").
	var plataforma := StaticBody3D.new()
	plataforma.position = pos
	add_child(plataforma)
	_caixa_solida(plataforma, tamanho, Vector3.ZERO, mat_madeira)


# ============================================================================
# ROTA DE ASCENSÃO (parkour aéreo)
#
# A ideia: você sobe a pé (vampiro) por plataformas e paredes, mas chega a
# saltos ALTOS e LONGOS demais para pernas humanas. Aí você vira MORCEGO (T),
# voa até a plataforma marcada por uma LUZ AZUL, POUSA (recarrega o voo) e
# VOLTA a vampiro (T) para continuar o parkour lá no alto.
# ============================================================================

func _construir_parkour_aereo() -> void:
	# --- Trecho 1: subida a pé, a partir dos telhados da entrada ---
	_criar_plataforma(Vector3(17, 4.5, 27), Vector3(5, 0.4, 5))
	_criar_plataforma(Vector3(21, 6.5, 30), Vector3(4, 0.4, 4))
	_criar_plataforma(Vector3(25, 8.5, 28), Vector3(4, 0.4, 4))

	# Paredes para wall jump, ganhando altura até o topo do trecho a pé.
	_criar_parede_parkour(Vector3(27.5, 9.0, 28), Vector3(0.6, 6, 4))
	_criar_parede_parkour(Vector3(24.0, 11.5, 30.5), Vector3(4, 6, 0.6))
	_criar_plataforma(Vector3(25, 12.5, 28), Vector3(4, 0.4, 4))  # fim do trecho a pé

	# --- SALTO DE MORCEGO 1 ---
	# Alto (+6 m) e longe (~12 m): impossível a pé. Vire morcego, voe até a luz,
	# pouse (recarrega o voo) e volte a vampiro para seguir.
	_criar_plataforma_voo(Vector3(26, 18.5, 40), Vector3(6, 0.4, 6))

	# --- Trecho 2: parkour de vampiro lá no alto (saltos curtos, possíveis) ---
	_criar_plataforma(Vector3(31, 18.5, 42), Vector3(3.5, 0.4, 3.5))
	_criar_plataforma(Vector3(30, 18.5, 47), Vector3(3.5, 0.4, 3.5))
	_criar_plataforma(Vector3(25, 19.5, 49), Vector3(3.5, 0.4, 3.5))

	# --- SALTO DE MORCEGO 2: até o mirante mais alto do vale ---
	_criar_plataforma_voo(Vector3(26, 26, 44), Vector3(5, 0.4, 5))


func _criar_parede_parkour(pos: Vector3, tamanho: Vector3) -> void:
	# Uma parede de pedra usada para wall jump na subida.
	var parede := StaticBody3D.new()
	parede.position = pos
	add_child(parede)
	_caixa_solida(parede, tamanho, Vector3.ZERO, mat_pedra)


func _criar_plataforma_voo(pos: Vector3, tamanho: Vector3) -> void:
	# Plataforma alta marcada por um FAROL AZUL: o destino de um salto de morcego.
	var plataforma := StaticBody3D.new()
	plataforma.position = pos
	add_child(plataforma)
	_caixa_solida(plataforma, tamanho, Vector3.ZERO, mat_pedra)

	# Pilar/farol emissivo no centro, para o jogador enxergar o destino de longe.
	_malha(plataforma, _malha_caixa(Vector3(0.5, 1.4, 0.5), mat_janela), Vector3(0, tamanho.y * 0.5 + 0.7, 0))
	var farol := OmniLight3D.new()
	farol.position = Vector3(0, tamanho.y * 0.5 + 1.5, 0)
	farol.light_color = Color(0.55, 0.75, 1.0)  # azul-frio: "voe até aqui"
	farol.omni_range = 16.0
	farol.light_energy = 3.0
	plataforma.add_child(farol)


# ============================================================================
# PRAÇA: POÇO CENTRAL + PORTÃO DE ENTRADA
# ============================================================================

func _construir_praca_e_portao() -> void:
	_criar_poco(Vector3(0, 0, 9))
	_criar_portao(Vector3(0, 0, 30))


func _criar_poco(pos: Vector3) -> void:
	var poco := StaticBody3D.new()
	poco.position = pos
	add_child(poco)

	# Anel de pedra (cilindro) com colisão cilíndrica.
	var anel := CylinderMesh.new()
	anel.top_radius = 1.4
	anel.bottom_radius = 1.5
	anel.height = 1.0
	anel.material = mat_pedra
	_malha(poco, anel, Vector3(0, 0.5, 0))

	var colisao := CollisionShape3D.new()
	var forma := CylinderShape3D.new()
	forma.radius = 1.5
	forma.height = 1.0
	colisao.shape = forma
	colisao.position = Vector3(0, 0.5, 0)
	poco.add_child(colisao)

	# Dois postes e um teto de madeira por cima do poço.
	_malha(poco, _malha_caixa(Vector3(0.2, 2.4, 0.2), mat_madeira), Vector3(-1.2, 1.2, 0))
	_malha(poco, _malha_caixa(Vector3(0.2, 2.4, 0.2), mat_madeira), Vector3(1.2, 1.2, 0))
	var teto := PrismMesh.new()
	teto.size = Vector3(3.2, 1.0, 1.6)
	teto.material = mat_telhado
	_malha(poco, teto, Vector3(0, 2.8, 0))


func _criar_portao(pos: Vector3) -> void:
	var portao := StaticBody3D.new()
	portao.position = pos
	add_child(portao)
	# Dois pilares de pedra e uma viga de madeira por cima (entrada da vila).
	_caixa_solida(portao, Vector3(1, 6, 1), Vector3(-4, 3, 0), mat_pedra)
	_caixa_solida(portao, Vector3(1, 6, 1), Vector3(4, 3, 0), mat_pedra)
	_malha(portao, _malha_caixa(Vector3(9.5, 1, 1), mat_madeira), Vector3(0, 6, 0))


# ============================================================================
# CEMITÉRIO: túmulos em grade + capela em ruínas
# ============================================================================

func _construir_cemiterio() -> void:
	# Túmulos em uma grade, com pequenas variações de posição e inclinação,
	# como lápides antigas e tortas. Fica a oeste da vila.
	for x in range(-42, -23, 4):
		for z in range(-20, -1, 4):
			# Deixa um espaço aberto onde fica a capela.
			if x > -34 and z < -10:
				continue
			var pos := Vector3(x + randf_range(-1.0, 1.0), 0, z + randf_range(-1.0, 1.0))
			_criar_lapide(pos, randf_range(0.0, 360.0))

	_criar_capela(Vector3(-31, 0, -15), 0.0)
	# Tochas fracas marcando a entrada do cemitério.
	_criar_tocha(Vector3(-22, 0, -6))
	_criar_tocha(Vector3(-22, 0, -16))


func _criar_lapide(pos: Vector3, graus: float) -> void:
	var lapide := StaticBody3D.new()
	lapide.position = pos
	# Inclina um pouco para parecer velha e abandonada.
	lapide.rotation_degrees = Vector3(randf_range(-7.0, 7.0), graus, randf_range(-9.0, 9.0))
	add_child(lapide)
	_caixa_solida(lapide, Vector3(0.8, 1.1, 0.18), Vector3(0, 0.55, 0), mat_pedra)


func _criar_capela(pos: Vector3, graus: float) -> void:
	var capela := StaticBody3D.new()
	capela.position = pos
	capela.rotation_degrees = Vector3(0, graus, 0)
	add_child(capela)

	# Paredes quebradas (alturas diferentes) formando uma ruína aberta.
	_caixa_solida(capela, Vector3(8, 5, 0.6), Vector3(0, 2.5, -3.5), mat_pedra)   # fundo
	_caixa_solida(capela, Vector3(0.6, 4, 7), Vector3(-3.7, 2, 0), mat_pedra)     # lateral esq.
	_caixa_solida(capela, Vector3(0.6, 2.5, 4), Vector3(3.7, 1.25, -1.5), mat_pedra) # lateral dir. quebrada
	_caixa_solida(capela, Vector3(0.7, 3, 0.7), Vector3(-3.4, 1.5, 3.4), mat_pedra)  # pilar frontal esq.
	_caixa_solida(capela, Vector3(0.7, 2, 0.7), Vector3(3.4, 1.0, 3.4), mat_pedra)   # pilar frontal dir. quebrado

	# Altar com uma vela acesa (luz quente fraca) lá dentro.
	_caixa_solida(capela, Vector3(2, 1, 1), Vector3(0, 0.5, -2.5), mat_pedra)
	_malha(capela, _malha_caixa(Vector3(0.2, 0.4, 0.2), mat_janela), Vector3(0, 1.2, -2.5))
	var vela := OmniLight3D.new()
	vela.position = Vector3(0, 1.4, -2.5)
	vela.light_color = Color(1.0, 0.55, 0.2)
	vela.omni_range = 6.0
	vela.set_script(ScriptTocha)
	capela.add_child(vela)


# ============================================================================
# ÁRVORES MORTAS (espalhadas para reforçar o clima)
# ============================================================================

func _espalhar_arvores_mortas() -> void:
	var posicoes := [
		Vector3(-26, 0, -2), Vector3(-38, 0, -3), Vector3(-30, 0, -22),
		Vector3(16, 0, 16), Vector3(-16, 0, 18), Vector3(24, 0, -16),
		Vector3(6, 0, -24), Vector3(-6, 0, 28),
	]
	for pos in posicoes:
		_criar_arvore_morta(pos)


func _criar_arvore_morta(pos: Vector3) -> void:
	var arvore := Node3D.new()
	arvore.position = pos
	add_child(arvore)

	# Tronco principal.
	var tronco := CylinderMesh.new()
	tronco.top_radius = 0.12
	tronco.bottom_radius = 0.35
	tronco.height = 4.0
	tronco.material = mat_tronco
	_malha(arvore, tronco, Vector3(0, 2.0, 0))

	# Alguns galhos retorcidos saindo em ângulos aleatórios.
	for i in range(4):
		var galho := CylinderMesh.new()
		galho.top_radius = 0.04
		galho.bottom_radius = 0.12
		galho.height = 1.6
		galho.material = mat_tronco
		var angulo := randf() * TAU
		_malha(
			arvore, galho,
			Vector3(sin(angulo) * 0.3, 3.0 + i * 0.3, cos(angulo) * 0.3),
			Vector3(randf_range(25.0, 55.0), rad_to_deg(angulo), randf_range(-30.0, 30.0))
		)


# ============================================================================
# JARDIM MORTO COM FLORES BRANCAS + ESTÁTUA CHORANDO ÁGUA ESCURA
# ============================================================================

func _construir_jardim_e_estatua() -> void:
	var centro := Vector3(34, 0, 6)

	# Muretas baixas de pedra cercam o jardim (aberto ao sul, pela vila).
	var cerca := StaticBody3D.new()
	cerca.position = centro
	add_child(cerca)
	_caixa_solida(cerca, Vector3(16, 0.6, 0.4), Vector3(0, 0.3, -8), mat_pedra)  # norte
	_caixa_solida(cerca, Vector3(0.4, 0.6, 16), Vector3(-8, 0.3, 0), mat_pedra)  # oeste
	_caixa_solida(cerca, Vector3(0.4, 0.6, 16), Vector3(8, 0.3, 0), mat_pedra)   # leste

	# Flores brancas em grade, deixando o centro livre para a estátua.
	for fx in range(-6, 7, 2):
		for fz in range(-6, 7, 2):
			if abs(fx) <= 2 and abs(fz) <= 2:
				continue
			var p := centro + Vector3(fx + randf_range(-0.4, 0.4), 0, fz + randf_range(-0.4, 0.4))
			_criar_flor_branca(p)

	_criar_estatua_chorando(centro)
	# Uma árvore morta no canto reforça o "jardim que já foi belo".
	_criar_arvore_morta(centro + Vector3(6, 0, -6))


func _criar_flor_branca(pos: Vector3) -> void:
	var flor := Node3D.new()
	flor.position = pos
	add_child(flor)

	var caule := CylinderMesh.new()
	caule.top_radius = 0.02
	caule.bottom_radius = 0.03
	caule.height = 0.5
	caule.material = mat_tronco
	_malha(flor, caule, Vector3(0, 0.25, 0))

	var petalas := SphereMesh.new()
	petalas.radius = 0.12
	petalas.height = 0.24
	petalas.material = mat_flor
	_malha(flor, petalas, Vector3(0, 0.55, 0))


func _criar_estatua_chorando(centro: Vector3) -> void:
	var estatua := StaticBody3D.new()
	estatua.position = centro
	add_child(estatua)

	# Pedestal e figura de mármore (corpo + cabeça) que olha para baixo.
	_caixa_solida(estatua, Vector3(1.6, 0.6, 1.6), Vector3(0, 0.3, 0), mat_pedra)
	var corpo := CapsuleMesh.new()
	corpo.radius = 0.35
	corpo.height = 1.8
	corpo.material = mat_marmore
	_malha(estatua, corpo, Vector3(0, 1.5, 0))
	var cabeca := SphereMesh.new()
	cabeca.radius = 0.28
	cabeca.height = 0.56
	cabeca.material = mat_marmore
	_malha(estatua, cabeca, Vector3(0, 2.45, 0.05))

	# Lágrimas de água escura escorrendo do rosto até uma poça no pedestal.
	_malha(estatua, _malha_caixa(Vector3(0.05, 1.5, 0.05), mat_agua_escura), Vector3(0.1, 1.7, 0.27))
	_malha(estatua, _malha_caixa(Vector3(0.05, 1.5, 0.05), mat_agua_escura), Vector3(-0.1, 1.7, 0.27))
	var poca := CylinderMesh.new()
	poca.top_radius = 0.7
	poca.bottom_radius = 0.7
	poca.height = 0.05
	poca.material = mat_agua_escura
	_malha(estatua, poca, Vector3(0, 0.63, 0.1))


# ============================================================================
# BIBLIOTECA ANTIGA ILUMINADA PELA LUA (sem teto, com feixe de luar)
# ============================================================================

func _construir_biblioteca() -> void:
	var centro := Vector3(-34, 0, 16)
	var sala := StaticBody3D.new()
	sala.position = centro
	add_child(sala)

	# Paredes de pedra sem teto, abertas pela frente (face +Z) para entrar.
	_caixa_solida(sala, Vector3(12, 5, 0.6), Vector3(0, 2.5, -5), mat_pedra)
	_caixa_solida(sala, Vector3(0.6, 5, 10), Vector3(-6, 2.5, 0), mat_pedra)
	_caixa_solida(sala, Vector3(0.6, 5, 10), Vector3(6, 2.5, 0), mat_pedra)

	# Estantes encostadas nas paredes laterais e ao fundo.
	for zz in [-3.0, 0.0, 3.0]:
		_criar_estante(centro + Vector3(-5.0, 0, zz), 90.0)
		_criar_estante(centro + Vector3(5.0, 0, zz), 90.0)
	_criar_estante(centro + Vector3(-2.5, 0, -4.3), 0.0)
	_criar_estante(centro + Vector3(2.5, 0, -4.3), 0.0)

	# FEIXE DE LUAR: um holofote pálido vindo do alto, como se a lua entrasse
	# pelo teto desabado. Acompanha um cilindro translúcido (a "coluna de luz").
	var luar := SpotLight3D.new()
	luar.position = centro + Vector3(0, 9, 0)
	luar.rotation_degrees = Vector3(-90, 0, 0)
	luar.light_color = Color(0.7, 0.76, 0.98)
	luar.light_energy = 6.0
	luar.spot_range = 16.0
	luar.spot_angle = 28.0
	add_child(luar)

	var feixe := CylinderMesh.new()
	feixe.top_radius = 0.6
	feixe.bottom_radius = 2.6
	feixe.height = 9.0
	feixe.material = mat_nevoa
	_malha(sala, feixe, Vector3(0, 4.5, 0))


func _criar_estante(pos: Vector3, graus: float) -> void:
	var estante := StaticBody3D.new()
	estante.position = pos
	estante.rotation_degrees = Vector3(0, graus, 0)
	add_child(estante)

	# Corpo de madeira da estante.
	_caixa_solida(estante, Vector3(1.8, 3.2, 0.4), Vector3(0, 1.6, 0), mat_madeira)
	# Fileiras de livros coloridos em três prateleiras.
	for prateleira in range(3):
		var y := 0.7 + prateleira * 0.9
		for k in range(6):
			var cor: Material = mats_livros[(k + prateleira) % mats_livros.size()]
			var livro := _malha_caixa(Vector3(0.22, 0.5, 0.3), cor)
			_malha(estante, livro, Vector3(-0.65 + k * 0.26, y, 0.06))


# ============================================================================
# CASTELO ARRUINADO COM SALÃO DE BAILE VAZIO
# ============================================================================

func _construir_castelo_e_salao() -> void:
	var centro := Vector3(0, 0, -46)
	var salao := StaticBody3D.new()
	salao.position = centro
	add_child(salao)

	# Piso de mármore liso e paredes parciais (o salão está aberto/arruinado).
	_caixa_solida(salao, Vector3(20, 0.4, 16), Vector3(0, 0.2, 0), mat_marmore)
	_caixa_solida(salao, Vector3(20, 7, 0.8), Vector3(0, 3.5, -8), mat_pedra)   # fundo
	_caixa_solida(salao, Vector3(0.8, 7, 16), Vector3(-10, 3.5, 0), mat_pedra)  # esquerda
	_caixa_solida(salao, Vector3(0.8, 7, 16), Vector3(10, 3.5, 0), mat_pedra)   # direita

	# Duas fileiras de colunas de mármore.
	for cx in [-6.0, 6.0]:
		for cz in [-5.0, 0.0, 5.0]:
			_criar_coluna(centro + Vector3(cx, 0, cz))

	# Um lustre quebrado pendurado, tombado de lado.
	_criar_lustre(centro + Vector3(0, 6, 0))

	# Luar frio e suave preenchendo o salão vazio.
	var luz := OmniLight3D.new()
	luz.position = centro + Vector3(0, 5, 3)
	luz.light_color = Color(0.6, 0.66, 0.92)
	luz.omni_range = 22.0
	luz.light_energy = 1.3
	add_child(luz)


func _criar_coluna(pos: Vector3) -> void:
	var coluna := StaticBody3D.new()
	coluna.position = pos
	add_child(coluna)

	var fuste := CylinderMesh.new()
	fuste.top_radius = 0.5
	fuste.bottom_radius = 0.6
	fuste.height = 6.0
	fuste.material = mat_marmore
	var visual := MeshInstance3D.new()
	visual.mesh = fuste
	visual.position = Vector3(0, 3, 0)
	coluna.add_child(visual)

	var colisao := CollisionShape3D.new()
	var forma := CylinderShape3D.new()
	forma.radius = 0.6
	forma.height = 6.0
	colisao.shape = forma
	colisao.position = Vector3(0, 3, 0)
	coluna.add_child(colisao)

	# Base e capitel de pedra.
	_malha(coluna, _malha_caixa(Vector3(1.4, 0.4, 1.4), mat_pedra), Vector3(0, 0.2, 0))
	_malha(coluna, _malha_caixa(Vector3(1.4, 0.4, 1.4), mat_pedra), Vector3(0, 6.0, 0))


func _criar_lustre(pos: Vector3) -> void:
	var lustre := Node3D.new()
	lustre.position = pos
	add_child(lustre)

	# Aro de metal/madeira, inclinado como se estivesse caindo.
	var aro := TorusMesh.new()
	aro.inner_radius = 1.0
	aro.outer_radius = 1.3
	aro.material = mat_madeira
	_malha(lustre, aro, Vector3.ZERO, Vector3(0, 0, 18))

	# Algumas velas ainda acesas sobre o aro.
	for a in range(5):
		var ang := a * TAU / 5.0
		var vela := _malha_caixa(Vector3(0.1, 0.4, 0.1), mat_janela)
		_malha(lustre, vela, Vector3(sin(ang) * 1.15, 0.25, cos(ang) * 1.15))

	var luz := OmniLight3D.new()
	luz.light_color = Color(1.0, 0.7, 0.35)
	luz.omni_range = 9.0
	luz.set_script(ScriptTocha)
	lustre.add_child(luz)


# ============================================================================
# RIO DE NÉVOA + PONTE QUEBRADA
# ============================================================================

func _construir_rio_e_ponte() -> void:
	# Rio de névoa: uma faixa baixa, translúcida e luminosa cortando o vale.
	var rio := MeshInstance3D.new()
	rio.mesh = _malha_caixa(Vector3(32, 0.4, 7), mat_nevoa)
	rio.position = Vector3(0, 0.25, -30)
	add_child(rio)

	_criar_ponte_quebrada(Vector3(0, 0, -30))


func _criar_ponte_quebrada(centro: Vector3) -> void:
	# Dois pilares de pedra erguem-se da névoa.
	for px in [-5.0, 5.0]:
		var pilar := StaticBody3D.new()
		pilar.position = centro + Vector3(px, 0, 0)
		add_child(pilar)
		_caixa_solida(pilar, Vector3(1.2, 4.0, 1.2), Vector3(0, 2.0, 0), mat_pedra)

	# Dois meios-tabuleiros inclinados sobem das margens, mas NÃO se encontram:
	# a ponte está quebrada no meio. São apenas visuais (cenário por cima).
	var deck_esq := _malha_caixa(Vector3(7, 0.5, 3), mat_pedra)
	_malha(self, deck_esq, centro + Vector3(-4.0, 3.2, 0), Vector3(0, 0, -14))
	var deck_dir := _malha_caixa(Vector3(7, 0.5, 3), mat_pedra)
	_malha(self, deck_dir, centro + Vector3(4.0, 3.2, 0), Vector3(0, 0, 14))

	# Parapeitos quebrados sobre cada metade.
	_malha(self, _malha_caixa(Vector3(7, 0.6, 0.25), mat_pedra), centro + Vector3(-4.0, 4.0, 1.4), Vector3(0, 0, -14))
	_malha(self, _malha_caixa(Vector3(7, 0.6, 0.25), mat_pedra), centro + Vector3(4.0, 4.0, 1.4), Vector3(0, 0, 14))


# ============================================================================
# PONTOS DE INTERESSE (textos de lore para a EXPLORAÇÃO)
# ============================================================================

func _criar_pontos_de_interesse() -> void:
	# Cada item é [posição, texto]. O texto aparece no HUD ao se aproximar.
	var pontos := [
		[Vector3(0, 1.5, 29), "Vila de Côvado das Sombras. Os portões estão abertos... mas ninguém veio recebê-lo."],
		[Vector3(0, 1.5, 9), "O poço seco. No fundo, apenas escuridão — e um cheiro antigo de ferro."],
		[Vector3(-22, 1.5, -11), "Cemitério da vila. As lápides são recentes demais para uma vila tão silenciosa."],
		[Vector3(-31, 1.5, -11), "Capela em ruínas. Uma única vela ainda arde no altar. Quem a acendeu?"],
		[Vector3(0, 1.5, -13), "A velha torre. A única janela acesa fica no alto, longe demais para mãos humanas. Talvez asas alcancem... (vire morcego com T e voe com Espaço)"],
		# Lugares de beleza triste
		[Vector3(34, 1.5, 6), "Jardim das Lamentações. As flores brancas ainda florescem — as únicas que sobraram vivas em todo o vale."],
		[Vector3(34, 1.5, 0), "Uma estátua de mármore chora água escura, sem parar, há anos. Dizem que ela chora por todos os que partiram."],
		[Vector3(-34, 1.5, 19), "A velha biblioteca perdeu o teto, mas não o silêncio. A lua entra pela abertura e lê as páginas que ninguém mais lê."],
		[Vector3(0, 1.5, -39), "O salão de baile do castelo. Aqui houve música, risos e luzes. Agora só o luar dança entre as colunas."],
		[Vector3(0, 1.5, -27), "A ponte sobre o rio de névoa, partida ao meio. Quem quiser alcançar o outro lado... precisa de asas."],
		# Rota de ascensão (parkour + voo)
		[Vector3(17, 5.5, 27), "A Ascensão começa aqui. Suba pelas plataformas e paredes — mas o último salto será alto demais para pernas humanas."],
		[Vector3(25, 13.5, 28), "Daqui o abismo é grande demais. Vire MORCEGO (T), voe até a luz azul, POUSE e volte a vampiro (T) para continuar lá no alto."],
		[Vector3(26, 27, 44), "O ponto mais alto do vale. Daqui se vê tudo o que um dia foi belo — e o silêncio que restou."],
	]
	for ponto in pontos:
		_criar_ponto_interesse(ponto[0], ponto[1])


func _criar_ponto_interesse(pos: Vector3, texto: String) -> void:
	var area := Area3D.new()
	area.position = pos
	area.set_script(ScriptPontoInteresse)
	area.texto = texto

	var colisao := CollisionShape3D.new()
	var forma := SphereShape3D.new()
	forma.radius = 3.5
	colisao.shape = forma
	area.add_child(colisao)

	add_child(area)
