# GUERRA DOS REINOS — UX/UI, Direção de Arte, Áudio e Narrativa

> **Documento 14 · Fase 6 — Experiência**

---

## 1. UX/UI

### 1.1 Princípios
1. **O campo é o herói:** HUD mínimo; a informação mora NO mundo (Congelada = peça envolta em gelo de resina; Queimando = brasinhas nas frestas; Escudo = redoma de vidro — animação, não ícone).
2. **Leitura em 3 alturas:** relance (silhuetas + cores de facção), foco (atributos em ícones padronizados), estudo (tooltip profundo com as palavras-chave explicadas).
3. **Previsão honesta:** tocar em qualquer Tropa mostra quem ela pode atacar e o resultado do combate (dano dos dois lados, fantasma) ANTES de confirmar — a ferramenta didática nº 1.
4. **Zero surpresa de regra:** Guarda brilha quando obriga o ataque; Chama Alta acende quando ativa; marcadores de Frio/Açúcar são peças físicas empilhadas ao lado da Tropa.

### 1.2 Fluxo de tela (mobile-first)
- Layout retrato nativo (o campo de 4+4 Tropas empilha verticalmente) — o jogo é mobile-first por natureza.
- Mão em leque inferior; arrastar-para-jogar; Energia como fileira de botões de madeira que acendem (gasto = botão empurrado ao centro).
- Acessibilidade: daltonismo (padrões além de cor nas tags), leitura de tela nos menus, tamanho de fonte, redução de movimento (resoluções instantâneas), remapeamento completo no PC.

## 2. Direção de Arte

- **Estilo:** cartoon 2.5D "diorama de mesa": tabuleiro como maquete viva, criaturas com proporções brinquedo (cabeças grandes, silhuetas de 1 leitura), materiais táteis (feltro nos campos, verniz na água). Referência de sensação: desenho animado de sábado de manhã encontra jogo de tabuleiro premium — sem citar nem copiar nenhuma obra.
- **Silhueta primeiro:** toda criatura é aprovada em teste de silhueta preta em 64 px. Se duas se confundem, uma volta.
- **Cor por função:** paleta da facção no corpo; SINAIS de estado universais por cor/forma (veneno = bolhas verdes, sempre, em qualquer skin).
- **Animação exagerada:** antecipação e squash-and-stretch generosos; cada criatura tem idle com personalidade (a Ovelha conta a si mesma para dormir), reação de dano e "assinatura" de abate/derrota SEM violência gráfica (nocautes de desenho: estrelinhas, poeira, saída de cena cômica).
- **O fim de turno como espetáculo:** Queimar, curas de Construções e transformações de Sementes resolvem num balé curto de consequências; o mundo é o VFX.

## 3. Áudio

- **Cada criatura:** voz própria (sílabas de bicho, não idioma), com variações de moral (a mesma "fala" em tom exaltado/apavorado).
- **Cada Terreno ativo:** muda a cama de ambiente da mesa inteira (Lago Congelado: craquelados; Fissura Vulcânica: subgrave respirando) — o SOM do campo é o campo.
- **Clima comanda a música:** trilha adaptativa por camadas; cada Evento Caótico e Terreno troca instrumentação (Nevasca: abafamento + coro; Lua Rubra: modo menor + sussurros).
- **Ritmo de partida:** intensidade da trilha segue um "diretor de tensão" (Vida dos dois jogadores + tamanho do campo); acelera no late game.
- **Higiene sonora competitiva:** todo evento de regra tem som ÚNICO e curto; jogável de olhos fechados por um veterano (meta real de design sonoro).

## 4. Narrativa (resumo do universo)

- **O mundo:** o continente **Terraviva** é uma maquete-mundo onde seis reinos disputam a regência em duelos exagerados. Ninguém morre de verdade (as peças voltam para a caixa) — o que justifica partidas infinitas e o tom leve.
- **As 6 facções** são "humores" do continente (Doc. 08). Não há campanha: **o lore vive inteiramente nas cartas** (flavor de 1 linha, nomes, animações e sons) e no tutorial — com o humor vindo de personagens (a general-padeira, o conde anfitrião, a confeiteira-marechala) e NUNCA de quebra de quarta parede que barateie as apostas.
- **Tom de texto:** flavor de 1 linha, sempre com um sorriso de canto (ver as 115 cartas); nomes próprios pronunciáveis em PT/EN/ES (localização planejada desde o design).

## 5. REVISÃO CRÍTICA (Fase 6 — experiência)
- **Conflito detectado: animação exagerada × higiene competitiva.** *Resolução:* orçamento de tempo por animação (abate ≤ 0.8 s no modo 2×), e TODA animação com consequência de regra termina antes do próximo input ser aceito.
- **Risco: retrato mobile duplica trabalho de câmera/UI.** *Decisão:* mantido — o mercado-alvo o exige; cortado, em troca, o plano de tabuleiros 3D rotacionáveis (valor baixo, custo alto).
- **Risco: lore só em flavor ser raso demais.** *Aceito:* sem campanha, a narrativa é ambiental por definição — a régua é "cada carta conta uma história em 1 linha", e a coleção inteira (aberta desde o início) é o livro do mundo.

**Veredicto:** aprovado.
