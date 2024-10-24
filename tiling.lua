local DOUBLE_CLICK_THRESHOLD_SECONDS = 0.3
local TITLE_BAR_HEIGHT = 30

local lastRightMouseDownTime = 0

local function isOverTitleBar(window)
    local windowFrame = window:frame()
    local mousePos = hs.mouse.absolutePosition()

    local isWithinXBounds = mousePos.x >= windowFrame.x and mousePos.x <= (windowFrame.x + windowFrame.w)
    local isWithinYBounds = mousePos.y >= windowFrame.y and mousePos.y <= (windowFrame.y + TITLE_BAR_HEIGHT)

    return isWithinXBounds and isWithinYBounds
end

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

hs.eventtap.new({hs.eventtap.event.types.rightMouseDown}, function(event)
    local currentTime = hs.timer.secondsSinceEpoch()

    if (currentTime - lastRightMouseDownTime) < DOUBLE_CLICK_THRESHOLD_SECONDS then
        local window = hs.window.focusedWindow()
        if window and isOverTitleBar(window) then
            fill()
        end
    end

    lastRightMouseDownTime = currentTime
end):start()

hs.hotkey.bind({"ctrl", "cmd"}, "w", fill)
hs.hotkey.bind({"ctrl", "cmd"}, "a", left)
hs.hotkey.bind({"ctrl", "cmd"}, "s", shrink)
hs.hotkey.bind({"ctrl", "cmd"}, "d", right)
