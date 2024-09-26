function leftHalf()
    hs.application.frontmostApplication():selectMenuItem({"Window", "Move & Resize", "Left"})
end

function rightHalf()
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
    frame.h = max.h / 1.5

    frame.x = max.x + (max.w / 2) - (frame.w / 2)
    frame.y = max.y + (max.h / 2) - (frame.h / 2)

    win:setFrame(frame)
end

hookLeftMouseDragged = hs.eventtap.new({hs.eventtap.event.types.leftMouseDragged}, function(e)
    local location = e:location()
    local frame = hs.mouse.getCurrentScreen():frame()

    if location.y <= frame.y + 1.0 then
        hs.timer.doAfter(0.1, function()
            fill()
        end)
    end

    if location.y <= frame.y then
        hs.mouse.setRelativePosition({
            x = location.x,
            y = location.y
        }, "Hack to disable Mission Control")
    end
end)

hs.hotkey.bind({"ctrl", "cmd"}, "w", fill)
hs.hotkey.bind({"ctrl", "cmd"}, "a", leftHalf)
hs.hotkey.bind({"ctrl", "cmd"}, "s", shrink)
hs.hotkey.bind({"ctrl", "cmd"}, "d", rightHalf)

hookLeftMouseDragged:start()