# TERRAVIVA — Sistema de Combate

> **Documento 05 · Fase 2 — Sistemas do Mundo**

---

## 1. Filosofia

Combate em TERRAVIVA é **xadrez com dentes**: 100% determinístico, decidido por posicionamento, terreno, tempo e leitura do Pulso. A matemática é simples o bastante para calcular de cabeça (Pilar 1) e o contexto é rico o bastante para nunca ser óbvia (Pilar 2).

## 2. Atributos de combate

| Atributo | Papel |
|---|---|
| **ATQ** | Força do golpe |
| **DEF** | Redução fixa de dano recebido |
| **VIDA** | Pontos de vida; 0 = vai ao descarte do dono |
| **VEL** | Hexes por Ordem de movimento; também desempata iniciativas de camada |
| **ALC** | Alcance de ataque em hexes (1 = corpo-a-corpo) |
| **PESO** | Classe física 1–5: quem pode empilhar, atravessar gelo/pontes, ser presa, ser empurrado |
| **ENE** | Energia: cargas para habilidades ativas (recarrega 1/Aurora) |
| **INT** | Inteligência 1–5: resistência a `Domesticado`, iscas e redirecionamentos (só afetam INT menor que a fonte) |
| **MORAL** | Ver Doc. 04 §2.4 |

## 3. Resolução de ataque (sempre nesta ordem)

```
1. Declarar (Ordem) ou disparar (Pulso/Territorial/Armadilha)
2. Verificar elegibilidade: alcance, Cobertura, Oculto
3. Dano = ATQ do atacante (± tags de terreno/clima/estado) − DEF do defensor
4. Mínimo 1 de dano se o ataque foi elegível ("toda garra arranha")
5. Aplicar tags da fonte (Venenoso, EmChamas, Elétrico...)
6. Retaliação: se o defensor sobrevive, é corpo-a-corpo e o atacante está ao alcance dele,
   devolve ⌊ATQ/2⌋ (sem re-retaliação)
7. Verificar Moral dos envolvidos e testemunhas com gatilhos
```

## 4. Regras espaciais

- **Bloqueio:** cada hex comporta 1 entidade (Peso ≥ 2). Corpos são muros.
- **Empilhamento de enxame:** duas entidades Peso 1 do mesmo dono compartilham hex e atacam juntas (somam ATQ, sofrem dano separado).
- **Empurrar:** efeitos `Empurrar(X)` deslocam o alvo X hexes; colidir com entidade/borda = 1 dano a ambos. Empurrar para `EmChamas`, Lago (não-aquático se afoga: 2 dano/Pulso até sair) ou Vulcão é combo legítimo do Léxico.
- **Cerco:** entidade sem hex livre adjacente ao início do Pulso ganha `Cercado` (−1 DEF). Formação importa.
- **Zona do Territorial:** entrar em hex adjacente a um Territorial inimigo dispara o ataque dele (1×/Pulso) — o mapa tem "campos minados vivos" visíveis.

## 5. Atacando o Coração do Reino

- O Coração (Vitalidade 25, DEF 0) ocupa 1 hex e é atacável como entidade.
- **Muralhas e Fortalezas** adjacentes ao Coração dão a ele +1 DEF cada (máx. +3).
- O Coração **não é** um alvo passivo: 1×/rodada ele emite um **Chamado** grátis (mini-ordem: move 1 criatura própria a até 2 hexes dele). A base se defende com carisma, não com estatísticas.
- Dano ao Coração é o relógio central do jogo; curas ao Coração são raras e caras por design (anti-stall, ver Doc. 12).

## 6. Construções em combate

- Construções têm VIDA e DEF, não atacam (exceto Torres e afins com ALC impresso).
- São `Inflamável` (madeira) ou `Metálico`/pedra conforme a carta — o Léxico decide como morrem.
- **Muralha**: construção especial de 3 segmentos em hexes adjacentes; bloqueia movimento e alcance ALC 1–2. Raízes (Lei 9) e cerco pesado são as respostas naturais.

## 7. Armadilhas

- Jogadas viradas para baixo num hex do seu território (custo pago às claras — o oponente sabe QUE existe, não QUAL é).
- Disparam na camada 8 do Pulso quando a condição impressa ocorre (ex.: "inimigo termina movimento aqui").
- Limite: 2 armadilhas armadas simultâneas por jogador. Reveladas se o hex for terraformado ou vasculhado (`Farejar`).

## 8. Exemplo de combate comentado

> **Contexto:** Tempestade ativa. Um brutamontes inimigo (ATQ 5/DEF 2/VIDA 7, `Metálico`) avança pelo gelo do lago congelado (Peso 4 — o gelo quebra! Lei 3). Ele cai: `Molhado`, perde a Ordem. No Pulso, a Tempestade atinge o hex `Elevado` da sua torre… mas sua torre tem para-raios (`Metálico`) e o dano **conduz** (Lei 4) pela água até o brutamontes `Molhado`: 2 de dano elétrico. Na sua vez, sua lanceira (ATQ 3) ataca do penhasco `Elevado` (+1): 4 − 2 DEF = 2 de dano. Ele cai para 3 de vida sem nunca ter chegado ao seu lado.
> **Lição:** nenhuma carta acima menciona outra; cinco regras públicas fizeram a história inteira.

---

## 9. REVISÃO CRÍTICA DA FASE 2 — Combate (auto-avaliação)

1. **Problema: "mínimo 1 de dano" enfraquece identidades de tanque.** *Análise:* mantido — remove estados insolúveis (DEF alta demais = jogo travado) e garante que enxames sempre tenham plano contra gigantes (Pilar 9). Tanques se diferenciam por VIDA e pelo Guardião, não por imunidade.
2. **Problema: Retaliação de ⌊ATQ/2⌋ pune agressão demais?** *Simulação de papel:* trocas favorecem o defensor em ~15% de valor — desejado, pois o mapa força o agressor a se expor; compensado pelo prêmio dos hexes selvagens centrais. Watch-item no Doc. 12.
3. **Problema: Coração com Chamado grátis pode congestionar o fim de jogo.** *Correção:* Chamado não funciona se o Coração foi danificado nesta rodada — pressão real desliga a defesa grátis.
4. **Problema: armadilhas quebram o princípio de informação aberta.** *Correção:* limitadas a 2, com custo público e contra-ferramenta universal (`Farejar` existe em 5+ cartas neutras). Informação oculta vira leitura de blefe orçamentado, não loteria.
5. **Melhoria adotada:** adição da regra de `Cercado` (−1 DEF) para recompensar manobra de flanco — sem ela, combates degeneravam em filas frontais nos testes de papel.

**Veredicto:** combate aprovado. Fase 2 completa; iniciar Fase 3 (economia e categorias de cartas).
