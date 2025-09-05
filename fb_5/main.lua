push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- imagem de fundo
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

-- imagem do terreno
local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

-- velocidade das imagens
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
-- ponto de loop
local BACKGROUND_LOOPING_POINT = 413

-- bird sprite
local bird = Bird()

-- spawn pipes
local pipes = {}

-- spawn timer
local spawnTimer = 0

-- filtro e titulo
function love.load()
    -- percebi que geração estava padronizada, essa solução pode ser temporária para garantir aleatorieade na geração de pipes
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    } )

    -- inicializar input table
    love.keyboard.keysPressed = {}
    
end

-- função de redimensionar
function love.resize(w, h)
    push:resize(w, h)
end

-- função das teclas
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then 
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else 
        return false
    end
    
end

--movimento das imagens
function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
     % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
    % VIRTUAL_WIDTH

    spawnTimer = spawnTimer + dt

    -- spawn pipe a cada 2 segundos
    if spawnTimer > 2 then
        table.insert(pipes, Pipe())
        print('Added new pipe!')
        spawnTimer = 0
    end
    
    --
    bird:update(dt)

    --remover pipes não visíveis que passaram da esquerda da tela
    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then
            table.remove(pipes, k)
        end 
    end
   
    --reset input table
    love.keyboard.keysPressed = {}

end

--renderização das imagens
function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pipe in pairs(pipes) do
        pipe:render()        
    end

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    bird:render()

    push:finish()
    
end