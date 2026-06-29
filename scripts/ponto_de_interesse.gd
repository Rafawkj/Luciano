# ponto_de_interesse.gd
# ----------------------------------------------------------------------------
# Um "ponto de interesse" de EXPLORAÇÃO. É uma Area3D invisível colocada em
# lugares marcantes da vila (portão, poço, cemitério, capela, torre...).
#
# Quando o JOGADOR entra na área, mostramos um texto de "lore" no HUD, ajudando
# a contar a história do lugar e reforçar a atmosfera. Ao sair, o texto some.
# ----------------------------------------------------------------------------

extends Area3D

# Texto que aparece ao se aproximar deste ponto. Pode ter várias linhas.
@export_multiline var texto: String = ""


func _ready() -> void:
	# body_entered / body_exited disparam quando um corpo (o jogador) entra/sai.
	body_entered.connect(_ao_entrar)
	body_exited.connect(_ao_sair)


func _ao_entrar(corpo: Node3D) -> void:
	if corpo.is_in_group("player"):
		_definir_texto_hud(texto)


func _ao_sair(corpo: Node3D) -> void:
	if corpo.is_in_group("player"):
		_definir_texto_hud("")


func _definir_texto_hud(valor: String) -> void:
	# Procura o rótulo do HUD (grupo "hud_mensagem") e atualiza o texto.
	var rotulo := get_tree().get_first_node_in_group("hud_mensagem")
	if rotulo:
		rotulo.text = valor
