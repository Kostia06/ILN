List= {}
function List:New(txt,line,block, dir)
    local action
    txt = tostring(txt)
    for _, i in ipairs(listActions) do
        if txt:find(i) then action = i break end
    end
    if action == nil then return txt end
    if action == 'remove' then self:Remove(txt,line,block,dir) end
    if action == 'append' then self:Add(txt,line,block,dir) end
end