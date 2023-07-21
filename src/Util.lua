function GenerateQuads(atlas, tilewidth, tileheight)
	local sheetwidth = atlas:getWidth() / tilewidth
	local sheetheight = atlas:getHeight() / tileheight
	
	local index = 1
	local spritesheet = {}
	
	for y = 0, sheetheight - 1 do
		for x = 0, sheetwidth - 1 do
			spritesheet[index] =
		        love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
		        tileheight, atlas:getDimensions())
		    	index = index + 1
		end
	end
	
	return spritesheet
end

function table.slice(tbl, first, last, step)
	local sliced = {}
	
	for index = first or 1, last or #tbl, step or 1 do
		sliced[#sliced + 1] = tbl[index]
	end
	
	return sliced
end