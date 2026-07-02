# TERRAVIVA — Filosofia e Processo de Balanceamento

> **Documento 10 · Fase 6 — Camada Competitiva**

---

## 1. Princípios inegociáveis

1. **Nenhuma carta vence sozinha.** Toda carta L tem impacto condicionado a estado de tabuleiro construído (Heróis exigem Condição de Lenda + Influência 7 — poder é COLHEITA, nunca topdeck).
2. **Anti power creep estrutural:** o custo-mestre é uma fórmula pública interna; expansões adicionam **opções laterais** (novas combinações do Léxico), nunca números maiores. Meta de poder: carta nova ≤ 102% da eficiência média do slot que ocupa.
3. **Toda estratégia tem ≥ 2 contra-estratégias em facções distintas** (matriz do Doc. 08 §13 + tech cards neutras).
4. **Decisão > lista de forças:** se um deck vence "no piloto automático" (win rate alta com baixa variância de decisões), ele é nerfado mesmo com win rate global aceitável. Medimos **densidade de decisão** (nº de jogadas não-forçadas por partida) via telemetria.

## 2. A curva-mestra de custo (interna)

```
CustoTotal ≈ (ATQ×1.0 + DEF×0.8 + VIDA×0.5 + VEL×0.5 + (ALC−1)×1.2 + ENE×0.3)/2.2
  + Σ(tags fortes: Voador +0.5, Oculto +0.7, Venenoso +0.5, Metálico +0.3...)
  − Σ(fraquezas impressas: comportamento sequestrável −0.5, Frágil −0.4, Fome −0.3/nível...)
  ± modificador de comportamento (Predador +0.4, Presa −0.3, Enraizado −0.6 + valor dos estágios...)
```
A fórmula **orienta**, não decide: todo custo final passa por playtest. Distribuição da diferença fórmula×final é revisada por trimestre (drift = sinal de creep).

## 3. Alavancas anti-degenerescência (já embutidas no design)

| Degenerescência clássica | Válvula estrutural |
|---|---|
| Tartaruga infinita | Reciclagem de deck com penalidade cumulativa; hexes ricos no centro; Marcos exigem expansão |
| Aggro incontestável | Retaliação; muralhas baratas; Guardiões; distância física ao Coração (mín. 4 rodadas de corrida) |
| Combo OTK | Sem "pilha" de efeitos; máx. 3 fichas/rodada; dano em um Pulso auditado (teto de projeto: 12 num cenário perfeito) |
| Ramp exponencial | Teto de estoque 10; comida apodrece; pilhagem nega produção |
| Controle de remoção total | Remoções são posicionais/condicionais; nenhuma remoção neutra "destrua alvo" incondicional existe no set |
| Mill/atrito | Deck recicla; fim por atrito é impossível por regra |

## 4. Processo de balance (operação viva)

- **Cadência:** hotfix semanal (só emergências: WR > 57% em alto MMR), patch mensal (ajustes finos), temporada trimestral (rotação de mapa da temporada + 1 mini-set).
- **Ferramentas:** simulador headless (o Pulso determinístico permite MILHÕES de partidas bot×bot por noite — vantagem direta da ausência de RNG); telemetria de win rate por facção/matchup/MMR; densidade de decisão; taxa de concessão antes da rodada 6 (proxy de frustração).
- **Estilo de ajuste:** preferir **mudança de contexto** (tag, custo, posição na curva) a mudança de números de combate; nunca mais de 2 nerfs na mesma facção por patch (identidade > meta).
- **Regra do espelho:** todo nerf publica junto o RACIOCÍNIO (nota de designer no cliente). Confiança da comunidade é ativo competitivo.

## 5. Watch-list inicial (herdada das revisões de fase)

1. Retaliação favorece defesa ~15% — monitorar WR de arquétipos aggro no MMR alto.
2. Tempestade como remoção telegrafada — monitorar taxa de "raio efetivo".
3. Javali Teimoso vs decks de fazenda no early.
4. Serpente de Vidro — tempo médio de revelação e feels-bad report.
5. Engrenato: curva de fichas — risco de a facção ser fraca DEMAIS em MMR baixo e forte demais em MMR altíssimo (perfil "Faker-only"); pode exigir buff de acessibilidade (custo do Laboratório).

## 6. REVISÃO CRÍTICA (Fase 6 — balanceamento)
- **Risco identificado:** simulador bot×bot pode otimizar para um meta que humanos não jogam. *Mitigação:* bots calibrados com replays humanos por MMR (ver Doc. 12-IA); decisões de nerf exigem DUAS fontes (sim + telemetria humana).
- **Risco:** teto de dano 12/Pulso pode ser furado por expansões. *Mitigação:* o teto vira teste automatizado no pipeline de design de cartas (CI de game design: toda carta nova roda a suíte de cenários extremos antes de ir a playtest).

**Veredicto:** aprovado.
