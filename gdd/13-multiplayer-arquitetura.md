# TERRAVIVA — Multiplayer Competitivo e Arquitetura Técnica

> **Documento 13 · Fase 6 — Direção Técnica**

---

## 1. Fundamento: determinismo como superpoder técnico

O jogo inteiro (incluindo o Pulso) é uma **função pura**: `estado' = f(estado, ações_dos_jogadores)`. Zero RNG em resolução (a única entropia é a ordem inicial dos baralhos, semeada pelo servidor). Consequências:

- **Servidor autoritativo barato:** o servidor só valida ações e re-executa `f`; o cliente prevê localmente (rollback trivial, pois não há segredo na resolução).
- **Replays = lista de ações** (kilobytes). Qualquer partida é reproduzível bit a bit para sempre (inclusive entre versões, com versionamento de regras).
- **Anti-cheat estrutural:** não existe estado oculto no cliente além da mão do oponente e ocultos — que NUNCA são enviados ao cliente até revelação. Wallhack é impossível por arquitetura, não por vigilância.
- **Simulação massiva** para balance e IA (Docs. 10/12).

## 2. Stack sugerida

| Camada | Escolha | Racional |
|---|---|---|
| Core de regras | **Rust** (crate compartilhado, compilado para servidor + WASM no cliente) | Determinismo, performance, um único source of truth das regras |
| Cliente | Unity (C# chamando o core via FFI/WASM) ou Godot | Cartoon 2.5D, pipeline de animação forte, mobile-first |
| Rede | WebSocket + protocolo de ações compacto (protobuf/flatbuffers) | Turnos: latência tolerante; reconexão simples |
| Backend | Serviços stateless (matchmaking, ligas, coleção) + partidas em processos leves | Escala horizontal; uma partida ≈ um ator |
| Persistência | Postgres (contas/coleção/ligas) + object storage para replays | Padrão, auditável |

## 3. Funcionalidades competitivas

- **Matchmaking:** MMR Glicko-2; fila por modo; proteção de novato (pool separado nas primeiras 20 partidas); duo-block de smurfing por sinais de conta.
- **Reconexão:** estado completo reidratável do log de ações; 90 s de janela com relógio pausado 1×/partida; bot NÃO assume (princípio: ninguém perde para "seu próprio bot").
- **Relógio:** 25 s/ficha + banco de 90 s por jogador (formato "xadrez rápido"); ranked de torneio usa banco 60 s.
- **Espectador:** delay de 2 min (anti-ghosting), overlay com setas de intenção do Pulso, recursos e Influência de ambos — o Pulso é *feito* para transmissão: a fase automática é o "replay da jogada" que narradores adoram.
- **Replay:** scrubbing por rodada, visão de qualquer lado, exportável e compartilhável por código curto.
- **Anti-cheat comportamental:** detecção de conluio/win-trading por grafos de partidas; relatórios in-client com follow-up visível.
- **Temporadas:** 3 meses; soft reset de liga (não de MMR); recompensas cosméticas por pico de liga; mapa da temporada rotaciona (hexes selvagens novos = meta fresco sem tocar em cartas).

## 4. eSports (desenho desde o dia 1)
- Cliente de torneio: lobbies, pick/ban de facções (BO3: ban 1 pick 2), decks abertos por fase de torneio.
- API pública de replay/estatísticas para sites de comunidade.
- Overlay de caster com "previsão do Pulso" (mostra o que VAI acontecer — drama instantâneo para narração).
- Formato âncora: **Conquista Dupla** — BO3 onde cada vitória por Domínio vale seed melhor no chaveamento (incentiva variedade de plano de jogo no competitivo).

## 5. REVISÃO CRÍTICA (Fase 6 — técnica)
- **Risco: animação do Pulso (8 s) somada a rodadas longas.** *Mitigação:* Pulso tem velocidade 1×/2×/instantânea (ranked default 2×); animações paralelas por camada, nunca sequenciais por entidade.
- **Risco: core em Rust + cliente Unity = fricção de FFI.* *Decisão:* aceita; o custo é pago uma vez e o ganho (regras únicas, replays eternos, WASM para web/ferramentas de comunidade) define o produto. Protótipo da ponte na primeira sprint técnica (risco desce cedo).
- **Risco: setas de intenção públicas podem poluir a tela no late game.** *Mitigação de UX:* setas agregadas por "história" (hover para detalhe), modo minimalista para MMR alto.

**Veredicto:** aprovado.
