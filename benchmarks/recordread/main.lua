local rec = require(arg[1])

local arr = {}
for i = 1, 1e5 do
    arr[i] = rec.new(i * math.pi)
end

for i = 1, 1e2 do
    local x = 0
    for i = 1, #arr do
        x = x + arr[i].field32
    end
    print(x)
end
