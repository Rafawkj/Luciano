# GUERRA DOS REINOS — Multiplayer Competitivo e Arquitetura Técnica

> **Documento 13 · Fase 6 — Direção Técnica**

---

## 1. Fundamento: determinismo como superpoder técnico

O jogo inteiro é uma **função pura**: `estado' = f(estado, ações_dos_jogadores)`. Toda aleatoriedade (ordem do baralho, alvos "aleatórios", Eventos Caóticos) vem de uma única seed do servidor. Consequências:

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
- **Relógio:** 45 s por turno + banco de 60 s por jogador (formato "xadrez rápido"); configurável em salas por código.
- **Espectador:** delay de 2 min (anti-ghosting), overlay com Energia, mãos contadas e Armadilhas marcadas (sem revelar) — o estado 100% aberto é *feito* para transmissão.
- **Replay:** scrubbing por rodada, visão de qualquer lado, exportável e compartilhável por código curto.
- **Anti-cheat comportamental:** detecção de conluio/win-trading por grafos de partidas; relatórios in-client com follow-up visível.
- **Rotação de mapa:** o Evento Caótico em destaque e o Terreno neutro da vitrine trocam mensalmente (meta fresco sem tocar em cartas). Sem ligas, sem temporadas de recompensa — o MMR oculto só pareia jogos justos.

## 4. Competitivo de comunidade (sem infraestrutura de liga própria)
- O jogo não tem torneios nem ligas oficiais in-client — mas as **salas por código + replays exportáveis + espectador** são deliberadamente suficientes para a comunidade organizar torneios por fora (o modelo do xadrez online).
- API pública de replay/estatísticas para sites de comunidade.
- Overlay de espectador com "linhas de ameaça" (dano letal disponível, Armadilhas armadas — mostra o que PODE acontecer).

## 5. REVISÃO CRÍTICA (Fase 6 — técnica)
- **Risco: animações de efeitos somadas a turnos longos.** *Mitigação:* velocidade 1×/2×/instantânea (online default 2×); animações paralelas, nunca sequenciais por entidade.
- **Risco: core em Rust + cliente Unity = fricção de FFI.* *Decisão:* aceita; o custo é pago uma vez e o ganho (regras únicas, replays eternos, WASM para web/ferramentas de comunidade) define o produto. Protótipo da ponte na primeira sprint técnica (risco desce cedo).
- **Risco: leitura do campo com 4+4 Tropas, 2+2 Construções e efeitos:** hierarquia visual rígida (Doc. 14) e log de partida sempre acessível.

**Veredicto:** aprovado.
