
local hyperCA = {"ctrl", "alt"}
local alt = {"alt"}
local cmd = {"cmd"}

-- test console
hs.hotkey.bind(hyperCA, 'c', function()
    local apps = hs.appfinder.appFromName("Visual Studio Code")
    hs.alert.show(apps)
end)

-- app launcher
local appShortcutMapping = {
    q = "Sequel Pro",
    t = "iTerm",
    g = "Google Chrome",
    e = "企业微信",
    w = "微信",
    r = "QQ",
    v = "visual Studio Code"
}
for key, app in pairs(appShortcutMapping) do
    hs.hotkey.bind(alt, key, function()
        hs.application.launchOrFocus(app)
    end)
end

-- Move Mouse to center of next Monitor
hs.hotkey.bind(cmd, '`', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    hs.mouse.setAbsolutePosition(center)
end)
movetoscreen = function(win, n) 
    local screens = hs.screen.allScreens()
    if n > #screens then
        hs.alert.show("Only " .. #screens .. " monitors ")
    else
        local toWin = screens[n]:name()
        hs.alert.show("Move " .. win:application():name() .. " to " .. toWin)
        hs.layout.apply({{nil, win:title(), toWin, hs.layout.maximized, nil, nil}})
    end
end
-- move cursor to monitor 1/2/3/4 and maximize the window
for n= 1, 4 do
    hs.hotkey.bind(hyperCA, tostring(n), function() movetoscreen(hs.window.focusedWindow(), n) end)
end

-- switch active window
hs.hotkey.bind(hyperCA, '/', function() hs.hints.windowHints() end)

-- translator

-- reload
-- http://www.hammerspoon.org/go/#fancyreload
function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon", reloadConfig):start()
hs.alert.show("Hammerspoon Config Reloaded")
