PipePair = Class{}

local GAP = 25
local PIPES_SPEED = 150

function PipePair:init(x, y)
	self.image = love.graphics.newImage('graphics/pipe.png')	
	
	self.x = x
	self.y = y
	
	self.pipeWidth = self.image:getWidth()
	
	self.pipes = {
		['left'] = Pipe('left', self.x, self.y, 40, 1),
		['right'] = Pipe('right', self.x + self.pipeWidth + GAP, self.y, 40, 3)
	}
	

	self.remove = false
	self.scored = false
	
	self.timer = 0
	self.flipTime = flipTime
	

end

function PipePair:update(dt)
  
	if self.y > -self.pipes['left'].height then
		self.y = self.y - PIPES_SPEED * dt
		self.pipes['left'].y = self.y
		self.pipes['right'].y = self.y
	else
		self.remove = true
	end
	
	for k, pipe in pairs(self.pipes) do
		pipe:update(dt)
	end
end

function PipePair:render()
	for k, pipe in pairs(self.pipes) do
		pipe:render()
	end
end
