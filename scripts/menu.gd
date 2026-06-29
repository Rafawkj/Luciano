# menu.gd
# ----------------------------------------------------------------------------
# MENU DE OPÇÕES (pausa o jogo). Abre e fecha com a tecla ESC.
#
# Permite, principalmente para rodar bem em PCs mais fracos:
#   - Reduzir a QUALIDADE GRÁFICA (Baixa / Média / Alta): desliga glow, névoa
#     volumétrica, sombras e usa escala de renderização menor no nível Baixa.
#   - Ajustar o VOLUME geral e o VOLUME do som ambiente (buses separados).
#   - Ajustar a SENSIBILIDADE do mouse.
#   - Voltar ao jogo ou sair.
#
# A interface é criada por CÓDIGO em _ready(), para a cena ficar simples.
# ----------------------------------------------------------------------------

extends CanvasLayer

var aberto: bool = false
var raiz: Control  # contêiner inteiro que mostramos/escondemos

# Referências aos sistemas que o menu ajusta.
var ambiente: WorldEnvironment
var luz: DirectionalLight3D
var jogador: Node


func _ready() -> void:
	# O menu precisa funcionar mesmo com o jogo pausado.
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 20  # acima do HUD

	var mundo := get_parent()
	ambiente = mundo.get_node_or_null("WorldEnvironment")
	luz = mundo.get_node_or_null("LuzDirecional")
	jogador = get_tree().get_first_node_in_group("player")

	_construir_interface()
	_aplicar_qualidade(2)  # começa em "Alta"
	_fechar()


func _unhandled_input(event: InputEvent) -> void:
	# ESC (ui_cancel) abre/fecha o menu.
	if event.is_action_pressed("ui_cancel"):
		if aberto:
			_fechar()
		else:
			_abrir()
		get_viewport().set_input_as_handled()


# ============================================================================
# ABRIR / FECHAR (pausa o jogo e libera o mouse)
# ============================================================================

func _abrir() -> void:
	aberto = true
	raiz.visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _fechar() -> void:
	aberto = false
	raiz.visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# ============================================================================
# CONSTRUÇÃO DA INTERFACE
# ============================================================================

func _construir_interface() -> void:
	raiz = Control.new()
	raiz.set_anchors_preset(Control.PRESET_FULL_RECT)
	raiz.mouse_filter = Control.MOUSE_FILTER_STOP  # bloqueia cliques no jogo
	add_child(raiz)

	# Fundo escurecido.
	var fundo := ColorRect.new()
	fundo.color = Color(0, 0, 0, 0.65)
	fundo.set_anchors_preset(Control.PRESET_FULL_RECT)
	raiz.add_child(fundo)

	# Caixa central com os controles.
	var caixa := VBoxContainer.new()
	caixa.anchor_left = 0.5
	caixa.anchor_right = 0.5
	caixa.anchor_top = 0.5
	caixa.anchor_bottom = 0.5
	caixa.offset_left = -230
	caixa.offset_right = 230
	caixa.offset_top = -210
	caixa.offset_bottom = 210
	caixa.add_theme_constant_override("separation", 14)
	raiz.add_child(caixa)

	var titulo := Label.new()
	titulo.text = "Opções"
	titulo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	titulo.add_theme_font_size_override("font_size", 34)
	caixa.add_child(titulo)

	# Qualidade gráfica.
	var opcao_qual := OptionButton.new()
	opcao_qual.add_item("Baixa")
	opcao_qual.add_item("Média")
	opcao_qual.add_item("Alta")
	opcao_qual.selected = 2
	opcao_qual.item_selected.connect(_aplicar_qualidade)
	caixa.add_child(_linha("Qualidade gráfica", opcao_qual))

	# Volume geral.
	var s_geral := _slider(1.0)
	s_geral.value_changed.connect(_on_volume_geral)
	caixa.add_child(_linha("Volume geral", s_geral))

	# Volume do som ambiente.
	var s_amb := _slider(1.0)
	s_amb.value_changed.connect(_on_volume_ambiente)
	caixa.add_child(_linha("Volume ambiente", s_amb))

	# Sensibilidade do mouse.
	var s_sens := _slider(0.45)
	s_sens.value_changed.connect(_on_sensibilidade)
	caixa.add_child(_linha("Sensibilidade do mouse", s_sens))

	# Botões.
	var btn_voltar := Button.new()
	btn_voltar.text = "Voltar ao jogo"
	btn_voltar.pressed.connect(_fechar)
	caixa.add_child(btn_voltar)

	var btn_sair := Button.new()
	btn_sair.text = "Sair do jogo"
	btn_sair.pressed.connect(func(): get_tree().quit())
	caixa.add_child(btn_sair)

	# Aplica a sensibilidade inicial (o valor padrão do slider).
	_on_sensibilidade(0.45)


# Monta uma linha "rótulo + controle".
func _linha(texto: String, controle: Control) -> HBoxContainer:
	var linha := HBoxContainer.new()
	linha.add_theme_constant_override("separation", 12)

	var rotulo := Label.new()
	rotulo.text = texto
	rotulo.custom_minimum_size = Vector2(200, 0)
	linha.add_child(rotulo)

	controle.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	linha.add_child(controle)
	return linha


func _slider(valor: float) -> HSlider:
	var s := HSlider.new()
	s.min_value = 0.0
	s.max_value = 1.0
	s.step = 0.01
	s.value = valor
	s.custom_minimum_size = Vector2(180, 0)
	return s


# ============================================================================
# CALLBACKS DOS CONTROLES
# ============================================================================

func _aplicar_qualidade(nivel: int) -> void:
	var vp := get_viewport()
	var env: Environment = ambiente.environment if ambiente else null

	match nivel:
		0:  # Baixa — desliga os efeitos caros e reduz a resolução interna.
			if env:
				env.glow_enabled = false
				env.volumetric_fog_enabled = false
				env.fog_enabled = false
			if luz:
				luz.shadow_enabled = false
			vp.msaa_3d = Viewport.MSAA_DISABLED
			vp.scaling_3d_scale = 0.75
		1:  # Média — efeitos moderados.
			if env:
				env.glow_enabled = true
				env.volumetric_fog_enabled = false
				env.fog_enabled = true
			if luz:
				luz.shadow_enabled = true
			vp.msaa_3d = Viewport.MSAA_DISABLED
			vp.scaling_3d_scale = 1.0
		2:  # Alta — tudo ligado.
			if env:
				env.glow_enabled = true
				env.volumetric_fog_enabled = true
				env.fog_enabled = true
			if luz:
				luz.shadow_enabled = true
			vp.msaa_3d = Viewport.MSAA_2X
			vp.scaling_3d_scale = 1.0


func _on_volume_geral(v: float) -> void:
	# Bus "Master" é sempre o índice 0.
	AudioServer.set_bus_volume_db(0, linear_to_db(maxf(v, 0.0001)))


func _on_volume_ambiente(v: float) -> void:
	var idx := AudioServer.get_bus_index("Ambiente")
	if idx != -1:
		AudioServer.set_bus_volume_db(idx, linear_to_db(maxf(v, 0.0001)))


func _on_sensibilidade(v: float) -> void:
	if jogador and jogador.has_method("definir_sensibilidade"):
		# Mapeia o slider (0..1) para uma faixa útil de sensibilidade.
		jogador.definir_sensibilidade(lerpf(0.0008, 0.006, v))
