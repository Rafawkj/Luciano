# TERRAVIVA — Sistema de Economia e Recursos

> **Documento 06 · Fase 3 — Economia e Cartas**

---

## 1. Filosofia: economia É tabuleiro

Sem mana, sem contador automático. Todo recurso vem de um lugar físico do mapa e pode ser **disputado, roubado, queimado ou comido**. A pergunta econômica de cada rodada não é "quanto tenho?", é "**onde** estou produzindo e quem pode me tirar isso?".

## 2. Os três recursos universais + Influência

| Recurso | Ícone | Produzido por | Gasta-se em | Personalidade |
|---|---|---|---|---|
| **Comida** 🍎 | maçã | Campos trabalhados, Florestas, pesca em Lagos, Fazendas | Criaturas (custo e `Fome`), moral de gulosos | O recurso da VIDA: sustenta exércitos; estoca mal (ver §4) |
| **Matéria** 🔨 | martelo | Montanhas, Cavernas, Vulcões, Serrarias/Minas | Construções, Terrenos, Artefatos, Tecnologias | O recurso da PERMANÊNCIA: tudo que fica no mapa |
| **Essência** ✨ | gota estelar | Pântanos, Ruínas, Templos, Cristais | Eventos, Clima, Maldições, Invocações, habilidades | O recurso do EXTRAORDINÁRIO: raro, volátil, disputadíssimo |
| **Influência** 👑 | coroa | NÃO se gasta: é uma **trilha** (0–15) que mede domínio territorial | Destrava Marcos de Domínio e o Herói | O placar da vitória do construtor |

**Custos mistos:** cartas custam combinações (ex.: `2🍎 1🔨`). A tríade cria identidades de deck legíveis: exército (🍎), fortaleza (🔨), magia (✨).

## 3. Fluxo de produção (fase Aurora)

1. Cada hex **produtivo do seu território** com trabalhador designado ou produção automática gera seu recurso (tabela no Doc. 03).
2. Construções produzem sem trabalhador (é sua vantagem sobre criaturas).
3. Renda base garantida: o Coração produz **1🍎 1🔨 sempre** — nenhum jogador chega a zero absoluto (anti-frustração; comeback mínimo garantido).
4. Teto de estoque: **10 por recurso**. Excedente vira 1 ponto de Influência por unidade perdida (riqueza ostensiva impressiona o reino — e evita hoarding infinito).

## 4. Regras de fricção (o que torna a economia um jogo)

- **Comida apodrece:** no Crepúsculo, Comida acima de 6 estraga (vai a 6). Exércitos grandes exigem logística contínua, não poupança.
- **Pilhagem:** criatura sua que termina Ordem em hex produtivo **inimigo** rouba 1 recurso daquele tipo (se o estoque dele tiver).
- **Sabotagem natural:** porcos comem plantações, fogo queima serrarias, fungos infestam fazendas — negação econômica é um arquétipo inteiro de jogo (Léxico, Doc. 04).
- **Escassez do meio:** os hexes selvagens centrais são os mais ricos (produzem +1). Economia máxima exige exposição máxima. Essa é a válvula anti-tartaruga estrutural do jogo.

## 5. Influência (a trilha de domínio)

Ganha-se Influência por: controlar hexes selvagens na Aurora (+1 cada), completar construções `Monumental` (+2), excedente de estoque (§3.4), certos Eventos.
Perde-se por: perder território para o oponente, Coração danificado (−1 por rodada em que sofreu dano).

- Influência **7** destrava a invocação do seu **Herói** (além da condição pessoal dele).
- Influência **10+** é pré-requisito para reivindicar Marcos.
- Influência é pública e mostrada como uma balança entre os dois reinos — o "placar de quem está construindo melhor", legível por espectadores num relance (Pilar 6).

## 6. Os 10 conceitos econômicos do briefing → onde vivem

Para não inflar o núcleo, os conceitos clássicos viram **especializações de facção** (Doc. 07):

| Conceito | Implementação |
|---|---|
| Comida, Madeira/Pedra/Metal, Cristais | Núcleo: 🍎 / 🔨 / ✨ (Matéria unifica os brutos; Cristal é terreno de Essência) |
| Energia | Atributo ENE das criaturas (cargas de habilidade) |
| Fé | Mecânica da facção Ordem do Primeiro Sol: Essência gerada em `Sagrado` vira "Fé" com usos exclusivos |
| Conhecimento | Facção Engrenato: descartar cartas → contadores de Pesquisa que destravam Tecnologias |
| Essência | Núcleo ✨ |
| Influência | Trilha universal 👑 |

**Regra de governança:** nenhuma expansão adiciona um 4º recurso universal. Novas economias = novas conversões entre os 3+1 existentes.

---

## 7. REVISÃO CRÍTICA DA FASE 3 — Economia (auto-avaliação)

1. **Problema: dupla punição (perder hex = perder produção E Influência) pode criar bola de neve.** *Correção:* renda base do Coração garantida + o jogador atrás em Influência compra com Duplo Horizonte vendo 3 cartas (catch-up de seleção, não de recursos grátis — mantém habilidade no centro).
2. **Problema: pilhagem de 1 recurso pode ser fraca demais para justificar o risco.** *Ajuste:* pilhar também nega a produção daquele hex na próxima Aurora (o trabalhador inimigo "foge"). Duplo efeito: ganho + negação.
3. **Problema: teto de 10 + apodrecimento em 6 são duas regras de teto — redundância?** *Análise:* mantidas ambas, papéis distintos: apodrecimento força ciclo de gasto TÁTICO de comida; teto de 10 existe para Matéria/Essência com válvula de Influência. Nomeadas de forma distinta na UI para não confundir.
4. **Problema: Influência fazia coisas demais (Herói + Marcos + placar).** *Correção:* removida a 4ª função de rascunho (descontos por Influência) — cortada por sobrecarga. Três funções, todas de leitura passiva, é o limite.
5. **Validação de fantasia:** playtest de papel confirmou o momento-assinatura: "cortei a comida dele e o exército dele passou fome e comeu a própria plantação" — hilário, estratégico, e 100% do Léxico. É o tipo de história que jogador conta para amigo (aquisição orgânica).

**Veredicto:** economia aprovada. Segue para categorias de cartas.
