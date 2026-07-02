# TERRAVIVA — Tabuleiro, Terrenos e Clima

> **Documento 03 · Fase 2 — Sistemas do Mundo**

---

## 1. O tabuleiro é o reino

Grade de **45 hexágonos (9 colunas × 5 fileiras)** compartilhada. Não existem "lados" rígidos: existe território conquistado. O centro do mapa contém hexes selvagens ricos — o jogo empurra os dois reinos um contra o outro naturalmente, sem timer artificial.

### 1.1 Anatomia de um hex
Cada hex possui, sempre visíveis:
- **Tipo de terreno** (Campo por padrão);
- **Tags naturais ativas** (ex.: `Molhado`, `Fértil`, `EmChamas`) — ícones pequenos na borda;
- **Controle** (aro colorido do jogador, ou cinza se selvagem);
- **Ocupante** (0 ou 1 entidade grande; até 2 entidades `Peso 1` empilham — enxames).

### 1.2 Por que hexes e não lanes
Lanes (o formato clássico do gênero) limitam o vocabulário posicional a "frente/trás". Hexes dão: flanqueio, cerco, gargalos, rotas de fuga — o mínimo necessário para comportamentos animais fazerem sentido espacial. 45 hexes é pequeno o bastante para leitura em tela de celular (testar 7×5 como fallback no protótipo).

---

## 2. Os 12 terrenos do set base

Todo terreno modifica **movimentação, combate, visão, economia e magia** através de tags e de um bônus estrutural — nunca por texto exclusivo por carta.

| Terreno | Produção (Aurora) | Movimento | Combate | Tags padrão | Identidade estratégica |
|---|---|---|---|---|---|
| **Campo** | 1 Comida se trabalhado | Normal | — | `Aberto` | O hex neutro; potencial puro |
| **Floresta** | 1 Comida | Custa +1 Vel (exceto `Silvestre`) | +1 DEF para ocupante; bloqueia alcance através | `Cobertura`, `Inflamável` | Defesa, emboscada, motor Verdelar |
| **Montanha** | 1 Matéria | Só `Escalador` ou Vel ≥ 3 sobe | +1 ATQ atacando morro abaixo; visão +1 para alcance | `Elevado` | Artilharia, mineração, muros naturais |
| **Lago** | 1 Comida (pesca adjacente) | Só `Aquático`/`Voador` entram | Ocupante aquático: +1 DEF | `Molhado`, `Profundo` | Fosso natural; apaga fogo adjacente |
| **Pântano** | 1 Essência | Peso ≥ 3 fica `Atolado` (perde 1 Ordem) | −1 Vel para não-nativos | `Molhado`, `Úmido` | Guerra de atrito, fungos, maldições |
| **Deserto** | — (nada na Aurora) | Normal | Criaturas terminam Pulso aqui: −1 Vida se sem `Adaptado` | `Árido`, `Quente` | Terra de ninguém; arma de negação |
| **Ruínas** | 1 Essência se trabalhado | Normal | Alcance dentro de Ruínas: +1 ALC | `Assombrado`, `Instável` | Tesouro arriscado; sinergia com Maldições |
| **Vulcão** | 2 Matéria | Ninguém termina turno nele sem `Ígneo` | Erupção: a cada 4ª rodada, hexes adjacentes ganham `EmChamas` | `Quente`, `Perigoso` | Relógio de área; motor Cindral |
| **Templo** | 1 Essência | Normal | Curas custam −1 aqui | `Sagrado` | Suporte, condição de Herói, anti-Maldição |
| **Fortaleza** | — | Só dono e aliados entram livremente | +2 DEF; ocupante não pode ser `Empurrado` | `Murado` | Âncora de território; ponto de Marco |
| **Caverna** | 1 Matéria | Entrada única (hex vira túnel: conecta a outra Caverna sua) | Ocupante fica `Oculto` (não é alvo de alcance) | `Escuro` | Mobilidade subterrânea, ninhos |
| **Cristal** | 1 Essência +1 se `LuaCheia` | Normal | Habilidades ativas custam −1 Essência adjacente | `Ressonante`, `Frágil` | Supermagia concentrada; alvo prioritário |

**Regras gerais de terreno:**
- Jogar um Terreno sobre outro **substitui** (o antigo vai para o descarte do dono do hex) — guerra de terraformação é legítima, mas Fortalezas e Templos são `Fundados` (só substituíveis se destruídos antes).
- Terrenos não têm "vida", mas alguns são `Frágil` ou `Inflamável` e podem ser degradados a Campo por efeitos naturais.
- Hexes selvagens do mapa da temporada nunca incluem Fortaleza/Templo (evita snowball de posição inicial).

---

## 3. Clima — o modificador global

Uma **carta de Clima** ativa substitui a anterior (só existe 1 clima por vez) e dura **2 Pulsos** por padrão. O clima não tem texto de exceções: ele **muda tags do mundo**, e o Léxico Natural (Doc. 04) faz o resto.

| Clima | Efeito de tags | Consequências emergentes (exemplos) |
|---|---|---|
| **Chuva** | Todos os hexes ganham `Molhado`; remove `EmChamas` | Plantas crescem +1; fogo morre; eletricidade ganha alcance +1 em `Molhado`; desertos produzem 1 Comida |
| **Nevasca** | Hexes ganham `Congelante`; Lagos viram transitáveis (`Gelo`) | Criaturas sem `Adaptado` perdem 1 Vel; fosso vira ponte; colmeias dormem (insetos pulam a camada 5) |
| **Seca** | Remove `Molhado`; Campos perdem produção; `Inflamável` dobra propagação de fogo | Economia de comida sofre; decks de fogo brilham; Lagos encolhem (borda vira Campo) |
| **Tempestade** | Raios: no Pulso, o hex `Elevado` mais alto de cada metade leva 2 de dano elétrico | Montanhas ficam perigosas; `Metálico` conduz aos adjacentes; voadores pousam (perdem `Voador` até acabar) |
| **Lua Vermelha** | `Noturno` ganha +1 ATQ; `Sagrado` suprimido; Maldições custam −1 | O meta-turno do terror; templos apagam; predadores da noite dominam |
| **Neblina** | Alcance máximo global = 1; `Oculto` para todos em `Cobertura` | Jogo vira corpo-a-corpo; armadilhas e emboscadas brilham |
| **Primavera** | Hexes `Fértil`; curas +1; Comida +1 em Campos trabalhados | O clima da reconstrução e do boom econômico |
| **Outono** | Compra do Duplo Horizonte vê 3 cartas; Florestas produzem +1 Matéria (lenha) | O clima do planejamento e do valor |

**Regras de clima:**
- Clima entra no fim da fase de Ações de quem o jogou e anuncia-se com transformação audiovisual completa do tabuleiro (Doc. 19).
- Cada baralho pode ter no máx. 3 cartas de Clima. Contrajogo: qualquer jogador pode **sobrescrever** com outro clima; além disso, a construção `Observatório` e cartas "Céu Limpo" encerram climas.
- Clima afeta **os dois** jogadores — jogá-lo é uma aposta assimétrica, não um buff privado. É a ferramenta clássica de quebra de simetria para o jogador que está atrás (Pilar 9).

---

## 4. Visão e informação

Não usamos fog of war (Pilar 5: estado legível, eSports). "Visão" em TERRAVIVA significa **elegibilidade de alvo**: `Oculto` (Cavernas, Neblina, Cobertura para algumas criaturas) impede ser alvo de ataques à distância e habilidades direcionadas, mas a entidade permanece visível no tabuleiro. Informação perfeita, alvos imperfeitos.

---

## 5. REVISÃO CRÍTICA DA FASE 2 — Tabuleiro/Clima (auto-avaliação)

1. **Problema: 12 terrenos + 8 climas + tags = risco de sobrecarga cognitiva.** *Correção:* orçamento fechado de **16 tags naturais** no set base (lista canônica no Doc. 04); toda tag tem ícone único e tooltip de uma linha. Terrenos além dos 6 primeiros são introduzidos progressivamente na campanha/tutorial.
2. **Problema: substituir terreno do oponente podia apagar investimento sem interação.** *Correção:* terraformar hex controlado pelo inimigo custa +1 Matéria e só é possível com entidade sua adjacente — terraformação ofensiva exige presença de tabuleiro, criando contrajogo físico.
3. **Problema: Tempestade com alvo determinístico ("hex elevado mais alto") podia ser abusada como remoção precisa barata.** *Decisão:* mantida por ser transparente e antecipável (o defensor pode descer da montanha antes) — vira minijogo de posicionamento, não remoção garantida. Registrada como watch-item de balanceamento (Doc. 12).
4. **Problema: Caverna criando rede de túneis podia quebrar a geometria do mapa.** *Correção:* máximo de 2 Cavernas conectadas por jogador; atravessar túnel consome a Ordem inteira da criatura.
5. **Melhoria adotada:** climas "sazonais" (Primavera/Outono) adicionados para dar opções econômicas ao arquétipo construtor — clima não é só arma de agressão.

**Veredicto:** aprovado. Segue para IA das criaturas e Léxico Natural.
