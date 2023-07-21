LeftPipe = Class{}
PIPE_SPEED = 200
function LeftPipe:init()
	self.image = love.graphics.newImage('graphics/leftpipe.png')	
	
	self.x = 0
	self.y = 288
	self.width = 256
	self.height = self.image:getHeight()
	self.scored = false
	self.remove = false

end

function LeftPipe:update(dt)
	if self.y > -self.height then
		self.y = self.y - PIPE_SCROLL * dt
	else
		self.remove = true
	end
	
	self.x = math.min( 0, self.x - PIPE_SPEED * dt)
	if self.x == 1 then
		self.x = math.max( self.width, self.x + PIPE_SPEED * dt)
	end
end

function LeftPipe:render()
	love.graphics.draw(self.image, self.x, self.y)
end