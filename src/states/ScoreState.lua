ScoreState = Class{__includes = BaseState}



function ScoreState:enter(params)
  self.score = params.score or 0
	self.highscores = params.highscores
end

function ScoreState:update(dt)
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		local highscore = false
		local scoreIndex = 0
		
		for index = 10, 1, -1 do
			local score = self.highscores[index].score or 0
			if self.score > score then
				highscoreIndex = index
				highscore = true
			end
		end
		
		if highscore then
			stateMachine:change('enter-highscore', {
				highscores = self.highscores,
				score = self.score,
				scoreIndex = highscoreIndex
			})
		else
			stateMachine:change('start', {
				highscores = self.highscores
			})
		end
		
	end
	
	
end

function ScoreState:render()
  
    love.graphics.setFont(mediumFont)
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter!', 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
end