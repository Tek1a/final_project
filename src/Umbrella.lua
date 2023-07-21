Umbrella = Class{}

OPEN_SPEED = 20
CLOSE_SPEED = 100

function Umbrella:init(y)
	self.skins = {
		['open'] = love.graphics.newImage('graphics/opened_umbrella.png'),
		['close'] = love.graphics.newImage('graphics/closed_umbrella.png')
	}
	
	self.width = self.skins['open']:getWidth()
	self.height = self.skins['open']:getHeight()
	
	self.x = VIRTUAL_WIDTH / 2 - self.width 
	self.y = y
	
	self.dy = 0
	
	self.state = 'open'

end

function Umbrella:update(dt)
	self.y = self.y + self.dy
	
	
	if self.state == 'open' then
		self.dy = OPEN_SPEED * dt
		
		if love.keyboard.wasPressed('space') then
			self.state = 'close'
		end
	elseif self.state == 'close' then
		self.dy = CLOSE_SPEED * dt
		
		if love.keyboard.wasPressed('space') then
			self.state = 'open'
		end
	end
end

function Umbrella:reset()
  	self.y = 0 - self.height
  	self.dy = 0
	
end

function  Umbrella:collides(pipe)
	if (self.x + 3) + (self.width - 5) >= pipe.x and self.x + 3 <= pipe.x + pipe.width then
		if (self.y + 3) + (self.height - 5) >= pipe.y and self.y + 3 <= pipe.y + pipe.height then
			return true
		end
	end
end

function Umbrella:render()
	love.graphics.draw(self.skins[self.state], self.x, self.y)
end
