do
	screenX, screenY = guiGetScreenSize()

	function getPositionFromBox (width, height, offsetX, offsetY, startIndicationX, startIndicationY)

		if type(width) ~= "number" then
			width = 0
		end

		if type(height) ~= "number" then
			height = 0
		end

		if type(offsetX) ~= "number" then
			offsetX = 0
		end

		if type(offsetY) ~= "number" then
			offsetY = 0
		end

		local startX = offsetX
		local startY = offsetY

		if startIndicationX == "right" then
			startX = screenX - (width + offsetX)
		elseif startIndicationX == "center" then
			startX = screenX / 2 - width / 2 + offsetX
		end

		if startIndicationY == "bottom" then
			startY = screenY - (height + offsetY)
		elseif startIndicationY == "center" then
			startY = screenY / 2 - height / 2 + offsetY
		end

		return startX, startY
	end
end