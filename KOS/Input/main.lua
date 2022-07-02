Input = {}
function Input:Main(value)
    local type = split(value,'%)')[2]:sub(1,-2)
    value = split(removeSpaces(value:gsub('input%(','')):gsub('\'',''):gsub('\"',''), '%)')[1]
    local question = value
    value = self:Ask(question)
    while not self:CheckType(type:gsub(':',''), value) do
        value = self:Ask(question)
    end
    if inList(value, alphabet) and type:gsub(':','') == '' then return  '\'' ..value..'\'' end
    return value
end
function Input:Ask(value)
    io.write(value)
    return io.read("*l")
end
function Input:CheckType(type, value)
    local list = {'int', 'var','list','boolean',''}
    local currenttype = Vars:CheckType(value)
    if type == 'int' and currenttype == type then  return true
    elseif type == 'var' and self:CheckVar(value) then  return true
    elseif type == 'list' and currenttype == type then  return true
    elseif type == 'boolean' and currenttype == type then  return true
    elseif type == '' then return true
    elseif not inList(type, list) then return true
    end
end
function Input:CheckVar(value)
    for _, i in ipairs(Vars) do
        if i.name == removeSpaces(value) then return true end
    end
    return false
end
function Input:CheckList(value)
    if value:sub(1,1) == '%['  and  value:sub(1,1) == '%]' then
        return true
    end
    return false
end