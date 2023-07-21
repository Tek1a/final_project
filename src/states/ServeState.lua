ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
	self.health = params.health
	self.score = params.score
	self.highscores = params.highscores
  self.umbrella = Umbrella(100)
	
end

function ServeState:update(dt)
	
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		stateMachine:change('play', {
			health = self.health,
			score = self.score,
			highscores = self.highscores
		})
	end
  
	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
	
end

function ServeState:render()
	self.umbrella:render()
	
  renderScore(self.score)
	renderHealth(self.health)
end