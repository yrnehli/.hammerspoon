local chromeHotkey = nil

function enableChromeHotkey()
    if chromeHotkey == nil then
        chromeHotkey = hs.hotkey.bind({"cmd", "shift"}, "c", function()
            hs.eventtap.event.newKeyEvent({"alt", "cmd"}, "i", true):post()
            hs.eventtap.event.newKeyEvent({"alt", "cmd"}, "i", false):post()
        end)
    end
end

function disableChromeHotkey()
    if chromeHotkey ~= nil then
        chromeHotkey:delete()
        chromeHotkey = nil
    end
end

function applicationWatcher(appName, eventType, appObject)
    if (appName == "Google Chrome") then
        if (eventType == hs.application.watcher.activated) then
            enableChromeHotkey()
        elseif (eventType == hs.application.watcher.deactivated) then
            disableChromeHotkey()
        end
    end
end

hs.application.watcher.new(applicationWatcher):start()

