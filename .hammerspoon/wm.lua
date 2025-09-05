local M = {}

local spaces = require("hs.spaces")
local mouse = require("hs.mouse")
local window = require("hs.window")

function M.MoveWindowToSpace(sp)
	local win = window.focusedWindow() -- current window
	local currentScreen = mouse.getCurrentScreen()
	local screenSpaces = spaces.spacesForScreen(currentScreen)
	-- this is broken since 14.5
	spaces.moveWindowToSpace(win, screenSpaces[sp], true)
	-- spaces.gotoSpace(spaceID) -- follow window to new space
end

function M.AddSpace()
	local currentScreen = mouse.getCurrentScreen()
	hs.spaces.addSpaceToScreen(currentScreen)
end

function M.RemoveSpace()
	local currentScreen = mouse.getCurrentScreen()
	local screenSpaces = spaces.spacesForScreen(currentScreen)
	local numSpaces = #screenSpaces
	if numSpaces == 1 then
		return
	end
	spaces.removeSpace(screenSpaces[#screenSpaces])
end

function M.GotoSpace(sp)
	local currentScreen = mouse.getCurrentScreen()
	local screenSpaces = spaces.spacesForScreen(currentScreen)
	local numSpaces = #screenSpaces
	if numSpaces <= sp then
		return
	end
	spaces.gotoSpace(screenSpaces[sp])
end

return M
