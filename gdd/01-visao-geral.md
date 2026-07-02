# TERRAVIVA — Documento de Visão Geral

> **Documento 01 · Fase 1 — Fundação**
> Estúdio: Projeto Terraviva · Versão 0.1 · Status: Em revisão interna

---

## 1. Elevator Pitch

**TERRAVIVA** é um jogo de cartas estratégico tático em que cada partida constrói um pequeno reino vivo. Você não joga cartas sobre uma mesa vazia: você planta florestas, ergue muralhas, solta criaturas que caçam, dormem, constroem e protegem território **por conta própria**. Depois que os dois jogadores agem, o mundo **pulsa** — e todo o ecossistema do tabuleiro vive um instante de vida real, seguindo regras naturais consistentes.

> **Tagline:** *"Cada carta vive. Cada hex respira."*

## 2. Fantasia central do jogador

O jogador é um **Regente** — não um mago que gasta mana, mas o administrador de um reino em miniatura. A fantasia não é "eu lanço feitiços", e sim:

- *"Eu construí este canto do mapa e agora ele me alimenta."*
- *"Meus lobos caçaram as ovelhas dele sozinhos, porque eu posicionei a floresta no lugar certo."*
- *"A chuva chegou e o meu plano inteiro mudou — e o dele também."*

A emoção-alvo é a mesma sensação de um episódio clássico de desenho animado sobre jogos de tabuleiro épicos: **um mundo em miniatura absurdamente vivo em cima da mesa**, levado a sério pelos jogadores e com carisma transbordando — mas com IP, regras, nomes e universo 100% originais.

## 3. Ficha técnica

| Campo | Definição |
|---|---|
| Gênero | Card game tático competitivo com tabuleiro vivo |
| Plataformas | PC, mobile (iOS/Android), tablets — cross-play e cross-progression |
| Sessão-alvo | 12 a 20 minutos por partida |
| Público-alvo | 12+, jogadores de estratégia e card games; segundo público: fãs de simulação/ecossistemas |
| Modelo de negócio | Free-to-play, monetização **somente cosmética** (ver Doc. 14) |
| Modo principal | 1v1 competitivo ranqueado |
| Direção visual | Cartoon estilizado, silhuetas fortes, animação exagerada (ver Doc. 19) |
| Motor sugerido | Unity ou Godot com simulação determinística em servidor (ver Doc. 17) |

## 4. Os três diferenciais (por que TERRAVIVA não é "mais um card game")

### 4.1 O Pulso do Reino
Todo turno termina com o **Pulso**: uma fase automática em que todas as entidades do tabuleiro executam seu comportamento natural (caçar, fugir, construir, coletar, crescer, dormir). Nenhum outro card game competitivo tem um "tick de ecossistema" como mecânica central. O jogador não controla o Pulso — ele o **prepara**. Dominar TERRAVIVA é dominar a arte de posicionar intenções.

### 4.2 Economia territorial, sem mana
Não existe mana. Recursos (**Comida, Matéria, Essência**) são produzidos pelo território que você controla e pelas criaturas/construções que trabalham nele. Sua "curva" não é um contador que sobe sozinho: é um reino que você cultiva e que o oponente pode atacar, ocupar ou sabotar. Economia **é** tabuleiro.

### 4.3 Mundo com lógica natural
Água apaga fogo. Lobos caçam ovelhas. Fungos se espalham na umidade. Metal conduz raio. O jogo tem um **Léxico Natural** (Doc. 06 e 07): um conjunto fechado e público de regras ecológicas que valem para todas as cartas, sempre. Nada acontece "porque o texto da carta diz"; acontece porque o mundo funciona assim. Isso torna o jogo profundamente intuitivo de aprender e profundamente rico de dominar.

## 5. Resumo do sistema (visão de helicóptero)

- **Tabuleiro:** grade de hexágonos 9×5 compartilhada. Cada jogador tem um **Coração do Reino** (base) em extremos opostos. Hexes começam como Campos neutros; jogadores jogam **cartas de Terreno** que transformam o mapa permanentemente.
- **Vitória:** destruir o Coração inimigo (25 de Vitalidade) **ou** completar 3 **Marcos de Domínio** (vitória por influência territorial — a "vitória do bom regente").
- **Turnos:** rodadas com fases **Aurora** (produção + compra), **Ações** (alternadas, 3 fichas por jogador) e **Pulso** (o mundo vive). Iniciativa alterna a cada rodada.
- **Cartas:** 14 categorias (Criaturas, Heróis, Construções, Terrenos, Eventos, Clima, Relíquias, Artefatos, Maldições, Invocações, Companheiros, Totens, Armadilhas, Tecnologias — Doc. 09).
- **Baralho:** 40 cartas, máximo 2 cópias, 1 Herói. Compra com **Duplo Horizonte** (veja 2 do topo, escolha 1) para reduzir variância.
- **Facções:** 12, cada uma com economia, comportamento e plano de jogo estruturalmente diferentes (Doc. 10).

## 6. Pilares de design (contrato inegociável)

Todo sistema, carta e mecânica futura deve passar por estes dez testes. Se falhar em um, volta para a prancheta.

| # | Pilar | Teste prático |
|---|---|---|
| 1 | Fácil de aprender | Um jogador novo entende a carta lendo-a uma vez? O comportamento é previsível pela lógica natural? |
| 2 | Difícil de dominar | Existe decisão não-óbvia de posicionamento/tempo associada? |
| 3 | Baixa dependência de sorte | Zero dados; RNG restrito à ordem do baralho, mitigada por Duplo Horizonte e mulligan. O Pulso é 100% determinístico. |
| 4 | Profundidade estratégica | A carta interage com terreno, clima E comportamento — no mínimo dois dos três. |
| 5 | Potencial competitivo | O estado do jogo é 100% legível pelos dois jogadores? (Sem informação oculta além da mão e armadilhas.) |
| 6 | Potencial para eSports | Um espectador entende o lance assistindo? A jogada tem "leitura de replay"? |
| 7 | Rejogabilidade | Mapa evolui diferente a cada partida; clima e terrenos criam contextos novos. |
| 8 | Combos criativos | Sinergias emergem do Léxico Natural, não de texto "combo peça A + peça B". |
| 9 | Contrajogo universal | Toda estratégia tem pelo menos 2 respostas em facções diferentes, com custo justo. |
| 10 | Diversão acima do realismo | A lógica natural serve à leitura e ao humor, nunca à simulação pura. Porcos comem plantações porque é engraçado E estratégico. |

## 7. Posicionamento competitivo

| Concorrente | O que ele domina | Onde TERRAVIVA se diferencia |
|---|---|---|
| Hearthstone | Acessibilidade, polish | Sem RNG de efeitos; tabuleiro posicional vivo |
| MTG Arena | Profundidade, coleção | Regras emergem de lógica natural, não de 200 keywords; partidas mais curtas |
| Legends of Runeterra | Interatividade turno-a-turno | Interação via território e ecossistema, não só pilha de respostas |
| Marvel Snap | Sessão curta, tensão | Profundidade tática de longo prazo; zero aleatoriedade de locais |
| Faeria / Duelyst | Tabuleiro tático | Entidades autônomas (Pulso) + economia territorial + clima global |
| Clash Royale | Leitura em tempo real | Turnos táticos, mas com a mesma sensação de "unidades vivas andando" |

**Espaço em branco no mercado:** nenhum card game competitivo importante ocupa o quadrante *"tabuleiro-ecossistema com unidades autônomas e economia territorial"*. Esse é o nosso terreno.

## 8. Universo e tom (resumo — detalhes no Doc. 20)

O mundo de **Terraviva** é um continente-organismo: a própria terra está viva e sonha. Os reinos que os jogadores erguem são "sonhos acordados" da terra, disputando qual visão de mundo florescerá. O tom é **aventura cartoon com sinceridade épica**: colorido, engraçado nas bordas (uma ovelha que rola morro abaixo), mas 100% sério nas regras e no competitivo.

Nomes, criaturas, terras e facções são inteiramente originais deste IP.

---

## 9. REVISÃO CRÍTICA DA FASE 1 (auto-avaliação do estúdio)

**Problemas identificados e correções aplicadas:**

1. **Risco: duas condições de vitória confundem novatos.** *Mitigação:* Marcos de Domínio só destravam visualmente após a rodada 4 e são apresentados como "medalhas" no tutorial; a vitória por destruição permanece o caminho default. Mantido, pois vitória alternativa é o contrajogo essencial contra decks-fortaleza ultradefensivos (Pilar 9).
2. **Risco: Pulso automático tirar agência ("o jogo joga sozinho").** *Correção de enquadramento:* comportamento é sempre **determinístico e previsível** — a UI mostra setas de intenção antes do fim do turno. O Pulso nunca decide nada aleatório; ele executa o que os jogadores armaram. Regra escrita no Doc. 06.
3. **Risco: economia de 3+ recursos pesada demais para mobile.** *Correção:* reduzido de um rascunho inicial com 10 recursos para **3 recursos universais + 1 trilha (Influência)**. Os 10 conceitos econômicos pedidos no briefing viram sabores por facção (Fé, Conhecimento etc. são **mecânicas de facção** sobre a Essência, não moedas separadas). Registrado no Doc. 08.
4. **Inconsistência:** o pitch prometia "centenas de interações de clima" sem sistema que as sustente. *Correção:* clima não terá texto por carta; altera **tags do Léxico Natural** (ex.: Chuva dá `Molhado` a todos os hexes) e as interações emergem — escala sem inflar regras. Doc. 05.
5. **Pendência aceita para Fase 2:** definir exatamente o orçamento de complexidade do Pulso (quantos comportamentos distintos no lançamento). Decisão preliminar: **10 comportamentos** no set base.

**Veredicto:** fundação aprovada. Avançar para Fase 2 (sistemas do mundo).
