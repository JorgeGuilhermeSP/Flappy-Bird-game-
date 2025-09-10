push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

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

-- spawn timer
local spawnTimer = 0

-- pausar jogo quando houver colisão
local scrolling = true

-- filtro e titulo
function love.load()
    --randomseed 
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Fifty Bird')

    -- inicializar fontes retro
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    --inicializar audio
    sounds = {
    ['jump'] = love.audio.newSource('jump.wav', 'static'),
    ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
    ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
    ['score'] = love.audio.newSource('score.wav', 'static'),

    -- https://freesound.org/people/xsgianni/sounds/388079/
        ['music'] = love.audio.newSource('marios_way.mp3', 'static')
}

sounds['music']:setLooping(true)
sounds['music']:play()


--inicializar resolução virtual
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    } )

    -- inicializar state machine
    gStateMachine = StateMachine{
        ['title'] = function () return TitleScreenState() end,
        ['countdown'] = function () return CountdownState() end,
        ['play'] = function () return PlayState() end,   
        ['score'] = function () return ScoreState() end
    }
    gStateMachine:change('title')

    -- inicializar input table
    love.keyboard.keysPressed = {}
    -- inicializar mouse input table
    love.mouse.buttonsPressed = {}
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

function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
    
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
    end
    
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]    
end

--movimento das imagens
function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
     % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
    % GROUND_LOOPING_POINT

    gStateMachine:update(dt)

    
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

end

--renderização das imagens
function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)

   gStateMachine:render()

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    

    push:finish()
    
end