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


func _ready() -> void:
	_criar_materiais()
	_construir_casas()
	_construir_praca_e_portao()
	_construir_cemiterio()
	_espalhar_arvores_mortas()
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
		# Casa isolada a oeste
		[Vector3(-22, 0, 4), 100.0],
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
	]
	for pos in tochas:
		_criar_tocha(pos)


func _criar_casa(pos: Vector3, graus: float) -> void:
	var casa := StaticBody3D.new()
	casa.position = pos
	casa.rotation_degrees = Vector3(0, graus, 0)
	add_child(casa)

	# Paredes (caixa sólida) e telhado em forma de prisma.
	_caixa_solida(casa, Vector3(5, 3.2, 5), Vector3(0, 1.6, 0), mat_parede)
	var telhado := PrismMesh.new()
	telhado.size = Vector3(5.8, 2.2, 5.8)
	telhado.material = mat_telhado
	_malha(casa, telhado, Vector3(0, 4.3, 0))

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
# PONTOS DE INTERESSE (textos de lore para a EXPLORAÇÃO)
# ============================================================================

func _criar_pontos_de_interesse() -> void:
	# Cada item é [posição, texto]. O texto aparece no HUD ao se aproximar.
	var pontos := [
		[Vector3(0, 1.5, 29), "Vila de Côvado das Sombras. Os portões estão abertos... mas ninguem veio recebê-lo."],
		[Vector3(0, 1.5, 9), "O poço seco. No fundo, apenas escuridão — e um cheiro antigo de ferro."],
		[Vector3(-22, 1.5, -11), "Cemitério da vila. As lápides são recentes demais para uma vila tão silenciosa."],
		[Vector3(-31, 1.5, -11), "Capela em ruínas. Uma única vela ainda arde no altar. Quem a acendeu?"],
		[Vector3(0, 1.5, -13), "A velha torre. A única janela acesa fica no alto, longe demais para mãos humanas. Talvez asas alcancem... (vire morcego com T e voe com Espaço)"],
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
