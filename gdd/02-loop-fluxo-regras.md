# TERRAVIVA — Loop Principal, Fluxo de Partida e Regras Núcleo

> **Documento 02 · Fase 1 — Fundação**

---

## 1. Loop principal (macro → micro)

### 1.1 Loop de partida (12–20 min)
```
Preparar reino → Expandir território → Provocar/explorar o ecossistema
      ↑                                              ↓
Recompensa cosmética ← Vitória/derrota ← Converter vantagem em dano ou Domínio
```

### 1.2 Loop de rodada (~90 s)
```
AURORA (produção + compra) → AÇÕES (alternadas, 3 fichas cada) → PULSO (o mundo vive) → CREPÚSCULO (limpeza)
```

### 1.3 Loop de decisão (a cada ficha de ação, ~10 s)
```
Ler intenções do ecossistema → Antecipar o Pulso → Agir (carta/mover/ordem) → Reavaliar
```

O prazer central do jogo mora no loop 1.3: **cada ação é uma aposta sobre como o mundo vai reagir** — mas uma aposta calculável, nunca sorteada.

---

## 2. Setup da partida

1. Cada jogador traz um baralho de **40 cartas** (regras de construção: §7).
2. O tabuleiro 9×5 inicia com: **Corações do Reino** nas colunas 1 e 9 (linha central), 6 hexes de **Campo** demarcados como território inicial de cada jogador, e **3 hexes selvagens** pré-definidos pelo "mapa da temporada" (ex.: um Lago central) — iguais para ambos, conhecidos antes do matchmaking (zero sorte de mapa).
3. Mulligan: cada jogador olha 4 cartas, devolve quantas quiser, compra substitutas (uma vez).
4. Recursos iniciais: 2 Comida, 2 Matéria, 0 Essência.
5. Sorteia-se apenas **quem tem a iniciativa na rodada 1** (ela alterna a cada rodada; o segundo recebe +1 Matéria de compensação — nosso "coin" é recurso, não carta aleatória).

## 3. Estrutura da rodada

### Fase 1 — AURORA (automática, ~5 s)
- Cada hex de território produtivo gera recursos (Doc. 08).
- Cada jogador compra pelo **Duplo Horizonte**: revela as 2 cartas do topo do próprio baralho, escolhe 1 para a mão, a outra vai para o fundo. (Mão máxima: 8; excedente vai ao fundo do baralho, não é destruído.)
- Efeitos "no início da rodada" resolvem em ordem de iniciativa.

### Fase 2 — AÇÕES (alternadas)
- Cada jogador tem **3 Fichas de Ação**. Alternando (iniciativa age primeiro), cada ficha permite UMA das opções:
  1. **Jogar uma carta** (pagando o custo em recursos);
  2. **Emitir uma Ordem** a uma criatura própria (mover até a Velocidade dela, atacar, ou usar habilidade ativa);
  3. **Trabalhar**: uma criatura ociosa coleta o recurso do hex em que está (mesmo sem tag de coletor);
  4. **Passar** (guarda a ficha como 1 recurso de escolha, máx. 1 por rodada — passar nunca é puramente perda).
- Jogar cartas **não** é limitado por "1 por turno": é limitado por fichas e recursos. Turnos rápidos, decisões densas.

### Fase 3 — PULSO (automática, determinística, ~8 s de animação)
O mundo vive. Resolução em **camadas fixas** (ordem pública e imutável — Doc. 06):
```
1. Clima avança/atualiza tags dos hexes
2. Plantas e fungos crescem/espalham
3. Coletores e engenheiros trabalham
4. Presas fogem
5. Predadores caçam
6. Guardiões reposicionam
7. Construções produzem/disparam
8. Armadilhas armadas verificam gatilhos
9. Efeitos de fim de Pulso (veneno, queimadura, cura de descanso)
```
Dentro de cada camada, resolve primeiro o jogador com iniciativa; empates espaciais seguem ordem de leitura do tabuleiro (noroeste → sudeste). **Zero aleatoriedade.**

### Fase 4 — CREPÚSCULO (~2 s)
- Verificação de vitória; contagem de Marcos de Domínio; troca de iniciativa; criaturas que não agiram nem trabalharam **dormem** (curam 1 se em território aliado).

## 4. Condições de vitória

1. **Conquista:** reduzir a Vitalidade do Coração inimigo (25) a 0.
2. **Domínio:** completar **3 Marcos** (manter cada um por uma AURORA inteira, não simultâneos):
   - **Marco da Abundância** — controlar 12+ hexes de território;
   - **Marco da Prosperidade** — produzir 8+ recursos numa única Aurora;
   - **Marco do Equilíbrio** — ter 5+ criaturas vivas E nenhuma ter sofrido dano na rodada anterior.
3. **Deck vazio ≠ derrota:** o baralho recicla o descarte com penalidade (−1 Vitalidade no Coração por reciclagem) — partidas não terminam por atrito de compra, mas empatar/enrolar tem custo crescente.

**Racional:** Conquista é o plano agressivo; Domínio é o plano de construtor e o contrapeso natural contra tartarugas — quem só defende perde o mapa.

## 5. Regras de território

- Um hex é **seu território** se estiver conectado ao seu Coração por uma cadeia de hexes seus e contiver (ou for adjacente a) uma entidade sua.
- Território determina: onde você pode **jogar cartas** (qualquer hex seu ou adjacente a ele), produção na Aurora e Marcos.
- Terrenos jogados sobre hexes tornam-nos permanentemente daquele tipo (o terreno é do mapa; o **controle** é de quem o cerca — território pode ser conquistado sem destruir nada).
- **Hexes selvagens** não pertencem a ninguém e abrigam recursos ricos: o meio do mapa é o prêmio e o campo de batalha natural.

## 6. Regras de combate (resumo — completo no Doc. 07)

- Ataque compara **ATQ do atacante vs DEF do defensor**: dano = ATQ − DEF (mínimo 1 se o ataque conectar). Sem dados.
- **Retaliação:** defensor corpo-a-corpo vivo contra-ataca com metade do ATQ (arredonda para baixo), exceto contra alcance maior.
- Terreno e clima modificam ATQ/DEF/Velocidade por **tags**, nunca por texto caso-a-caso.
- Criaturas **bloqueiam** hexes; corredores e gargalos importam. Peso limita quem atravessa pontes, pântanos etc.

## 7. Construção de baralho

| Regra | Valor | Racional |
|---|---|---|
| Tamanho | 40 exatas | Consistência alta (Pilar 3) |
| Cópias | Máx. 2 | Menos "auto-pilot", mais adaptação |
| Heróis | Exatamente 1 (começa fora do baralho, invocável quando condição pessoal for cumprida) | Identidade do deck sem loteria de compra |
| Facções | 1 facção principal + até 8 cartas **Neutras** | Identidade forte, espaço para tech cards (Pilar 9) |
| Terrenos | Mínimo 6 cartas de Terreno | Garante que todo deck participa da guerra de mapa |

## 8. Informação e honestidade

- Únicas informações ocultas: **mãos** e **Armadilhas** (jogadas viradas para baixo, com custo pago às claras).
- Intenções do Pulso são exibidas como **setas fantasma** para ambos os jogadores durante a fase de Ações. Ler o mundo é habilidade; adivinhar não é.

---

## 9. REVISÃO CRÍTICA DA FASE 1 — Regras (auto-avaliação)

1. **Problema detectado: "Trabalhar" podia tornar criaturas baratas melhores que construções.** *Correção:* Trabalhar gera exatamente 1 recurso e a criatura fica `Exausta` (não retalia até o próximo turno). Construções produzem sem ocupar fichas. Balanço registrado no Doc. 12.
2. **Problema: 3 fichas + cartas ilimitadas por ficha podia explodir o tempo de turno.** *Correção:* ficha é o limitador universal (máx. 3 ações/rodada/jogador) + relógio de 25 s por ficha no ranqueado. Ritmo previsto: rodada ≤ 90 s.
3. **Problema: reciclagem de deck podia viabilizar stall infinito.** *Correção:* penalidade de reciclagem é **cumulativa** (−1, depois −2, −3...). Stall tem prazo de validade matemático.
4. **Problema: Marco do Equilíbrio incentivava passividade.** *Correção:* exige 5+ criaturas EM CAMPO, o que força desenvolvimento e expõe alvos — não dá para "esconder e vencer".
5. **Dúvida em aberto (para Fase 2):** presas fugirem ANTES de predadores caçarem (ordem 4→5) favorece defesa. Decisão mantida por ora: recompensa antecipação do caçador (cercar antes de caçar), que é gameplay mais rico que "soltar lobo = abate garantido". Reavaliar no playtest de papel.

**Veredicto:** regras núcleo aprovadas. Fase 2 liberada.
