# TERRAVIVA — IA de Oponentes

> **Documento 12 · Fase 6 — Camada Competitiva**
> (Não confundir com a IA das criaturas — Doc. 04 —, que é regra de jogo determinística. Aqui: os bots que jogam CONTRA você.)

---

## 1. Arquitetura

Dois cérebros compartilhando o mesmo motor:
- **Avaliador tático:** busca em árvore rasa (2–3 rodadas) sobre o simulador determinístico das regras — barato porque não há RNG para amostrar; poda por heurísticas de território/tempo.
- **Diretor estratégico:** máquina de estados por arquétipo (curva de plano de jogo da facção: "Natureza: proteger brotos até rodada 5"). O diretor restringe o que o avaliador considera.

## 2. Perfis de personalidade

| Perfil | Viés do avaliador | Uso |
|---|---|---|
| **Agressiva ("Brasa")** | Peso alto em dano ao Coração e tempo; desconta valor de trocas futuras | Campanha Fogo/Sangrentos; treino anti-aggro |
| **Controladora ("Maré")** | Peso em negação, remoção posicional e Influência; joga pelo late | Treino anti-controle |
| **Defensiva ("Pedra")** | Peso em DEF do território e Marcos; raramente cruza o meio | Tutoriais de cerco |
| **Adaptativa ("Espelho")** | Reavalia arquétipo do humano a cada 3 rodadas e escolhe a contra-postura da matriz do Doc. 08 | Sparring padrão de Ranked practice |
| **Imprevisível ("Granulado")** | Amostra entre as 3 melhores jogadas (não a melhor) com temperatura alta; adora clima | Diversão casual; quebra de leitura |

## 3. Erros humanos deliberados (a regra do "quase")

Bots abaixo de MMR alto cometem erros CURADOS, nunca aleatórios burros:
- **Erro de horizonte:** ignora consequência a 2 rodadas (esquece que o vulcão entra em erupção no Crepúsculo) — o erro humano nº 1 real.
- **Apego:** protege demais uma carta cara já jogada (viés de custo afundado).
- **Ganância de recurso:** coleta 1 rodada além do seguro.
- Erros têm orçamento por dificuldade (Fofa: 4/partida → Regente: ~0) e NUNCA incluem: desperdiçar ficha sem propósito, mirar alvo ilegal, "fingir lag". O bot erra como gente, não como software.

## 4. Calibração e usos
- Treinados/calibrados com replays humanos por faixa de MMR (imitação para abertura de partida + avaliador para o meio-fim).
- Usos: campanha, preencher matchmaking em ligas novas (marcado como BOT — transparência total), sparring de deck (o Sandbox permite "jogar contra meu próprio deck pilotado pela IA Espelho"), e o simulador noturno de balance (Doc. 10).

## 5. REVISÃO CRÍTICA (Fase 6 — IA)
- **Risco: bots não declarados destroem confiança.** Regra dura: bot é SEMPRE identificado. Sem exceções de growth.
- **Risco: IA Espelho forte demais vira ferramenta de coaching paga por fora.** *Decisão:* abraçar — Espelho é feature GRATUITA de treino; democratiza coaching e diferencia o produto.
- **Dívida técnica aceita:** o Diretor por máquina de estados exige manutenção por facção a cada expansão; orçado no roadmap (1 eng./mês por trimestre).

**Veredicto:** aprovado.
