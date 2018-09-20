local pyth = require(arg[1])

local out = pyth.pyth(1500)
local xs, ys, zs = out[1], out[2], out[3]
print(#xs, #ys, #zs)
--for i = 1,  #xs do
--    print(xs[i], ys[i], zs[i])
--end
