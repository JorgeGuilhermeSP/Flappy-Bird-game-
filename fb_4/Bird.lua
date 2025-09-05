Bird = Class{}

local GRAVITY = 20

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    -- velocidade de Y; gravidade
    self.dy = 0
end
 
function Bird:update(dt)
    -- aplicar gravidade para velocidade
    self.dy = self.dy + GRAVITY * dt

    -- gravidade negativa ao apertar espaço
    if love.keyboard.wasPressed('space') then
        self.dy = -5
    end

    -- aplicar velocidade atual para posição y
    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end