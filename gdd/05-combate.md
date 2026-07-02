# TERRAVIVA — Sistema de Combate

> **Documento 05 · Sistemas do Mundo** · v0.2

---

## 1. Filosofia

Xadrez com dentes: 100% determinístico, decidido por posicionamento, terreno, tempo e leitura de Instintos. Matemática simples de cabeça; contexto rico o bastante para nunca ser óbvia.

## 2. Atributos

| Atributo | Papel |
|---|---|
| **ATQ** | Força do golpe |
| **DEF** | Redução fixa de dano |
| **VIDA** | 0 = descarte |
| **VEL** | Hexes por Ordem de movimento |
| **ALC** | Alcance (1 = corpo-a-corpo) |
| **PESO** | Classe física 1–5: empilhar, gelo, pontes, empurrão |
| **ENE** | Cargas de habilidade ativa (recarrega 1/Aurora) |

## 3. Resolução de ataque (sempre nesta ordem)

```
1. Declarar (Ordem) ou disparar (Sentinela/Armadilha)
2. Elegibilidade: alcance, Cobertura, Oculto
3. Instintos defensivos (Guardião intercepta? Fuga?)
4. Dano = ATQ (± tags de terreno/clima/estado) − DEF do defensor
5. Mínimo 1 de dano se elegível ("toda garra arranha")
6. Tags da fonte aplicam (Venenoso, EmChamas...)
7. Retaliação: defensor corpo-a-corpo vivo devolve ⌊ATQ/2⌋ (ATQ cheio com Contra-ataque)
```

## 4. Regras espaciais

- **Bloqueio:** 1 entidade por hex (2 se Peso 1 do mesmo dono — somam ATQ, sofrem dano separado).
- **Empurrar(X):** desloca X hexes; colisão = 1 dano a ambos. Empurrar para fogo, lago ou espinhos é combo legítimo do Léxico.
- **Cercado:** sem hex livre adjacente no início da sua Aurora = −1 DEF. Flanquear paga.
- **Zona de Sentinela:** entrar adjacente a uma Sentinela inimiga dispara o ataque dela — "campos minados vivos", visíveis.

## 5. Atacando o Coração do Reino

- Coração: Vitalidade 25, DEF 0, ocupa 1 hex.
- Muralhas/Fortalezas adjacentes dão +1 DEF cada (máx. +3).
- 1×/rodada o Coração emite um **Chamado** grátis (move 1 criatura sua a até 2 hexes dele) — indisponível se ele sofreu dano nesta rodada.
- Curas ao Coração são raras e caras por design (anti-stall).

## 6. Construções em combate

- Têm VIDA e DEF; não atacam (exceto Torres com ALC impresso).
- Morrem pelo Léxico: madeira queima, pedra teme `Raízes`, metal conduz.
- **Muralha:** 3 segmentos; bloqueia movimento e ALC 1–2. Respostas naturais: raízes, aríetes, cerco, voo.

## 7. Armadilhas

- Viradas para baixo em hex seu; custo pago às claras; máx. 2 armadas.
- Disparam imediatamente quando a condição impressa ocorre.
- Reveláveis por `Farejar` e por terraformação do hex.

## 8. Exemplo comentado

> Tempestade ativa. O cavaleiro `Metálico` dos Humanos avança pelo lago congelado — Peso 4: o gelo quebra (Lei 3), ele cai `Molhado` e perde a Ordem. No Crepúsculo, o raio atinge a torre `Elevado`… que é `Metálico` e conduz (Lei 4) pela água até o cavaleiro: 2 de dano. Na sua vez, sua lanceira ataca do penhasco (+1 de `Elevado`). Cinco regras públicas, nenhum texto de carta especial.

---

## 9. REVISÃO CRÍTICA (v0.2)
1. Camadas do antigo Pulso removidas; Sentinela e Guardião preservam a defesa reativa sem fase própria.
2. "Mínimo 1 de dano" mantido (nunca há estado insolúvel).
3. `Cercado` movido para verificação na Aurora (não existe mais Pulso) — mesmo efeito, novo relógio.

**Veredicto:** aprovado.
