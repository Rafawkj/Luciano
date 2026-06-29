# tocha.gd
# ----------------------------------------------------------------------------
# Faz uma luz "tremular" como a chama de uma tocha, criando clima sombrio.
# É colocado em uma OmniLight3D (luz pontual). A energia da luz oscila de leve
# o tempo todo, imitando o bruxulear do fogo.
# ----------------------------------------------------------------------------

extends OmniLight3D

# Brilho médio da chama.
@export var energia_base: float = 2.2
# Quanto o brilho varia para cima/baixo.
@export var variacao: float = 0.7
# Velocidade do tremular.
@export var velocidade: float = 11.0

# Contador interno de tempo (para a onda do seno).
var _tempo: float = 0.0


func _process(delta: float) -> void:
	_tempo += delta * velocidade
	# Combina uma onda suave (seno) com um pouco de aleatoriedade,
	# para a chama não tremular de forma perfeitamente regular.
	var oscilacao := sin(_tempo) * 0.5 + (randf() - 0.5)
	light_energy = energia_base + oscilacao * variacao
