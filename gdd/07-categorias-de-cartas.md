# TERRAVIVA — As 14 Categorias de Cartas

> **Documento 07 · Fase 3 — Economia e Cartas**
> Cada categoria tem mecânica exclusiva, papel estratégico distinto e regra de contrajogo nativa.

---

## 1. Tabela mestra

| # | Categoria | Permanência | Mecânica exclusiva | Contrajogo nativo |
|---|---|---|---|---|
| 1 | **Criatura** | Fica no mapa | Comportamento no Pulso; atributos completos (Doc. 04/05) | Combate, fome, moral, terreno hostil |
| 2 | **Herói** | Única, 1 por deck | Entra pela **Condição de Lenda** + Influência 7; nunca começa na mão; ao morrer, volta ao "Salão" e pode retornar 1× por +3✨ | Negar a condição de lenda dele (ela é pública desde o início da partida) |
| 3 | **Construção** | Fica no mapa | Produz/afeta sem gastar fichas; `Fundada` (não substituível por terraformação) | Fogo, raízes, cerco, pilhagem |
| 4 | **Terreno** | Permanente no hex | Transforma o mapa; define tags do hex | Re-terraformação (com presença), degradação natural |
| 5 | **Evento** | Instantâneo | Único tipo jogável **fora do seu turno de ficha** se marcado `Reflexo` (janela de resposta) | Custo em ✨ raro; previsibilidade de recursos abertos |
| 6 | **Clima** | Global, 2 Pulsos | Substitui o clima anterior; afeta ambos | Sobrescrever com outro clima; Observatório |
| 7 | **Relíquia** | Equipada no Coração | Modifica as regras do SEU reino (ex.: "seus Campos produzem +1") — 1 ativa por vez | Roubo por pilhagem do hex do Coração; custo alto |
| 8 | **Artefato** | Equipado em criatura | Transfere-se ao matar o portador (**despojo**: quem abate, leva) | Matar o portador vira risco/prêmio para os dois lados |
| 9 | **Maldição** | Anexada a hex/criatura | Único tipo que persiste ESCONDIDO até o gatilho (marca visível, efeito oculto) | `Sagrado` bloqueia; purificação; adivinhas pelo custo pago |
| 10 | **Invocação** | Temporária (X Pulsos) | Entidade que ignora custo de Comida/Fome mas expira; não conta para Marcos | Esperar expirar; banir com `Sagrado` |
| 11 | **Companheiro** | Anexado a criatura | Concede segundo comportamento à criatura (ex.: falcão = olhos: remove `Oculto` adjacente) | Morre junto do hospedeiro; alvo de tiro isolado |
| 12 | **Totem** | Fica no mapa | Aura de 1 hex de raio; **empilha efeito** a cada Pulso que sobrevive (juros crescentes) | Frágil (VIDA 1–3); prioridade de remoção clara |
| 13 | **Armadilha** | Oculta em hex seu | Única informação totalmente oculta; dispara na camada 8 do Pulso | Limite de 2; `Farejar`; terraformar o hex revela |
| 14 | **Tecnologia** | Global permanente | Melhora uma REGRA sua para o resto da partida (ex.: "seus Coletores colhem +1") — exige Laboratório/pesquisa | Custo altíssimo de tempo; destruir o Laboratório cancela a pesquisa em andamento |

## 2. Regras transversais

- **Raridades:** Comum, Incomum, Rara, Lendária (Lendária = máx. 1 cópia). Raridade indica complexidade/impacto de build, **nunca** poder bruto (Pilar: anti pay-to-win e anti power creep, Doc. 12).
- **Identidade de custo:** Criaturas pendem para 🍎, permanentes de mapa para 🔨, tipos "mágicos" (5, 6, 9, 10) para ✨. Ler os recursos abertos do oponente = prever o que ele PODE fazer. Contagem de recursos é a "contagem de cartas" do nosso jogo.
- **Janela de Reflexo:** para preservar interatividade sem criar pilha infinita estilo stack: apenas Eventos `Reflexo` respondem, apenas 1 por gatilho, e o gatilho deve estar impresso ("quando uma criatura sua for atacada...").

## 3. Anatomia visual da carta (resumo de UX — detalhes no Doc. 18)

```
┌─────────────────────────┐
│ CUSTO(ícones)      RARO │
│      [ARTE 60%]         │
│ NOME                    │
│ Categoria · Facção      │
│ ⚔ATQ 🛡DEF ❤VIDA 👣VEL │
│ 🎯ALC ⚖PESO ⚡ENE 🧠INT │
│ [COMPORTAMENTO] [TAGS]  │
│ Passiva / Ativa (2 li.) │
│ "flavor de 1 linha"     │
└─────────────────────────┘
```
Regra de ouro editorial: **máximo 2 linhas de texto de regras por carta.** Se precisa de mais, a mecânica pertence ao Léxico ou não deve existir.

---

## 4. REVISÃO CRÍTICA DA FASE 3 — Categorias (auto-avaliação)

1. **Problema: 14 categorias no set inicial é MUITO.** *Decisão estrutural:* todas existem nas REGRAS desde o dia 1, mas o set base concentra 80% das cartas em 6 categorias (Criatura, Terreno, Construção, Evento, Clima, Armadilha). As demais aparecem em poucas cartas-assinatura por facção e crescem em expansões (plano no Doc. 21). Ensinar em camadas, não tudo de uma vez.
2. **Problema: Maldição oculta + Armadilha oculta = dois sistemas de informação escondida.** *Correção:* unificadas na mesma regra de orçamento — máximo de **2 permanentes ocultos** por jogador, somando Maldições e Armadilhas.
3. **Problema: Artefato com despojo pode fazer snowball.** *Análise:* mantido — é um dos melhores geradores de decisão do design (equipar = apostar), e o mecanismo é simétrico por natureza. Watch-item de custo no Doc. 12.
4. **Melhoria adotada:** Herói com **Condição de Lenda pública** (ex.: "construa 3 Fortalezas") substitui o rascunho anterior ("compre o herói no turno certo"): remove sorte, cria uma mini-quest legível que o oponente pode sabotar — puro Pilar 9.
5. **Corte realizado:** subcategoria "Veículos" do rascunho inicial foi cortada do set base (sobreposição funcional com Artefatos + orçamento de complexidade estourado). Reavaliar na Expansão 2.

**Veredicto:** categorias aprovadas. Fase 3 completa; iniciar Fase 4 (facções).
