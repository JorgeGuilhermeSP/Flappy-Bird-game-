push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'PipePair'

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

local GROUND_LOOPING_POINT = 514

-- bird sprite
local bird = Bird()

--spawn pipes pairs
local pipePairs = {}

-- spawn timer
local spawnTimer = 0

-- -- initialize our last recorded Y value for a gap placement to base other gaps off of
local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- pausar jogo quando houver colisão
local scrolling = true

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
    if scrolling then
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
     % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
    % GROUND_LOOPING_POINT

    spawnTimer = spawnTimer + dt

    -- spawn pipe pair a cada 2 segundos
    if spawnTimer > 2 then
        -- modify the last Y coordinate we placed so pipe gaps aren't too far apart
        -- no higher than 10 pixels below the top edge of the screen,
        -- and no lower than a gap length (90 pixels) from the bottom
        local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        lastY = y
        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end
    
    -- update bird input and gravity
    bird:update(dt)

    --para todos os pipes na tela
    for k, pair in pairs(pipePairs) do
        pair:update(dt)
    
    for l, pipe in pairs(pair.pipes) do
        if bird:collides(pipe) then
             scrolling = false
    end
end
    if pair.x < -PIPE_WIDTH then
        pair.remove = true
    end
end

for k, pair in pairs(pipePairs) do 
    if pair.remove then
        table.remove(pipePairs, k)
        end
    end
end
    --reset input table
    love.keyboard.keysPressed = {}

end

--renderização das imagens
function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pair in pairs(pipePairs) do
        pair:render()        
    end

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    bird:render()

    push:finish()
    
end