local box = require(arg[1])

local n = 1e8

if arg[1] == 'benchmarks.getv.inline' then
    local b = {x = math.pi}
    local x
    for i = 1, n do
        x = b.x
    end
    print(x)
else
    local b = box.new(math.pi)
    local x
    for i = 1, n do
        x = box.v(b)
    end
    print(x)
end
