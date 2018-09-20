local function ok(x, y, z)
    return x + y == z
end

local function silly(xs, ys, zs)
    local NI = #xs
    local NJ = #ys
    local NK = #zs

    local nsol = 0
    for i = 1, NI do
        local x = xs[i]
        for j = 1, NJ do
            local y = ys[j]
            for k = 1, NK do
                local z = zs[k]
                if ok(x, y, z) then
                    nsol = nsol + 1
                end
            end
        end
    end
    return nsol
end

return { silly = silly }
