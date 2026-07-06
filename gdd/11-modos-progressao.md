# GUERRA DOS REINOS — Estrutura do Jogo: Menu, Modos e Tutorial

> **Documento 11** · v0.4 — o jogo não tem quests, missões, campanhas, passes, conquistas nem progressão de conta. É um jogo de estratégia puro, como um tabuleiro digital: liga, monta, joga.

---

## 1. Menu principal (3 opções, nada mais)

```
┌─────────────────────────────┐
│     GUERRA DOS REINOS       │
│                             │
│      ▶ CRIAÇÃO DE DECK      │
│      ▶ JOGAR                │
│      ▶ TUTORIAL             │
└─────────────────────────────┘
```

## 2. CRIAÇÃO DE DECK

- **Coleção completa liberada desde a instalação.** Todas as **220 cartas** (6 facções × 30 + 40 Neutras) disponíveis para todos, sempre — sem desbloqueio, sem moeda, sem sorte. (Filosofia: xadrez não esconde as peças.)
- **Editor:** filtros pelos 4 tipos (Tropas, Feitiços, Construções, Terrenos), por facção, por custo e por palavra-chave; curva de custos visível; busca por texto.
- **Validador em tempo real:** 40 cartas · máx. 2 cópias (1 se Lendária) · até 2 facções principais · Neutras à vontade (Doc. 02 §3).
- **6 decks prontos** (um por facção, desenhados para ensinar o plano de jogo da facção) — editáveis como ponto de partida.
- **Código de deck:** exportar/importar por string curta (compartilhamento fora do jogo).

## 3. JOGAR

Ao tocar em JOGAR, uma única escolha: **Offline** ou **Online**.

### 3.1 Offline (contra IA)
- Escolha seu deck, a facção da IA (ou aleatória) e a dificuldade — os 5 perfis do Doc. 12 (Brasa, Maré, Pedra, Espelho, Granulado) em 3 níveis cada.
- Sem recompensas, sem contadores de vitória obrigatórios: é a mesa de treino.
- Opção **Partida Livre**: desfazer ilimitado e dicas do Códice ativadas (o "modo aprender jogando").

### 3.2 Online
- **Partida rápida:** matchmaking automático por MMR oculto (ninguém vê número nenhum; só serve para parear jogos justos). Proteção de novato nas primeiras 20 partidas.
- **Partida com amigo:** criar sala por código de 6 letras; quem tem o código entra. Sem ranking, sem consequência.
- **Modos dentro de Jogar:** Normal (padrão da fila), Rápido e Caos (disponíveis offline e em salas por código — Doc. 02 §14).

## 4. TUTORIAL

O tutorial substitui qualquer campanha: **4 lições de 3–5 minutos**, rejogáveis, direto do menu.

| Lição | Ensina | Momento-assinatura |
|---|---|---|
| 1. O Duelo | Energia, jogar Tropas, atacar, Vida | Primeiro ataque e primeiro dano de volta |
| 2. O Campo | Guarda, Voador, bloqueio, Construções e Terrenos | "Ele não pode te atacar sem passar pelo urso" |
| 3. As Facções | Palavras-chave e a mecânica da sua facção (Frio, Chama Alta, Açúcar...) | O primeiro combo de facção |
| 4. A Partida | Jogo completo guiado contra IA Fofa, com Lendária no clímax | Invocar a primeira Lendária |

- Ao fim da lição 4, o jogo sugere: "Monte seu deck ou jogue com um pronto" → leva ao menu.
- As **Dicas do Códice** (1 linha na primeira vez que cada Lei dispara numa partida) continuam disponíveis fora do tutorial, desligáveis.

## 5. O que NÃO existe (por decisão de produto)

- ❌ Quests, missões diárias, campanhas, puzzles, chefes.
- ❌ Passe de temporada, conquistas, níveis de conta, moedas.
- ❌ Ligas e divisões visíveis (o MMR é oculto e serve só ao pareamento).
- ❌ Desbloqueio de cartas — a coleção nasce completa.
- Se houver monetização futura, será **apenas cosmética** (skins de tabuleiro/tropas numa loja simples), sem nunca tocar nesta lista.

---

## 6. REVISÃO CRÍTICA (v0.4)
1. **Risco: sem progressão, qual é a retenção?** A mesma do xadrez e do futebol: o próprio jogo. A aposta exige que o núcleo (Léxico + tabuleiro) carregue tudo — por isso os gates de diversão do roadmap (Doc. 15) são os mais importantes do projeto.
2. **Risco: coleção completa de graça mata monetização.** Decisão consciente de identidade; cosmético-opcional é o único caminho compatível. Registrado como risco de negócio (Doc. 15, risco 7).
3. **MMR oculto sem liga visível** pode frustrar quem quer "subir de rank". Contra-argumento: o público-alvo desta estrutura é quem cansou de ladder-grind. Se a demanda por ranking visível crescer, é adicionável sem tocar no resto (decisão reversível, registrada).
4. **Tutorial de 4 lições vs campanha de 30 missões da v0.2:** perde-se profundidade de ensino do Léxico lei a lei; compensado pela Partida Livre com desfazer + Dicas do Códice (aprender jogando de verdade, não em missões).

**Veredicto:** aprovado.
