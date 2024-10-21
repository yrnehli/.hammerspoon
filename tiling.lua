function left()
    hs.application.frontmostApplication():selectMenuItem({"Window", "Move & Resize", "Left"})
end

function right()
    hs.application.frontmostApplication():selectMenuItem({"Window", "Move & Resize", "Right"})
end

function fill()
    hs.application.frontmostApplication():selectMenuItem({"Window", "Fill"})
end

function shrink()
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

hs.hotkey.bind({"ctrl", "cmd"}, "w", fill)
hs.hotkey.bind({"ctrl", "cmd"}, "a", left)
hs.hotkey.bind({"ctrl", "cmd"}, "s", shrink)
hs.hotkey.bind({"ctrl", "cmd"}, "d", right)
