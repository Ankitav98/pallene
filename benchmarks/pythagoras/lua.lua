local function istriple(a, b, c)
    return a*a + b*b == c*c
end

local function pyth(N)
    local nsol= 0
    local xs= {}
    local ys= {}
    local zs= {}

    for x = 1, N do
        for y = 1, N do
            for z = 1, N do
                if istriple(x,y,z) then
                    nsol = nsol + 1
                    xs[nsol] = x
                    ys[nsol] = y
                    zs[nsol] = z
                end
            end
        end
    end

    local out= {}
    out[1] = xs
    out[2] = ys
    out[3] = zs
    return out
end

return  { pyth = pyth }
