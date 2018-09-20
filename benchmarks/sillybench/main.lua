local silly = require(arg[1])

local values = {}
for i = 1, 1500 do
    values[i] = i
end

local out = silly.silly(values, values, values)
print(out)


