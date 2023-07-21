Pipe = Class{}

function Pipe:init(identity, x, y, dx, flipTime)
	self.image = love.graphics.newImage('graphics/pipe.png')	
	
	self.x = x
	self.y = y
	
	self.dx = dx
	
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	
	self.timer = 0
	self.flipTime = flipTime
	
	self.identity = identity
	

end

function Pipe:update(dt)
	self.timer = self.timer + 1 * dt
	
	print(self.identity)
	
	if self.identity == 'right' and self.timer > self.flipTime then
		self.dx = -self.dx
		self.timer = 0
	elseif self.identity == 'left' then
		self.dx = 0
	end
	
	self.x = self.x + self.dx * dt
end

function Pipe:render()
	love.graphics.draw(
		self.image, 
		(self.identity == 'left' and self.x or self.x + self.width), 
		self.y,
		0,
		(self.identity == 'left' and 1 or -1), 
		1)
end
