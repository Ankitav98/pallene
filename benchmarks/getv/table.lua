local M = {}

function M.new(v)
    return { v = v }
end

function M.v(b)
    return b.v
end

return M
