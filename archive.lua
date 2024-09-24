hs.eventtap.new({hs.eventtap.event.types.rightMouseDown, hs.eventtap.event.types.otherMouseDown}, function(e)
    local button = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])

    -- RMouse
    if button == 1 then
        m = hs.mouse.absolutePosition()
        a = hs.application.frontmostApplication()
        f = hs.window.focusedWindow():frame()

        if m.y > f.y and m.y < f.y + 35 then
            if m.x > f.x and m.x < f.x + 70 then
                a:hide()
            end
        end
    end

    -- MMouse
    if button == 2 then
        m = hs.mouse.absolutePosition()
        a = hs.application.frontmostApplication()
        w = hs.window.focusedWindow()
        f = w:frame()

        if m.y > f.y and m.y < f.y + 35 then
            if m.x > f.x and m.x < f.x + 70 then
                w:setSize(hs.geometry.size(900, 600))
                return true
            end
        end
    end
end):start()
