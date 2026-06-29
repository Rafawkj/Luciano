# 🦇 Vampire Prototype — Protótipo Dark Fantasy (Godot 4)

Protótipo jogável de um mini mundo aberto *dark fantasy* medieval.
O protagonista é um **vampiro** que pode alternar entre a **forma humanoide** e a
**forma de morcego** (que voa por tempo limitado).

> ⚠️ Este é apenas o **primeiro protótipo jogável** — a base do projeto.
> Ainda não é o jogo completo: usa formas geométricas simples no lugar de
> modelos 3D, para focar na jogabilidade.

---

## 🎮 Controles

| Tecla            | Ação                                             |
|------------------|--------------------------------------------------|
| **W A S D**      | Andar                                            |
| **Shift**        | Correr (segurando, na forma vampiro)             |
| **Espaço**       | Pular (vampiro) / Subir batendo asas (morcego)   |
| **T**            | Transformar entre vampiro ↔ morcego              |
| **Mouse**        | Girar a câmera                                    |
| **ESC**          | Liberar / prender o cursor do mouse              |

**Forma morcego:** segure **Espaço** para voar. Você tem ~5 segundos de voo;
o "tanque" recarrega assim que você toca o chão de novo.

---

## 📁 Estrutura do projeto

```
.
├── project.godot        # Configuração do projeto + mapa de teclas (Input Map)
├── icon.svg             # Ícone do projeto
├── scenes/
│   ├── world.tscn       # CENA PRINCIPAL: terreno, luz, céu e o jogador
│   └── player.tscn      # O personagem (vampiro/morcego) + câmera em 3ª pessoa
├── scripts/
│   └── player.gd        # Toda a lógica: movimento, câmera, voo e transformação
└── assets/              # (vazia) Para modelos, texturas e sons futuros
```

### O que cada arquivo faz

- **`project.godot`** — Define o nome do jogo, qual cena abre primeiro
  (`world.tscn`) e o **Input Map** (os nomes das ações como `mover_frente`,
  `pular`, `correr`, `transformar` ligados às teclas).

- **`scenes/world.tscn`** — O "mundo". Contém:
  - `Chao` — um terreno plano (60×60) com **colisão**, feito de um `StaticBody3D`.
  - `Pilar1/2/3` — pilares (também com colisão) que servem de referência visual
    para você perceber o movimento.
  - `LuzDirecional` — iluminação tipo "luar".
  - `WorldEnvironment` — céu noturno e uma névoa leve para o clima sombrio.
  - `Player` — uma instância da cena do personagem.

- **`scenes/player.tscn`** — O personagem. Sua árvore de nós:
  - `Player` (`CharacterBody3D`) — o corpo físico com colisão (uma cápsula).
  - `ModeloVampiro` — as malhas visíveis na forma vampiro (corpo + cabeça).
  - `ModeloMorcego` — as malhas da forma morcego (corpo + duas asas), começa oculto.
  - `PivoCamera` → `Camera3D` — a câmera em 3ª pessoa que segue e gira com o mouse.

- **`scripts/player.gd`** — O cérebro do personagem, bastante comentado:
  - Movimento (andar / correr / pular) na forma vampiro.
  - Câmera girando com o mouse.
  - Transformação ao apertar **T**.
  - Voo por tempo limitado na forma morcego.

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
