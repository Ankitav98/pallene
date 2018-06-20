local _M = {}

function _M.new(x, y)
    return { x, y }
end

function _M.centroid(points, N)
    local x = 0.0
    local y = 0.0
    for _ = 1, N do
        x = 0.0
        y = 0.0
        for i = 1, #points do
            local p = points[i]
            x = x + p[1]
            y = y + p[2]
        end
    end
    return { x = x / #points, y = y / #points }
end

return _M
