StartState = Class{__includes = BaseState}

local hover = 1
function StartState:enter(params)
  self.highscores = params.highscores
end

function StartState:update(dt)
  
  if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
    sounds['select']:play()
		hover = hover == 1 and 2 or 1
	end
	
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
	
		if hover == 1 then
			stateMachine:change('serve', {
				highscores = self.highscores,
				health = 3,
				score = 0
			})
		else
			stateMachine:change('highscore', {
				highscores = self.highscores
			})
		end
			
	end
	
	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function StartState:render()
	love.graphics.setFont(scoreFont)
    love.graphics.printf("GAME", 0, VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(mediumFont)

    if hover == 1 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 40,
        VIRTUAL_WIDTH, 'center')

	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        
    if hover == 2 then
        love.graphics.setColor(100/255, 255/255, 255/255, 255/255)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 65,
        VIRTUAL_WIDTH, 'center')

	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end


