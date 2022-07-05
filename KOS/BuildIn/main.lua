BuildIn = {}
function BuildIn:Check(txt,block)
    local action 
    txt = tostring(txt)
    if txt == nil then return txt end
    for _, i in ipairs(buildinActions) do
        if txt:find(i) then action = i break end
    end
    if action == nil then return txt end
    local value = txt
    if action:find('#') then return self:GetCount(value, action,block ) 
    elseif action:find('type') then return self:GetType(value, action,block)
    elseif action:find('index') then return self:GetIndex(value, action,block)
    end
    return txt
end
function BuildIn:CheckVar(value,block)
    for _, i in ipairs(Vars) do
        if removeSpaces(value) == i.name then
            if checkBlock({i.block, block}, i.declarations) then return i.value end
        end
    end
    return value
end