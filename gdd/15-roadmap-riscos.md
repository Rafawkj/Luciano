# GUERRA DOS REINOS — Roadmap, Plano de Expansão e Riscos de Design

> **Documento 15 · Fase 6 — Produção**

---

## 1. Roadmap de desenvolvimento

| Fase | Duração | Entregas | Gate de saída |
|---|---|---|---|
| **P0 — Papel** | 6 sem. | Protótipo físico (print & play), 3 facções (Fogo, Gelo, Humano) | 20 partidas seguidas divertidas sem árbitro confuso |
| **P1 — Protótipo digital** | 3 meses | Core Rust das regras + cliente feio jogável; Sandbox interno | Determinismo validado; ponte Rust↔engine provada |
| **P2 — Vertical slice** | 4 meses | 3 facções com arte final, 60 cartas, Casual online, replay | "Momento aha" mensurado com 30 novatos (≥70% jogam sem ajuda após o tutorial) |
| **P3 — Alpha fechado** | 4 meses | 6 facções, 220 cartas oficiais, fila online com MMR oculto, telemetria de balance | WR de facções 45–55%; retenção D7 ≥ 25% no grupo de teste |
| **P4 — Beta aberto** | 3 meses | Tutorial (4 lições), salas por código, replays, mobile | Estabilidade; ≥70% dos novatos completam o tutorial |
| **Lançamento 1.0** | — | Menu final (Criação de Deck · Jogar · Tutorial), modos Normal/Rápido/Caos | — |
| **Pós-lançamento** | contínuo | Trimestral: mini-set (35 cartas) + Eventos Caóticos novos; Anual: expansão grande | — |

## 2. Plano de expansão (anos 1–3)

- **Mini-sets trimestrais:** +5 cartas por facção e +5 neutras (35), sempre dentro dos 4 tipos fixos (Tropas, Feitiços, Construções, Terrenos).
- **Exp. 1 — "Estação das Crias":** tema de filhotes e crescimento — Tropas-ovo que chocam por condição (nenhum tipo novo de carta, nunca).
- **Exp. 2 — "Marés Vivas":** 7ª facção (aquática, arquivada das versões antigas).
- **Exp. 3 — "O Relógio Desperta":** 8ª facção (autômatos, arquivada das versões antigas).
- **Regra de governança (inegociável):** cada expansão pode adicionar **no máx. 1 palavra-chave nova** — crescimento por combinação, não por vocabulário (anti-creep cognitivo). Rotação: formato "Estação" (últimos 2 anos) + "Perene" (tudo); cartas nunca são apagadas.

## 3. Riscos de design & soluções (registro vivo)

| # | Risco | Prob. | Impacto | Solução/mitigação |
|---|---|---|---|---|
| 1 | Vantagem de quem começa (menos turnos no Rápido) | Média | Alto | 1º jogador não compra no turno 1; telemetria de WR por lado |
| 2 | Complexidade de entrada | Baixa | Alto | Manual de 10 min; tutorial de 4 lições + Partida Livre com desfazer; 15 palavras-chave fechadas |
| 3 | Turnos lentos no mobile | Baixa | Médio | Relógio de 45 s, animações 2×, partidas ≤ 15 min |
| 4 | Meta resolvido rápido | Média | Alto | Mini-sets trimestrais; rotação mensal de Eventos Caóticos em destaque; 15 pares de facção |
| 5 | Snowball de campo (quem domina o campo vence sempre) | Média | Médio | Feitiços de dano em área e Debandada; Guarda barata; teto de 4 Tropas |
| 6 | Sangrento (Pacto) bimodal por habilidade | Média | Médio | Watch-list (Pacto Maior); curva de Vida auditada |
| 7 | Monetização: coleção grátis + sem passes = receita só de cosméticos opcionais | Alta | Alto (negócio) | Skins de clima/tabuleiro/tropas em loja simples; preço justo de venda do jogo é o plano B (modelo "jogo de tabuleiro digital"); NUNCA reverter para P2W/quests |
| 8 | Comparação injusta com a obra inspiradora ("é o jogo do desenho?") | Baixa | Médio | IP 100% original auditado (nomes, criaturas, termos); a inspiração é estrutural (tabuleiro vivo), não de conteúdo; revisão jurídica de todo o set antes do anúncio |
| 9 | Escopo de 6 facções no lançamento | Baixa | Médio | Gate P3: se produção derrapar, lançar com 5 e entregar a 6ª no primeiro patch grande (decisão pré-autorizada) |
| 10 | Animações artesanais estourarem orçamento | Alta | Médio | 6 shaders de material reutilizados em tudo; personalidade via timing e som (baratos), não frames únicos |

## 4. REVISÃO CRÍTICA (Fase 6 — produção)
- O roadmap posiciona os DOIS riscos fatais (1 e 2) nos gates mais baratos (P0 e P2) — falhar cedo é a estratégia.
- Dívida declarada: plano de live-ops (eventos semanais) ainda raso; detalhar em pré-produção de P4.
- Decisão pré-autorizada do risco 9 registrada para blindar o time contra "crunch por orgulho de número redondo".

**Veredicto:** aprovado.
