# TERRAVIVA — Roadmap, Plano de Expansão e Riscos de Design

> **Documento 15 · Fase 6 — Produção**

---

## 1. Roadmap de desenvolvimento

| Fase | Duração | Entregas | Gate de saída |
|---|---|---|---|
| **P0 — Papel** | 6 sem. | Protótipo físico (grade impressa + tokens), 4 facções, Pulso manual | 20 partidas seguidas divertidas sem árbitro confuso |
| **P1 — Protótipo digital** | 3 meses | Core Rust do Pulso + cliente feio jogável; Sandbox interno | Pulso determinístico validado; ponte Rust↔engine provada |
| **P2 — Vertical slice** | 4 meses | 4 facções com arte final, 60 cartas, 1 mapa, Casual online, replay | "Momento aha" mensurado em teste com 30 novatos (≥70% entendem o Pulso sem ajuda) |
| **P3 — Alpha fechado** | 5 meses | 12 facções, 150 cartas, Ranked, Draft, telemetria de balance | WR de facções 45–55%; retenção D7 ≥ 25% no grupo de teste |
| **P4 — Beta aberto** | 4 meses | Campanha, Puzzle, passe, loja, mobile | Estabilidade; economia cosmética validada |
| **Lançamento 1.0** | — | 6 modos, 3 mapas de temporada, torneios custom | — |
| **Pós-lançamento** | contínuo | Trimestral: mini-set (30 cartas) + mapa novo; Anual: expansão grande | — |

## 2. Plano de expansão (anos 1–3)

- **Exp. 1 — "Estação das Crias":** estreia dos **Companheiros** (dívida assumida na Fase 5) + tema de filhotes/crescimento; mini-facção mecânica: ovos que chocam por condição.
- **Exp. 2 — "Marés de Cima":** hexes de céu (camada de voo formalizada), reavaliação dos Veículos cortados; facção 13 (aérea).
- **Exp. 3 — "O Subsolo Sonha":** rede de cavernas expandida, facção 14 (subterrânea), mapas com dois "andares".
- **Regra de governança (inegociável):** cada expansão pode adicionar **no máx. 2 tags e 1 comportamento** ao Léxico — crescimento por combinação, não por vocabulário (anti-creep cognitivo). Rotação: formato "Estação" (últimos 2 anos) + "Perene" (tudo); cartas nunca são apagadas.

## 3. Riscos de design & soluções (registro vivo)

| # | Risco | Prob. | Impacto | Solução/mitigação |
|---|---|---|---|---|
| 1 | Pulso percebido como "o jogo joga por mim" | Média | Fatal | Setas de intenção, botão Prever Pulso, Ordens sempre soberanas; medir % de jogadores que sentem controle (survey + densidade de decisão) |
| 2 | Complexidade de entrada (tabuleiro+eco+eco) | Alta | Alto | Léxico fechado de 16 tags/10 leis; campanha-tutorial em camadas; neutras didáticas; "Dicas do Códice" |
| 3 | Rodadas lentas no mobile | Média | Alto | 3 fichas/rodada, relógio, Pulso 2×, partidas ≤ 20 min como métrica de corte de features |
| 4 | Meta resolvido rápido (pouco RNG = decks "resolvidos") | Média | Alto | Rotação TRIMESTRAL de mapa da temporada (hexes selvagens mudam o meta sem tocar cartas — nossa válvula única); mini-sets |
| 5 | Snowball territorial | Média | Médio | Renda base do Coração; catch-up de seleção; clima como quebra simétrica; hexes ricos centrais sempre contestáveis |
| 6 | Facção Engrenato bimodal por MMR | Média | Médio | Watch-list; alavanca de acessibilidade (custos de Laboratório) |
| 7 | Monetização cosmética insuficiente | Média | Alto (negócio) | Skins de Pulso/clima/tabuleiro (categorias inéditas), passe, torneios; NUNCA reverter o anti-P2W (perderia a identidade) |
| 8 | Comparação injusta com a obra inspiradora ("é o jogo do desenho?") | Baixa | Médio | IP 100% original auditado (nomes, criaturas, termos); a inspiração é estrutural (tabuleiro vivo), não de conteúdo; revisão jurídica de todo o set antes do anúncio |
| 9 | Escopo de 12 facções no lançamento | Alta | Alto | Gate P3: se produção derrapar, lançar com 9 e entregar 3 na primeira temporada (decisão pré-autorizada aqui para não virar crise) |
| 10 | Animações do ecossistema estourarem orçamento | Alta | Médio | Sistema de animação por rig compartilhado por espécie; personalidade via timing e som (baratos), não frames únicos |

## 4. REVISÃO CRÍTICA (Fase 6 — produção)
- O roadmap posiciona os DOIS riscos fatais (1 e 2) nos gates mais baratos (P0 e P2) — falhar cedo é a estratégia.
- Dívida declarada: plano de live-ops (eventos semanais) ainda raso; detalhar em pré-produção de P4.
- Decisão pré-autorizada do risco 9 registrada para blindar o time contra "crunch por orgulho de número redondo".

**Veredicto:** aprovado.
