# TERRAVIVA — Multiplayer Competitivo e Arquitetura Técnica

> **Documento 13 · Fase 6 — Direção Técnica**

---

## 1. Fundamento: determinismo como superpoder técnico

O jogo inteiro (incluindo o Crepúsculo e os Instintos) é uma **função pura**: `estado' = f(estado, ações_dos_jogadores)`. Zero RNG em resolução (a única entropia é a ordem inicial dos baralhos, semeada pelo servidor). Consequências:

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
| Backend | Serviços stateless (matchmaking, contas, decks) + partidas em processos leves | Escala horizontal; uma partida ≈ um ator |
| Persistência | Postgres (contas/decks/MMR) + object storage para replays | Padrão, auditável |

## 3. Funcionalidades competitivas

- **Matchmaking:** MMR Glicko-2 **oculto** (só pareamento; sem ranks visíveis); proteção de novato (pool separado nas primeiras 20 partidas); salas por código de 6 letras para jogar com amigos.
- **Reconexão:** estado completo reidratável do log de ações; 90 s de janela com relógio pausado 1×/partida; bot NÃO assume (princípio: ninguém perde para "seu próprio bot").
- **Relógio:** 25 s/ficha + banco de 90 s por jogador (formato "xadrez rápido"); configurável em salas por código.
- **Espectador:** delay de 2 min (anti-ghosting), overlay com zonas de Sentinela, alcances, recursos e Influência de ambos — o estado 100% aberto é *feito* para transmissão.
- **Replay:** scrubbing por rodada, visão de qualquer lado, exportável e compartilhável por código curto.
- **Anti-cheat comportamental:** detecção de conluio/win-trading por grafos de partidas; relatórios in-client com follow-up visível.
- **Rotação de mapa:** o mapa vigente da fila rápida troca mensalmente (hexes selvagens novos = meta fresco sem tocar em cartas). Sem ligas, sem temporadas de recompensa — o MMR oculto só pareia jogos justos.

## 4. Competitivo de comunidade (sem infraestrutura de liga própria)
- O jogo não tem torneios nem ligas oficiais in-client — mas as **salas por código + replays exportáveis + espectador** são deliberadamente suficientes para a comunidade organizar torneios por fora (o modelo do xadrez online).
- API pública de replay/estatísticas para sites de comunidade.
- Overlay de espectador com "linhas de ameaça" (alcances, Instintos armados e Pavios — mostra o que PODE acontecer).

## 5. REVISÃO CRÍTICA (Fase 6 — técnica)
- **Risco: animações de Crepúsculo/Instintos somadas a rodadas longas.** *Mitigação:* velocidade 1×/2×/instantânea (online default 2×); animações paralelas, nunca sequenciais por entidade.
- **Risco: core em Rust + cliente Unity = fricção de FFI.* *Decisão:* aceita; o custo é pago uma vez e o ganho (regras únicas, replays eternos, WASM para web/ferramentas de comunidade) define o produto. Protótipo da ponte na primeira sprint técnica (risco desce cedo).
- **Risco: setas de intenção públicas podem poluir a tela no late game.** *Mitigação de UX:* setas agregadas por "história" (hover para detalhe), modo minimalista para MMR alto.

**Veredicto:** aprovado.
