hs.window.setFrameCorrectness = true

local function resizeWindowsToFit()
    local screen = hs.screen.mainScreen()
    local windows = hs.window.visibleWindows()

    for _, win in ipairs(windows) do
        local visibleFrame = win:screen():frame()
        local frame = win:frame()
        local overflowing = false

        if frame.x < visibleFrame.x then
            frame.x = frame.x + (visibleFrame.x - frame.x)
            overflowing = true
        end

        if frame.x > visibleFrame.x then
            frame.x = frame.x - (frame.x - visibleFrame.x)
            overflowing = true
        end

        if overflowing then
            win:setFrame(frame, 0)
        end
    end
end

hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.screensDidUnlock then
        resizeWindowsToFit()
    end
end):start()

resizeWindowsToFit()
