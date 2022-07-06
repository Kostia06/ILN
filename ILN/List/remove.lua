function List:Remove(txt,line,block,dir)
    local type = split(txt:gsub('remove',''),'%.')[2]
    local value = removeSpaces(split(txt:gsub('remove',''),'%.')[1])
    local txt = txt:gsub(value,'')
    if type:find('Index' .. '%(') then
        self:RemoveByIndex(value,block, dir,txt)
    elseif  type:find('Name'.. '%(') then
        self:RemoveByName(value, block, dir,txt)
    end
end
function List:RemoveByName(value, block ,dir,txt)
    local name = txt:gsub('.removeName' .. '%(', ''):gsub('%)', '')
    local list = self:GetList(value)
    if Vars:CheckType(value) == nil then
        for _, var in ipairs(Vars) do
            if name:find(removeSpaces(var.name)) then
                if checkBlock({var.block, block}, var.decorations, dir) then
                    name = name:gsub(removeSpaces(var.name), var.value)
                end
            end
        end
    end
    name = removeSpaces(BuildIn:Check(name, block))
    local type = Vars:CheckType(name)
    if type ~= 'list' and inList(tostring(name), expressions) and not inList(name, alphabet) then
        name = exe(name)
    end
    for _, i in ipairs(list) do
        if i == name then
            table.remove(list, _)
        end
    end
    local newvalue = ''
    for _, i in ipairs(list) do
        newvalue = newvalue .. i .. ','
    end
    newvalue = '[' .. newvalue:sub(1, -2) .. ']'
    for _, i in ipairs(Vars) do
        if value == i.name then
            i:update(newvalue)
        end
    end

end
function List:RemoveByIndex(value, block ,dir,txt)
    local index = txt:gsub('.removeIndex'..'%(',''):gsub('%)','')
    local list = self:GetList(value)
        if Vars:CheckType(value) == nil then
        for _, var in ipairs(Vars) do
            if index:find(removeSpaces(var.name)) then
                if checkBlock({var.block, block}, var.decorations, dir) then
                    index = index:gsub(removeSpaces(var.name), var.value)
                end
            end
        end
    end
    index = removeSpaces(BuildIn:Check(index, block))
    local type = Vars:CheckType(index)
    if type ~= 'list' and inList(tostring(index), expressions) and not inList(index, alphabet) then
        index = exe(index)
    end
    if  index > #list then return  end
    table.remove(list, index)
    local newvalue = ''
    for _, i in ipairs(list) do
        newvalue = newvalue .. i .. ','
    end
    newvalue = '['..newvalue:sub(1,-2) .. ']'
    for _, i in ipairs(Vars) do
        if value == i.name then
            i:update(newvalue)
        end
    end
end
function List:GetList(var)
    local list
    for _, i in ipairs(Vars) do
        if var:gsub(' ', '') == i.name then
            list = split(i.value:gsub('%[', ''):gsub('%]', ''), ',')
        end
    end
    return list
end