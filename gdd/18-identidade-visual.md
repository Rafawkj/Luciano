# GUERRA DOS REINOS — Bíblia de Identidade Visual

> **Documento 18 · Identidade** · v0.6 — **REDESIGN COMPLETO por briefing do diretor**
> Direção anterior ("Diorama Vivo", maquete artesanal) arquivada. Nova direção: **fantasia mágica cartoon premium**.
> Mockup navegável: [mockups/identidade-visual.html](mockups/identidade-visual.html)

---

## 1. O estilo artístico final: **ENCANTO VIVO**

**Conceito-mestre: cada carta é um PORTAL para o reino dela.** A moldura não é uma borda — é uma janela de cristal encantado que deixa o reino "vazar": o frio embaça o vidro da carta de Gelo, faíscas escapam da carta de Fogo, calda escorre da carta Doce. A mesa é a **arena arcana onde os reinos se encontram** — e o Terreno ativo literalmente puxa a arena para dentro do reino dele.

A receita do estilo (em ordem de prioridade):
1. **Fantasia mágica** — runas, cristais, energia luminosa em tudo que é interativo;
2. **Cartoon moderno** — contorno limpo, formas arredondadas, poses dinâmicas, olhos expressivos;
3. **Aventura colorida** — saturação alta com sombras COLORIDAS (nunca cinza/preto puro);
4. **UI polida de jogo digital** — placas mágicas, botões-gema arredondados, brilho como affordance;
5. **Humor visual sutil** — uma piada por carta (pose, adereço, expressão), nunca ao custo da leitura.

**Proibições da direção:** realismo, dark-fantasy pesado, menus cinzas quadrados, molduras metálicas genéricas, texto pequeno, poluição visual, cara de template.

**Regra de ouro da direção:** *"Se não brilha, não convida; se não é redondo, não é nosso; se não dá para ler em miniatura, volta."*

## 2. Paleta de cores geral

- **Base do mundo (UI global):** índigo-noite encantado `#1d1440` → violeta profundo `#2c1e5c` (o "céu arcano" onde tudo flutua), com névoa mágica turquesa `#39d8d8` e dourado-feitiço `#ffcf5c` como acentos universais.
- **Luz:** toda luz do jogo tem cor — dourado para o precioso, turquesa para o arcano, e a cor da facção para tudo que é dela.
- **Sombras:** roxo-azulado translúcido, nunca preto chapado.
- **Texto:** marfim `#f6efdd` sobre placas escuras; tinta `#3a2b1a` sobre pergaminho claro.
- **Contraste mínimo:** AA em qualquer tamanho de carta; números de ATQ/VIDA legíveis a 64 px.

## 3. Identidade visual por facção (paletas oficiais do diretor)

| Facção | Paleta | Elementos da moldura | Sensação | A carta parece… |
|---|---|---|---|---|
| ❄ **Gelo** | azul claro · branco · ciano · prata · roxo frio | cristais de gelo nos cantos, flocos mágicos, névoa congelante, runas azuladas, borda translúcida | elegante, fria, misteriosa, defensiva | …feita de cristal encantado |
| 🔥 **Fogo** | vermelho · laranja · amarelo · preto carvão · dourado quente | brasas, rachaduras brilhantes, fumaça cartoon, faíscas subindo, chamas estilizadas nos cantos | agressiva, energética, explosiva, divertida | …quente e prestes a explodir |
| 🍬 **Doce** | rosa · lilás · azul bebê · amarelo creme · branco glacê | confeitos, glacê escorrendo no topo, açúcar cristalizado, corações e estrelinhas, calda mágica | fofa, alegre, protetora, encantada | …bonita e mágica, sem ser infantil |
| 🩸 **Sangrento** | vermelho rubi · vinho · preto · roxo escuro · dourado envelhecido | rubis, lua vermelha, morcegos estilizados, névoa escura, símbolos de pacto, ornamento gótico cartoon | misteriosa, vampírica, elegante, teatral | …sombria e estilosa, ainda cartoon |
| 🌿 **Natureza** | verde · verde musgo · marrom madeira · amarelo solar · azul claro | folhas e cipós crescendo pela borda, sementes, flores mágicas, cogumelos, luz de vaga-lume | viva, orgânica, acolhedora, crescente | …formada por madeira viva e energia natural |
| ⚔ **Humano** | marrom couro · dourado · azul aço · bege · vermelho bandeira | escudos, mapas, engrenagens simples, bandeirolas, torres, ferramentas de aventureiro | tática, aventureira, heroica, organizada | …feita por aventureiros inteligentes |
| 🎒 **Neutra** | bege · cinza · bronze · azul suave · verde apagado | mapas, mochilas, moedas, placas de estrada, pergaminhos, símbolos de viagem | flexível, viajante, curiosa, útil | …de quem já passou por todos os reinos |

Molduras: **layout idêntico, alma diferente** — mesma grade, cada facção troca material, ornamento de canto e cor de brilho. Neutras nunca mais chamativas que facções.

## 4. Layout da carta (formato vertical, proporção ~2:2.8)

```
┌──────────────────────┐
│ [GEMA]  NOME NA PLACA│  ← placa mágica no topo; gema de custo no canto sup. esquerdo
│ ┌──────────────────┐ │
│ │                  │ │
│ │   ARTE CENTRAL   │ │  ← ~55% da carta; personagem com silhueta clara,
│ │  (o "portal")    │ │    pose dinâmica, fundo simples do reino
│ └──────────────────┘ │
│  Tipo · Facção  ◆rar │  ← linha fina; gema de raridade à direita
│ ┌──────────────────┐ │
│ │ caixa-pergaminho │ │  ← habilidade, com ícones de palavra-chave
│ └──────────────────┘ │
│ [⚔ATQ]        [♥VIDA]│  ← medalhões grandes na base (só Tropas)
└──────────────────────┘
```

- **Nome:** placa encantada com leve arco; tipografia display arredondada, alta legibilidade.
- **Gema de custo por facção:** Gelo = cristal azul lapidado · Fogo = pedra de lava com brasas · Doce = bala cristalizada · Sangrento = rubi · Natureza = semente luminosa · Humano = medalhão de bronze · Neutra = moeda antiga. Número grande, branco com contorno.
- **Caixa de texto:** pergaminho mágico claro, textura mínima, ícones pequenos antes de palavras-chave (❄ Congelar, 🔥 Queimar, 🛡 Guarda, 🪽 Voador, 💥 Explodir, ⚡ Investida…).
- **Ataque:** medalhão-espada/garra com fundo explosivo (agressivo). **Vida:** coração-cristal com aro-escudo (protetor). Ambos com número grande.
- **Raridade** (especial ≠ poluído): Comum = moldura simples · Incomum = brilho leve na placa do nome · Rara = gema pequena incrustada · Épica = aura animada suave na borda · Lendária = moldura elaborada + partículas mágicas orbitando (contidas nas bordas — a arte continua limpa).

## 5. A mesa: **ARENA ARCANA**

Vista levemente inclinada (top-down ~15°), como um tabuleiro flutuando no céu arcano.

- **Material:** madeira encantada com veios que brilham de leve; **cristais nas bordas** que acendem no turno do dono; runas no aro externo; 2 pequenos portais de energia (deck = portal de entrada; descarte = portal que "arquiva" a carta em luz).
- **Espaços de Tropa:** círculos rúnicos no chão que pulsam quando vazios-jogáveis e **acendem em glow suave** ao receber a peça. *(Nota do estúdio: o briefing cita 4 espaços; o Manual v0.5.1 define **5** — mantivemos 5 e o layout comporta ambos; ver pendência.)*
- **Espaço de Terreno:** pedestal maior e ornamentado à esquerda de cada lado. **Terreno ativo transforma a arena**: Gelo congela as bordas · Fogo abre rachaduras de lava · Doce cobre de confeitos e brilho · Sangrento sobe névoa rubra · Natureza cresce cipós e folhas · Humano ergue bandeirolas e torres.
- **Construções:** nas laterais, como **estruturas em miniatura** de verdade (torre, altar, fornalha) e não cartas deitadas; emitem partículas quando o efeito dispara.
- **Vida do jogador:** grande **orbe-coração de cristal** com número enorme, moldura da facção.
- **Energia:** fileira de **cristais que acendem** (5/10 = 5 acesos de 10); o cristal gasto apaga com um "puff" de pó mágico.
- **Mão:** leque na base com as cartas "respirando"; carta jogável tem a moldura acesa por dentro.

## 6. Animações (rápidas, claras, satisfatórias — ≤ 0,6 s cada)

| Evento | Animação |
|---|---|
| Jogar carta | flash de portal + impacto suave com ondulação rúnica no slot |
| Ataque | avanço curto + efeito da facção no impacto (lasca de gelo, fagulha, respingo de calda…) |
| Dano | número flutuante grande com contorno |
| Cura | brilho ascendente dourado/rosa/verde conforme a fonte |
| Congelar | camada de gelo cartoon "cresce" sobre a peça com craquelado |
| Queimar | chaminha cartoon persistente no canto da peça |
| Drenar | filete de energia rubra voa do alvo até o orbe de Vida |
| Crescer / +1/+1 | folhas e luz verde sobem; os números "pulam" |
| Escudo | bolha mágica com reflexo aparece com "pop" |
| Açúcar | estrelinhas e confeitos orbitam o marcador |
| Frio acumulado | flocos empilham como contas visíveis ao lado da peça |
| Pacto | selo rúnico vermelho pisca sobre o orbe de Vida do próprio jogador |
| Armadilha | a carta virada treme de leve quando a condição chega perto (teaser!) |

## 7. Ícones (kit mínimo consistente)

- **Custo:** as 7 gemas de facção (§4).
- **ATQ/VIDA:** espada-explosão / coração-escudo.
- **Palavras-chave:** 15 ícones monocromáticos de traço grosso (legíveis a 16 px), sempre acompanhados da palavra na caixa de texto.
- **Marcadores no campo:** Frio = floco-conta · Açúcar = confeito-estrela · Queimar = chaminha · Escudo = bolha · Virada = zzz de vapor.
- **Tipos:** Tropa = elmo · Feitiço = estrela cadente · Construção = torre · Terreno = montinho com bandeira.

## 8. Tela principal

- **Fundo:** panorama pintado dos reinos ao longe, todos no mesmo mundo — montanhas geladas, vulcão, castelo doce, floresta viva, castelo rubro e vila humana sob o mesmo céu arcano com duas luas; partículas suaves.
- **Logo provisório:** "GUERRA DOS REINOS" em letras cartoon empilhadas com contorno grosso, gemas das 6 facções incrustadas na palavra REINOS; balanço sutil.
- **Botões (placas mágicas arredondadas, empilhadas):** **JOGAR** (maior, dourado) · **COLEÇÃO** · **MONTAR DECK** · **LOJA** · **CONFIGURAÇÕES** (ícone-engrenagem discreto).
- *(Nota do estúdio: o briefing pede "Loja ou Pacotes" — se "Pacotes" significar aquisição de CARTAS, isso muda a decisão v0.4 de coleção completa desde a instalação. Implementado como LOJA de cosméticos até o diretor confirmar; ver pendência.)*

## 9. Tela de coleção

- Grade de cartas com **filtros-gema** no topo: facção (7 gemas clicáveis), tipo, custo (régua 1–8+), raridade, busca por nome.
- Hover/toque: a carta **cresce com tilt 3D suave** e mostra detalhes + palavras-chave explicadas.
- Cartas legíveis mesmo pequenas (o layout do §4 garante); as que faltam aparecem como silhueta rúnica.
- Fundo: estante-grimório do reino da facção filtrada.

## 10. Tela de montagem de deck

- **Esquerda:** coleção filtrável. **Direita:** o deck como um grimório de lombada da facção.
- Painel vivo de equilíbrio: **curva de custo** em barras-cristal, contagem por tipo (Tropas/Feitiços/Construções/Terrenos) contra a proporção recomendada do Manual (§3), gemas das 2 facções escolhidas, alerta amigável quando algo foge do recomendado ("Seu grimório está com fome de Tropas!").
- Validador: 40 cartas · máx. 2 cópias (1 Lendária) · até 2 facções + Neutras — sempre visível como selos que acendem.

## 11. Exemplo canônico de carta (referência de arte)

> **Pinguim Espadachim (Gelo, Comum, custo 2, 2/3).** Moldura de cristal azul com flocos nos cantos e névoa sutil na base; gema de custo = cristal lapidado com "2"; arte: pinguim rechonchudo em pose de esgrima, espada-agulha de gelo erguida, cachecol esvoaçante, olhos determinados e ligeiramente ridículos (o humor), fundo de fiorde simplificado com aurora; placa do nome em prata gelada; caixa-pergaminho: "Quando entra em campo, ❄ Congele uma Tropa inimiga com 2 ou menos de Ataque."; medalhões ⚔2 / ♥3. Limpa, engraçada, congelante.

## 12. Regras de consistência (para tudo continuar UM jogo)

1. **Mesma grade de carta para todas as facções** — só material/ornamento/cor mudam.
2. **Sombras sempre coloridas**; contorno sempre limpo; cantos sempre arredondados.
3. **Brilho = interatividade** (nunca decorar com glow o que não é clicável/jogável).
4. **1 piada visual por carta, máximo** — o humor tempera, não domina.
5. **Teste de miniatura:** toda carta aprovada a 64 px de altura; toda silhueta única em preto.
6. **Efeito de facção usa a paleta da facção** — dano de Fogo nunca é azul.
7. **Épico/Lendário brilham nas BORDAS**, nunca sobre a arte ou o texto.
8. **Nada de preto puro, cinza chapado ou caixa quadrada** em nenhuma tela.

---

## REVISÃO CRÍTICA (v0.6)
1. **Direção "Diorama Vivo" arquivada** por briefing do diretor — substituída por "Encanto Vivo" (fantasia mágica cartoon premium). O que sobrevive da direção antiga: proporção-brinquedo dos personagens, silhueta-primeiro, humor sutil, leitura em miniatura e o princípio "o tabuleiro é vivo".
2. **⚠ Pendência — espaços de Tropa:** o briefing cita 4; o Manual v0.5.1 define 5. Mantido **5** (regra vence arte) até o diretor confirmar.
3. **⚠ Pendência — "Loja ou Pacotes":** se houver pacotes de cartas, a decisão v0.4 (coleção completa, sem P2W) muda. Implementado como Loja cosmética até confirmação.
4. Mockup navegável refeito no estilo novo (mesma URL de sempre).
