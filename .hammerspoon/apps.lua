local hyper = { "cmd", "ctrl", "shift", "option" }

-- LAUNCH/FOCUS APPS

local appsModal = hs.hotkey.modal.new(hyper, "o")

local apps = {
    { mod = "", key = "s", app = "Safari" },
    { mod = "", key = "q", app = "kitty" },
}

for _, object in ipairs(apps) do
    appsModal:bind(object.mod, object.key, function()
        result = hs.application.launchOrFocus(object.app)
        appsModal:exit()
    end)
end

appsModal:bind("", "escape", function()
    appsModal:exit()
end)
