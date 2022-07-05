

function BuildIn:GetCount(value, action,block)
    value = value:gsub(action, '')
    local type = Vars:CheckType(value)
    local value  = self:CheckVar(value,block)
    if type == 'list' then 
        return #split(value, ',')
    else
        return #removeSpaces(value):gsub('\'',''):gsub('\"','')
    end
end