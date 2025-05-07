-- require("apps")
local wm = require("wm")
local spaceIndicator = require('space-indicator')
spaceIndicator.init()

local hyper = { 'cmd', 'ctrl', 'option', 'shift' }

-- hs.hotkey.bind({ "option", "shift" }, '1', function() wm.MoveWindowToSpace(1) end)
-- hs.hotkey.bind({ "option", "shift" }, '2', function() wm.MoveWindowToSpace(2) end)
-- hs.hotkey.bind({ "option", "shift" }, '3', function() wm.MoveWindowToSpace(3) end)
-- hs.hotkey.bind({ "option", "shift" }, '4', function() wm.MoveWindowToSpace(4) end)
-- -- hs.hotkey.bind({ "option", "shift" }, '4', function() require'hs.spaces'.gotoSpace(3)  end)


-- hs.hotkey.bind(hyper, 'a', function() wm.MoveWindowToSpace(1) end)
-- hs.hotkey.bind(hyper, 's', function() wm.MoveWindowToSpace(2) end)
-- hs.hotkey.bind(hyper, 'd', function() wm.MoveWindowToSpace(3) end)
-- hs.hotkey.bind(hyper, 'f', function() wm.MoveWindowToSpace(4) end)
-- hs.hotkey.bind(hyper, 'g', function() wm.MoveWindowToSpace(5) end)
-- hs.hotkey.bind(hyper, 'x', function() wm.RemoveSpace() end)
-- hs.hotkey.bind(hyper, 'n', function() wm.AddSpace() end)

-- hs.hotkey.bind(hyper, 'a', function() wm.GotoSpace(1) end)
-- hs.hotkey.bind(hyper, 's', function() wm.GotoSpace(2) end)

-- ENABLE CLI ACCESS
hs.ipc.cliInstall()

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
hs.hotkey.bind(hyper, "r", function()
    hs.reload()
    hs.notify
        .new({
            title = "Hammerspoon",
            informativeText = "Config reloaded!",
            autoWithdraw = true,
            withdrawAfter = 2,
        })
        :send()
end)

hs.window.animationDuration = 0


hs.grid.setGrid("6x3")
hs.grid.setMargins({ 6, 6 })

-- hs.grid.MARGINX = 0
-- hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 9
hs.grid.GRIDHEIGHT = 3

-- Show grid
hs.hotkey.bind(hyper, "g", function()
    hs.grid.show()
end)

-- Center window on the screen
hs.hotkey.bind(hyper, "c", function()
    local win = hs.window.focusedWindow()
    win:centerOnScreen()
end)


-- Center window on the screen
hs.hotkey.bind(hyper, "f", function()
    local win = hs.window.focusedWindow()
    hs.grid.maximizeWindow(win)
end)

-- hs.hotkey.bind({ "option", "shift" }, "/", function()
--     local win = hs.window.focusedWindow()

--     hs.notify
--         .new({
--             title = "Hammerspoon",
--             informativeText = win:title(),
--             autoWithdraw = true,
--             withdrawAfter = 2,
--         })
--         :send()
-- end)
--
hs.hotkey.bind(hyper, "h", function()
    -- move the focused window one display to the left
    local win = hs.window.focusedWindow()
    local visibleWindows = win:windowsToWest(hs.window.visibleWindows())

    win:focusWindowWest(visibleWindows, true, true)
end)

hs.hotkey.bind(hyper, "l", function()
    -- move the focused window one display to the left
    local win = hs.window.focusedWindow()
    local visibleWindows = win:windowsToEast(hs.window.visibleWindows())

    win:focusWindowEast(visibleWindows, true, true)
end)

hs.hotkey.bind(hyper, "k", function()
    -- move the focused window one display to the left
    local win = hs.window.focusedWindow()
    local visibleWindows = win:windowsToNorth(hs.window.visibleWindows())

    win:focusWindowNorth(visibleWindows, true, true)
end)

hs.hotkey.bind(hyper, "j", function()
    -- move the focused window one display to the left
    local win = hs.window.focusedWindow()
    local visibleWindows = win:windowsToSouth(hs.window.visibleWindows())

    win:focusWindowSouth(visibleWindows, true, true)
end)
