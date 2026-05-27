# 🐦 Flappy Bird Clone - Evolução com Lua & LÖVE

Este repositório documenta o processo de desenvolvimento e evolução incremental de um clone do clássico jogo **Flappy Bird**. Desenvolvido em **Lua** com a engine **LÖVE (Love2D)**, o projeto destaca a transição de mecânicas simples para uma arquitetura de jogo robusta, com controle de estados, áudio e física.

## 📈 Linha do Tempo e Marcos de Desenvolvimento

A estrutura do repositório reflete o aprendizado passo a passo de conceitos fundamentais de desenvolvimento de jogos através de versões incrementais:

*   **`fb_0` e `fb_1`:** Configuração inicial do ambiente e renderização dos primeiros elementos gráficos.
*   **`fb_2` a `fb_4` (Bird & Gravity):** Implementação da física de gravidade (força constante puxando o pássaro para baixo) e a mecânica de "anti-gravidade" (o impulso ao clicar/pressionar uma tecla).
*   **`fb_5` e `fb_6` (Infinite Pipe & Pipe Pair):** Lógica de geração procedural e infinita de obstáculos, organizando os canos em pares (superior e inferior) com espaçamentos controlados.
*   **`fb_7` (Collision):** Implementação da detecção de colisão exata entre o pássaro, os canos e o chão.
*   **`fb_8` (State Machine):** Introdução de uma **Máquina de Estados**, padrão de projeto essencial para gerenciar as telas do jogo (Menu, Contagem Regressiva, Jogando e Game Over).
*   **`fb_9` e `fb_10` (Score & Countdown):** Adicionado o sistema de pontuação ao passar pelos canos e uma tela de contagem regressiva para preparar o jogador.
*   **`fb_11` (Audio):** Integração de efeitos sonoros para pulos, pontuação e colisões, melhorando o feedback do usuário.
*   **`Flappy_Bird` (Versão Final):** O jogo completo e polido, trazendo a atualização de jogabilidade por meio do clique do mouse.

## 🕹️ Conceitos Técnicos Aplicados

*   **Máquina de Estados (State Machine):** Organização do fluxo do jogo, garantindo que cada tela (Menu, Play, Game Over) execute apenas a sua própria lógica de atualização e desenho.
*   **Física Espacial (Aceleração e Gravidade):** Simulação realística de peso e forças atuando sobre o personagem.
*   **Geração Procedural de Obstáculos:** Criação e destruição dinâmica de objetos na memória à medida que eles saem da tela, garantindo a otimização do uso de hardware.
*   **Gerenciamento de Áudio e Inputs:** Manipulação de fontes de áudio e captura de múltiplos eventos de entrada (Teclado e Mouse).

## 🚀 Como Executar o Jogo

Você precisará do **LÖVE** instalado em seu sistema ([love2d.org](https://love2d.org/)).

1. Clone o repositório:
```bash
   git clone [https://github.com/JorgeGuilhermeSP/Flappy-Bird-game-.git](https://github.com/JorgeGuilhermeSP/Flappy-Bird-game-.git)
