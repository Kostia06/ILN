
Vars = {}
function Vars:New(txt, line, block, dir)
    local name = split(txt, '=')[1]
    if  split(txt, '=')[2] == nil then return end
    local value = tostring(BuildIn:Check(split(txt, '=')[2]))
    if value:find('input%(') then value = tostring(Input:Main(value)) end
    if inList(value, expressions) and inList(value, numbers) then 
        value = self:CheckExpression(removeSpaces(value),block,dir) 
    end
    local decorations = self:CheckDecorations(name)
    if decorations ~= 'local' then 
        block = 'any'
    else
        block = dir .. '/' .. block
    end
    name = name:gsub(decorations, '')
    local type = self:CheckType(value)
    if self:Update(name, value) then return end
    value = self:CheckValue(value)
    if type ~= 'list' and not inList(value, alphabet)  and inList(value, numbers) then 
        value = exe(value)
    end
    local info ={
        name= removeSpaces(name):gsub(' ',''),
        value = tostring(removeSpaces(value)),
        decorations = decorations,
        type = type,
        block = block,
        dir = dir,
        line = line,
        update = function(self,value)
            self.value = value
            self.type = Vars:CheckType(self.value)
        end,
    }
    table.insert(Vars,info)
end
function Vars:CheckType(value)
    value = tostring(value)
    if removeSpaces(value):find('%[') and removeSpaces(value):find('%]') then return 'list'
    elseif removeSpaces(value):find('true') or removeSpaces(value):find('false') then return 'boolean'
    elseif  value:find('\'') or value:find('\"') then return 'str'  
    elseif tonumber(value) then return 'int' 
    else return nil
    end
end
function Vars:CheckDecorations(name)
    if name:find('const') then return 'const'
    elseif name:find('local') then return 'local' 
    else return 'var' 
    end
end
function Vars:CheckValue(value)
    for _, i in ipairs(Vars) do
        if  value:find(i.name) then
            if value:find('\'') or value:find('\"') then break end
            value = value:gsub(i.name, i.value)
        end
    end
    return value
end
function Vars:Update(name, value)
    for _, i in ipairs(Vars) do
        if removeSpaces(name):gsub(' ','') == i.name then
            if i.decorations == 'const' then return true end
            i:update(value)
            return true
        end
    end
    return false
end
function Vars:GetBlock(name)
    for _, i in ipairs(Vars) do
        if name == i.name then return i.block end
    end
end
function Vars:CheckExpression(line,block,dir)
    for _, i in ipairs(Vars) do
        if line:find(i.name) then
            if checkBlock({i.block, block}, i.decorations, dir) then
                line = line:gsub(i.name, i.value)
            end
        end
    end
    return exe(line)
end