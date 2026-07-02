# TERRAVIVA — Game Design Document

> **Card game estratégico de reinos vivos** · IP original · Documento mestre do estúdio
> *"Cada carta vive. Cada hex respira."*

Jogo de cartas tático competitivo inspirado exclusivamente na filosofia de gameplay de "tabuleiro vivo" (unidades com comportamento próprio, terrenos que importam, ecossistema com lógica) — com universo, nomes, regras e cartas 100% originais.

## Estrutura do GDD

| Doc | Conteúdo | Fase |
|---|---|---|
| [01](01-visao-geral.md) | Visão geral, pilares de design, posicionamento de mercado | 1 |
| [02](02-loop-fluxo-regras.md) | Loop principal, fluxo de partida, regras núcleo, vitória | 1 |
| [03](03-tabuleiro-terrenos-clima.md) | Tabuleiro 9×5, os 12 terrenos, os 8 climas | 2 |
| [04](04-lexico-natural-ia-criaturas.md) | **Léxico Natural** (16 tags, 10 leis) e IA das criaturas (10 comportamentos, moral) | 2 |
| [05](05-combate.md) | Sistema de combate determinístico | 2 |
| [06](06-economia.md) | Economia territorial (Comida/Matéria/Essência + Influência) | 3 |
| [07](07-categorias-de-cartas.md) | As 14 categorias de cartas | 3 |
| [08](08-faccoes.md) | As 12 facções + matriz de contrajogo | 4 |
| [cartas/](cartas/00-formato-e-indice.md) | **Set inicial "Primeiro Pulso": 150 cartas originais** | 5 |
| [10](10-balanceamento.md) | Filosofia e processo de balanceamento (anti power creep) | 6 |
| [11](11-modos-progressao.md) | 10 modos de jogo; progressão 100% cosmética | 6 |
| [12](12-ia-oponentes.md) | IA de oponentes (5 perfis, erros humanos deliberados) | 6 |
| [13](13-multiplayer-arquitetura.md) | Multiplayer, eSports, anti-cheat, arquitetura técnica | 6 |
| [14](14-ux-arte-audio-narrativa.md) | UX/UI, direção de arte, áudio, narrativa | 6 |
| [15](15-roadmap-riscos.md) | Roadmap, plano de expansão, riscos e soluções | 6 |
| [16](16-partidas-exemplo.md) | Duas partidas completas comentadas | 6 |
| [17](17-glossario.md) | Glossário completo | 6 |

## Os 3 diferenciais em uma linha cada
1. **O Pulso do Reino** — após as ações dos jogadores, o ecossistema inteiro vive um turno automático, determinístico e previsível: caçadas, colheitas, crescimento, fugas.
2. **Economia territorial sem mana** — recursos nascem de hexes que podem ser conquistados, queimados ou comidos.
3. **Léxico Natural** — 10 leis públicas (água apaga fogo, metal conduz raio, raízes quebram muralhas...) substituem centenas de textos de carta; os combos emergem do mundo.

## Metodologia
Desenvolvido em 6 fases, cada uma encerrada com **revisão crítica interna** (problemas, correções e cortes registrados ao fim de cada documento) antes de liberar a seguinte — o histórico de decisões faz parte do GDD.
