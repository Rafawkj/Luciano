# 🦇 Vampire Prototype — Protótipo Dark Fantasy (Godot 4)

Protótipo jogável de um mini mundo aberto *dark fantasy* medieval.
O protagonista é um **vampiro** que pode alternar entre a **forma humanoide** e a
**forma de morcego** (que voa por tempo limitado).

O foco do jogo é **exploração** e **imersão na atmosfera dark fantasy**: uma vila
silenciosa e enevoada (Covado das Sombras), iluminada só pelo luar e por tochas
tremeluzentes, cheia de cantos para descobrir e fragmentos de história espalhados.

> ⚠️ Este é um **protótipo** — a base do projeto. Ainda não é o jogo completo:
> usa formas geométricas simples no lugar de modelos 3D, para focar na
> jogabilidade e na ambientação.

---

## 🎮 Controles

| Tecla            | Ação                                             |
|------------------|--------------------------------------------------|
| **W A S D**      | Andar                                            |
| **Shift**        | Correr (segurando, na forma vampiro)             |
| **Espaço**       | Pular — aperte de novo no ar para o **pulo duplo** |
| **Espaço** (na parede) | **Pulo de parede** (impulsiona para longe e para cima) |
| **Espaço** (morcego) | Subir batendo asas                          |
| **T**            | Transformar entre vampiro ↔ morcego              |
| **Mouse**        | Girar a câmera                                    |
| **ESC**          | Liberar / prender o cursor do mouse              |

### 🏃 Parkour (forma vampiro)

A movimentação foi feita para ser **fluida** e divertida de encadear:

- **Pulo duplo** — aperte Espaço uma segunda vez no ar.
- **Wall slide** — encoste numa parede caindo (segurando a direção contra ela)
  para **deslizar devagar**.
- **Wall jump** — aperte Espaço enquanto desliza para saltar da parede.
- **Pulo variável** — segure Espaço para pular mais alto; solte para pular baixo.
- **Coyote time** e **jump buffer** deixam os pulos mais perdoados/precisos.
- **Telhados pisáveis**: suba pelos **caixotes** e **toldos**, corra pelos
  telhados e atravesse as **passarelas** entre as casas.

### 🦇 A Ascensão (parkour + voo combinados)

A leste da entrada há uma **rota vertical** que mistura as duas formas:

1. Suba a pé (vampiro) pelas plataformas e **wall jumps**.
2. No topo do trecho a pé, o salto fica **alto e longe demais** — vire
   **morcego (T)** e voe até a plataforma marcada por uma **luz azul**.
3. **Pouse** (isso recarrega o voo) e aperte **T** para voltar a vampiro.
4. Faça o parkour lá no alto e repita o salto de morcego até o **mirante**
   mais alto do vale.

As **luzes azuis-frias** sempre indicam "voe até aqui"; as luzes quentes são
apenas tochas de ambientação.

**Forma morcego:** segure **Espaço** para voar. Você tem ~5 segundos de voo;
o "tanque" recarrega assim que você toca o chão de novo.

### 🎯 O que fazer

**Explore a vila** de Covado das Sombras: ande pelas ruas, espie a praça com o
**poço**, o **cemitério** com lápides tortas, a **capela em ruínas** com sua vela
acesa, as **árvores mortas** e o **portão** de entrada. Ao se aproximar de cada
lugar marcante, um **texto de lore** aparece no topo da tela.

Procure também os lugares de **beleza triste** — a sensação de que este mundo já
foi lindo antes da tragédia:

- 🌼 **Jardim das Lamentações** — um jardim morto onde só restaram flores brancas.
- 🗿 **Estátua que chora água escura** — no centro do jardim, chorando há anos.
- 📖 **Biblioteca antiga** — sem teto, iluminada por um feixe de luar.
- 🕯️ **Salão de baile vazio** — no castelo arruinado, onde só o luar dança.
- 🌉 **Ponte quebrada sobre o rio de névoa** — partida ao meio.
- 🗼 **Torre com vista para todo o vale** — alcançável apenas voando.

No alto da **torre** existe uma **janela com sacada** que o pulo do vampiro **não
alcança**. Vire morcego (**T**) e **voe (Espaço)** até a sacada — ao chegar, uma
mensagem especial aparece na tela. 🦇

---

## 🌒 Atmosfera & exploração (a "vibe" dark fantasy)

O clima é construído por vários detalhes trabalhando juntos:

- **Luar frio** (luz direcional azulada) + **lua** brilhante no céu.
- **Tochas e velas** com luz quente que **tremula** (`scripts/tocha.gd`).
- **Névoa volumétrica** e *bloom/glow* fazem as janelas e chamas brilharem no escuro.
- **Pontos de interesse** (`scripts/ponto_de_interesse.gd`): áreas invisíveis que
  exibem textos de história quando você se aproxima — recompensando a exploração.
- A vila inteira é **gerada por código** (`scripts/village_builder.gd`), o que
  facilita aumentá-la: basta adicionar coordenadas nas listas do script.

---

## 📁 Estrutura do projeto

```
.
├── project.godot        # Configuração do projeto + mapa de teclas (Input Map)
├── icon.svg             # Ícone do projeto
├── scenes/
│   ├── world.tscn       # CENA PRINCIPAL: terreno, luar, lua, névoa, vila e HUD
│   ├── player.tscn      # O personagem (vampiro/morcego) + câmera em 3ª pessoa
│   └── village.tscn     # A torre (com a janela alta) + o Construtor da vila
├── scripts/
│   ├── player.gd            # Movimento, câmera, voo e transformação (+ juice)
│   ├── hud.gd               # HUD: forma atual, barra de voo e pulo duplo
│   ├── audio_ambiente.gd    # Som ambiente gerado por código (vento, sino, piano)
│   ├── janela_alta.gd       # Gatilho que detecta quando você chega à janela alta
│   ├── village_builder.gd   # Monta a vila por código (casas, poço, cemitério...)
│   ├── tocha.gd             # Faz a luz das tochas/velas tremular
│   └── ponto_de_interesse.gd # Mostra textos de lore ao explorar
└── assets/              # (vazia) Para modelos, texturas e sons futuros
```

### O que cada arquivo faz

- **`project.godot`** — Define o nome do jogo, qual cena abre primeiro
  (`world.tscn`) e o **Input Map** (os nomes das ações como `mover_frente`,
  `pular`, `correr`, `transformar` ligados às teclas).

- **`scenes/world.tscn`** — O "mundo". Contém:
  - `Chao` — um terreno plano (120×120) com **colisão**, feito de um `StaticBody3D`.
  - `LuzDirecional` — o luar (luz azulada vinda de cima).
  - `Lua` — uma esfera brilhante (emissiva) no céu.
  - `WorldEnvironment` — céu noturno, névoa volumétrica e *glow* para o clima sombrio.
  - `Vila` — uma instância de `village.tscn`.
  - `Player` — uma instância da cena do personagem.
  - `HUD` — um `CanvasLayer` com um rótulo de texto na tela (instruções e lore).

- **`scenes/village.tscn`** — A vila:
  - `Torre` — torre de pedra alta. No topo ficam a `JanelaPainel` (a janela que
    brilha), o `Balcao` (sacada com colisão onde você pousa) e o `GatilhoJanela`
    (uma `Area3D` que detecta a chegada do jogador).
  - `Construtor` — um nó com o script `village_builder.gd`, que cria todo o
    resto da vila (casas, poço, portão, cemitério, capela, árvores e tochas).

- **`scripts/hud.gd`** — Interface na tela (canto superior esquerdo): forma
  atual, barra de **tempo de voo** (fica vermelha quando acaba) e estado do
  **pulo duplo**. Os widgets são criados por código.

- **`scripts/audio_ambiente.gd`** — Som ambiente **sintetizado por código**
  (sem arquivos): vento contínuo, um sino distante de tempos em tempos e um
  **piano solitário** no salão de baile (áudio 3D — só se ouve por perto). Para
  usar sons reais depois, é só atribuir um `.ogg`/`.wav` ao `.stream` dos players.

- **`scripts/janela_alta.gd`** — Detecta quando o jogador entra na sacada da
  janela alta e mostra uma mensagem na tela. Como o pulo não alcança aquela
  altura, só dá para chegar **voando como morcego**.

- **`scripts/village_builder.gd`** — Constrói a vila inteira por código a partir
  de listas de posições. Cada peça (casa, tocha, poço, túmulo, árvore, capela,
  jardim, estátua, biblioteca, salão de baile, ponte de névoa, ponto de
  interesse) tem sua própria função, fácil de ler e ajustar.

- **`scripts/tocha.gd`** — Colocado nas luzes das tochas/velas; faz o brilho
  oscilar para imitar uma chama.

- **`scripts/ponto_de_interesse.gd`** — Mostra um texto de lore no HUD quando o
  jogador entra na área; some quando ele se afasta.

- **`scenes/player.tscn`** — O personagem. Sua árvore de nós:
  - `Player` (`CharacterBody3D`) — o corpo físico com colisão (uma cápsula).
  - `ModeloVampiro` — as malhas visíveis na forma vampiro (corpo + cabeça).
  - `ModeloMorcego` — as malhas da forma morcego (corpo + duas asas), começa oculto.
  - `PivoCamera` → `Camera3D` — a câmera em 3ª pessoa que segue e gira com o mouse.

- **`scripts/player.gd`** — O cérebro do personagem, bastante comentado:
  - Parkour fluido na forma vampiro: aceleração/atrito, pulo duplo, wall slide,
    wall jump, pulo variável, coyote time, jump buffer e gravidade assimétrica.
  - Câmera em `SpringArm3D` (não atravessa telhados/paredes) com *FOV kick*.
  - **Feel & juice**: squash & stretch ao pular/aterrissar, poeira na
    aterrissagem, faíscas + flash de luz ao transformar, o modelo virando na
    direção do movimento e o morcego batendo as asas.
  - Transformação ao apertar **T**.
  - Voo (com aceleração) por tempo limitado na forma morcego.

---

## ▶️ Como testar

1. Instale a **Godot Engine 4.3** (ou mais recente) — download em
   <https://godotengine.org/download>. É um único executável, não precisa instalar nada.
2. Abra a Godot e clique em **Import** (Importar).
3. Selecione o arquivo **`project.godot`** desta pasta e abra o projeto.
4. Pressione **F5** (ou o botão ▶️ "Run Project" no canto superior direito).
5. O jogo abre direto na cena `world.tscn`. Use **WASD** para andar, **Shift**
   para correr, **Espaço** para pular, **mouse** para olhar e **T** para virar morcego.
6. Como morcego, **segure Espaço** para voar até o tempo acabar; pouse para recarregar.

> 💡 Dica: se o mouse "sumir" e você quiser usar a interface, aperte **ESC**
> para liberar o cursor.

---

## 🔧 Ajustes fáceis

No início de `scripts/player.gd` há constantes prontas para você experimentar:

- `VELOCIDADE_ANDAR`, `VELOCIDADE_CORRER`, `FORCA_PULO` — sensação de movimento.
- `VELOCIDADE_VOO`, `VELOCIDADE_SUBIDA`, `TEMPO_MAXIMO_VOO` — como o morcego voa.
- `SENSIBILIDADE_MOUSE` — velocidade da câmera.

---

## 🗺️ Próximos passos (ideias para depois)

- Trocar as formas geométricas por modelos 3D de verdade.
- Animações de andar / voar / transformar.
- Barra de UI mostrando o tempo de voo restante.
- Inimigos, vida e habilidades de vampiro (sugar sangue, etc.).
- Terreno maior com colinas, castelo e vilarejo.
