local hyperCA = {"ctrl", "alt"}
local hyperAC = {"alt", "cmd"}
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
    w = "WeChat",
    r = "QQ",
    v = "Visual Studio Code",
    n = "neteasemusic",
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

    hs.mouse.absolutePosition(center)
    hs.eventtap.leftClick(center)
end)

-- move cursor to monitor 1/2/3/4 and maximize the window
for n= 1, 4 do
    hs.hotkey.bind(hyperCA, tostring(n), function()
	local win = hs.window.focusedWindow()
	local app = win:application()
	local screens = hs.screen.allScreens()
	if n > #screens then 
	    hs.alert.show("Only " .. #screens .. " monitors")
	else
	    local toScreen = screens[n]
	    hs.alert.show("Move " .. app:name() .." to " .. toScreen:name())
	    hs.layout.apply({{app, nil, toScreen, hs.layout.maximized, nil, nil}})
	end
    end)
end
-- switch active window
-- hs.hotkey.bind(hyperCA, '/', function() hs.hints.windowHints() end)
-- switcher_vscode = hs.window.switcher.new{"Visual Studio Code"}
switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only

hs.hotkey.bind(alt, 'tab', 'Next window',function()switcher:next()end)

-- translator



-- reload
-- http://www.hammerspoon.org/go/#fancyreload
-- function reloadConfig(files)
-- 	doReload = false
-- 	for _, file in pairs(files) do
-- 		if file:sub(-4) == ".lua" then
-- 			doReload = true
-- 		end
-- 	end
-- 	if doReload then
-- 		hs.reload()
-- 	end
-- end
-- hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon", reloadConfig):start()
-- hs.alert.show("Hammerspoon Config Reloaded")
