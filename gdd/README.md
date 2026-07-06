# GUERRA DOS REINOS — Game Design Document

> **Jogo de cartas de fantasia maluca** · IP original · Mundo: Terraviva · **v0.5**
> *"Fantasia maluca. Guerra de verdade."*

Duelo 1v1 rápido e engraçado: 30 de Vida, Energia que cresce sozinha, campo com 4 Tropas + 2 Construções + 1 Terreno, 15 palavras-chave. Manual completo aprende-se em 10 minutos; a profundidade vem das 6 facções.

## As 6 facções (+ Neutros)

| Facção | Reino | Estilo | Mecânica especial |
|---|---|---|---|
| ❄ Gelo | Reino Glacial | Defesa e controle | **Frio Acumulado** (3 marcadores = Congelada e −1 ATQ) |
| 🔥 Fogo | Chama Selvagem | Agressivo e explosivo | **Chama Alta** (ativa se bateu na cara neste turno) |
| 🍬 Doce | Império Açucarado | Suporte e combos fofos | **Açúcar** (2 marcadores = +1/+1) |
| 🩸 Sangrento | Clã Rubro | Risco alto, recompensa alta | **Pacto X** (pague Vida por poder) |
| 🌿 Natureza | Bosque Vivo | Quantidade e crescimento | **Semente** (0/1 que vira Broto 1/2) |
| ⚔ Humano | Ordem dos Aventureiros | Tática e versatilidade | **Preparar** (ativa com Construção em campo) |
| 🎒 Neutros | Errantes de Terraviva | Completam qualquer deck | — |

## Estrutura do GDD

| Doc | Conteúdo |
|---|---|
| [01](01-visao-geral.md) | Visão geral, pilares, posicionamento |
| [02](02-manual-de-regras.md) | **MANUAL DE REGRAS COMPLETO** (o coração do projeto) |
| [08](08-faccoes.md) | As 6 facções + contrajogo |
| [cartas/](cartas/00-formato-e-indice.md) | **Set "Primeira Guerra": 115 cartas** (15 por facção + 25 neutras) |
| [10](10-balanceamento.md) | Balanceamento e watch-list |
| [11](11-modos-progressao.md) | Menu (Criação de Deck · Jogar · Tutorial); sem quests nem progressão |
| [12](12-ia-oponentes.md) | IA de oponentes (5 perfis, erros humanos) |
| [13](13-multiplayer-arquitetura.md) | Online, anti-cheat, arquitetura |
| [14](14-ux-arte-audio-narrativa.md) | UX/UI, arte, áudio, narrativa |
| [15](15-roadmap-riscos.md) | Roadmap, expansões, riscos |
| [16](16-partidas-exemplo.md) | Partida completa comentada (Fogo × Gelo) |
| [17](17-glossario.md) | Glossário completo |
| [18](18-identidade-visual.md) | **Identidade visual "O Diorama Vivo"** (+ [mockup](mockups/identidade-visual.html)) |

## Identidade em 3 linhas
1. **Regras de 10 minutos, profundidade de anos** — 4 tipos de carta, 15 palavras-chave, 6 facções que jogam completamente diferente.
2. **Humor de verdade** — Regra da Diversão no manual, Modo Caos, flavors com piada, ovelhas táticas.
3. **O Diorama Vivo** — visual de maquete artesanal: cada facção é um material real (lã, glacê, veludo, musgo, ferro, retalho).

## Histórico de direção
- **v0.5 (atual)** — adoção do manual "Guerra dos Reinos" do diretor: Energia única, campo de slots, 15 palavras-chave, modos Normal/Rápido/Caos. Personagens, facções e direção de arte preservados.
- **v0.4** — menu mínimo (Criação de Deck · Jogar · Tutorial); sem quests/progressão.
- **v0.3** — 5 categorias de carta; 25 neutras.
- **v0.2** — fim da fase automática; 6 facções.
- **v0.1** — conceito original (hexágonos, ecossistema, 12 facções, 150 cartas).
