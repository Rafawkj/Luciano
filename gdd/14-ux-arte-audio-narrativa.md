# TERRAVIVA — UX/UI, Direção de Arte, Áudio e Narrativa

> **Documento 14 · Fase 6 — Experiência**

---

## 1. UX/UI

### 1.1 Princípios
1. **O tabuleiro é o herói:** HUD mínimo nas bordas; nada cobre hexes; a informação mora NO mundo (tags como ícones no hex, moral como postura da criatura, fome como barriga roncando — animação, não número).
2. **Leitura em 3 alturas:** relance (silhuetas + cores de facção), foco (atributos em ícones padronizados), estudo (tooltip profundo com as Leis relevantes destacadas).
3. **Previsão honesta:** tocar/hover em qualquer entidade mostra alcances, zonas de Sentinela e Instintos armados; um botão "Prever Crepúsculo" mostra a contabilidade fantasma do fim da rodada (fogo, veneno, crescimentos, pavios — a ferramenta didática nº 1).
4. **Zero surpresa de regra:** toda interação do Léxico prestes a ocorrer é sinalizada (ex.: mover para hex `Inflamável` com fogo perto acende um aviso sutil).

### 1.2 Fluxo de tela (mobile-first)
- Layout retrato opcional (tabuleiro 9×5 gira para 5×9 com câmera reposicionada) — decisão cara e prioritária para o mercado mobile.
- Mão em leque inferior recolhível; arrastar-para-jogar com fantasma de posicionamento válido; fichas de ação como 3 gemas grandes (estado do turno legível de relance por ambos).
- Acessibilidade: daltonismo (padrões além de cor nas tags), leitura de tela nos menus, tamanho de fonte, redução de movimento (resoluções instantâneas), remapeamento completo no PC.

## 2. Direção de Arte

- **Estilo:** cartoon 2.5D "diorama de mesa": tabuleiro como maquete viva, criaturas com proporções brinquedo (cabeças grandes, silhuetas de 1 leitura), materiais táteis (feltro nos campos, verniz na água). Referência de sensação: desenho animado de sábado de manhã encontra jogo de tabuleiro premium — sem citar nem copiar nenhuma obra.
- **Silhueta primeiro:** toda criatura é aprovada em teste de silhueta preta em 64 px. Se duas se confundem, uma volta.
- **Cor por função:** paleta da facção no corpo; SINAIS de estado universais por cor/forma (veneno = bolhas verdes, sempre, em qualquer skin).
- **Animação exagerada:** antecipação e squash-and-stretch generosos; cada criatura tem idle com personalidade (a Ovelha conta a si mesma para dormir), reação de moral e "assinatura" de abate/derrota SEM violência gráfica (nocautes de desenho: estrelinhas, poeira, saída de cena cômica).
- **O Crepúsculo como espetáculo:** a luz do tabuleiro amanhece/anoitece a cada rodada; fogo, crescimento e pavios resolvem num balé curto de consequências; o mundo é o VFX.

## 3. Áudio

- **Cada criatura:** voz própria (sílabas de bicho, não idioma), com variações de moral (a mesma "fala" em tom exaltado/apavorado).
- **Cada terreno:** cama de ambiente (Floresta: pássaros; Pântano: bolhas; Vulcão: subgrave) misturada por proporção de hexes no mapa — o SOM do mapa é o mapa.
- **Clima comanda a música:** trilha adaptativa por camadas; cada clima troca instrumentação (Chuva: pizzicato; Nevasca: abafamento + coro; Lua Vermelha: modo menor + sussurros) — já especificado carta a carta no set.
- **Ritmo de partida:** intensidade da trilha segue um "diretor de tensão" (Vitalidade dos Corações + proximidade de Marcos); o Crepúsculo tem tema rítmico próprio que acelera no late game.
- **Higiene sonora competitiva:** todo evento de regra tem som ÚNICO e curto; jogável de olhos fechados por um veterano (meta real de design sonoro).

## 4. Narrativa (resumo do universo)

- **O mundo:** o continente **Terraviva** é um ser adormecido; cada partida é um "sonho de regência" em que dois Regentes propõem reinos. Vitória por Conquista = o sonho mais feroz; por Domínio = o sonho mais harmonioso. (Elegante: justifica partidas infinitas, mapas mutáveis e a ausência de morte permanente — tudo é sonho da terra.)
- **As 6 facções** são "humores" do continente (Doc. 08); a campanha conta a primeira Grande Regência em 30 missões, uma dor de cabeça diplomática por vez, com o humor vindo de personagens (a general-padeira, o conde anfitrião, a confeiteira-marechala) e NUNCA de quebra de quarta parede que barateie as apostas.
- **Tom de texto:** flavor de 1 linha, sempre com um sorriso de canto (ver as 90 cartas); nomes próprios pronunciáveis em PT/EN/ES (localização planejada desde o design).

## 5. REVISÃO CRÍTICA (Fase 6 — experiência)
- **Conflito detectado: animação exagerada × higiene competitiva.** *Resolução:* orçamento de tempo por animação (abate ≤ 0.8 s no modo 2×), e TODA animação com consequência de regra termina antes do próximo input ser aceito.
- **Risco: retrato mobile duplica trabalho de câmera/UI.** *Decisão:* mantido — o mercado-alvo o exige; cortado, em troca, o plano de tabuleiros 3D rotacionáveis (valor baixo, custo alto).
- **Risco: "sonho da terra" soar descompromissado.** *Mitigação:* consequências persistem DENTRO da campanha (escolhas mudam missões seguintes); o frame onírico existe para o PvP, não para anular a campanha.

**Veredicto:** aprovado.
