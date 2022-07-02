function List:Add(txt, line, block, dir)
    local value = split(split(txt:gsub('append', ''), '%.')[2],'%)')[1]:gsub('%(','')
    local list = removeSpaces(split(txt:gsub('append', ''), '%.')[1])
    if Vars:CheckType(value ) == nil then
        for _, var in ipairs(Vars) do
            if value:find(removeSpaces(var.name)) then
                if checkBlock({var.block, block}, var.decorations, dir) then
                    value = value:gsub(removeSpaces(var.name), var.value)
                end
            end
        end
    end
    value = removeSpaces(BuildIn:Check(value, block))
    local type = Vars:CheckType(value)
    if type ~= 'list' and inList(tostring(value), expressions) and not inList(value, alphabet) then
        value = exe(value)
    end
    for _, var in ipairs(Vars) do
        if list:find(removeSpaces(var.name)) then
            if checkBlock({var.block, block}, var.decorations, dir) then
                if #split(var.value,',') > 1 then
                    value = var.value:gsub('%]','') .. ', '..value .. ']'
                    var:update(value)
                end
            end
        end
    end
end
