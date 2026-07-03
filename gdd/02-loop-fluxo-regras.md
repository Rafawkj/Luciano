# TERRAVIVA — Loop Principal, Fluxo de Partida e Regras Núcleo

> **Documento 02 · Fundação** · v0.2 (sem fase automática)

---

## 1. Loop principal

### 1.1 Loop de partida (12–20 min)
```
Preparar reino → Expandir território → Converter vantagem em dano ou Domínio → Vitória/derrota
```

### 1.2 Loop de rodada (~80 s)
```
AURORA (produção + compra) → AÇÕES (alternadas, 3 fichas cada) → CREPÚSCULO (estados resolvem)
```

### 1.3 Loop de decisão (a cada ficha, ~10 s)
```
Ler o mapa e o clima → Antecipar as leis do mundo → Agir → Reavaliar
```

## 2. Setup da partida

1. Baralho de **40 cartas** (regras: §7).
2. Tabuleiro 9×5: **Corações** nas colunas 1 e 9 (linha central); 6 hexes de Campo iniciais por jogador; **3 hexes selvagens** centrais definidos pelo mapa da temporada (públicos antes do matchmaking — zero sorte de mapa).
3. Mulligan: olhe 4, devolva quantas quiser, compre substitutas (uma vez).
4. Recursos iniciais: 2 Comida, 2 Matéria, 0 Essência.
5. Sorteia-se só a **iniciativa da rodada 1** (alterna a cada rodada; o segundo ganha +1 Matéria).

## 3. Estrutura da rodada

### Fase 1 — AURORA (automática, ~5 s)
- Hexes produtivos do seu território geram recursos (Doc. 03/06).
- Compra pelo **Duplo Horizonte**: revele 2 do topo, escolha 1, a outra vai ao fundo. (Mão máx.: 8.)

### Fase 2 — AÇÕES (alternadas)
Cada jogador tem **3 Fichas de Ação**; alternando (iniciativa primeiro), cada ficha permite UMA opção:
1. **Jogar uma carta** (pagando o custo);
2. **Ordem**: uma criatura sua move (até VEL), ataca ou usa a habilidade ativa;
3. **Trabalhar**: criatura ociosa coleta o recurso do hex (fica `Exausta`);
4. **Passar** (guarda a ficha como 1 recurso à escolha; máx. 1×/rodada).

Sem limite de "1 carta por turno": fichas e recursos são os limitadores. **Instintos** (habilidades reativas impressas, ex.: Guardião intercepta) disparam durante as ações de qualquer jogador, por gatilhos públicos — interação constante sem fase extra.

### Fase 3 — CREPÚSCULO (automática, ~4 s)
Apenas **contabilidade de estados**, em ordem fixa e pública:
```
1. Clima avança (duração −1) e aplica seu efeito de rodada
2. Fogo espalha para `Inflamável` adjacente e queima (Lei 2)
3. Veneno pinga; regeneração/crescimento (Enraizados sobem 1 estágio)
4. Fome: criaturas com Fome consomem Comida ou ficam `Faminto`
5. Verificação de vitória; Marcos; troca de iniciativa
```
Nenhuma criatura se move ou ataca aqui. O Crepúsculo nunca decide nada: só executa consequências já visíveis.

## 4. Condições de vitória

1. **Conquista:** Vitalidade do Coração inimigo (25) a 0.
2. **Domínio:** completar **3 Marcos** (cada um mantido por uma Aurora inteira):
   - **Abundância** — controlar 12+ hexes;
   - **Prosperidade** — produzir 8+ recursos numa Aurora;
   - **Equilíbrio** — 5+ criaturas vivas e nenhuma danificada na rodada anterior.
3. **Deck vazio:** recicla o descarte com penalidade cumulativa de Vitalidade (−1, −2, −3...) — anti-stall estrutural.

## 5. Regras de território

- Hex é **seu** se conectado ao seu Coração por hexes seus e com entidade sua nele ou adjacente.
- Você joga cartas em território seu ou adjacente a ele.
- Terrenos transformam hexes permanentemente; o **controle** é de quem cerca.
- Hexes selvagens produzem +1 e dão Influência: o centro é o prêmio.

## 6. Combate (resumo — Doc. 05)

- Dano = ATQ − DEF (mínimo 1 se elegível). Sem dados.
- **Retaliação:** defensor corpo-a-corpo sobrevivente devolve ⌊ATQ/2⌋.
- Terreno e clima modificam por tags; corpos bloqueiam hexes; Peso limita travessias.

## 7. Construção de baralho

| Regra | Valor | Racional |
|---|---|---|
| Tamanho | 40 exatas | Consistência (Pilar 3) |
| Cópias | Máx. 2 | Adaptação > repetição |
| Lendas | Exatamente 1 **Tropa Lendária** (entra por quest pública + Influência 7) | Identidade sem loteria |
| Facções | 1 facção + até 8 cartas **Neutras** (cartas/05) | Identidade + espaço de tech |
| Terrenos | Mínimo 5 cartas de Terreno | Todo deck participa da guerra de mapa |

## 8. Informação

Ocultos: **mãos** e **Feitiços ocultos** (Armadilhas/Maldições; custo pago às claras; máx. 2 armados). Todo o resto é público — inclusive quests de Lenda e contagens.

---

## 9. REVISÃO CRÍTICA (v0.2)

1. **Sem a fase automática, de onde vem a interação fora do seu turno?** Dos **Instintos** (reativos, gatilho público), das Armadilhas, dos Feitiços `Reflexo` e da alternância por ficha (ninguém fica 60 s assistindo). Testar em papel se 3 fichas alternadas bastam para sensação de "jogo vivo"; se não, avaliar 4 fichas.
2. **Crepúsculo ainda é uma mini-fase automática — contradiz a mudança?** Não: é bookkeeping de efeitos que OS JOGADORES criaram (fogo que VOCÊ pôs, veneno que VOCÊ aplicou), padrão do gênero, sem movimento nem decisão. Mantido com esta fronteira escrita: **nenhuma criatura age no Crepúsculo, nunca.**
3. **Marco do Equilíbrio** revalidado sem Pulso: segue exigindo 5+ criaturas em campo — inalterado.

**Veredicto:** aprovado.
