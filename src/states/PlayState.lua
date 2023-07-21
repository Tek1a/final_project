PlayState = Class{__includes = BaseState}

PIPE_SCROLL = 200
SPAWN_INTERVAL = 1.5
    	
    	
function PlayState:enter(params)
  self.health = params.health
  self.score = params.score
  self.highscores = params.highscores
  
	self.umbrella = Umbrella(-50)
	self.pipePairs = {}
	self.timer = 0
	self.score = 0
  self.paused = false
	
	
end
function PlayState:update(dt)
  if self.paused then
		if love.keyboard.wasPressed('p') then
			self.paused = false
		else
			return
		end
	elseif love.keyboard.wasPressed('p') then
		self.paused = true
		return
	end
	self.timer = self.timer + 1 * dt
  
	
	if self.timer > SPAWN_INTERVAL then
		table.insert(self.pipePairs, PipePair(-50, VIRTUAL_HEIGHT))
		self.timer = 0
	end
	
	for k, pair in pairs(self.pipePairs) do
		
    
    if pair.remove == true then
			table.remove(self.pipePairs, k)
		end
    
		if pair.scored == false and pair.y + pair.pipes['left'].height  < self.umbrella.y then
			self.score = self.score + 1
			pair.scored = true
		end
    pair:update(dt)
	end
	
  if self.umbrella.y + self.umbrella.height > VIRTUAL_HEIGHT then
    self.umbrella:reset()
  end
	
	self.umbrella:update(dt)
  
  
	for k, pair in pairs(self.pipePairs) do
		for i, pipe in pairs(pair.pipes) do
			if self.umbrella:collides(pipe) then
        sounds['hurt']:play()
        self.health = self.health - 1
        
        if not (self.health == 0) then
          stateMachine:change('serve', {
            health = self.health,
            score = self.score,
            highscores = self.highscores
          })
			goto continue
        end
        
        sounds['select']:play()
        
				stateMachine:change('score', {
          score = self.score,
          highscores = self.highscores
				})
      
        ::continue::
        if love.keyboard.wasPressed('escape') then
          love.event.quit()
        end
	
			end
		end
	end
	
	
	
end

function PlayState:render()
	for k, pair in pairs(self.pipePairs) do
		pair:render()
	end
	self.umbrella:render()
	
  renderScore(self.score)
	renderHealth(self.health)

end
