# TERRAVIVA — Léxico Natural e IA das Criaturas

> **Documento 04 · Fase 2 — Sistemas do Mundo**
> Este é o documento mais importante do projeto: define o "motor de vida" do jogo.

---

## 1. O Léxico Natural

O Léxico é o conjunto **fechado, público e universal** de tags e leis de interação. Cartas nunca reimplementam essas leis em texto; elas apenas carregam tags. Isso garante os Pilares 1, 4 e 8: intuitivo de aprender, profundo de combinar, e combos que **emergem** em vez de serem escritos.

### 1.1 As 16 tags naturais do set base

| Tag | Significado | Fontes típicas |
|---|---|---|
| `Molhado` | Hex/entidade encharcado | Chuva, Lagos, habilidades de água |
| `EmChamas` | Fogo ativo: 1 dano por Pulso ao ocupante; espalha para `Inflamável` adjacente | Habilidades ígneas, Vulcão |
| `Inflamável` | Pode pegar fogo | Florestas, construções de madeira, plantas |
| `Congelante` | −1 Vel; `Molhado`+`Congelante` = `Congelado` (perde o próximo Pulso) | Nevasca, sopros de gelo |
| `Metálico` | Conduz eletricidade a `Metálico`/`Molhado` adjacentes; imune a veneno | Autômatos, armaduras, construções de metal |
| `Elétrico` | Dano elétrico; segue condução | Tempestade, enguias, tecnologias |
| `Venenoso` | Quem sofre dano desta fonte ganha `Envenenado` (1 dano/Pulso, 2 Pulsos) | Fungos, aranhas, pântanos |
| `Fértil` | Produção +1; plantas aqui crescem +1 estágio | Primavera, adubação, rios |
| `Úmido` | Fungos espalham para cá; madeira aqui não queima | Pântano, sombra de floresta |
| `Elevado` | +1 ATQ atacando para baixo; alvo preferencial de raios | Montanhas, torres |
| `Cobertura` | Não pode ser alvo de ALC > 1 vindo de fora | Florestas, muralhas |
| `Oculto` | Não pode ser alvo direcionado; revela-se ao agir | Cavernas, Neblina, camuflagem |
| `Sagrado` | Maldições não entram; curas +1 | Templos, bênçãos |
| `Assombrado` | Criaturas aqui não curam; Essência produzida +1 | Ruínas, maldições de área |
| `Noturno` | Ativa sob Lua Vermelha/efeitos de noite | Predadores da noite, morcegos |
| `Adaptado(X)` | Ignora penalidade do contexto X (frio, deserto, pântano...) | Espécies nativas |

### 1.2 Leis naturais (sempre verdadeiras, sem exceções)

1. **Água apaga fogo:** `Molhado` remove/impede `EmChamas`.
2. **Fogo consome madeira:** `EmChamas` em hex `Inflamável` espalha 1 hex `Inflamável` por Pulso e degrada Florestas a Campo após 2 Pulsos.
3. **Gelo + água = travessia:** Lago `Congelante` é transitável; quebra sob Peso ≥ 4 (a criatura cai: `Molhado` + perde a Ordem).
4. **Metal conduz:** dano `Elétrico` salta para entidades `Metálico`/`Molhado` adjacentes (uma vez por cadeia por Pulso).
5. **Umidade cria vida pequena:** fungos e plantas com `Espalhar` só se propagam para hexes `Úmido`/`Molhado`/`Fértil`.
6. **Frio adormece o sangue frio:** insetos e répteis (espécies marcadas) pulam sua camada do Pulso sob `Congelante`.
7. **Veneno não morde metal:** `Metálico` ignora `Envenenado`.
8. **O sagrado repele o profano:** Maldições não podem ser jogadas em/atravessar hexes `Sagrado`.
9. **Raízes rompem pedra:** plantas com `Raízes` causam dano dobrado a construções e muralhas.
10. **Todo ser precisa comer:** entidades com `Fome(X)` consomem X Comida na Aurora; sem pagamento, ganham `Faminto` (−1 ATQ, comportamento muda para buscar comida — inclusive a SUA plantação).

> **Nota de design:** a lista de leis é impressa no jogo ("Códice do Regente") e cabe numa tela. É o nosso equivalente a regras de xadrez: pequena, absoluta, infinitamente combinável.

---

## 2. IA das criaturas — o sistema de Comportamento

Toda criatura tem exatamente **1 Comportamento** (às vezes condicional). Durante o **Pulso**, criaturas que não receberam Ordem neste turno executam seu comportamento. Criaturas ordenadas gastaram sua vontade — o Pulso as ignora (exceto reflexos como Retaliação).

> **Princípio de agência:** o jogador sempre pode "domar" a criatura com uma Ordem (ficha de ação). O comportamento é o que ela faz **de graça** quando você não gasta ação nela. IA não substitui o jogador; ela multiplica o valor do posicionamento. Setas de intenção são sempre visíveis para ambos os jogadores.

### 2.1 Os 10 comportamentos do set base

| Comportamento | Regra determinística no Pulso | Leitura estratégica |
|---|---|---|
| **Predador** | Move até a Vel em direção à **presa válida** mais próxima (criatura inimiga de Peso menor); ataca se alcançar | Míssil teleguiado lento; alimente-o com alvos ou desvie-o com iscas |
| **Presa** | Se inimigo adjacente ou a 2 hexes, foge 1 hex na direção oposta (prioriza território aliado) | Frágil mas escorregadia; ótima coletora que se autopreserva |
| **Engenheiro** | Se em hex com construção aliada danificada: repara 1. Senão, avança 1 hex rumo à construção aliada mais próxima | Manutenção grátis; núcleo de decks-fortaleza |
| **Coletor** | Colhe 1 recurso do hex atual se produtivo; senão move 1 rumo ao hex produtivo livre mais próximo | Economia automática; alvo prioritário do oponente |
| **Guardião** | Se aliado adjacente foi atacado neste turno, move-se para interceptar (troca de hex permitida); senão mantém posição em `Postura` (+1 DEF) | O "tanque com cérebro" |
| **Nômade** | Move 1 hex por Pulso na direção do Coração inimigo, evitando combate se possível | Pressão constante e barata; win condition de tempo |
| **Colônia** | Se 2+ membros da mesma colônia adjacentes: geram 1 token de operária a cada 2 Pulsos (máx. definido na carta) | Crescimento exponencial se ignorado; fraco a dano em área |
| **Enraizado** | Não se move nunca; a cada Pulso cresce +1 estágio (cartas definem os estágios) | Investimento de tempo→poder; pá de contrajogo: mover é impossível, remover é obrigatório |
| **Curandeiro** | Move até 2 rumo ao aliado ferido mais próximo; cura 1 se adjacente | Sustain automático; caça-lo é abrir a defesa inimiga |
| **Territorial** | Ataca automaticamente qualquer inimigo que ENTRE em hex adjacente (1×/Pulso); nunca deixa seu terreno de origem | Zona de negação viva; o mapa dita onde ele é forte |

### 2.2 Resolução de ambiguidade (regras de desempate, nesta ordem)
1. Alvo/destino mais próximo (distância em hexes);
2. Alvo com menor Vida atual;
3. Ordem de leitura do tabuleiro (noroeste → sudeste).

Sempre determinístico, sempre igual para os dois jogadores, sempre exibido nas setas de intenção. **Um bot e um humano chegam à mesma previsão** — requisito para competitivo e replay.

### 2.3 Estados que modificam comportamento
- `Faminto`: comportamento vira Coletor-de-Comida (até comer — de qualquer fonte, incluindo plantações inimigas... ou suas).
- `Apavorado` (moral quebrada, Doc. 05): vira Presa por 1 Pulso.
- `Dormindo`: não executa Pulso; cura 1/Pulso; acorda se sofrer dano ou receber Ordem.
- `Domesticado` (efeitos de encantador): executa o comportamento **a favor do controlador do efeito** no próximo Pulso.

### 2.4 Personalidade e Moral (a alma da carta)
Cada criatura tem **Personalidade** (texto curto: "covarde", "orgulhoso", "guloso"...) que define seu **gatilho de Moral**:
- Moral é um valor 1–5. Eventos contrários à personalidade reduzem a moral (ex.: "orgulhoso" perde 1 de moral se recuar; "guloso" perde se passar uma Aurora sem comer).
- Moral 0 = `Apavorado` por 1 Pulso, depois reseta para 1.
- Moral cheia (5) concede o **Traço Exaltado** da carta (pequeno bônus impresso, ex.: +1 ATQ).

**Racional:** moral transforma flavor em mecânica sem RNG — cada gatilho é público e determinístico. É também nossa maior alavanca de carisma: a ovelha covarde É covarde nas regras.

---

## 3. Exemplo integrado (uma jogada que só existe em TERRAVIVA)

> Você tem uma Floresta (`Inflamável`, `Cobertura`) cheia de coletores inimigos. Joga um evento ígneo no hex central: `EmChamas`. No Pulso, o fogo espalha pela Floresta (Lei 2). Os coletores inimigos não são Presas — não fogem — e queimam. O oponente responde na rodada seguinte com Chuva: `Molhado` apaga tudo (Lei 1)... mas a Chuva também faz o SEU pântano espalhar fungos `Venenoso` (Lei 5) para o território dele. Nenhuma dessas cartas menciona a outra. O mundo fez tudo.

---

## 4. REVISÃO CRÍTICA DA FASE 2 — Léxico/IA (auto-avaliação)

1. **Problema: Predador podia ser "removedor grátis" bom demais.** *Correção:* Predador só considera presa válida **de Peso menor** e move-se no Pulso (lento, telegráfado). Counterplay: pesos iguais o ignoram, iscas o desviam, Guardiões interceptam.
2. **Problema: loops de comportamento (Presa foge → Predador segue → infinito).** *Correção:* cada entidade executa **no máximo 1 movimento + 1 ação por Pulso**; o Pulso tem camadas únicas, sem re-verificação. Loop impossível por construção.
3. **Problema: 10 comportamentos + 16 tags + 10 leis — o teto de complexidade foi atingido?** *Análise:* sim, e é intencional que seja ORÇAMENTO MÁXIMO: expansões futuras devem preferir **novas combinações** a novos vocábulos (regra de governança de design registrada no Doc. 21). Tudo junto ainda cabe em 3 telas de "Códice".
4. **Problema: Moral parecia subsistema demais para o set base.** *Decisão após debate interno:* mantida, porém **simplificada** — moral só tem 3 estados visíveis na UI (Exaltado/Normal/Apavorado) e um único gatilho por carta. A versão de 5 pontos fica interna. Corta 80% da carga cognitiva mantendo 100% do carisma.
5. **Confirmação do item pendente da Fase 1:** ordem Presa-foge-antes-de-Predador-caçar validada em simulação de papel — caçadas exigem cerco em 2 turnos, o que gera o gameplay de armadilha espacial desejado.

**Veredicto:** aprovado. Segue para combate.
