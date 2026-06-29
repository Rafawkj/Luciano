# hud.gd
# ----------------------------------------------------------------------------
# HUD (interface na tela). Fica preso ao CanvasLayer "HUD".
#
# Mostra, no canto superior esquerdo:
#   - A forma atual (Vampiro / Morcego).
#   - Uma barra com o tempo de voo restante (fica vermelha quando acaba).
#   - O estado do pulo duplo (pronto / disponível / usado).
#
# Os widgets são criados por CÓDIGO em _ready(), para a cena ficar simples.
# O rótulo de lore (MensagemLabel) continua vindo da cena.
# ----------------------------------------------------------------------------

extends CanvasLayer

const LARGURA_BARRA := 200.0

var jogador: Node = null

var forma_label: Label
var pulo_label: Label
var voo_titulo: Label
var barra_fundo: ColorRect
var barra_preench: ColorRect


func _ready() -> void:
	jogador = get_tree().get_first_node_in_group("player")
	_criar_widgets()


func _criar_widgets() -> void:
	forma_label = _novo_label(Vector2(24, 22))

	voo_titulo = _novo_label(Vector2(24, 52))
	voo_titulo.text = "Voo"

	barra_fundo = ColorRect.new()
	barra_fundo.color = Color(0, 0, 0, 0.55)
	barra_fundo.position = Vector2(70, 54)
	barra_fundo.size = Vector2(LARGURA_BARRA, 16)
	add_child(barra_fundo)

	barra_preench = ColorRect.new()
	barra_preench.color = Color(0.55, 0.75, 1.0, 0.95)
	barra_preench.position = Vector2(70, 54)
	barra_preench.size = Vector2(LARGURA_BARRA, 16)
	add_child(barra_preench)

	pulo_label = _novo_label(Vector2(24, 80))


func _novo_label(pos: Vector2) -> Label:
	var l := Label.new()
	l.position = pos
	# Cor clara com sombra escura, para ler bem sobre qualquer fundo.
	l.add_theme_color_override("font_color", Color(0.92, 0.9, 0.84))
	l.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
	l.add_theme_constant_override("shadow_offset_x", 2)
	l.add_theme_constant_override("shadow_offset_y", 2)
	add_child(l)
	return l


func _process(_delta: float) -> void:
	if jogador == null:
		return

	var morcego: bool = jogador.eh_morcego()
	forma_label.text = "Forma: " + ("Morcego" if morcego else "Vampiro") + "   (T troca)"

	# Barra de voo: largura proporcional ao tempo restante; vermelha quando baixo.
	var f: float = jogador.fracao_voo()
	barra_preench.size.x = LARGURA_BARRA * f
	if f < 0.25:
		barra_preench.color = Color(1.0, 0.45, 0.3, 0.95)
	else:
		barra_preench.color = Color(0.55, 0.75, 1.0, 0.95)

	# Estado do pulo duplo (só relevante como vampiro).
	if morcego:
		pulo_label.text = "Segure Espaco para voar"
		pulo_label.add_theme_color_override("font_color", Color(0.92, 0.9, 0.84))
	elif jogador.is_on_floor():
		pulo_label.text = "Pulo duplo: pronto"
		pulo_label.add_theme_color_override("font_color", Color(0.7, 0.9, 0.7))
	elif jogador.pulo_duplo_disponivel():
		pulo_label.text = "Pulo duplo: disponivel"
		pulo_label.add_theme_color_override("font_color", Color(0.7, 0.9, 0.7))
	else:
		pulo_label.text = "Pulo duplo: usado"
		pulo_label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
