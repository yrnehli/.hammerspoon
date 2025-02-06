-- CMD+SHIFT+C => OPT+CMD+I
hs.hotkey.bind({"cmd", "shift"}, "c", function()
    hs.eventtap.event.newKeyEvent({"alt", "cmd"}, "i", true):post()
    hs.eventtap.event.newKeyEvent({"alt", "cmd"}, "i", false):post()
end)
