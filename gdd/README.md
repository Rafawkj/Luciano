# TERRAVIVA — Game Design Document

> **Card game estratégico de reinos vivos** · IP original · Documento mestre do estúdio · **v0.3**
> *"Seu reino, suas ordens, um mundo que reage."*

Jogo de cartas tático competitivo em tabuleiro de hexágonos: terrenos, clima e leis naturais públicas (o **Léxico**) no lugar de mana e de centenas de keywords. Universo, nomes, regras e cartas 100% originais.

## As 6 facções

| Facção | Identidade | Mecânica exclusiva |
|---|---|---|
| **Gelados** | Controle de ritmo, inverno paciente | Zero (congelamento cirúrgico) |
| **Doces** | Boom econômico confeitado e frágil ao clima | Glacê + Rush de Açúcar |
| **Sangrentos** | Vampiros, zumbis e esqueletos; a morte como recurso | Reerguer + Drenar (pagam em VIDA e Cadáveres) |
| **Natureza** | Crescimento e inevitabilidade verde | Estágios (broto→copa→ancião) |
| **Fogo** | Agressão com fatura | Sacrifício + Pavio |
| **Humanos** | Versatilidade, muralhas e conversão | Formação + Milícia |

## Estrutura do GDD

| Doc | Conteúdo |
|---|---|
| [01](01-visao-geral.md) | Visão geral, pilares, posicionamento de mercado |
| [02](02-loop-fluxo-regras.md) | Loop, fluxo de partida, regras núcleo, vitória |
| [03](03-tabuleiro-terrenos-clima.md) | Tabuleiro 9×5, 10 terrenos, 7 climas |
| [04](04-lexico-natural-ia-criaturas.md) | **Léxico Natural** (14 tags, 10 leis) e **Instintos** (8 reações) |
| [05](05-combate.md) | Combate determinístico |
| [06](06-economia.md) | Economia territorial (Comida/Matéria/Essência + Influência) |
| [07](07-categorias-de-cartas.md) | As **5 categorias** de cartas: Tropas, Construções, Terrenos, Feitiços, Climas |
| [08](08-faccoes.md) | As 6 facções, cartas neutras e matriz de contrajogo |
| [cartas/](cartas/00-formato-e-indice.md) | **Set "Primeira Regência": 115 cartas (15 por facção + 25 neutras)** |
| [10](10-balanceamento.md) | Balanceamento (anti power creep) |
| [11](11-modos-progressao.md) | Modos de jogo; progressão 100% cosmética |
| [12](12-ia-oponentes.md) | IA de oponentes (5 perfis, erros humanos deliberados) |
| [13](13-multiplayer-arquitetura.md) | Multiplayer, eSports, anti-cheat, arquitetura técnica |
| [14](14-ux-arte-audio-narrativa.md) | UX/UI, arte, áudio, narrativa |
| [15](15-roadmap-riscos.md) | Roadmap, expansões, riscos e soluções |
| [16](16-partidas-exemplo.md) | Duas partidas completas comentadas |
| [17](17-glossario.md) | Glossário completo |

## Os 3 diferenciais em uma linha cada
1. **O tabuleiro é o reino** — economia territorial sem mana: recursos nascem de hexes que podem ser conquistados, queimados ou comidos.
2. **Léxico Natural** — 10 leis públicas (água apaga fogo, doce atrai gulosos, o sagrado repele o profano...) substituem centenas de textos de carta; os combos emergem do mundo.
3. **Zero sorte de resolução** — sem dados, sem RNG de efeitos, sem fases autônomas: cada ação é uma decisão de um jogador; o mundo apenas **reage** (Instintos e Crepúsculo, sempre previsíveis).

## Histórico de direção
- **v0.3 (atual)** — categorias reduzidas a 5 (**Tropas, Construções, Terrenos, Feitiços, Climas**); Heróis viram Tropas Lendárias; Artefatos/Totens cortados; +25 cartas neutras (set: 115).
- **v0.2** — Pulso removido (agência 100% do jogador; mundo reativo via Instintos + Crepúsculo); 6 facções (Gelados, Doces, Sangrentos, Natureza, Fogo, Humanos); 90 cartas.
- **v0.1** — 12 facções, fase automática de ecossistema ("Pulso do Reino"), 150 cartas. Decisões registradas nas revisões críticas de cada documento.
