# TERRAVIVA — Documento de Visão Geral

> **Documento 01 · Fundação** · Versão 0.2 (revisão de direção: sem fase automática; 6 facções)

---

## 1. Elevator Pitch

**TERRAVIVA** é um jogo de cartas estratégico tático em que cada partida constrói um pequeno reino vivo sobre um tabuleiro de hexágonos. Você planta florestas, ergue muralhas, comanda criaturas — e o mundo **reage com lógica natural**: água apaga fogo, gelo congela lagos, doce atrai formigas, mortos-vivos se reerguem em solo profano. Nada acontece sozinho: **cada movimento é seu**. A profundidade vem do terreno, do clima e das leis do mundo, não de fases automáticas nem de sorte.

> **Tagline:** *"Seu reino, suas ordens, um mundo que reage."*

## 2. Fantasia central do jogador

O jogador é um **Regente** — o comandante de um reino em miniatura:

- *"Eu construí este canto do mapa e agora ele me alimenta."*
- *"Eu ataquei com fogo a floresta dele no turno exato em que a seca chegou."*
- *"O exército dele congelou no lago porque EU quebrei o gelo."*

Um mundo em miniatura carismático em cima da mesa, com regras levadas a sério — e IP, nomes e universo 100% originais.

## 3. Ficha técnica

| Campo | Definição |
|---|---|
| Gênero | Card game tático competitivo com tabuleiro |
| Plataformas | PC, mobile (iOS/Android), cross-play e cross-progression |
| Sessão-alvo | 12 a 20 minutos por partida |
| Público-alvo | 12+, jogadores de estratégia e card games |
| Modelo de negócio | Coleção completa desde a instalação; sem quests, passes ou progressão; cosméticos opcionais |
| Modo principal | 1v1 (offline contra IA ou online) · Menu: Criação de Deck · Jogar · Tutorial |
| Direção visual | Cartoon estilizado, silhuetas fortes, animação exagerada |

## 4. Os três diferenciais

### 4.1 O tabuleiro é o reino
Grade de hexágonos compartilhada onde terreno, posição e território importam. Economia **é** tabuleiro: recursos nascem de hexes que podem ser conquistados, queimados ou comidos. Não existe mana.

### 4.2 Léxico Natural
Um conjunto fechado e público de leis do mundo (água apaga fogo, metal conduz raio, doce gruda, o profano reergue os mortos). As cartas carregam tags; as leis fazem o resto. Combos **emergem** do mundo em vez de serem escritos carta a carta — fácil de aprender, fundo de dominar.

### 4.3 Controle total, zero sorte de resolução
Sem dados, sem efeitos aleatórios, sem fases automáticas: toda ação da partida é uma decisão de um jogador. A única aleatoriedade é a ordem do próprio baralho — mitigada pela compra "Duplo Horizonte" (veja 2, escolha 1) e pelo mulligan.

## 5. Resumo do sistema

- **Tabuleiro:** hexes 9×5; **Coração do Reino** (base, 25 de Vitalidade) em extremos opostos; hexes selvagens ricos no centro.
- **Vitória:** destruir o Coração inimigo **ou** completar 3 **Marcos de Domínio** (vitória territorial do construtor).
- **Rodada:** **Aurora** (produção + compra) → **Ações alternadas** (3 fichas por jogador) → **Crepúsculo** (efeitos de estado resolvem: fogo espalha, veneno pinga, plantas crescem — tudo previsível e impresso nas regras).
- **Cartas — exatamente 5 categorias:** **Tropas, Construções, Terrenos, Feitiços e Climas** (Doc. 07).
- **Baralho:** 40 cartas, máx. 2 cópias, 1 Tropa Lendária com condição pública, até 8 Neutras.
- **Facções (6):** **Gelados · Doces · Sangrentos · Natureza · Fogo · Humanos** — cada uma muda estruturalmente a forma de jogar (Doc. 08).

## 6. Pilares de design (contrato inegociável)

| # | Pilar | Teste prático |
|---|---|---|
| 1 | Fácil de aprender | Carta entendida numa leitura; efeito previsível pela lógica natural |
| 2 | Difícil de dominar | Toda carta tem decisão de posicionamento/tempo não-óbvia |
| 3 | Baixa dependência de sorte | Zero dados; RNG só na ordem do baralho, mitigada |
| 4 | Profundidade estratégica | Carta interage com terreno, clima ou leis — no mínimo dois |
| 5 | Potencial competitivo | Estado 100% legível (informação oculta: só mão e armadilhas) |
| 6 | Potencial para eSports | Espectador entende o lance assistindo |
| 7 | Rejogabilidade | Mapa evolui diferente a cada partida |
| 8 | Combos criativos | Sinergias emergem do Léxico, não de texto "peça A + peça B" |
| 9 | Contrajogo universal | Toda estratégia tem ≥ 2 respostas em facções diferentes |
| 10 | Diversão acima do realismo | A lógica serve à leitura e ao humor |

## 7. Posicionamento competitivo

| Concorrente | Onde TERRAVIVA se diferencia |
|---|---|
| Hearthstone | Sem RNG de efeitos; tabuleiro posicional com terreno |
| MTG Arena | Regras emergem de leis naturais, não de centenas de keywords; partidas curtas |
| Legends of Runeterra | Interação via território e terreno, não só pilha de respostas |
| Marvel Snap | Profundidade tática; zero aleatoriedade de locais |
| Faeria / Duelyst | Economia territorial + clima global + Léxico Natural |

**Espaço em branco:** nenhum card game competitivo grande ocupa o quadrante *"tabuleiro-território com leis naturais públicas e zero RNG de resolução"*.

## 8. Universo e tom

O continente **Terraviva** é uma terra viva onde seis grandes reinos disputam a regência: o inverno eterno dos **Gelados**, o reino confeitado dos **Doces**, a corte profana dos **Sangrentos**, o bosque sem dono da **Natureza**, as fornalhas do **Fogo** e as muralhas versáteis dos **Humanos**. Tom: aventura cartoon com sinceridade épica — engraçado nas bordas, sério nas regras.

---

## 9. REVISÃO CRÍTICA (registro da mudança de direção v0.2)

1. **Corte do "Pulso do Reino"** (fase automática de ecossistema, v0.1): removido por decisão de produto — risco de o jogador sentir que "o jogo joga sozinho" e custo alto de leitura. **O que foi preservado:** a sensação de mundo vivo migra para (a) leis naturais passivas do Léxico, (b) efeitos de estado resolvidos no Crepúsculo de forma fixa e impressa, e (c) **Instintos** — habilidades reativas das criaturas que disparam em resposta a eventos (interceptar, contra-atacar, colher ao passar) sempre sob gatilhos públicos. Agência 100% do jogador.
2. **Redução de 12 → 6 facções:** foco de produção e identidades mais fortes e arquetípicas (Gelo/Doce/Morte/Natureza/Fogo/Humano são legíveis instantaneamente por qualquer público). As 6 cortadas ficam arquivadas como candidatas de expansão.
3. **Set inicial reduzido para 90 cartas (15 por facção):** menos vocabulário no lançamento, curadoria maior por carta, custo de coleção menor para o jogador novo.

**Veredicto:** direção v0.2 aprovada; documentos seguintes atualizados.
