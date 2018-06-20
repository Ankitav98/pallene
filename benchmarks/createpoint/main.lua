local Point = require(arg[1])

local points = {}
if arg[1] == "benchmarks.createpoint.inline" then
    for i = 1, 1e7 do
        table.insert(points, { x = math.pi, y = math.pi})
    end
else
    for i = 1, 1e7 do
        table.insert(points, Point.new(math.pi, math.pi))
    end
end

print(points)
