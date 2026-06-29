# janela_alta.gd
# ----------------------------------------------------------------------------
# Fica preso a uma Area3D colocada na sacada da JANELA ALTA da torre.
#
# Essa área detecta quando o JOGADOR entra nela. Como a janela fica muito alta,
# só é possível chegar lá VOANDO na forma de morcego — o pulo do vampiro não
# alcança. Ao chegar, mostramos uma mensagem na tela (HUD) e no console.
# ----------------------------------------------------------------------------

extends Area3D

# Mensagem exibida ao alcançar a janela. Editável no Inspetor.
@export var mensagem: String = "Você alcançou a janela alta da torre! 🦇 Só dá pra chegar voando como morcego."

# Garante que a mensagem só apareça uma vez.
var ja_alcancada: bool = false


func _ready() -> void:
	# Conecta o sinal "body_entered": ele dispara quando um corpo físico
	# (como o jogador) entra nesta área.
	body_entered.connect(_ao_entrar_corpo)


func _ao_entrar_corpo(corpo: Node3D) -> void:
	if ja_alcancada:
		return

	# Só reage ao jogador (que está no grupo "player").
	if corpo.is_in_group("player"):
		ja_alcancada = true
		print(mensagem)

		# Procura o rótulo do HUD (no grupo "hud_mensagem") e mostra a mensagem.
		var rotulo := get_tree().get_first_node_in_group("hud_mensagem")
		if rotulo:
			rotulo.text = mensagem
