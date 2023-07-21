require 'src/Dependencies'




local background = love.graphics.newImage('graphics/background.png')
local background_scroll = 0


local BACKGROUND_SCROLL_SPEED = 30

local LOOPING_POINT = 313

function love.load()
	
	math.randomseed(os.time())
	
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Umbrella')
	
	
	mediumFont = love.graphics.newFont('fonts/font.ttf', 16)
	scoreFont = love.graphics.newFont('fonts/font.ttf', 32)
  smallFont = love.graphics.newFont('fonts/font.ttf', 8)
  
  heartsTexture = love.graphics.newImage('graphics/hearts.png')
	
	heartsQuad = GenerateQuads(heartsTexture, 16, 16)
	
  sounds = {
		['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
		['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
		['select'] = love.audio.newSource('sounds/select.wav', 'static'),
		['music'] = love.audio.newSource('sounds/background.mp3', 'static')
	}
	
	sounds['music']:setLooping(true)
	sounds['music']:play()
	
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	
	})
	
	
	stateMachine = StateMachine {
		['start'] = function() return StartState() end,
    ['serve'] = function() return ServeState() end,
		['play'] = function() return PlayState() end,
		['score'] = function() return ScoreState() end,
    ['highscore'] = function() return HighscoreState() end,
		['enter-highscore'] = function() return EnterHighscoreState() end
	}
	
	stateMachine:change('start', {
      highscores = loadHighscores()
	})
  love.keyboard.keysPressed = {}
	
end

function love.update(dt)
	background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % LOOPING_POINT
	stateMachine:update(dt)
	
	love.keyboard.keysPressed = {}
end




function love.keypressed(key)
	love.keyboard.keysPressed[key] = true

end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end




function love.resize(w, h)
	push:resize(w, h)
end

function love.draw()
	push:start()
	
	love.graphics.draw(background, -background_scroll, 0)
	
	stateMachine:render()
	
	push:finish()
end

function renderHealth(health)
	local healthX = 20
	
	for i = 1, health do
		love.graphics.draw(heartsTexture, heartsQuad[8], healthX, 5)
		healthX = healthX + 12
	end
	
	for i = 1, 3 - health do
		love.graphics.draw(heartsTexture, heartsQuad[1], healthX, 5)
		healthX = healthX + 12
	end
end
function renderScore(score)
	love.graphics.setFont(scoreFont)
	love.graphics.print('Score: ', VIRTUAL_WIDTH - 150, 5)
	love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end

function loadHighscores()
	love.filesystem.setIdentity('Umbrella')
	
	if not love.filesystem.getInfo('Umbrella.lst') then
		local scores = ''
		for index = 10, 1, -1 do
			scores = scores .. 'NAM\n'
			scores = scores .. 0 .. '\n'
		end
		
		love.filesystem.write('Umbrella.lst', scores)
	end
	
	local name = true
	local currentName = nil
	local counter = 1
	
	local scores = {}
	
	for index = 1, 10 do
		scores[index] = {
			name = nil,
			score = nil
		}
	end
	
	for line in love.filesystem.lines('Umbrella.lst') do
		if name then
			scores[counter].name = string.sub(line, 1, 3)
		else
			scores[counter].score = tonumber(line)
			counter = counter + 1
		end
		
		name = not name
	end
	
	return scores
end