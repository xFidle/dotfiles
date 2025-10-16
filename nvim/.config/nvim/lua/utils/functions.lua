local M = {}

function M.blend_colors(color1, color2, blendFactor)
    local c1, c2 = {}, {}
    local result = '#'
    for i=0,2 do
        c1[i] = tonumber(string.sub(color1, 2 + 2*i, 3 + 2*i), 16)
        c2[i] = tonumber(string.sub(color2, 2 + 2*i, 3 + 2*i), 16)
        local channel = math.floor(tostring((1 - blendFactor) * c1[i] + blendFactor * c2[i]))
        result = result .. string.format("%02x", channel)
    end
    return result
end

return M
