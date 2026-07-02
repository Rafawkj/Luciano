# TERRAVIVA — Roadmap, Plano de Expansão e Riscos de Design

> **Documento 15 · Fase 6 — Produção**

---

## 1. Roadmap de desenvolvimento

| Fase | Duração | Entregas | Gate de saída |
|---|---|---|---|
| **P0 — Papel** | 6 sem. | Protótipo físico (grade impressa + tokens), 3 facções (Fogo, Natureza, Humanos) | 20 partidas seguidas divertidas sem árbitro confuso |
| **P1 — Protótipo digital** | 3 meses | Core Rust das regras + cliente feio jogável; Sandbox interno | Determinismo validado; ponte Rust↔engine provada |
| **P2 — Vertical slice** | 4 meses | 3 facções com arte final, 45 cartas, 1 mapa, Casual online, replay | "Momento aha" do Léxico mensurado com 30 novatos (≥70% preveem interações sem ajuda) |
| **P3 — Alpha fechado** | 4 meses | 6 facções, 90 cartas, Ranked, Draft, telemetria de balance | WR de facções 45–55%; retenção D7 ≥ 25% no grupo de teste |
| **P4 — Beta aberto** | 4 meses | Campanha, Puzzle, passe, loja, mobile | Estabilidade; economia cosmética validada |
| **Lançamento 1.0** | — | 6 modos, 3 mapas de temporada, torneios custom | — |
| **Pós-lançamento** | contínuo | Trimestral: mini-set (30 cartas) + mapa novo; Anual: expansão grande | — |

## 2. Plano de expansão (anos 1–3)

- **Mini-sets trimestrais:** +5 cartas por facção (30); o primeiro estreia **Totens e Artefatos** (dívida assumida na revisão do set).
- **Exp. 1 — "Estação das Crias":** estreia dos **Companheiros** + tema de filhotes/crescimento; ovos que chocam por condição.
- **Exp. 2 — "Marés Vivas":** 7ª facção (aquática — arquivada da v0.1: controle de fluxo e empurrões).
- **Exp. 3 — "O Relógio Desperta":** 8ª facção (autômatos — arquivada da v0.1: máquinas sem Fome e sem Instinto).
- **Regra de governança (inegociável):** cada expansão pode adicionar **no máx. 2 tags e 1 Instinto** ao Léxico — crescimento por combinação, não por vocabulário (anti-creep cognitivo). Rotação: formato "Estação" (últimos 2 anos) + "Perene" (tudo); cartas nunca são apagadas.

## 3. Riscos de design & soluções (registro vivo)

| # | Risco | Prob. | Impacto | Solução/mitigação |
|---|---|---|---|---|
| 1 | Instintos/Crepúsculo percebidos como perda de controle | Baixa | Alto | Gatilhos 100% públicos, botão Prever Crepúsculo, nenhuma criatura age sozinha (fronteira escrita no Doc. 02); survey de sensação de controle |
| 2 | Complexidade de entrada (tabuleiro+eco+eco) | Alta | Alto | Léxico fechado de 16 tags/10 leis; campanha-tutorial em camadas; neutras didáticas; "Dicas do Códice" |
| 3 | Rodadas lentas no mobile | Média | Alto | 3 fichas/rodada, relógio, resoluções 2×, partidas ≤ 20 min como métrica de corte de features |
| 4 | Meta resolvido rápido (pouco RNG = decks "resolvidos") | Média | Alto | Rotação TRIMESTRAL de mapa da temporada (hexes selvagens mudam o meta sem tocar cartas — nossa válvula única); mini-sets |
| 5 | Snowball territorial | Média | Médio | Renda base do Coração; catch-up de seleção; clima como quebra simétrica; hexes ricos centrais sempre contestáveis |
| 6 | Sangrentos (custo em VIDA) bimodais por MMR | Média | Médio | Watch-list; alavanca do teto de ❤/rodada |
| 7 | Monetização cosmética insuficiente | Média | Alto (negócio) | Skins de clima/tabuleiro (categorias raras no gênero), passe, torneios; NUNCA reverter o anti-P2W (perderia a identidade) |
| 8 | Comparação injusta com a obra inspiradora ("é o jogo do desenho?") | Baixa | Médio | IP 100% original auditado (nomes, criaturas, termos); a inspiração é estrutural (tabuleiro vivo), não de conteúdo; revisão jurídica de todo o set antes do anúncio |
| 9 | Escopo de 6 facções no lançamento | Baixa | Médio | Gate P3: se produção derrapar, lançar com 5 e entregar 1 na primeira temporada (decisão pré-autorizada) |
| 10 | Animações do ecossistema estourarem orçamento | Alta | Médio | Sistema de animação por rig compartilhado por espécie; personalidade via timing e som (baratos), não frames únicos |

## 4. REVISÃO CRÍTICA (Fase 6 — produção)
- O roadmap posiciona os DOIS riscos fatais (1 e 2) nos gates mais baratos (P0 e P2) — falhar cedo é a estratégia.
- Dívida declarada: plano de live-ops (eventos semanais) ainda raso; detalhar em pré-produção de P4.
- Decisão pré-autorizada do risco 9 registrada para blindar o time contra "crunch por orgulho de número redondo".

**Veredicto:** aprovado.
