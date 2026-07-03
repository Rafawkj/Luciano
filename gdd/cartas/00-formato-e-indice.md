# Set Inicial "PRIMEIRA REGÊNCIA" — Formato e Índice

> **Documento 09 · Cartas** · v0.3
> **115 cartas: 6 facções × 15 + 25 Neutras.**
> O jogo tem exatamente **5 categorias de carta**: **Tropas · Construções · Terrenos · Feitiços · Climas.**

## As 5 categorias

| Categoria | O que faz | Subtipos possíveis |
|---|---|---|
| **Tropa** | Unidade no mapa; age por Ordens; tem Instinto e atributos | **Lendária** (1 por baralho, entra pela Condição de Lenda) |
| **Construção** | Permanente no mapa; produz/afeta sem gastar fichas | Muralha, Fundada |
| **Terreno** | Transforma um hex permanentemente; define tags | — |
| **Feitiço** | Efeito instantâneo ou colocado | **Reflexo** (responde fora do turno), **Armadilha** (oculto num hex), **Maldição** (anexo oculto), **Formação** (anunciado), **Pavio** (contagem) |
| **Clima** | Global, 2 rodadas, substitui o anterior, afeta ambos | — |

## Esquema de dados (tropas)

```
#### N. Nome da Carta
Tropa · Facção · Raridade | Classe · Espécie · Elemento
Custo | ATQ DEF VIDA VEL ALC PESO ENE
Instinto: (1 dos 8 do Léxico ou —) | Tags: (do Léxico)
Passiva: ...
Ativa (custo em ⚡): ...
Anim: sugestão | Som: sugestão
"Flavor de 1 linha."
```

Não-tropas usam o subconjunto aplicável. Tropas Lendárias incluem a **Condição de Lenda** (quest pública).

## Convenções
- Custos: 🍎 Comida · 🔨 Matéria · ✨ Essência · **❤ VIDA** (Sangrentos) · **☠ Cadáver** (Sangrentos).
- Raridade: C, I, R, L.
- Regra editorial: **máx. 2 linhas de regra**; vocabulário exclusivamente do Léxico (Doc. 04).

## Índice (115)

| Arquivo | Conteúdo | Qtde |
|---|---|---|
| 01-gelados-doces.md | Gelados (1–15), Doces (16–30) | 30 |
| 02-sangrentos-natureza.md | Sangrentos (31–45), Natureza (46–60) | 30 |
| 03-fogo-humanos.md | Fogo (61–75), Humanos (76–90) | 30 |
| 05-neutras.md | Neutras (91–115): 10 Tropas · 5 Terrenos · 4 Construções · 4 Feitiços · 2 Climas | 25 |

Distribuição típica por facção (15): 1 Tropa Lendária · 7–8 Tropas · 1–2 Terrenos · 1–2 Construções · 2–3 Feitiços/Climas.
