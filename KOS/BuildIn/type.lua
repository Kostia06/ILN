function BuildIn:GetType(value, action,block)
    value = value:gsub(action, '')
    local type = Vars:CheckType(value)
    local value  = self:CheckVar(value,block)
    return tostring(type)
end