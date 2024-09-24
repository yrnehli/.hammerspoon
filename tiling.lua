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
    local f = win:frame()
    local max = hs.screen.mainScreen():frame()

    f.w = max.w / 1.5
    f.h = max.h / 1.5

    f.x = max.w / 2 - (f.w / 2)
    f.y = max.h / 2 - (f.h / 2)

    win:setFrame(f)
end

hookLeftMouseDragged = hs.eventtap.new({hs.eventtap.event.types.leftMouseDragged}, function(e)
    local location = e:location()

    if location.y <= 1.0 then
        hs.timer.doAfter(0.1, function()
            fill()
        end)
    end

    if location.y == 0.0 then
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
