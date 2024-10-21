local function left()
    hs.application.frontmostApplication():selectMenuItem({"Window", "Move & Resize", "Left"})
end

local function right()
    hs.application.frontmostApplication():selectMenuItem({"Window", "Move & Resize", "Right"})
end

local function fill()
    hs.application.frontmostApplication():selectMenuItem({"Window", "Fill"})
end

local function shrink()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local frame = win:frame()
    local max = screen:frame()

    frame.w = max.w / 1.5
    frame.h = frame.w / 3 * 2

    frame.x = max.x + (max.w / 2) - (frame.w / 2)
    frame.y = max.y + (max.h / 2) - (frame.h / 2)

    win:setFrame(frame)
end

local lastRightMouseDownTime = 0
local doubleClickThreshold = 0.3

local function isOverTitleBar(window)
    local windowFrame = window:frame()
    local titleBarHeight = 25
    local mousePos = hs.mouse.absolutePosition()

    if mousePos.x >= windowFrame.x and mousePos.x <= (windowFrame.x + windowFrame.w) and mousePos.y >= windowFrame.y and
        mousePos.y <= (windowFrame.y + titleBarHeight) then
        return true
    end
    return false
end

local rightMouseDownEvent = hs.eventtap.new({hs.eventtap.event.types.rightMouseDown}, function(event)
    local currentTime = hs.timer.secondsSinceEpoch()

    if (currentTime - lastRightMouseDownTime) < doubleClickThreshold then
        local window = hs.window.focusedWindow()
        if window and isOverTitleBar(window) then
            fill()
        end
    end

    lastRightMouseDownTime = currentTime
end)

rightMouseDownEvent:start()

hs.hotkey.bind({"ctrl", "cmd"}, "w", fill)
hs.hotkey.bind({"ctrl", "cmd"}, "a", left)
hs.hotkey.bind({"ctrl", "cmd"}, "s", shrink)
hs.hotkey.bind({"ctrl", "cmd"}, "d", right)
