# TERRAVIVA — Léxico Natural e Instintos

> **Documento 04 · Sistemas do Mundo** · v0.2 — substitui a antiga "IA das criaturas": criaturas **não agem sozinhas**; elas têm **Instintos** (reações impressas, com gatilho público) e o mundo tem **leis**.

---

## 1. O Léxico Natural

Conjunto **fechado, público e universal** de tags e leis. Cartas carregam tags; nunca reescrevem as leis. É o que torna o jogo intuitivo (Pilar 1) e combinatório (Pilar 8).

### 1.1 As 14 tags naturais do set base

| Tag | Significado | Fontes típicas |
|---|---|---|
| `Molhado` | Encharcado | Chuva, Lagos |
| `EmChamas` | 1 dano/Crepúsculo ao ocupante; espalha para `Inflamável` adjacente | Fogo, habilidades ígneas |
| `Inflamável` | Pode pegar fogo | Florestas, madeira, açúcar |
| `Congelante` | −1 VEL; `Molhado`+`Congelante` = `Congelado` (perde a próxima Ordem) | Nevasca, sopros de gelo |
| `Metálico` | Conduz eletricidade; imune a veneno | Armaduras, máquinas humanas |
| `Venenoso` | Dano desta fonte aplica `Envenenado` (1 dano/Crepúsculo, 2 rodadas) | Pântanos, aranhas |
| `Fértil` | Produção +1; plantas crescem +1 estágio | Primavera, adubo |
| `Doce` | Açucarado: atrai `Guloso`; derrete sob Chuva; queima MUITO bem | Terrenos e criaturas dos Doces |
| `Profano` | Curas não funcionam; mortos-vivos aqui curam 1/Crepúsculo | Ruínas, Pântano, Lua de Sangue |
| `Sagrado` | Maldições não entram; mortos-vivos sofrem 1/Crepúsculo aqui | Capelas humanas, bênçãos |
| `Elevado` | +1 ATQ para baixo; alvo de raios | Montanhas, torres, geleiras |
| `Cobertura` | Não é alvo de ALC > 1 externo | Florestas, muralhas |
| `Oculto` | Não é alvo direcionado; revela ao agir | Neblina, camuflagem |
| `Adaptado(X)` | Ignora penalidade do contexto X | Espécies nativas |

### 1.2 As 10 leis naturais (sempre verdadeiras)

1. **Água apaga fogo:** `Molhado` remove/impede `EmChamas`.
2. **Fogo consome:** `EmChamas` espalha 1 hex `Inflamável` por Crepúsculo; Florestas/Açúcar degradam a Campo/Terra Queimada após 2 Crepúsculos queimando.
3. **Gelo + água = travessia:** Lago `Congelante` é transitável; quebra sob Peso ≥ 4 (cai: `Molhado`, perde a Ordem).
4. **Metal conduz:** dano `Elétrico` salta para `Metálico`/`Molhado` adjacentes (1×/cadeia).
5. **Doce derrete e atrai:** Chuva/calor desativam hexes `Doce` por 1 rodada; criaturas `Guloso` (qualquer dono!) ganham +1 VEL movendo-se em direção a `Doce`.
6. **Frio adormece:** criaturas de sangue frio (marcadas) perdem o Instinto sob `Congelante`.
7. **Veneno não morde metal nem osso:** `Metálico` e `Ossudo` ignoram `Envenenado`.
8. **O sagrado repele o profano** (e vice-versa): Maldições não entram em `Sagrado`; curas não funcionam em `Profano`.
9. **Raízes rompem pedra:** `Raízes` causa dano dobrado a construções e muralhas.
10. **Todo ser precisa comer:** `Fome(X)` consome X Comida na Aurora; sem pagamento: `Faminto` (−1 ATQ; pode comer plantação — inclusive a sua).

**Regra de precedência:** quando tags conflitam (ex.: clima aplica `Profano` global, mas uma Capela cria `Sagrado`), **fontes permanentes (terrenos, construções `Fundada`) prevalecem sobre clima**, e clima prevalece sobre efeitos temporários. Descoberta no playtest de papel da Partida 2 (Doc. 16).

> O Códice do Regente (in-game) mostra as 10 leis em uma tela. São as regras de xadrez do jogo: poucas, absolutas, infinitamente combináveis.

---

## 2. Instintos — reações, não vontade própria

Um **Instinto** é uma habilidade reativa impressa na criatura, com **gatilho público**. Ele dispara sozinho — mas só em resposta a algo que um jogador fez. Ninguém anda nem ataca "por conta própria": o Instinto é o reflexo, o jogador é o cérebro.

### 2.1 Os 8 Instintos do set base

| Instinto | Gatilho → Reação |
|---|---|
| **Guardião** | Aliado adjacente é atacado → esta criatura intercepta (recebe o golpe no lugar) |
| **Sentinela** | Inimigo entra em hex adjacente → ataca-o imediatamente (1×/rodada) |
| **Contra-ataque** | Sobrevive a ataque corpo-a-corpo → retalia com ATQ CHEIO (em vez de metade) |
| **Colheita** | Recebe Ordem de mover e termina em hex produtivo → coleta 1 recurso de graça |
| **Reparador** | Termina Ordem adjacente a construção danificada → repara 1 |
| **Médico** | Termina Ordem adjacente a aliado ferido → cura 1 |
| **Fuga** | Sobreviveria a um ataque com 1 de VIDA → em vez disso recua 1 hex e evita o dano (1×/partida) |
| **Ímpeto** | Pode agir na rodada em que entra (sem "enjoo de invocação") |

Regras: cada criatura tem **no máximo 1 Instinto** (+tags). Gatilhos são verificados na hora, sem fila nem fase própria. Tudo aparece na UI como resposta instantânea — o jogo parece vivo porque REAGE, não porque age.

### 2.2 Estados que alteram criaturas
- `Faminto` — −1 ATQ até comer (Lei 10).
- `Exausta` — não retalia nem usa Instinto até o fim da rodada (efeito de Trabalhar e de alguns golpes).
- `Congelado` — perde a próxima Ordem.
- `Envenenado` — 1 dano/Crepúsculo por 2 rodadas.
- `Guloso` — marca de personalidade: interage com a Lei 5 (o Javali dos Humanos e metade dos Doces têm).

## 3. Exemplo integrado

> O oponente Doce montou um Campo de Açúcar defendido. Você (Fogo) lança uma fagulha: açúcar é `Inflamável` — e queima em dobro (caramelo!). Ele responde com Chuva para apagar (Lei 1)… mas a Chuva também **derrete** os hexes `Doce` (Lei 5): a economia dele para por uma rodada de qualquer jeito. Nenhuma carta citou a outra. O mundo fez tudo.

---

## 4. REVISÃO CRÍTICA (v0.2)
1. **O que se perdeu com o corte da autonomia:** caçadas automáticas e ecologia espontânea. **O que se ganhou:** zero sensação de perda de controle, rodadas mais rápidas, e a leitura "gatilho→reação" é padrão consolidado do gênero (fácil de ensinar). Trade aceito pela direção.
2. **Moral/Personalidade removidos como sistema numérico** — viravam carga sem a fase automática. O carisma migrou para: tag `Guloso` (mecânica real via Lei 5), Instintos temáticos (Fuga na ovelha) e animação/som. Flavor com dente, sem contador.
3. **Orçamento de vocabulário v0.2:** 14 tags + 10 leis + 8 Instintos (era 16+10+10) — teto reduzido junto com o número de facções. Expansões: máx. +2 tags e +1 Instinto cada.
4. **INT e MORAL saem da ficha de criatura** (eram suportes da autonomia). Ficha final: Custo · ATQ · DEF · VIDA · VEL · ALC · PESO · ENE (cargas de ativa) + Instinto + tags.

**Veredicto:** aprovado.
