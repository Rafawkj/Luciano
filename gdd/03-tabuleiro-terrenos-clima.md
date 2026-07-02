# TERRAVIVA — Tabuleiro, Terrenos e Clima

> **Documento 03 · Sistemas do Mundo** · v0.2

---

## 1. O tabuleiro é o reino

Grade de **45 hexágonos (9×5)** compartilhada. Não existem "lados" rígidos: existe território conquistado. O centro contém hexes selvagens ricos — o mapa empurra os reinos um contra o outro sem timer artificial.

### 1.1 Anatomia de um hex
- **Tipo de terreno** (Campo por padrão);
- **Tags naturais ativas** (ícones na borda: `Molhado`, `Fértil`, `EmChamas`...);
- **Controle** (aro colorido, ou cinza se selvagem);
- **Ocupante** (1 entidade; 2 se ambas Peso 1 do mesmo dono — enxames).

### 1.2 Por que hexes
Flanqueio, cerco, gargalos e rotas — o vocabulário posicional que faz terreno e alcance importarem. 45 hexes cabem numa tela de celular.

## 2. Os 10 terrenos do set base

| Terreno | Produção (Aurora) | Movimento | Combate | Tags padrão | Identidade |
|---|---|---|---|---|---|
| **Campo** | 1 Comida se trabalhado | Normal | — | `Aberto` | O hex neutro |
| **Floresta** | 1 Comida | +1 VEL de custo (exceto `Silvestre`) | +1 DEF; bloqueia alcance através | `Cobertura`, `Inflamável` | Defesa, emboscada, motor da Natureza |
| **Montanha** | 1 Matéria | Só `Escalador` ou VEL ≥ 3 | +1 ATQ morro abaixo | `Elevado` | Artilharia e mineração |
| **Lago** | 1 Comida (pesca adjacente) | Só `Aquático`/`Voador` | +1 DEF para aquáticos | `Molhado`, `Profundo` | Fosso natural; apaga fogo adjacente |
| **Pântano** | 1 Essência | Peso ≥ 3 fica `Atolado` | −1 VEL para não-nativos | `Molhado`, `Profano` | Atrito; lar dos Sangrentos |
| **Deserto/Terra Queimada** | — | Normal | Fim de rodada aqui: −1 VIDA sem `Adaptado` | `Árido`, `Quente` | Terra de ninguém; arma de negação |
| **Ruínas** | 1 Essência se trabalhado | Normal | ALC +1 de dentro | `Profano`, `Instável` | Tesouro arriscado; ossuários |
| **Campo de Açúcar** | 1 Comida +1 se `Fértil` | Normal | — | `Doce`, `Inflamável` | Motor dos Doces; atrai `Guloso` |
| **Fortaleza** | — | Só o dono entra livre | +2 DEF; ocupante não `Empurrável` | `Murado` | Âncora de território (Humanos) |
| **Geleira** | 1 Matéria | Escorregadio: entrar custa a Ordem inteira sem `Adaptado(Frio)` | +1 DEF para nativos | `Congelante`, `Elevado` | Muralha viva dos Gelados |

**Regras gerais:** terraformar substitui o terreno anterior (sobre hex controlado pelo inimigo: +1🔨 e exige entidade sua adjacente). `Fundada` (Fortaleza) só cai se destruída. Terrenos `Frágil`/`Inflamável` podem degradar a Campo pelas leis naturais.

## 3. Clima — o modificador global

Uma carta de Clima substitui a anterior e dura **2 rodadas**. Clima não tem texto de exceções: muda **tags do mundo**, e o Léxico faz o resto. Afeta os DOIS jogadores.

| Clima | Efeito de tags | Consequências emergentes (exemplos) |
|---|---|---|
| **Chuva** | Hexes `Molhado`; remove `EmChamas` | Fogo morre; plantas crescem +1; açúcar derrete (hexes `Doce` param 1 rodada) |
| **Nevasca** | Hexes `Congelante`; Lagos viram `Gelo` transitável | Sem `Adaptado(Frio)`: −1 VEL; o fosso vira ponte |
| **Seca** | Remove `Molhado`; Campos param; `Inflamável` espalha em dobro | Economia de comida sofre; decks de Fogo brilham |
| **Tempestade** | Raio no hex `Elevado` mais alto de cada metade (2 dano; conduz por `Metálico`/`Molhado`); voadores pousam | Montanhas perigosas; leitura de posicionamento |
| **Lua de Sangue** | `Profano` em todos os hexes; mortos-vivos +1 ATQ; curas −1 | O meta-turno dos Sangrentos |
| **Neblina** | ALC global = 1; `Oculto` em `Cobertura` | Jogo vira corpo-a-corpo; emboscadas brilham |
| **Primavera** | Hexes `Fértil`; curas +1; Campos +1🍎 | O clima da reconstrução |

**Contrajogo de clima:** sobrescrever com outro clima; evento neutro "Céu Limpo"; máx. 3 cartas de Clima por baralho (Gelados e Fogo: 4).

## 4. Visão e informação

Sem fog of war. `Oculto` = não pode ser **alvo direcionado** (a entidade permanece visível). Informação perfeita, alvos imperfeitos.

---

## 5. REVISÃO CRÍTICA (v0.2)
1. Terrenos reduzidos de 12 → 10 e realinhados às 6 facções (Campo de Açúcar e Geleira entram; Vulcão vira carta de Fogo; Templo/Cristal/Caverna arquivados para expansão).
2. Durações e efeitos convertidos de "Pulsos" para **rodadas** (resolvem no Crepúsculo).
3. Interação assinatura nova auditada: Chuva derrete açúcar — dá contrajogo econômico contra Doces sem carta dedicada (Léxico trabalhando).

**Veredicto:** aprovado.
